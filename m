Return-Path: <Igal.Liberman@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0118.outbound.protection.outlook.com [65.55.169.118])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F3B731A1623
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2015 20:27:17 +1100 (AEDT)
From: Igal.Liberman <igal.liberman@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: [RFC,3/8] soc/fman: Add FMan Real Time Clock support
Date: Wed, 11 Mar 2015 07:08:18 +0200
Message-ID: <1426050498-12573-1-git-send-email-igal.liberman@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: scottwood@freescale.com, Igal Liberman <Igal.Liberman@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Igal Liberman <Igal.Liberman@freescale.com>

Signed-off-by: Igal Liberman <Igal.Liberman@freescale.com>
---
 drivers/soc/fsl/fman/fm_drv.c           |   98 ++++
 drivers/soc/fsl/fman/fm_drv.h           |    9 +-
 drivers/soc/fsl/fman/inc/fm_rtc_ext.h   |  398 ++++++++++++++++
 drivers/soc/fsl/fman/inc/fsl_fman_drv.h |    3 +
 drivers/soc/fsl/fman/rtc/Makefile       |    2 +-
 drivers/soc/fsl/fman/rtc/fm_rtc.c       |  763 +++++++++++++++++++++++++++++++
 drivers/soc/fsl/fman/rtc/fm_rtc.h       |   89 ++++
 7 files changed, 1360 insertions(+), 2 deletions(-)
 create mode 100644 drivers/soc/fsl/fman/inc/fm_rtc_ext.h
 create mode 100644 drivers/soc/fsl/fman/rtc/fm_rtc.c
 create mode 100644 drivers/soc/fsl/fman/rtc/fm_rtc.h

diff --git a/drivers/soc/fsl/fman/fm_drv.c b/drivers/soc/fsl/fman/fm_drv.c
index 9859ac6..ffeb223 100644
--- a/drivers/soc/fsl/fman/fm_drv.c
+++ b/drivers/soc/fsl/fman/fm_drv.c
@@ -423,6 +423,32 @@ static struct lnx_wrp_fm_dev_t *read_fm_dev_tree_node(struct platform_device
 		}
 	}
 
+#ifdef CONFIG_FSL_FMAN_RTC
+	/* Get the RTC base address and size */
+	memset(&name, 0, sizeof(name));
+	if (WARN_ON(strlen("ptp-timer") >= sizeof(name.name)))
+		return NULL;
+	strcpy(name.name, "ptp-timer");
+	if (WARN_ON(strlen("fsl,fman-ptp-timer") >= sizeof(name.compatible)))
+		return NULL;
+	strcpy(name.compatible, "fsl,fman-ptp-timer");
+	for_each_child_of_node(fm_node, dev_node) {
+		if (likely(of_match_node(&name, dev_node) != NULL)) {
+			err = of_address_to_resource(dev_node, 0, &res);
+			if (unlikely(err < 0)) {
+				pr_err("of_address_to_resource() = %d",
+				       err);
+				goto _return_null;
+			}
+
+			p_lnx_wrp_fm_dev->fm_rtc_base_addr = 0;
+			p_lnx_wrp_fm_dev->fm_rtc_phys_base_addr = res.start;
+			p_lnx_wrp_fm_dev->fm_rtc_mem_size = res.end + 1 -
+							    res.start;
+		}
+	}
+#endif
+
 	of_node_put(fm_node);
 
 	p_lnx_wrp_fm_dev->active = true;
@@ -485,6 +511,9 @@ uint32_t get_qman_channel_id(struct lnx_wrp_fm_dev_t *p_lnx_wrp_fm_dev,
 
 static int configure_fm_dev(struct lnx_wrp_fm_dev_t *p_lnx_wrp_fm_dev)
 {
+#ifdef CONFIG_FSL_FMAN_RTC
+	struct resource *dev_res;
+#endif
 	int err;
 
 	if (!p_lnx_wrp_fm_dev->active) {
@@ -551,6 +580,32 @@ static int configure_fm_dev(struct lnx_wrp_fm_dev_t *p_lnx_wrp_fm_dev)
 		return -ENOSYS;
 	}
 
+#ifdef CONFIG_FSL_FMAN_RTC
+	if (p_lnx_wrp_fm_dev->fm_rtc_phys_base_addr) {
+		dev_res =
+		    __devm_request_region(p_lnx_wrp_fm_dev->dev,
+					  p_lnx_wrp_fm_dev->res,
+					  p_lnx_wrp_fm_dev->
+						fm_rtc_phys_base_addr,
+					  p_lnx_wrp_fm_dev->fm_rtc_mem_size,
+					  "fman-ptp-timer");
+		if (unlikely(!dev_res)) {
+			pr_err("__devm_request_region() failed\n");
+			return -ENOSYS;
+		}
+
+		p_lnx_wrp_fm_dev->fm_rtc_base_addr =
+		    PTR_TO_UINT(devm_ioremap
+				(p_lnx_wrp_fm_dev->dev,
+				 p_lnx_wrp_fm_dev->fm_rtc_phys_base_addr,
+				 p_lnx_wrp_fm_dev->fm_rtc_mem_size));
+		if (unlikely(p_lnx_wrp_fm_dev->fm_rtc_base_addr == 0)) {
+			pr_err("devm_ioremap() failed\n");
+			return -ENOSYS;
+		}
+	}
+#endif
+
 	p_lnx_wrp_fm_dev->params.base_addr = p_lnx_wrp_fm_dev->fm_base_addr;
 	p_lnx_wrp_fm_dev->params.fm_id = p_lnx_wrp_fm_dev->id;
 	p_lnx_wrp_fm_dev->params.f_exception = lnxwrp_fm_dev_exceptions_cb;
@@ -669,6 +724,34 @@ static int init_fm_dev(struct lnx_wrp_fm_dev_t *p_lnx_wrp_fm_dev)
 		 */
 	}
 
+#ifdef CONFIG_FSL_FMAN_RTC
+	if (p_lnx_wrp_fm_dev->fm_rtc_base_addr) {
+		struct fm_rtc_params_t fm_rtc_param;
+
+		memset(&fm_rtc_param, 0, sizeof(fm_rtc_param));
+		fm_rtc_param.h_app = p_lnx_wrp_fm_dev;
+		fm_rtc_param.h_fm = p_lnx_wrp_fm_dev->h_dev;
+		fm_rtc_param.base_address = p_lnx_wrp_fm_dev->fm_rtc_base_addr;
+		p_lnx_wrp_fm_dev->h_rtc_dev = fm_rtc_config(&fm_rtc_param);
+
+		if (!(p_lnx_wrp_fm_dev->h_rtc_dev)) {
+			pr_err("FM-RTC\n");
+			return -ENOSYS;
+		}
+
+		if (fm_rtc_cfg_period((struct fm *)p_lnx_wrp_fm_dev,
+			DPA_PTP_NOMINAL_FREQ_PERIOD_NS) != 0) {
+			pr_err("FM-RTC\n");
+			return -ENOSYS;
+		}
+
+		if (fm_rtc_init((struct fm *)p_lnx_wrp_fm_dev) != 0) {
+			pr_err("FM-RTC\n");
+			return -ENOSYS;
+		}
+	}
+#endif
+
 	if (unlikely(fill_qman_channhels_info(p_lnx_wrp_fm_dev) < 0)) {
 		pr_err("can't fill qman channel info\n");
 		return -ENOSYS;
@@ -682,6 +765,11 @@ static void free_fm_dev(struct lnx_wrp_fm_dev_t *p_lnx_wrp_fm_dev)
 	if (!p_lnx_wrp_fm_dev->active)
 		return;
 
+#ifdef CONFIG_FSL_FMAN_RTC
+	if (p_lnx_wrp_fm_dev->h_rtc_dev)
+		fm_rtc_free((struct fm *)p_lnx_wrp_fm_dev);
+#endif
+
 	if (p_lnx_wrp_fm_dev->h_dev)
 		fm_free(p_lnx_wrp_fm_dev->h_dev);
 
@@ -813,6 +901,16 @@ void *fm_get_handle(struct fm *fm)
 }
 EXPORT_SYMBOL(fm_get_handle);
 
+#ifdef CONFIG_FSL_FMAN_RTC
+void *fm_get_rtc_handle(struct fm *fm)
+{
+	struct lnx_wrp_fm_dev_t *p_lnx_wrp_fm_dev =
+		(struct lnx_wrp_fm_dev_t *)fm;
+
+	return (void *)p_lnx_wrp_fm_dev->h_rtc_dev;
+}
+EXPORT_SYMBOL(fm_get_rtc_handle);
+#endif
 
 void fm_mutex_lock(void)
 {
diff --git a/drivers/soc/fsl/fman/fm_drv.h b/drivers/soc/fsl/fman/fm_drv.h
index e0be922..c2831a7 100644
--- a/drivers/soc/fsl/fman/fm_drv.h
+++ b/drivers/soc/fsl/fman/fm_drv.h
@@ -92,11 +92,18 @@ struct lnx_wrp_fm_dev_t {
 	phys_addr_t fm_muram_phys_base_addr;
 	uint64_t fm_muram_base_addr;
 	resource_size_t fm_muram_mem_size;
+#ifdef CONFIG_FSL_FMAN_RTC
+	uint64_t fm_rtc_phys_base_addr;
+	uint64_t fm_rtc_base_addr;
+	resource_size_t fm_rtc_mem_size;
+#endif
 	int irq;
 	int err_irq;
 	struct fm_params_t params;
 	void *h_dev;
-
+#ifdef CONFIG_FSL_FMAN_RTC
+	void *h_rtc_dev;
+#endif
 	struct muram_info *p_muram;
 
 	struct lnx_wrp_fm_port_dev_t ports[NUM_OF_FM_PORTS];
diff --git a/drivers/soc/fsl/fman/inc/fm_rtc_ext.h b/drivers/soc/fsl/fman/inc/fm_rtc_ext.h
new file mode 100644
index 0000000..46768c6
--- /dev/null
+++ b/drivers/soc/fsl/fman/inc/fm_rtc_ext.h
@@ -0,0 +1,398 @@
+/*
+ * Copyright 2008-2015 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in the
+ *       documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *       names of its contributors may be used to endorse or promote products
+ *       derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+/*File          fm_rtc_ext.h
+ *External definitions and API for FM RTC IEEE1588 Timer Module.
+ */
+
+#ifndef __FM_RTC_EXT_H__
+#define __FM_RTC_EXT_H__
+
+#include "service.h"
+#include "fsl_fman_rtc.h"
+
+struct fm;
+
+/* FM RTC functions, definitions and enums. */
+
+/* FM RTC initialization API. */
+
+/* FM RTC Alarm Polarity Options.*/
+enum fm_rtc_alarm_polarity {
+	FM_RTC_ALARM_POLARITY_ACTIVE_HIGH =
+		/*< Active-high output polarity */
+		FMAN_RTC_ALARM_POLARITY_ACTIVE_HIGH,
+	FM_RTC_ALARM_POLARITY_ACTIVE_LOW =
+		/*< Active-low output polarity */
+		FMAN_RTC_ALARM_POLARITY_ACTIVE_LOW
+};
+
+/* FM RTC Trigger Polarity Options.*/
+enum fm_rtc_trigger_polarity {
+	FM_RTC_TRIGGER_ON_RISING_EDGE =
+		/*< Trigger on rising edge */
+		FMAN_RTC_TRIGGER_ON_RISING_EDGE,
+	FM_RTC_TRIGGER_ON_FALLING_EDGE =
+		/*< Trigger on falling edge */
+		FMAN_RTC_TRIGGER_ON_FALLING_EDGE
+};
+
+/* IEEE1588 Timer Module FM RTC Optional Clock Sources.*/
+enum fm_src_clock {
+	/* external high precision timer reference clock */
+	FM_RTC_SOURCE_CLOCK_EXTERNAL = FMAN_RTC_SOURCE_CLOCK_EXTERNAL,
+	/* MAC system clock */
+	FM_RTC_SOURCE_CLOCK_SYSTEM = FMAN_RTC_SOURCE_CLOCK_SYSTEM,
+	/* RTC clock oscilator */
+	FM_RTC_SOURCE_CLOCK_OSCILATOR = FMAN_RTC_SOURCE_CLOCK_OSCILATOR
+};
+
+/* FM RTC configuration parameters structure.
+ * This structure should be passed to fm_rtc_config().
+ */
+struct fm_rtc_params_t {
+	void *h_fm;		/* FM Handle*/
+	uintptr_t base_address;	/* Base address of FM RTC registers */
+	/* A handle to an application layer object; This handle will
+	 * be passed by the driver upon calling the above callbacks
+	 */
+	void *h_app;
+};
+
+/* Function	fm_rtc_config
+ * Description	  Configures the FM RTC module according to user's parameters.
+ *		  The driver assigns default values to some FM RTC parameters.
+ *		  These parameters can be overwritten using the advanced
+ *		  configuration routines.
+ * Param[in]	  p_fm_rtc_param - FM RTC configuration parameters.
+ * Return	  Handle to the new FM RTC object; NULL pointer on failure.
+ * Cautions	  None
+ */
+void *fm_rtc_config(struct fm_rtc_params_t *p_fm_rtc_param);
+
+/* Function	fm_rtc_init
+ * Description	  Initializes the FM RTC driver and hardware.
+ * Param[in]	  fm_dev - Pointer to FM object
+ * Return	  0 on success; Error code otherwise.
+ * Cautions	  Must be called after fm_rtc_config and before fm_rt_init ().
+ */
+int fm_rtc_init(struct fm *fm_dev);
+
+/*Function	fm_rtc_free
+ *Description	  Frees the FM RTC object and all allocated resources.
+ * Param[in]	  fm_dev - Pointer to FM object
+ * Return	  0 on success; Error code otherwise.
+ * Cautions	  Must be called after fm_rtc_config and before fm_rt_init ().
+ */
+int fm_rtc_free(struct fm *fm_dev);
+
+/* FM RTC advanced configuration functions. */
+
+/* Function	fm_rtc_cfg_period
+ * Description	  Configures the period of the timestamp if different than
+ *		  default [DEFAULT_clockPeriod].
+ * Param[in]	  fm_dev - Pointer to FM object
+ * Param[in]	  period - Period in nano-seconds.
+ * Return	  0 on success; Error code otherwise.
+ * Cautions	  Must be called after fm_rtc_config and before fm_rt_init ().
+ */
+int fm_rtc_cfg_period(struct fm *fm_dev, uint32_t period);
+
+/* Function	fm_rtc_cfg_src_clk
+ * Description	  Configures the source clock of the RTC.
+ * Param[in]	  fm_dev - Pointer to FM object
+ * Param[in]	  src_clk - Source clock selection.
+ * Param[in]	  freq_in_mhz - the source-clock frequency (in MHz).
+ * Return	  0 on success; Error code otherwise.
+ * Cautions	  Must be called after fm_rtc_config and before fm_rt_init ().
+ */
+int fm_rtc_cfg_src_clk(struct fm *fm_dev, enum fm_src_clock src_clk,
+		       uint32_t freq_in_mhz);
+
+/* Function	fm_rtc_cfg_pulse_realign
+ * Description	  Configures the RTC to automatic FIPER pulse realignment in
+ *		  response to timer adjustments [DEFAULT_pulseRealign]
+ *		  In this mode, the RTC clock is identical to the source clock.
+ *		  This feature can be useful when the system contains an
+ *		  external RTC with inherent frequency compensation.
+ * Param[in]	  fm_dev - Pointer to FM object
+ * Param[in]	  enable - true to enable automatic realignment.
+ * Return	  0 on success; Error code otherwise.
+ * Cautions	  Must be called after fm_rtc_config and before fm_rt_init ().
+ */
+int fm_rtc_cfg_pulse_realign(struct fm *fm_dev, bool enable);
+
+/* Function	fm_rtc_cfg_freq_bypass
+ * Description	  Configures the RTC to bypass the frequency compensation
+ *		  mechanism. [DEFAULT_bypass]
+ *		  In this mode, the RTC clock is identical to the source clock.
+ *		  This feature can be useful when the system contains an
+ *		  external RTC with inherent frequency compensation.
+ * Param[in]	  fm_dev - Pointer to FM object
+ * Param[in]	  enabled - true to bypass frequency compensation;
+ * Return	  0 on success; Error code otherwise.
+ * Cautions	  Must be called after fm_rtc_config and before fm_rt_init ().
+ */
+int fm_rtc_cfg_freq_bypass(struct fm *fm_dev, bool enabled);
+
+/* Function      fm_rtc_cfg_inverted_in_clk_phase
+ * Description	  Configures the RTC to invert the source clock phase on input.
+ *		  [DEFAULT_invertInputClkPhase]
+ * Param[in]	  fm_dev - Pointer to FM object
+ * Param[in]	  inverted - true to invert the source clock phase on input.
+ *		  false otherwise.
+ * Return	  0 on success; Error code otherwise.
+ * Cautions	  Must be called after fm_rtc_config and before fm_rt_init ().
+ */
+int fm_rtc_cfg_inverted_in_clk_phase(struct fm *fm_dev, bool inverted);
+
+/* Function	fm_rtc_cfg_inverted_out_clk_phase
+ * Description	  Configures the RTC to invert the output clock phase.
+ *		  [DEFAULT_invertOutputClkPhase]
+ * Param[in]	  fm_dev - Pointer to FM object
+ * Param[in]	  inverted - true to invert the output clock phase.
+ * Return	  0 on success; Error code otherwise.
+ * Cautions	  Must be called after fm_rtc_config and before fm_rt_init ().
+ */
+int fm_rtc_cfg_inverted_out_clk_phase(struct fm *fm_dev, bool inverted);
+
+/* Function	  fm_rtc_cfg_out_clk_div
+ * Description	  Configures the divisor for generating the output clock from
+ *		  the RTC clock. [DEFAULT_output_clock_divisor]
+ * Param[in]	  fm_dev - Pointer to FM object
+ * Param[in]	  divisor - Divisor for generation of the output clock.
+ * Return	  0 on success; Error code otherwise.
+ * Cautions	  Must be called after fm_rtc_config and before fm_rt_init ().
+ */
+int fm_rtc_cfg_out_clk_div(struct fm *fm_dev, uint16_t div);
+
+/* Function	fm_rtc_cfg_alarm_polarity
+ * Description	  Configures the polarity (active-high/active-low) of a
+ *		  specific alarm signal. [DEFAULT_alarm_polarity]
+ * Param[in]	  fm_dev - Pointer to FM object
+ * Param[in]	  alarm_id - Alarm ID.
+ * Param[in]	  alarm_polarity - Alarm polarity.
+ * Return	  0 on success; Error code otherwise.
+ * Cautions	  Must be called after fm_rtc_config and before fm_rt_init ().
+ */
+int fm_rtc_cfg_alarm_polarity(struct fm *fm_dev, uint8_t alarm_id,
+			      enum fm_rtc_alarm_polarity alarm_polarity);
+
+/* Function	fm_rtc_cfg_extern_trigger_polarity
+ * Description	  Configures the polarity (rising/falling edge) of a specific
+ *		  external trigger signal. [DEFAULT_trigger_polarity]
+ * Param[in]	  fm_dev - Pointer to FM object
+ * Param[in]	  trigger_id - Trigger ID.
+ * Param[in]	  trigger_polarity - Trigger polarity.
+ * Return	  0 on success; Error code otherwise.
+ * Cautions	  Must be called after fm_rtc_config and before fm_rt_init ().
+ */
+int fm_rtc_cfg_extern_trigger_polarity(struct fm *fm_dev, uint8_t trigger_id,
+				       enum fm_rtc_trigger_polarity
+				       trigger_polarity);
+
+/* FM RTC runtime control API. */
+
+/* Function	  fm_rtc_exceptions_cb
+ * Description	  Exceptions user callback routine, used for RTC different
+ *		  mechanisms.
+ * Param[in]	  h_app - User's application descriptor.
+ * Param[in]	  id - source id.
+ */
+typedef void (fm_rtc_exceptions_cb) (void *h_app, uint8_t id);
+
+/* FM RTC alarm parameters */
+struct fm_rtc_alarm_params_t {
+	uint8_t alarm_id;   /*< 0 or 1 */
+	uint64_t alarm_time; /* In nanoseconds, the time when the alarm
+			      * should go off - must be a multiple of
+			      * the RTC period
+			      */
+	/* This routine will be called when RTC reaches alarm_time */
+	fm_rtc_exceptions_cb *f_alarm_callback;
+	bool clear_on_expiration; /* true to turn off the alarm once expired.*/
+};
+
+/* FM RTC Periodic Pulse parameters. */
+struct fm_rtc_periodic_pulse_params_t {
+	/* 0 or 1 */
+	uint8_t periodic_pulse_id;
+	/* In Nanoseconds. Must be a multiple of the RTC period */
+	uint64_t periodic_pulse_period;
+	/* This routine will be called every periodic_pulse_period. */
+	fm_rtc_exceptions_cb *f_periodic_pulse_callback;
+};
+
+/* FM RTC Periodic Pulse parameters. */
+struct fm_rtc_external_trigger_params_t {
+	uint8_t external_trigger_id; /* 0 or 1 */
+	bool use_pulse_as_input; /* Use the pulse interrupt instead of
+				  * an external signal
+				  */
+	/* This routine will be called every periodic_pulse_period. */
+	fm_rtc_exceptions_cb *f_external_trigger_callback;
+};
+
+/* Function	fm_rtc_enable
+ * Description	  Enable the RTC (time count is started).
+ * Param[in]	  fm_dev - Pointer to FM object
+ * Return	  0 on success; Error code otherwise.
+ * Cautions	  Must be called only after fm_rtc_init().
+ */
+int fm_rtc_enable(struct fm *fm_dev);
+
+/* Function	fm_rtc_disable
+ * Description	  Disable the RTC (time count is stopped).
+ * Param[in]	  fm_dev - Pointer to FM object
+ * Return	  0 on success; Error code otherwise.
+ * Cautions	  Must be called only after fm_rtc_init().
+ */
+int fm_rtc_disable(struct fm *fm_dev);
+
+/* Function	fm_rtc_set_clk_offset
+ * Description	  Sets the clock offset (usually relative to another clock).
+ *		  The user can pass a negative offset value.
+ * Param[in]	  fm_dev - Pointer to FM object
+ * Param[in]	  offset - New clock offset (in nanoseconds).
+ * Return	  0 on success; Error code otherwise.
+ * Cautions	  Must be called only after fm_rtc_init().
+ */
+int fm_rtc_set_clk_offset(struct fm *fm_dev, int64_t offset);
+
+/* Function	fm_rtc_set_alarm
+ * Description	  schedules an alarm event to a given RTC time.
+ * Param[in]	  fm_dev - Pointer to FM object
+ * Param[in]	  p_fm_rtc_alarm_params - Alarm parameters.
+ * Return	  0 on success; Error code otherwise.
+ * Cautions	  Must be called only after fm_rtc_init() and prior
+ *		  to fm_rtc_enable().
+ */
+int fm_rtc_set_alarm(struct fm *fm_dev,
+		     struct fm_rtc_alarm_params_t *p_fm_rtc_alarm_params);
+
+/* Function	fm_rtc_set_periodic_pulse
+ * Description	  Sets a periodic pulse.
+ * Param[in]	  fm_dev - Pointer to FM object
+ * Param[in]	  p_fm_rtc_periodic_pulse_params - Periodic pulse parameters.
+ * Return	  0 on success; Error code otherwise.
+ * Cautions	  Must be called only after fm_rtc_init() and prior
+ *		  to fm_rtc_enable().
+ */
+int fm_rtc_set_periodic_pulse(struct fm *fm_dev,
+			      struct fm_rtc_periodic_pulse_params_t *
+			      p_fm_rtc_periodic_pulse_params);
+
+/* Function	  fm_rtc_clear_periodic_pulse
+ * Description	  Clears a periodic pulse.
+ * Param[in]	  fm_dev - Pointer to FM object
+ * Param[in]	  periodic_pulse_id                 - Periodic pulse id.
+ * Return	  0 on success; Error code otherwise.
+ * Cautions	  Must be called only after fm_rtc_init().
+ */
+int fm_rtc_clear_periodic_pulse(struct fm *fm_dev,
+				uint8_t periodic_pulse_id);
+
+/* Function	fm_rtc_set_external_trigger
+ * Description	  Sets an external trigger indication and define a callback
+ *		  routine to be called on such event.
+ * Param[in]	  fm_dev - Pointer to FM object
+ * Param[in]	  p_fm_rtc_external_trigger_params- External Trigger
+ *		  parameters.
+ * Return	  0 on success; Error code otherwise.
+ * Cautions	  Must be called only after fm_rtc_init().
+ */
+int fm_rtc_set_external_trigger(struct fm *fm_dev,
+				struct fm_rtc_external_trigger_params_t *
+				p_fm_rtc_external_trigger_params);
+
+/* Function	fm_rtc_clear_external_trigger
+ * Description	  Clears external trigger indication.
+ * Param[in]	  fm_dev - Pointer to FM object
+ * Param[in]	  id - External Trigger id.
+ * Return	  0 on success; Error code otherwise.
+ * Cautions	  Must be called only after fm_rtc_init().
+ */
+int fm_rtc_clear_external_trigger(struct fm *fm_dev, uint8_t id);
+
+/* Function	  fm_rtc_get_external_trigger_time_stamp
+ * Description	  Reads the External Trigger TimeStamp.
+ * Param[in]	  fm_dev - Pointer to FM object
+ * Param[in]	  trigger_id - External Trigger id.
+ * Param[out]	  p_time_stamp - External Trigger timestamp
+ * Return	  0 on success; Error code otherwise.
+ * Cautions	  Must be called only after fm_rtc_init().
+ */
+int fm_rtc_get_external_trigger_time_stamp(struct fm *fm_dev,
+					   uint8_t trigger_id,
+					   uint64_t *p_time_stamp);
+
+/* Function	fm_rtc_get_cnt
+ * Description	  Returns the current RTC time.
+ * Param[in]	  fm_dev - Pointer to FM object
+ * Param[out]	  p_ts - returned time stamp (in nanoseconds).
+ * Return	  0 on success; Error code otherwise.
+ * Cautions	  Must be called only after fm_rtc_init().
+ */
+int fm_rtc_get_current_time(struct fm *fm_dev, uint64_t *p_ts);
+
+/* Function	  fm_rtc_set_current_time
+ * Description	  Sets the current RTC time.
+ * Param[in]	  fm_dev - Pointer to FM object
+ * Param[in]	  ts - The new time stamp (in nanoseconds).
+ * Return	  0 on success; Error code otherwise.
+ * Cautions	  Must be called only after fm_rtc_init().
+ */
+int fm_rtc_set_current_time(struct fm *fm_dev, uint64_t ts);
+
+/* Function	fm_rtc_get_freq_compensation
+ * Description	  Retrieves the frequency compensation value
+ * Param[in]	  fm_dev - Pointer to FM object
+ * Param[out]	  p_compensation - A pointer to the returned value of
+ *		  compensation.
+ * Return	  0 on success; Error code otherwise.
+ * Cautions	  Must be called only after fm_rtc_init().
+ */
+int fm_rtc_get_freq_compensation(struct fm *fm_dev,
+				 uint32_t *p_compensation);
+
+/* Function	fm_rtc_set_freq_compensation
+ * Description	  Sets a new frequency compensation value.
+ * Param[in]	  fm_dev - Pointer to FM object
+ * Param[in]	  freq_compensation - The new frequency compensation value
+ *		  to set.
+ * Return	  0 on success; Error code otherwise.
+ * Cautions	  Must be called only after fm_rtc_init().
+ */
+int fm_rtc_set_freq_compensation(struct fm *fm_dev,
+				 uint32_t freq_compensation);
+
+#endif /* __FM_RTC_EXT_H__ */
diff --git a/drivers/soc/fsl/fman/inc/fsl_fman_drv.h b/drivers/soc/fsl/fman/inc/fsl_fman_drv.h
index a0b88c2..4bef301 100644
--- a/drivers/soc/fsl/fman/inc/fsl_fman_drv.h
+++ b/drivers/soc/fsl/fman/inc/fsl_fman_drv.h
@@ -62,6 +62,9 @@ struct fm *fm_bind(struct device *fm_dev);
 void fm_unbind(struct fm *fm);
 
 void *fm_get_handle(struct fm *fm);
+#ifdef CONFIG_FSL_FMAN_RTC
+void *fm_get_rtc_handle(struct fm *fm);
+#endif
 struct resource *fm_get_mem_region(struct fm *fm);
 
 /*	fm_mutex_lock
diff --git a/drivers/soc/fsl/fman/rtc/Makefile b/drivers/soc/fsl/fman/rtc/Makefile
index c8b4477..b4b2fce 100644
--- a/drivers/soc/fsl/fman/rtc/Makefile
+++ b/drivers/soc/fsl/fman/rtc/Makefile
@@ -1,3 +1,3 @@
 obj-$(CONFIG_FSL_FMAN_RTC)	+= fsl_fman_rtc.o
 
-fsl_fman_rtc-objs		:= fman_rtc.o
+fsl_fman_rtc-objs		:= fman_rtc.o fm_rtc.o
diff --git a/drivers/soc/fsl/fman/rtc/fm_rtc.c b/drivers/soc/fsl/fman/rtc/fm_rtc.c
new file mode 100644
index 0000000..dc64527
--- /dev/null
+++ b/drivers/soc/fsl/fman/rtc/fm_rtc.c
@@ -0,0 +1,763 @@
+/*
+ * Copyright 2008 - 2015 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *	 notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *	 notice, this list of conditions and the following disclaimer in the
+ *	 documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *	 names of its contributors may be used to endorse or promote products
+ *	 derived from this software without specific prior written permission.
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include "service.h"
+
+#include "fm_rtc.h"
+#include "fm_common.h"
+
+#include <linux/string.h>
+#include <linux/slab.h>
+
+static int check_init_parameters(struct fm_rtc_t *p_rtc)
+{
+	struct rtc_cfg *p_rtc_drv_param = p_rtc->p_rtc_drv_param;
+	int i;
+
+	if ((p_rtc_drv_param->src_clk != FMAN_RTC_SOURCE_CLOCK_EXTERNAL) &&
+	    (p_rtc_drv_param->src_clk != FMAN_RTC_SOURCE_CLOCK_SYSTEM) &&
+	    (p_rtc_drv_param->src_clk != FMAN_RTC_SOURCE_CLOCK_OSCILATOR)) {
+		pr_err("Source clock undefined\n");
+		return -EINVAL;
+	}
+	if (p_rtc->output_clock_divisor == 0) {
+		pr_err("Divisor for output clock (should be positive)\n");
+		return -EDOM;
+	}
+
+	for (i = 0; i < p_rtc->rtc_intg.fm_rtc_num_of_alarms; i++) {
+		if ((p_rtc_drv_param->alarm_polarity[i] !=
+		     FMAN_RTC_ALARM_POLARITY_ACTIVE_LOW) &&
+		    (p_rtc_drv_param->alarm_polarity[i] !=
+		     FMAN_RTC_ALARM_POLARITY_ACTIVE_HIGH)) {
+			pr_err("Alarm %d signal polarity\n", i);
+			return -EBADRQC;
+		}
+	}
+	for (i = 0; i < p_rtc->rtc_intg.fm_rtc_num_of_ext_triggers; i++) {
+		if ((p_rtc_drv_param->trigger_polarity[i] !=
+		     FMAN_RTC_TRIGGER_ON_FALLING_EDGE) &&
+		     (p_rtc_drv_param->trigger_polarity[i] !=
+			FMAN_RTC_TRIGGER_ON_RISING_EDGE)) {
+			pr_err("Trigger %d signal polarity\n", i);
+			return -EBADRQC;
+		}
+	}
+
+	return 0;
+}
+
+/* Checks if p_rtc driver parameters were initialized
+ * returns 0 if success else returns error code
+ */
+static int is_init_done(struct rtc_cfg *p_rtc_drv_parameters)
+{
+	if (!p_rtc_drv_parameters)
+		return 0;
+	return -ENOSYS;
+}
+
+static void rtc_exceptions(void *h_fm_rtc)
+{
+	struct fm_rtc_t *p_rtc = (struct fm_rtc_t *)h_fm_rtc;
+	struct rtc_regs __iomem *p_mem_map;
+
+	register uint32_t events;
+
+	p_mem_map = p_rtc->p_mem_map;
+
+	events = fman_rtc_check_and_clear_event(p_mem_map);
+	if (events&FMAN_RTC_TMR_TEVENT_ALM1) {
+		if (p_rtc->alarm_params[0].clear_on_expiration) {
+			fman_rtc_set_timer_alarm_l(p_mem_map, 0, 0);
+			fman_rtc_disable_interrupt(p_mem_map,
+						   FMAN_RTC_TMR_TEVENT_ALM1);
+		}
+		ASSERT(p_rtc->alarm_params[0].f_alarm_callback);
+		p_rtc->alarm_params[0].f_alarm_callback(p_rtc->h_app, 0);
+	}
+	if (events&FMAN_RTC_TMR_TEVENT_ALM2) {
+		if (p_rtc->alarm_params[1].clear_on_expiration) {
+			fman_rtc_set_timer_alarm_l(p_mem_map, 1, 0);
+			fman_rtc_disable_interrupt(p_mem_map,
+						   FMAN_RTC_TMR_TEVENT_ALM2);
+		}
+		ASSERT(p_rtc->alarm_params[1].f_alarm_callback);
+		p_rtc->alarm_params[1].f_alarm_callback(p_rtc->h_app, 1);
+	}
+	if (events&FMAN_RTC_TMR_TEVENT_PP1) {
+		ASSERT(p_rtc->periodic_pulse_params[0].
+			    f_periodic_pulse_callback);
+		p_rtc->
+		periodic_pulse_params[0].f_periodic_pulse_callback(p_rtc->
+								   h_app, 0);
+	}
+	if (events&FMAN_RTC_TMR_TEVENT_PP2) {
+		ASSERT(p_rtc->periodic_pulse_params[1].
+			    f_periodic_pulse_callback);
+		p_rtc->
+		periodic_pulse_params[1].f_periodic_pulse_callback(p_rtc->
+								   h_app, 1);
+	}
+	if (events&FMAN_RTC_TMR_TEVENT_ETS1) {
+		ASSERT(p_rtc->external_trigger_params[0].
+			    f_external_trigger_callback);
+		p_rtc->external_trigger_params[0].
+		    f_external_trigger_callback(p_rtc->h_app, 0);
+	}
+	if (events&FMAN_RTC_TMR_TEVENT_ETS2) {
+		ASSERT(p_rtc->external_trigger_params[1].
+			    f_external_trigger_callback);
+		p_rtc->external_trigger_params[1].
+		    f_external_trigger_callback(p_rtc->h_app, 1);
+	}
+}
+
+static void set_rtc_intg_params(struct fm_rtc_t *p_rtc)
+{
+	struct fm_revision_info_t rev_info;
+
+	fm_get_revision(p_rtc->h_fm, &rev_info);
+
+	p_rtc->rtc_intg.fm_rtc_num_of_alarms = 2;
+	p_rtc->rtc_intg.fm_rtc_num_of_ext_triggers = 2;
+
+	if (rev_info.major_rev == 6)
+		p_rtc->rtc_intg.fm_rtc_num_of_periodic_pulses = 3;
+	else
+		p_rtc->rtc_intg.fm_rtc_num_of_periodic_pulses = 2;
+}
+
+void *fm_get_rtc_handle(struct fm *fm);
+
+void *fm_rtc_config(struct fm_rtc_params_t *p_fm_rtc_param)
+{
+	struct fm_rtc_t *p_rtc;
+
+	/* Allocate memory for the FM RTC driver parameters */
+	p_rtc = kzalloc(sizeof(*p_rtc), GFP_KERNEL);
+	if (!p_rtc)
+		return NULL;
+
+	/* Allocate memory for the FM RTC driver parameters */
+	p_rtc->p_rtc_drv_param = kzalloc(sizeof(*p_rtc->p_rtc_drv_param),
+					  GFP_KERNEL);
+	if (!p_rtc->p_rtc_drv_param) {
+		kfree(p_rtc);
+		return NULL;
+	}
+
+	/* Store RTC configuration parameters */
+	p_rtc->h_fm = p_fm_rtc_param->h_fm;
+
+	/* Set default RTC configuration parameters */
+	fman_rtc_defconfig(p_rtc->p_rtc_drv_param);
+
+	p_rtc->output_clock_divisor = DEFAULT_OUTPUT_CLOCK_DIVISOR;
+	p_rtc->p_rtc_drv_param->bypass = DEFAULT_BYPASS;
+	p_rtc->clk_period_nano_sec = DEFAULT_CLOCK_PERIOD;	/* 1 usec */
+
+	/* Store RTC parameters in the RTC control structure */
+	p_rtc->p_mem_map = (struct rtc_regs __iomem *)
+	    UINT_TO_PTR(p_fm_rtc_param->base_address);
+	p_rtc->h_app = p_fm_rtc_param->h_app;
+
+	set_rtc_intg_params(p_rtc);
+
+	return p_rtc;
+}
+
+int fm_rtc_init(struct fm *fm_dev)
+{
+	struct fm_rtc_t *p_rtc = fm_get_rtc_handle(fm_dev);
+	struct rtc_cfg *p_rtc_drv_param;
+	struct rtc_regs __iomem *p_mem_map;
+	uint32_t freq_compensation = 0;
+	uint64_t tmp_double;
+	bool init_freq_comp = false;
+
+	p_rtc_drv_param = p_rtc->p_rtc_drv_param;
+	p_mem_map = p_rtc->p_mem_map;
+
+	if (check_init_parameters(p_rtc) != 0) {
+		pr_err("Init Parameters are not Valid\n");
+		return -EINVAL;
+	}
+	/* TODO check that no timestamping MACs are working in this stage. */
+
+	/* find source clock frequency in Mhz */
+	if (p_rtc->p_rtc_drv_param->src_clk != FMAN_RTC_SOURCE_CLOCK_SYSTEM)
+		p_rtc->src_clk_freq_mhz =
+		    p_rtc->p_rtc_drv_param->ext_src_clk_freq;
+	else
+		p_rtc->src_clk_freq_mhz =
+		    (uint32_t)(fm_get_clock_freq(p_rtc->h_fm) / 2);
+
+	/* if timer in Master mode Initialize TMR_CTRL */
+	/* We want the counter (TMR_CNT) to count in nano-seconds */
+	if (!p_rtc_drv_param->timer_slave_mode &&
+	    p_rtc->p_rtc_drv_param->bypass)
+		p_rtc->clk_period_nano_sec = (1000 / p_rtc->src_clk_freq_mhz);
+	else {
+		/* Initialize TMR_ADD with the initial frequency compensation
+		 * value:freq_compensation = (2^32 / frequency ratio)
+		 * frequency ratio = sorce clock/rtc clock =
+		 * (p_rtc->src_clk_freq_mhz*1000000))/ 1/(p_rtc->
+		 * clk_period_nano_sec*1000000000)
+		 */
+		init_freq_comp = true;
+		freq_compensation =
+		    (uint32_t)DIV_CEIL(ACCUMULATOR_OVERFLOW*1000,
+					p_rtc->clk_period_nano_sec *
+					p_rtc->src_clk_freq_mhz);
+	}
+
+	/* check the legality of the relation between source
+	 * and destination clocks
+	 */
+	/* should be larger than 1.0001 */
+	tmp_double = 10000*(uint64_t)p_rtc->clk_period_nano_sec *
+					(uint64_t)p_rtc->src_clk_freq_mhz;
+	if ((tmp_double) <= 10001) {
+		pr_err("Relation bet src, dest clk should be >1.0001\n");
+		return -EINVAL;
+	}
+	fman_rtc_init(p_rtc_drv_param,
+		      p_mem_map,
+		      p_rtc->rtc_intg.fm_rtc_num_of_alarms,
+		      p_rtc->rtc_intg.fm_rtc_num_of_periodic_pulses,
+		      p_rtc->rtc_intg.fm_rtc_num_of_ext_triggers,
+		      init_freq_comp,
+		      freq_compensation,
+		      p_rtc->output_clock_divisor);
+
+	/* Register the FM RTC interrupt */
+	fm_register_intr(p_rtc->h_fm, FM_MOD_TMR, 0, FM_INTR_TYPE_NORMAL,
+			 rtc_exceptions, p_rtc);
+
+	/* Free parameters structures */
+	kfree(p_rtc->p_rtc_drv_param);
+	p_rtc->p_rtc_drv_param = NULL;
+
+	return 0;
+}
+
+int fm_rtc_free(struct fm *fm_dev)
+{
+	struct fm_rtc_t *p_rtc = fm_get_rtc_handle(fm_dev);
+
+	if (!p_rtc->p_rtc_drv_param)
+		fman_rtc_disable(p_rtc->p_mem_map);
+	else
+		kfree(p_rtc->p_rtc_drv_param);
+
+	/* Unregister FM RTC interrupt */
+	fm_unregister_intr(p_rtc->h_fm, FM_MOD_TMR, 0, FM_INTR_TYPE_NORMAL);
+	kfree(p_rtc);
+
+	return 0;
+}
+
+int fm_rtc_cfg_src_clk(struct fm *fm_dev, enum fm_src_clock src_clk,
+		       uint32_t freq_in_mhz)
+{
+	struct fm_rtc_t *p_rtc = fm_get_rtc_handle(fm_dev);
+	int ret;
+
+	ret = is_init_done(p_rtc->p_rtc_drv_param);
+	if (!ret)
+		return -ENOSYS;
+
+	p_rtc->p_rtc_drv_param->src_clk = (enum fman_src_clock)src_clk;
+	if (src_clk != FM_RTC_SOURCE_CLOCK_SYSTEM)
+		p_rtc->p_rtc_drv_param->ext_src_clk_freq = freq_in_mhz;
+
+	return 0;
+}
+
+int fm_rtc_cfg_period(struct fm *fm_dev, uint32_t period)
+{
+	struct fm_rtc_t *p_rtc = fm_get_rtc_handle(fm_dev);
+	int ret;
+
+	ret = is_init_done(p_rtc->p_rtc_drv_param);
+	if (!ret)
+		return -ENOSYS;
+
+	p_rtc->clk_period_nano_sec = period;
+
+	return 0;
+}
+
+int fm_rtc_cfg_freq_bypass(struct fm *fm_dev, bool enabled)
+{
+	struct fm_rtc_t *p_rtc = fm_get_rtc_handle(fm_dev);
+	int ret;
+
+	ret = is_init_done(p_rtc->p_rtc_drv_param);
+	if (!ret)
+		return -ENOSYS;
+
+	p_rtc->p_rtc_drv_param->bypass = enabled;
+
+	return 0;
+}
+
+int fm_rtc_cfg_inverted_in_clk_phase(struct fm *fm_dev, bool inverted)
+{
+	struct fm_rtc_t *p_rtc = fm_get_rtc_handle(fm_dev);
+	int ret;
+
+	ret = is_init_done(p_rtc->p_rtc_drv_param);
+	if (!ret)
+		return -ENOSYS;
+
+	p_rtc->p_rtc_drv_param->invert_input_clk_phase = inverted;
+
+	return 0;
+}
+
+int fm_rtc_cfg_inverted_out_clk_phase(struct fm *fm_dev, bool inverted)
+{
+	struct fm_rtc_t *p_rtc = fm_get_rtc_handle(fm_dev);
+	int ret;
+
+	ret = is_init_done(p_rtc->p_rtc_drv_param);
+	if (!ret)
+		return -ENOSYS;
+
+	p_rtc->p_rtc_drv_param->invert_output_clk_phase = inverted;
+
+	return 0;
+}
+
+int fm_rtc_cfg_out_clk_div(struct fm *fm_dev, uint16_t div)
+{
+	struct fm_rtc_t *p_rtc = fm_get_rtc_handle(fm_dev);
+	int ret;
+
+	ret = is_init_done(p_rtc->p_rtc_drv_param);
+	if (!ret)
+		return -ENOSYS;
+
+	p_rtc->output_clock_divisor = div;
+
+	return 0;
+}
+
+int fm_rtc_cfg_pulse_realign(struct fm *fm_dev, bool enable)
+{
+	struct fm_rtc_t *p_rtc = fm_get_rtc_handle(fm_dev);
+	int ret;
+
+	ret = is_init_done(p_rtc->p_rtc_drv_param);
+	if (!ret)
+		return -ENOSYS;
+
+	p_rtc->p_rtc_drv_param->pulse_realign = enable;
+
+	return 0;
+}
+
+int fm_rtc_cfg_alarm_polarity(struct fm *fm_dev, uint8_t alarm_id,
+			      enum fm_rtc_alarm_polarity alarm_polarity)
+{
+	struct fm_rtc_t *p_rtc = fm_get_rtc_handle(fm_dev);
+	int ret;
+
+	ret = is_init_done(p_rtc->p_rtc_drv_param);
+	if (!ret)
+		return -ENOSYS;
+
+	if (alarm_id >= p_rtc->rtc_intg.fm_rtc_num_of_alarms) {
+		pr_err("Alarm ID\n");
+		return -EBADRQC;
+	}
+
+	p_rtc->p_rtc_drv_param->alarm_polarity[alarm_id] =
+	    (enum fman_rtc_alarm_polarity)alarm_polarity;
+
+	return 0;
+}
+
+int fm_rtc_cfg_extern_trigger_polarity(struct fm *fm_dev, uint8_t trigger_id,
+				       enum fm_rtc_trigger_polarity
+				       trigger_polarity)
+{
+	struct fm_rtc_t *p_rtc = fm_get_rtc_handle(fm_dev);
+	int ret;
+
+	ret = is_init_done(p_rtc->p_rtc_drv_param);
+	if (!ret)
+		return -ENOSYS;
+
+	if (trigger_id >= p_rtc->rtc_intg.fm_rtc_num_of_ext_triggers) {
+		pr_err("External trigger ID\n");
+		return -EBADRQC;
+	}
+
+	p_rtc->p_rtc_drv_param->trigger_polarity[trigger_id] =
+	    (enum fman_rtc_trigger_polarity)trigger_polarity;
+
+	return 0;
+}
+
+int fm_rtc_enable(struct fm *fm_dev)
+{
+	bool reset_clock = 0;
+	struct fm_rtc_t *p_rtc = fm_get_rtc_handle(fm_dev);
+	int ret;
+
+	ret = is_init_done(p_rtc->p_rtc_drv_param);
+	if (ret)
+		return ret;
+
+	fman_rtc_enable(p_rtc->p_mem_map, reset_clock);
+	return 0;
+}
+EXPORT_SYMBOL(fm_rtc_enable);
+
+int fm_rtc_disable(struct fm *fm_dev)
+{
+	struct fm_rtc_t *p_rtc = fm_get_rtc_handle(fm_dev);
+	int ret;
+
+	ret = is_init_done(p_rtc->p_rtc_drv_param);
+	if (ret)
+		return ret;
+
+	/* TODO A check must be added here, that no timestamping MAC's
+	 * are working in this stage.
+	 */
+	fman_rtc_disable(p_rtc->p_mem_map);
+	return 0;
+}
+EXPORT_SYMBOL(fm_rtc_disable);
+
+int fm_rtc_set_clk_offset(struct fm *fm_dev, int64_t offset)
+{
+	struct fm_rtc_t *p_rtc = fm_get_rtc_handle(fm_dev);
+	int ret;
+
+	ret = is_init_done(p_rtc->p_rtc_drv_param);
+	if (ret)
+		return ret;
+
+	fman_rtc_set_timer_offset(p_rtc->p_mem_map, offset);
+	return 0;
+}
+
+int fm_rtc_set_alarm(struct fm *fm_dev,
+		     struct fm_rtc_alarm_params_t *p_fm_rtc_alarm_params)
+{
+	struct fm_rtc_t *p_rtc = fm_get_rtc_handle(fm_dev);
+	uint64_t tmp_alarm;
+	bool enable = false;
+	int ret;
+	u64 reminder;
+
+	ret = is_init_done(p_rtc->p_rtc_drv_param);
+	if (ret)
+		return ret;
+
+	if (p_fm_rtc_alarm_params->alarm_id >=
+		p_rtc->rtc_intg.fm_rtc_num_of_alarms) {
+		pr_err("Alarm ID\n");
+		return -EBADRQC;
+	}
+	if (p_fm_rtc_alarm_params->alarm_time < p_rtc->clk_period_nano_sec) {
+		pr_err("Alarm time must be >= RTC period - %d ns\n",
+		       p_rtc->clk_period_nano_sec);
+		return -EBADRQC;
+	}
+
+	div64_u64_rem(p_fm_rtc_alarm_params->alarm_time,
+		      (uint64_t)p_rtc->clk_period_nano_sec,
+		      &reminder);
+
+	if (reminder) {
+		pr_err("Alarm time must be multiple of RTCperiod-%d ns\n",
+		       p_rtc->clk_period_nano_sec);
+		return -EBADRQC;
+	}
+	tmp_alarm = div64_u64(p_fm_rtc_alarm_params->alarm_time,
+			      (uint64_t)p_rtc->clk_period_nano_sec);
+
+	if (p_fm_rtc_alarm_params->f_alarm_callback) {
+		p_rtc->alarm_params[p_fm_rtc_alarm_params->alarm_id].
+		    f_alarm_callback = p_fm_rtc_alarm_params->f_alarm_callback;
+		p_rtc->alarm_params[p_fm_rtc_alarm_params->alarm_id].
+		    clear_on_expiration = p_fm_rtc_alarm_params->
+					  clear_on_expiration;
+		enable = true;
+	}
+
+	fman_rtc_set_alarm(p_rtc->p_mem_map, p_fm_rtc_alarm_params->alarm_id,
+			   (unsigned long)tmp_alarm, enable);
+
+	return 0;
+}
+EXPORT_SYMBOL(fm_rtc_set_alarm);
+
+int fm_rtc_set_periodic_pulse(struct fm *fm_dev,
+			      struct fm_rtc_periodic_pulse_params_t *
+			      p_fm_rtc_periodic_pulse_params)
+{
+	struct fm_rtc_t *p_rtc = fm_get_rtc_handle(fm_dev);
+	bool enable = false;
+	uint64_t tmp_fiper;
+	int ret;
+	u64 reminder;
+
+	ret = is_init_done(p_rtc->p_rtc_drv_param);
+	if (ret)
+		return ret;
+
+	if (p_fm_rtc_periodic_pulse_params->periodic_pulse_id >=
+	    p_rtc->rtc_intg.fm_rtc_num_of_periodic_pulses) {
+		pr_err("Periodic pulse ID\n");
+		return -EBADRQC;
+	}
+	if (fman_rtc_is_enabled(p_rtc->p_mem_map)) {
+		pr_err("Can't set Periodic pulse when RTC is enable.\n");
+		return -EBADRQC;
+	}
+	if (p_fm_rtc_periodic_pulse_params->periodic_pulse_period <
+	      p_rtc->clk_period_nano_sec) {
+		pr_err("Periodic pulse must be >= RTC period - %d ns\n",
+		       p_rtc->clk_period_nano_sec);
+		return -EBADRQC;
+	}
+	div64_u64_rem(p_fm_rtc_periodic_pulse_params->periodic_pulse_period,
+		      (uint64_t)p_rtc->clk_period_nano_sec,
+		      &reminder);
+	if (reminder) {
+		pr_err("Periodic pulse is multiple of RTC period-%dns\n",
+		       p_rtc->clk_period_nano_sec);
+		return -EBADRQC;
+	}
+	tmp_fiper = div64_u64(
+			p_fm_rtc_periodic_pulse_params->periodic_pulse_period,
+			(uint64_t)p_rtc->clk_period_nano_sec);
+	if (tmp_fiper&0xffffffff00000000LL) {
+		pr_err("Periodic pulse/RTC Period (=%d) > 4294967296\n",
+		       p_rtc->clk_period_nano_sec);
+		return -EBADRQC;
+	}
+	if (p_fm_rtc_periodic_pulse_params->f_periodic_pulse_callback) {
+		p_rtc->periodic_pulse_params[p_fm_rtc_periodic_pulse_params->
+		periodic_pulse_id].f_periodic_pulse_callback =
+		    p_fm_rtc_periodic_pulse_params->f_periodic_pulse_callback;
+		    enable = true;
+	}
+	fman_rtc_set_periodic_pulse(p_rtc->p_mem_map,
+				    p_fm_rtc_periodic_pulse_params->
+				    periodic_pulse_id,
+				    (uint32_t)tmp_fiper, enable);
+	return 0;
+}
+EXPORT_SYMBOL(fm_rtc_set_periodic_pulse);
+
+int fm_rtc_clear_periodic_pulse(struct fm *fm_dev,
+				uint8_t periodic_pulse_id)
+{
+	struct fm_rtc_t *p_rtc = fm_get_rtc_handle(fm_dev);
+	int ret;
+
+	ret = is_init_done(p_rtc->p_rtc_drv_param);
+	if (ret)
+		return ret;
+
+	if (periodic_pulse_id >=
+		p_rtc->rtc_intg.fm_rtc_num_of_periodic_pulses) {
+		pr_err("Periodic pulse ID\n");
+		return -EBADRQC;
+	}
+
+	p_rtc->
+	periodic_pulse_params[periodic_pulse_id].f_periodic_pulse_callback =
+	    NULL;
+	fman_rtc_clear_periodic_pulse(p_rtc->p_mem_map, periodic_pulse_id);
+
+	return 0;
+}
+
+int fm_rtc_set_external_trigger(struct fm *fm_dev,
+				struct fm_rtc_external_trigger_params_t *
+				p_fm_rtc_external_trigger_params)
+{
+	struct fm_rtc_t *p_rtc = fm_get_rtc_handle(fm_dev);
+	bool enable = false;
+	int ret;
+
+	ret = is_init_done(p_rtc->p_rtc_drv_param);
+	if (ret)
+		return ret;
+
+	if (p_fm_rtc_external_trigger_params->external_trigger_id >=
+	    p_rtc->rtc_intg.fm_rtc_num_of_ext_triggers) {
+		pr_err("External Trigger ID\n");
+		return -EBADRQC;
+	}
+
+	if (p_fm_rtc_external_trigger_params->f_external_trigger_callback) {
+		p_rtc->
+		external_trigger_params[p_fm_rtc_external_trigger_params->
+					     external_trigger_id].
+		    f_external_trigger_callback =
+		    p_fm_rtc_external_trigger_params->
+		    f_external_trigger_callback;
+		enable = true;
+	}
+
+	fman_rtc_set_ext_trigger(p_rtc->p_mem_map,
+				 p_fm_rtc_external_trigger_params->
+				 external_trigger_id, enable,
+				 p_fm_rtc_external_trigger_params->
+				 use_pulse_as_input);
+	return 0;
+}
+
+int fm_rtc_clear_external_trigger(struct fm *fm_dev,
+				  uint8_t external_trigger_id)
+{
+	struct fm_rtc_t *p_rtc = fm_get_rtc_handle(fm_dev);
+	int ret;
+
+	ret = is_init_done(p_rtc->p_rtc_drv_param);
+	if (ret)
+		return ret;
+
+	if (external_trigger_id >= p_rtc->rtc_intg.
+	    fm_rtc_num_of_ext_triggers) {
+		pr_err("External Trigger ID\n");
+		return -EBADRQC;
+	}
+
+	p_rtc->external_trigger_params[external_trigger_id].
+	    f_external_trigger_callback = NULL;
+
+	fman_rtc_clear_external_trigger(p_rtc->p_mem_map, external_trigger_id);
+
+	return 0;
+}
+
+int fm_rtc_get_external_trigger_time_stamp(struct fm *fm_dev,
+					   uint8_t trigger_id,
+					   uint64_t *p_time_stamp)
+{
+	struct fm_rtc_t *p_rtc = fm_get_rtc_handle(fm_dev);
+	int ret;
+
+	ret = is_init_done(p_rtc->p_rtc_drv_param);
+	if (ret)
+		return ret;
+
+	if (trigger_id >= p_rtc->rtc_intg.fm_rtc_num_of_ext_triggers) {
+		pr_err("External trigger ID");
+		return -EBADRQC;
+	}
+	*p_time_stamp =
+	    fman_rtc_get_trigger_stamp(p_rtc->p_mem_map,
+				       trigger_id)*p_rtc->
+				       clk_period_nano_sec;
+
+	return 0;
+}
+
+int fm_rtc_get_current_time(struct fm *fm_dev, uint64_t *p_ts)
+{
+	struct fm_rtc_t *p_rtc = fm_get_rtc_handle(fm_dev);
+	int ret;
+
+	ret = is_init_done(p_rtc->p_rtc_drv_param);
+	if (ret)
+		return ret;
+
+	*p_ts = fman_rtc_get_timer(p_rtc->p_mem_map) *
+						p_rtc->clk_period_nano_sec;
+
+	return 0;
+}
+EXPORT_SYMBOL(fm_rtc_get_current_time);
+
+int fm_rtc_set_current_time(struct fm *fm_dev, uint64_t ts)
+{
+	struct fm_rtc_t *p_rtc = fm_get_rtc_handle(fm_dev);
+	int ret;
+
+	ret = is_init_done(p_rtc->p_rtc_drv_param);
+	if (ret)
+		return ret;
+
+	ts = div64_u64(ts, p_rtc->clk_period_nano_sec);
+	fman_rtc_set_timer(p_rtc->p_mem_map, (unsigned long)ts);
+
+	return 0;
+}
+EXPORT_SYMBOL(fm_rtc_set_current_time);
+
+int fm_rtc_get_freq_compensation(struct fm *fm_dev,
+				 uint32_t *p_compensation)
+{
+	struct fm_rtc_t *p_rtc = fm_get_rtc_handle(fm_dev);
+	int ret;
+
+	ret = is_init_done(p_rtc->p_rtc_drv_param);
+	if (ret)
+		return ret;
+
+	*p_compensation =
+			fman_rtc_get_frequency_compensation(p_rtc->p_mem_map);
+
+	return 0;
+}
+EXPORT_SYMBOL(fm_rtc_get_freq_compensation);
+
+int fm_rtc_set_freq_compensation(struct fm *fm_dev,
+				 uint32_t freq_compensation)
+{
+	struct fm_rtc_t *p_rtc = fm_get_rtc_handle(fm_dev);
+	int ret;
+
+	ret = is_init_done(p_rtc->p_rtc_drv_param);
+	if (ret)
+		return ret;
+
+	/* set the new freq_compensation */
+	fman_rtc_set_frequency_compensation(p_rtc->p_mem_map,
+					    freq_compensation);
+
+	return 0;
+}
+EXPORT_SYMBOL(fm_rtc_set_freq_compensation);
diff --git a/drivers/soc/fsl/fman/rtc/fm_rtc.h b/drivers/soc/fsl/fman/rtc/fm_rtc.h
new file mode 100644
index 0000000..c4774e7
--- /dev/null
+++ b/drivers/soc/fsl/fman/rtc/fm_rtc.h
@@ -0,0 +1,89 @@
+/*
+ * Copyright 2008 - 2015 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *	 notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *	 notice, this list of conditions and the following disclaimer in the
+ *	 documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *	 names of its contributors may be used to endorse or promote products
+ *	 derived from this software without specific prior written permission.
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+/* Memory map and internal definitions for FM RTC IEEE1588 Timer driver. */
+
+#ifndef __FM_RTC_H__
+#define __FM_RTC_H__
+
+#include "service.h"
+#include "fm_rtc_ext.h"
+#include "dpaa_integration_ext.h"
+
+/* General definitions */
+
+#define ACCUMULATOR_OVERFLOW            ((uint64_t)(1LL << 32))
+#define DEFAULT_OUTPUT_CLOCK_DIVISOR     0x00000002
+#define DEFAULT_BYPASS			 false
+#define DEFAULT_CLOCK_PERIOD             1000
+
+struct fm_rtc_alarm_t {
+	fm_rtc_exceptions_cb *f_alarm_callback;
+	bool clear_on_expiration;
+};
+
+struct fm_rtc_periodic_pulse_t {
+	fm_rtc_exceptions_cb *f_periodic_pulse_callback;
+};
+
+struct fm_rtc_external_trigger_t {
+	fm_rtc_exceptions_cb *f_external_trigger_callback;
+};
+
+struct fm_rtc_intg_t {
+	uint32_t fm_rtc_num_of_alarms;
+	uint32_t fm_rtc_num_of_periodic_pulses;
+	uint32_t fm_rtc_num_of_ext_triggers;
+};
+
+/* RTC FM driver control structure. */
+struct fm_rtc_t {
+	void *h_fm;
+	/* Application handle */
+	void *h_app;
+	struct rtc_regs __iomem *p_mem_map;
+	/* RTC clock period in nano-seconds (for FS mode) */
+	uint32_t clk_period_nano_sec;
+	uint32_t src_clk_freq_mhz;
+	/* Output clock divisor (for FS mode) */
+	uint16_t output_clock_divisor;
+	struct fm_rtc_alarm_t alarm_params[FM_RTC_NUM_OF_ALARMS];
+	struct fm_rtc_periodic_pulse_t
+	    periodic_pulse_params[FM_RTC_NUM_OF_PERIODIC_PULSES];
+	struct fm_rtc_external_trigger_t
+	    external_trigger_params[FM_RTC_NUM_OF_EXT_TRIGGERS];
+	/* RTC Driver parameters (for Init phase) */
+	struct rtc_cfg *p_rtc_drv_param;
+	/* RTC Driver integration params */
+	struct fm_rtc_intg_t rtc_intg;
+};
+
+#endif /* __FM_RTC_H__ */
-- 
1.7.9.5

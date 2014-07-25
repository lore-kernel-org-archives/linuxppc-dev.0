Return-Path: <guangyu.chen@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0141.outbound.protection.outlook.com [207.46.163.141])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 048CB1A095B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jul 2014 15:41:51 +1000 (EST)
Date: Fri, 25 Jul 2014 13:30:52 +0800
From: Nicolin Chen <Guangyu.Chen@freescale.com>
To: Varka Bhadram <varkabhadram@gmail.com>
Subject: Re: [PATCH v3 2/2] ASoC: fsl_asrc: Add ASRC ASoC CPU DAI and
 platform drivers
Message-ID: <20140725053051.GB29136@MrMyself>
References: <cover.1406259578.git.nicoleotsuka@gmail.com>
 <f4ff79269a1680f9ce128e0e98fea926d3a41834.1406259578.git.nicoleotsuka@gmail.com>
 <53D1DC0B.1000905@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <53D1DC0B.1000905@gmail.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, b42378@freescale.com, timur@tabi.org,
 pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, tiwai@suse.de,
 linux-kernel@vger.kernel.org, rdunlap@infradead.org, b02247@freescale.com,
 lgirdwood@gmail.com, robh+dt@kernel.org, perex@perex.cz,
 Nicolin Chen <nicoleotsuka@gmail.com>, broonie@kernel.org,
 galak@codeaurora.org, grant.likely@linaro.org, tklauser@distanz.ch,
 shawn.guo@linaro.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Varka,

On Fri, Jul 25, 2014 at 09:54:43AM +0530, Varka Bhadram wrote:
> On 07/25/2014 09:33 AM, Nicolin Chen wrote:
> >The Asynchronous Sample Rate Converter (ASRC) converts the sampling rate of a
> >signal associated with an input clock into a signal associated with a different
> >output clock. The driver currently works as a Front End of DPCM with other Back
> >Ends DAI links such as ESAI<->CS42888 and SSI<->WM8962 and SAI. It converts the
> >original sample rate to a common rate supported by Back Ends for playback while
> >converts the common rate of Back Ends to a desired rate for capture. It has 3
> >pairs to support three different substreams within totally 10 channels.
> >
> (...)
> 
> >+Required properties:
> >+
> >+  - compatible : Compatible list, must contain "fsl,imx35-asrc" or
> >+    "fsl,imx53-asrc".
> >+
> >+  - reg : Offset and length of the register set for the device.
> >+
> >+  - interrupts : Contains the spdif interrupt.
> >+
> >+  - dmas : Generic dma devicetree binding as described in
> >+	   Documentation/devicetree/bindings/dma/dma.txt.
> >+
> >+  - dma-names : Six dmas have to be defined: "rxa", "rxb", "rxc", "txa", "txb",
> >+		and "txc".
> >+
> >+  - clocks : Contains an entry for each entry in clock-names.
> >+
> >+  - clock-names : Includes the following entries:
> >+	"mem"		Peripheral access clock to access registers.
> >+	"ipg"		Peripheral clock to driver module.
> >+	"asrck_<0-f>"	Clock sources for input and output clock.
> >+
> >+   - big-endian : If this property is absent, the native endian mode will
> >+		  be in use as default, or the big endian mode will be in use
> >+		  for all the device registers.
> >+
> >+   - fsl,asrc-rate : Defines a mutual sample rate used by Back End DAI link.
> >+
> >+   - fsl,asrc-width : Defines a mutual sample width used by Back End DAI link.
> >+
> 
> indentation for the properties....
> 
> - compatible		: Should be "fsl,imx35-asrc" or "fsl,imx53-asrc".
> - reg			: Offset and length of the register set for the device.
> ....
> 
> (...)
> 
> >+
> >+static const struct platform_device_id fsl_asrc_devtype[] = {
> >+	{
> >+		.name = "imx35-asrc",
> >+		.driver_data = IMX35_ASRC,
> >+	}, {
> >+		.name = "imx53-asrc",
> >+		.driver_data = IMX53_ASRC,
> >+	}, {
> >+		/* sentinel */
> >+	}
> >+};
> >+MODULE_DEVICE_TABLE(platform, fsl_asrc_devtype);
> >+
> >+static const struct of_device_id fsl_asrc_ids[] = {
> >+	{
> >+		.compatible = "fsl,imx35-asrc",
> >+		.data = &fsl_asrc_devtype[IMX35_ASRC],
> >+	}, {
> >+		.compatible = "fsl,imx53-asrc",
> >+		.data = &fsl_asrc_devtype[IMX53_ASRC],
> >+	}, {
> >+		/* sentinel */
> >+	}
> >+};
> >+MODULE_DEVICE_TABLE(of, fsl_asrc_ids);
> >+
> 
> move these ids after probe/remove... every driver follows same thing...
> 
> >+static irqreturn_t fsl_asrc_isr(int irq, void *dev_id)
> >+{
> >+	struct fsl_asrc *asrc_priv = (struct fsl_asrc *)dev_id;
> >+	struct device *dev = &asrc_priv->pdev->dev;
> >+	enum asrc_pair_index index;
> >+	u32 status;
> >+
> >+	regmap_read(asrc_priv->regmap, REG_ASRSTR, &status);
> >+
> >+	/* Clean overload error */
> >+	regmap_write(asrc_priv->regmap, REG_ASRSTR, ASRSTR_AOLE);
> >+
> >+	/*
> >+	 * We here use dev_dbg() for all exceptions because ASRC itself does
> >+	 * not care if FIFO overflowed or underrun while a warning in the
> >+	 * interrupt would result a ridged conversion.
> >+	 */
> >+	for (index = ASRC_PAIR_A; index < ASRC_PAIR_MAX_NUM; index++) {
> >+		if (!asrc_priv->pair[index])
> >+			continue;
> >+
> >+		if (status & ASRSTR_ATQOL) {
> >+			asrc_priv->pair[index]->error |= ASRC_TASK_Q_OVERLOAD;
> >+			dev_dbg(dev, "ASRC Task Queue FIFO overload");
> 
> missed terminating new line (\n)...
> 
> >+		}
> >+
> >+		if (status & ASRSTR_AOOL(index)) {
> >+			asrc_priv->pair[index]->error |= ASRC_OUTPUT_TASK_OVERLOAD;
> >+			pair_dbg("Output Task Overload");
> 
> same
> 
> >+		}
> >+
> >+		if (status & ASRSTR_AIOL(index)) {
> >+			asrc_priv->pair[index]->error |= ASRC_INPUT_TASK_OVERLOAD;
> >+			pair_dbg("Input Task Overload");
> 
> same
> 
> >+		}
> >+
> >+		if (status & ASRSTR_AODO(index)) {
> >+			asrc_priv->pair[index]->error |= ASRC_OUTPUT_BUFFER_OVERFLOW;
> >+			pair_dbg("Output Data Buffer has overflowed");
> 
> same
> 
> >+		}
> >+
> >+		if (status & ASRSTR_AIDU(index)) {
> >+			asrc_priv->pair[index]->error |= ASRC_INPUT_BUFFER_UNDERRUN;
> >+			pair_dbg("Input Data Buffer has underflowed");
> 
> same..
> 
> >+		}
> >+	}
> >+
> >+	return IRQ_HANDLED;
> >+}
> >+
> 
> (...)
> 
> >+/**
> >+ * Configure input and output thresholds
> >+ */
> >+static int fsl_asrc_set_watermarks(struct fsl_asrc_pair *pair, u32 in, u32 out)
> >+{
> 
> static void for function..?
> 
> >+	struct fsl_asrc *asrc_priv = pair->asrc_priv;
> >+	enum asrc_pair_index index = pair->index;
> >+
> >+	regmap_update_bits(asrc_priv->regmap, REG_ASRMCR(index),
> >+			   ASRMCRi_EXTTHRSHi_MASK |
> >+			   ASRMCRi_INFIFO_THRESHOLD_MASK |
> >+			   ASRMCRi_OUTFIFO_THRESHOLD_MASK,
> >+			   ASRMCRi_EXTTHRSHi |
> >+			   ASRMCRi_INFIFO_THRESHOLD(in) |
> >+			   ASRMCRi_OUTFIFO_THRESHOLD(out));
> >+
> >+	return 0;
> >+}
> 
> (...)
> 
> >+static const struct dev_pm_ops fsl_asrc_pm = {
> >+	SET_RUNTIME_PM_OPS(fsl_asrc_runtime_suspend, fsl_asrc_runtime_resume, NULL)
> >+	SET_SYSTEM_SLEEP_PM_OPS(fsl_asrc_suspend, fsl_asrc_resume)
> >+};
> >+
> 
> move device ids to here...

I'll fix them all in v4.

Thank you,
Nicolin

---

> 
> >+static struct platform_driver fsl_asrc_driver = {
> >+	.probe = fsl_asrc_probe,
> >+	.driver = {
> >+		.name = "fsl-asrc",
> >+		.of_match_table = fsl_asrc_ids,
> >+		.pm = &fsl_asrc_pm,
> >+	},
> >+};
> >+module_platform_driver(fsl_asrc_driver);
> 
> Thanks...
> 
> -- 
> Regards,
> Varka Bhadram.
> 

Return-Path: <emillbrandt@dekaresearch.com>
Received: from dekaexchange07.deka.local (mail.dekaresearch.com
	[208.65.175.196]) by ozlabs.org (Postfix) with ESMTP id A3158B7D5B
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  9 Jun 2010 03:13:38 +1000 (EST)
From: Eric Millbrandt <emillbrandt@dekaresearch.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 1/2] powerpc/5200: Export port-config
Date: Tue, 8 Jun 2010 12:46:01 -0400
Message-ID: <1276015562-28928-2-git-send-email-emillbrandt@dekaresearch.com>
In-Reply-To: <1276015562-28928-1-git-send-email-emillbrandt@dekaresearch.com>
References: <1276015562-28928-1-git-send-email-emillbrandt@dekaresearch.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>,
	linuxppc-dev@lists.ozlabs.org,
	Eric Millbrandt <emillbrandt@dekaresearch.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Allow device drivers to safely modify port-config.  This allows device driv=
ers
access to gpio pins to manually bit-bang slave devices.

Signed-off-by: Eric Millbrandt <emillbrandt@dekaresearch.com>
---
 arch/powerpc/include/asm/mpc52xx.h           |    2 +
 arch/powerpc/platforms/52xx/mpc52xx_common.c |   61 ++++++++++++++++++++++=
++++
 2 files changed, 63 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/mpc52xx.h b/arch/powerpc/include/asm/=
mpc52xx.h
index b664ce7..ebc5a3b 100644
--- a/arch/powerpc/include/asm/mpc52xx.h
+++ b/arch/powerpc/include/asm/mpc52xx.h
@@ -274,7 +274,9 @@ extern void mpc52xx_declare_of_platform_devices(void);
 extern void mpc52xx_map_common_devices(void);
 extern int mpc52xx_set_psc_clkdiv(int psc_id, int clkdiv);
 extern unsigned int mpc52xx_get_xtal_freq(struct device_node *node);
+extern unsigned int mpc52xx_read_port_config(void);
 extern void mpc52xx_restart(char *cmd);
+extern int mpc52xx_write_port_config(u32 mux, int operation);

 /* mpc52xx_gpt.c */
 struct mpc52xx_gpt_priv;
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_common.c b/arch/powerpc/pl=
atforms/52xx/mpc52xx_common.c
index a46bad0..77c685a 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_common.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_common.c
@@ -37,6 +37,11 @@ static struct of_device_id mpc52xx_bus_ids[] __initdata =
=3D {
        {}
 };

+static struct of_device_id mpc52xx_gpio_simple[] =3D {
+       { .compatible =3D "fsl,mpc5200-gpio", },
+       {}
+};
+
 /*
  * This variable is mapped in mpc52xx_map_wdt() and used in mpc52xx_restar=
t().
  * Permanent mapping is required because mpc52xx_restart() can be called
@@ -82,6 +87,15 @@ mpc5200_setup_xlb_arbiter(void)
        iounmap(xlb);
 }

+/*
+ * This variable is mapped in mpc52xx_write_port_config() and
+ * mpc52xx_read_port_config().  Permanent mapping is required because
+ * mpc52xx_map_and_lock_port_config() can be called from interrupt context
+ * while node mapping (which calls ioremap()) cannot be used at such point=
.
+ */
+static DEFINE_SPINLOCK(mpc52xx_port_config_lock);
+static u32 __iomem *port_config;
+
 /**
  * mpc52xx_declare_of_platform_devices: register internal devices and chil=
dren
  *                                     of the localplus bus to the of_plat=
form
@@ -117,6 +131,7 @@ void __init
 mpc52xx_map_common_devices(void)
 {
        struct device_node *np;
+       const u32 *regaddr;

        /* mpc52xx_wdt is mapped here and used in mpc52xx_restart,
         * possibly from a interrupt context. wdt is only implement
@@ -135,6 +150,13 @@ mpc52xx_map_common_devices(void)
        np =3D of_find_matching_node(NULL, mpc52xx_cdm_ids);
        mpc52xx_cdm =3D of_iomap(np, 0);
        of_node_put(np);
+
+       /* port_config register */
+       np =3D of_find_matching_node(NULL, mpc52xx_gpio_simple);
+       regaddr =3D of_get_address(np, 0, NULL, NULL);
+       port_config =3D ioremap((u32) of_translate_address(np, regaddr), 0x=
4);
+
+       of_node_put(np);
 }

 /**
@@ -233,3 +255,42 @@ mpc52xx_restart(char *cmd)

        while (1);
 }
+
+/**
+ * mpc52xx_write_port_config: Allow mutually exclusive access to the
+ * port_config register
+ *
+ * @newmux: value to write to port_config
+ * @operation: set to 0 for | or 1 for &
+ */
+int mpc52xx_write_port_config(u32 newmux, int operation)
+{
+       unsigned long flags;
+       u32 mux;
+
+       if (!port_config)
+               return -ENODEV;
+
+       spin_lock_irqsave(&mpc52xx_port_config_lock, flags);
+       mux =3D in_be32(port_config);
+       if (operation)
+               out_be32(port_config, mux & newmux);
+       else
+               out_be32(port_config, mux | newmux);
+       spin_unlock_irqrestore(&mpc52xx_port_config_lock, flags);
+
+       return 0;
+}
+EXPORT_SYMBOL(mpc52xx_write_port_config);
+
+/**
+ * mpc52xx_read_port_config: Return the value of port_config
+ */
+unsigned int mpc52xx_read_port_config(void)
+{
+       if (!port_config)
+               return -ENODEV;
+
+       return in_be32(port_config);
+}
+EXPORT_SYMBOL(mpc52xx_read_port_config);
--
1.6.3.1


This e-mail and the information, including any attachments, it contains are=
 intended to be a confidential communication only to the person or entity t=
o whom it is addressed and may contain information that is privileged. If t=
he reader of this message is not the intended recipient, you are hereby not=
ified that any dissemination, distribution or copying of this communication=
 is strictly prohibited. If you have received this communication in error, =
please immediately notify the sender and destroy the original message.

Thank you.

Please consider the environment before printing this email.

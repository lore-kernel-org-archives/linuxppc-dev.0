Return-Path: <Kim.Phillips@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CE935B7B72
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 13 Oct 2009 03:06:26 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n9CG6MlF003535 for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 12 Oct 2009 09:06:23 -0700 (MST)
Received: from az33exm22.fsl.freescale.net (az33exm22.am.freescale.net
	[10.64.32.10])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id n9CG9H8h023685
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 12 Oct 2009 11:09:18 -0500 (CDT)
Date: Mon, 12 Oct 2009 11:06:19 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] * mpc8313erdb.dts: Fixed eTSEC interrupt assignment.
Message-Id: <20091012110619.972d0f61.kim.phillips@freescale.com>
In-Reply-To: <F7AA2B23-A019-4E11-993D-AF0F6F1FD50A@kernel.crashing.org>
References: <25940478.1252060285938.JavaMail.root@viefep11.chello.at>
	<20090909182227.GA8215@b07421-ec1.am.freescale.net>
	<F7AA2B23-A019-4E11-993D-AF0F6F1FD50A@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Scott Wood <scottwood@freescale.com>, u-boot@lists.denx.de,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Roland Lezuo <roland.lezuo@chello.at>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 9 Sep 2009 15:28:01 -0500
Kumar Gala <galak@kernel.crashing.org> wrote:

> 
> On Sep 9, 2009, at 1:22 PM, Scott Wood wrote:
> 
> > On Fri, Sep 04, 2009 at 12:31:25PM +0200, Roland Lezuo wrote:
> >> The following patch is needed to correctly assign the IRQs for the
> >> gianfar driver on the MPC8313ERDB-revc boards. ERR and TX are swapped
> >> as well as the interrupt lines for the two devices.
> >
> > And it will incorrectly assign them on older revisions of the chip.
> >
> > We really should have a u-boot fixup based on SVR.

Roland, is it possible for you to test this u-boot patch?:

>From 44c73137acf20626e930e3f4142e60054d8bd46f Mon Sep 17 00:00:00 2001
From: Kim Phillips <kim.phillips@freescale.com>
Date: Mon, 12 Oct 2009 10:51:20 -0500
Subject: [PATCH] mpc83xx: mpc8313 - handle erratum IPIC1 (TSEC IRQ number swappage)

mpc8313e erratum IPIC1 swapped TSEC interrupt ID numbers on rev. 1
h/w (see AN3545).  The base device tree in use has rev. 1 ID numbers,
so if on Rev. 2 (and higher) h/w, we fix them up here.

Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
---
 cpu/mpc83xx/fdt.c |   39 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/cpu/mpc83xx/fdt.c b/cpu/mpc83xx/fdt.c
index 13443cb..daf73a6 100644
--- a/cpu/mpc83xx/fdt.c
+++ b/cpu/mpc83xx/fdt.c
@@ -69,6 +69,45 @@ void ft_cpu_setup(void *blob, bd_t *bd)
     defined(CONFIG_HAS_ETH2) || defined(CONFIG_HAS_ETH3) ||\
     defined(CONFIG_HAS_ETH4) || defined(CONFIG_HAS_ETH5)
 	fdt_fixup_ethernet(blob);
+#ifdef CONFIG_MPC8313
+	/*
+	* mpc8313e erratum IPIC1 swapped TSEC interrupt ID numbers on rev. 1
+	* h/w (see AN3545).  The base device tree in use has rev. 1 ID numbers,
+	* so if on Rev. 2 (and higher) h/w, we fix them up here
+	*/
+	if (REVID_MAJOR(immr->sysconf.spridr) >= 2) {
+		int nodeoffset, path;
+		const char *prop;
+
+		nodeoffset = fdt_path_offset(blob, "/aliases");
+		if (nodeoffset >= 0) {
+#if defined(CONFIG_HAS_ETH0)
+			prop = fdt_getprop(blob, nodeoffset, "ethernet0", NULL);
+			if (prop) {
+				u32 tmp[] = { 32, 0x8, 33, 0x8, 34, 0x8 };
+
+				path = fdt_path_offset(blob, prop);
+				prop = fdt_getprop(blob, path, "interrupts", 0);
+				if (prop)
+					fdt_setprop(blob, path, "interrupts",
+						    &tmp, sizeof(tmp));
+			}
+#endif
+#if defined(CONFIG_HAS_ETH1)
+			prop = fdt_getprop(blob, nodeoffset, "ethernet1", NULL);
+			if (prop) {
+				u32 tmp[] = { 35, 0x8, 36, 0x8, 37, 0x8 };
+
+				path = fdt_path_offset(blob, prop);
+				prop = fdt_getprop(blob, path, "interrupts", 0);
+				if (prop)
+					fdt_setprop(blob, path, "interrupts",
+						    &tmp, sizeof(tmp));
+			}
+#endif
+		}
+	}
+#endif
 #endif
 
 	do_fixup_by_prop_u32(blob, "device_type", "cpu", 4,
-- 
1.6.4.4

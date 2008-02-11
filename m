Return-Path: <martin-langer@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id A8EE4DDF7D
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Feb 2008 07:29:37 +1100 (EST)
Date: Mon, 11 Feb 2008 21:29:33 +0100
From: Martin Langer <martin-langer@gmx.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Fix for Freescale ppc cores: major revision detection
Message-ID: <20080211202933.GA3399@tuba>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Feb 11, 2008 at 09:01:03AM -0600, Kumar Gala wrote:
> 
> On Feb 9, 2008, at 11:47 AM, Martin Langer wrote:
> 
> >Ppc cores by Freescale are using the configuration field instead of  
> >the
> >major revision field for their major revision number. Those field
> >definitions come from include/asm-powerpc/reg.h.
> >
> >Look at the pdf below and you will see that PVR_MAJ() does a wrong  
> >shift
> >for ppc cores by Freescale. This patch fixes it.
> >
> >http://www.freescale.com/files/archives/doc/support_info/PPCPVR.pdf
> 
> This doc doesn't encompass the e500/book-e cores that don't follow the  
> same pattern.
> 
> The code should probably be something like:
> 
> #ifdef CONFIG_FSL_BOOKE
> maj = PVR_MAJ(pvr);
> #else
> maj = (pvr >> 8) & 0xff;
> #endif

Thanks for the hint. Inspired by that I did the logic the other way 
round. So we have the same default cases as we had before and 
additionally it will fit for the cores mentioned in the doc.


--- arch/powerpc/kernel/setup-common.c.ORIGINAL	2008-02-08 22:22:56.000000000 +0100
+++ arch/powerpc/kernel/setup-common.c	2008-02-11 20:54:37.000000000 +0100
@@ -241,8 +241,21 @@
 	/* If we are a Freescale core do a simple check so
 	 * we dont have to keep adding cases in the future */
 	if (PVR_VER(pvr) & 0x8000) {
-		maj = PVR_MAJ(pvr);
-		min = PVR_MIN(pvr);
+		switch (PVR_VER(pvr)) {
+			case 0x8000:	/* 7441/7450/7451, Vger */
+			case 0x8001:	/* 7445/7455, Apollo 6 */
+			case 0x8002:	/* 7447/7457, Apollo 7 */
+			case 0x8003:	/* 7447A, Apollo 7 PM */
+			case 0x8004:	/* 7448, Apollo 8 */
+			case 0x800c:	/* 7410, Nitro */
+				maj = ((pvr >> 8) & 0xF);
+				min = PVR_MIN(pvr);
+				break;
+			default:	/* e500/book-e */
+				maj = PVR_MAJ(pvr);
+				min = PVR_MIN(pvr);
+				break;
+		}
 	} else {
 		switch (PVR_VER(pvr)) {
 			case 0x0020:	/* 403 family */

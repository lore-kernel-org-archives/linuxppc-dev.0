Return-Path: <martin-langer@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 3CA7ADE062
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2008 07:40:42 +1100 (EST)
Date: Wed, 27 Feb 2008 21:40:38 +0100
From: Martin Langer <martin-langer@gmx.de>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] Fix for Freescale ppc cores: major revision detection
Message-ID: <20080227204038.GA3529@tuba>
References: <20080211202933.GA3399@tuba>
	<18371.60089.808367.553892@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18371.60089.808367.553892@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Feb 26, 2008 at 09:32:25PM +1100, Paul Mackerras wrote:
> Martin Langer writes:
> 
> Care to resend this with a proper description and a Signed-off-by
> line?

Sure.

> > +		switch (PVR_VER(pvr)) {
> > +			case 0x8000:	/* 7441/7450/7451, Vger */
> > +			case 0x8001:	/* 7445/7455, Apollo 6 */
> > +			case 0x8002:	/* 7447/7457, Apollo 7 */
> > +			case 0x8003:	/* 7447A, Apollo 7 PM */
> > +			case 0x8004:	/* 7448, Apollo 8 */
> > +			case 0x800c:	/* 7410, Nitro */
> 
> BTW, these case labels are all indented one tab too far.

Ok. Now it's fixed.


The major revision number of some ppc cores by Freescale is placed in 
the configuration field instead of the major revision field. The patch 
corrects the behaviour for those 74xx cores.

Signed-off-by: Martin Langer <martin-langer@gmx.de>


--- setup-common.c.ORIGINAL	2008-02-08 22:22:56.000000000 +0100
+++ setup-common.c	2008-02-27 21:21:44.000000000 +0100
@@ -241,8 +241,21 @@
 	/* If we are a Freescale core do a simple check so
 	 * we dont have to keep adding cases in the future */
 	if (PVR_VER(pvr) & 0x8000) {
-		maj = PVR_MAJ(pvr);
-		min = PVR_MIN(pvr);
+		switch (PVR_VER(pvr)) {
+		case 0x8000:	/* 7441/7450/7451, Voyager */
+		case 0x8001:	/* 7445/7455, Apollo 6 */
+		case 0x8002:	/* 7447/7457, Apollo 7 */
+		case 0x8003:	/* 7447A, Apollo 7 PM */
+		case 0x8004:	/* 7448, Apollo 8 */
+		case 0x800c:	/* 7410, Nitro */
+			maj = ((pvr >> 8) & 0xF);
+			min = PVR_MIN(pvr);
+			break;
+		default:	/* e500/book-e */
+			maj = PVR_MAJ(pvr);
+			min = PVR_MIN(pvr);
+			break;
+		}
 	} else {
 		switch (PVR_VER(pvr)) {
 			case 0x0020:	/* 403 family */

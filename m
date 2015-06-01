Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AB8491A016E
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Jun 2015 19:08:08 +1000 (AEST)
Received: from localhost.localdomain (localhost [127.0.0.1])
 by ozlabs.org (Postfix) with ESMTP id 690D7140FDF
 for <linuxppc-dev@ozlabs.org>; Mon,  1 Jun 2015 19:08:08 +1000 (AEST)
Message-ID: <1433149688.24546.18.camel@neuling.org>
Subject: Re: [PATCH] cxl: Set up and enable PSL Timebase
From: Michael Neuling <mikey@neuling.org>
To: Philippe Bergheaud <felix@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, imunsie@au1.ibm.com, vaibhav@linux.vnet.ibm.com
Date: Mon, 01 Jun 2015 19:08:08 +1000
In-Reply-To: <556C0BCE.1080302@linux.vnet.ibm.com>
References: <1432818778-27819-1-git-send-email-felix@linux.vnet.ibm.com>
 <1433140899.24546.14.camel@neuling.org>
 <556C0BCE.1080302@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-06-01 at 09:37 +0200, Philippe Bergheaud wrote:
> Michael Neuling wrote:
> > On Thu, 2015-05-28 at 15:12 +0200, Philippe Bergheaud wrote:
> >=20
> >>This patch configures the PSL Timebase function and enables it,
> >>after the CAPP has been initialized by OPAL. Failures are reported
> >>and ignored.
> >=20
> >=20
> > Needs an Signed-off-by.
> Yes.
> > Comments inline.
> >=20
> >=20
> >>---
> >> drivers/misc/cxl/cxl.h |    5 +++++
> >> drivers/misc/cxl/pci.c |   35 +++++++++++++++++++++++++++++++++++
> >> 2 files changed, 40 insertions(+), 0 deletions(-)
> >>
> >>diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
> >>index a1cee47..38a7cf9 100644
> >>--- a/drivers/misc/cxl/cxl.h
> >>+++ b/drivers/misc/cxl/cxl.h
> >>@@ -82,8 +82,10 @@ static const cxl_p1_reg_t CXL_PSL_AFUSEL  =3D {0x00B=
0};
> >> /* 0x00C0:7EFF Implementation dependent area */
> >> static const cxl_p1_reg_t CXL_PSL_FIR1      =3D {0x0100};
> >> static const cxl_p1_reg_t CXL_PSL_FIR2      =3D {0x0108};
> >>+static const cxl_p1_reg_t CXL_PSL_Timebase  =3D {0x0110};
> >> static const cxl_p1_reg_t CXL_PSL_VERSION   =3D {0x0118};
> >> static const cxl_p1_reg_t CXL_PSL_RESLCKTO  =3D {0x0128};
> >>+static const cxl_p1_reg_t CXL_PSL_TB_CTLSTAT =3D {0x0140};
> >> static const cxl_p1_reg_t CXL_PSL_FIR_CNTL  =3D {0x0148};
> >> static const cxl_p1_reg_t CXL_PSL_DSNDCTL   =3D {0x0150};
> >> static const cxl_p1_reg_t CXL_PSL_SNWRALLOC =3D {0x0158};
> >>@@ -151,6 +153,9 @@ static const cxl_p2n_reg_t CXL_PSL_WED_An     =3D {=
0x0A0};
> >> #define CXL_PSL_SPAP_Size_Shift 4
> >> #define CXL_PSL_SPAP_V    0x0000000000000001ULL
> >>=20
> >>+/****** CXL_PSL_Control **********************************************=
******/
> >>+#define CXL_PSL_Control_tb 0x0000000000000001ULL
> >>+
> >> /****** CXL_PSL_DLCNTL ***********************************************=
******/
> >> #define CXL_PSL_DLCNTL_D (0x1ull << (63-28))
> >> #define CXL_PSL_DLCNTL_C (0x1ull << (63-29))
> >>diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
> >>index fc938de..afd89cc 100644
> >>--- a/drivers/misc/cxl/pci.c
> >>+++ b/drivers/misc/cxl/pci.c
> >>@@ -360,6 +360,38 @@ static int init_implementation_adapter_regs(struct=
 cxl *adapter, struct pci_dev
> >> 	return 0;
> >> }
> >>=20
> >>+#define TBSYNC_CNT(n) (((u64)n & 0x7) << (63-6))
> >>+
> >>+static int cxl_setup_psl_timebase(struct cxl *adapter, struct pci_dev =
*dev)
> >>+{
> >>+	u64 psl_tb;
> >>+	int delta;
> >>+	unsigned int retry =3D 0;
> >>+
> >>+	/*
> >>+	 * Setup PSL Timebase Control and Status register
> >>+	 * with the recommended Timebase Sync Count value
> >>+	 */
> >>+	cxl_p1_write(adapter, CXL_PSL_TB_CTLSTAT, TBSYNC_CNT(2)); =20
> >=20
> >=20
> > 2? =20
> Quoting the PSL workbook description of the PSL_TB_CTLSTAT register:
>=20
> 4:6 tbsync_cnt
> TimebaseSyncCount. Number of 250MHz cycles x 2048 before initiating anoth=
er Timebase Recalibration sequence.
> Processor chipTimebase facilities receive a tod_sync pulse every 16us or =
4000 250 MHz cycles so '010' is the Recommended value.
> 000 =3D never
> 001 =3D 2048
> 010 =3D 4096 (2 * 2048)
> ...
> 111 =3D 14336 (7 * 2048)
>=20
> Will make the TimebaseSyncCount unit explicit. Something like:
>=20
> #define _2048_250MHZ_CYCLES 1
> cxl_p1_write(adapter, CXL_PSL_TB_CTLSTAT, TBSYNC_CNT(2 * _2048_250MHZ_CYC=
LES));

Sounds good!

> >=20
> >>+
> >>+	/* Enable PSL Timebase */
> >>+	cxl_p1_write(adapter, CXL_PSL_Control, CXL_PSL_Control_tb);
> >>+	/* Wait until CORE TB and PSL TB difference <=3D 16usecs */
> >=20
> >=20
> > How many tries does this normally take?
> Two. The second attempt always succeds.

Ok

> > Should we have a sleep in here to wait for it to sync rather than just
> > coming back around right away?
> Yes, will add msleep(1) at the beginning of the loop (as the first attemp=
t always fails).

Humm, ok.  Is there any documentation to say how long it's suppose to
take? =20

Mikey

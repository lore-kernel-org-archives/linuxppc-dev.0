Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [59.145.155.3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp03.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1C7FD474C5
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Jan 2009 20:38:55 +1100 (EST)
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by e28smtp03.in.ibm.com (8.13.1/8.13.1) with ESMTP id n069cmj4010341
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Jan 2009 15:08:48 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	n069cqBu2171016
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Jan 2009 15:08:52 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
	by d28av02.in.ibm.com (8.13.1/8.13.3) with ESMTP id n069cmII023931
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Jan 2009 20:38:48 +1100
Date: Tue, 6 Jan 2009 15:08:47 +0530
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] 2.6.28-git4 - powerpc - drivers build fails with
	!CONFIG_VIOPATH
Message-ID: <20090106093847.GB5066@linux.vnet.ibm.com>
References: <5414eaef99b7392a95f6e3488b81dbf7@bga.com>
	<20090104182441.GA5086@linux.vnet.ibm.com>
	<98d6aef17cba9d835d7866745f811dc7@bga.com>
	<20090106072549.GA5066@linux.vnet.ibm.com>
	<20090106073149.GA12371@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20090106073149.GA12371@uranus.ravnborg.org>
Cc: linux-ppc <linuxppc-dev@ozlabs.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Milton Miller <miltonm@bga.com>, Stephen Rothwell <sfr@canb.auug.org.au>
Reply-To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

* Sam Ravnborg <sam@ravnborg.org> [2009-01-06 08:31:49]:

> > 
> > 	Sorry for resending the patch before taking care of the response. Resending 
> > the patch with changes made to other three drivers also.
> > 
> > Impact: Fix the VIOPATH dependency in the iSeries dependent drivers.
> > 
> > iSeries depend drivers build fails, when CONFIG_VIOPATH is disabled.
> > Removing the dependency of VIOPATH by selecting it, when the drivers
> > dependent on iSeries code.
> > 
> > 
> > Signed-off-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
> > ---
> >  arch/powerpc/platforms/iseries/Kconfig |    5 ++++-
> >  drivers/char/Kconfig                   |    1 +
> >  drivers/scsi/Kconfig                   |    1 +
> >  3 files changed, 6 insertions(+), 1 deletions(-)
> > 
> > diff --git a/arch/powerpc/platforms/iseries/Kconfig b/arch/powerpc/platforms/iseries/Kconfig
> > index ed3753d..5cb2320 100644
> > --- a/arch/powerpc/platforms/iseries/Kconfig
> > +++ b/arch/powerpc/platforms/iseries/Kconfig
> > @@ -10,18 +10,21 @@ menu "iSeries device drivers"
> >  config VIODASD


<snip>

> 
> VIOPATH is set using select so the "depends on" is effectively ignored.
> If you think you need the "depends on" then you need to revisit the
> symbol that will select VIOPATH and make sure _they_ have this dependency.
> 
> 	Sam

Hi Sam,

	VIOPATH is used only by the PPC_ISERIES code. The symbols selecting
the VIOPATH are also dependent on the PPC_ISERIES. Should we make the 
config VIOPATH as default n, because it being selected the dependent
drivers.

Impact: Fix the VIOPATH dependency in the iSeries dependent drivers.

iSeries depend drivers build fails, when CONFIG_VIOPATH is disabled.
Removing the dependency of VIOPATH by selecting it, when the drivers
dependent on iSeries code.

Signed-off-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/iseries/Kconfig |    6 ++++--
 drivers/char/Kconfig                   |    1 +
 drivers/scsi/Kconfig                   |    1 +
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/iseries/Kconfig b/arch/powerpc/platforms/iseries/Kconfig
index ed3753d..fd524cd 100644
--- a/arch/powerpc/platforms/iseries/Kconfig
+++ b/arch/powerpc/platforms/iseries/Kconfig
@@ -10,18 +10,21 @@ menu "iSeries device drivers"
 config VIODASD
 	tristate "iSeries Virtual I/O disk support"
 	depends on BLOCK
+	select VIOPATH
 	help
 	  If you are running on an iSeries system and you want to use
 	  virtual disks created and managed by OS/400, say Y.
 
 config VIOCD
 	tristate "iSeries Virtual I/O CD support"
+	select VIOPATH
 	help
 	  If you are running Linux on an IBM iSeries system and you want to
 	  read a CD drive owned by OS/400, say Y here.
 
 config VIOTAPE
 	tristate "iSeries Virtual Tape Support"
+	select VIOPATH
 	help
 	  If you are running Linux on an iSeries system and you want Linux
 	  to read and/or write a tape drive owned by OS/400, say Y here.
@@ -30,5 +33,4 @@ endmenu
 
 config VIOPATH
 	bool
-	depends on VIODASD || VIOCD || VIOTAPE || ISERIES_VETH
-	default y
+	default n
diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index 1697043..b8da09a 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -616,6 +616,7 @@ config HVC_ISERIES
 	default y
 	select HVC_DRIVER
 	select HVC_IRQ
+	select VIOPATH
 	help
 	  iSeries machines support a hypervisor virtual console.
 
diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
index b732297..256c7be 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -884,6 +884,7 @@ config SCSI_IBMVSCSI
 	tristate "IBM Virtual SCSI support"
 	depends on PPC_PSERIES || PPC_ISERIES
 	select SCSI_SRP_ATTRS
+	select VIOPATH if PPC_ISERIES
 	help
 	  This is the IBM POWER Virtual SCSI Client
 
-- 
Thanks & Regards,
Kamalesh Babulal,
Linux Technology Center,
IBM, ISTL.

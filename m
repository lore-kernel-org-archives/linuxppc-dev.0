Return-Path: <rcjenn@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B6C34DEA6E
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2008 00:53:56 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m67Erq7s026163
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jul 2008 10:53:52 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m67Erqow199266
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jul 2008 10:53:52 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m67ErpQr031592
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jul 2008 10:53:52 -0400
Date: Mon, 7 Jul 2008 09:53:40 -0500
From: Robert Jennings <rcj@linux.vnet.ibm.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: linux-next: scsi tree build failure
Message-ID: <20080707145340.GB21578@linux.vnet.ibm.com>
References: <20080707222528.280f0b9e.sfr@canb.auug.org.au>
	<1215441589.3274.17.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1215441589.3274.17.camel@localhost.localdomain>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-scsi <linux-scsi@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	linux-next@vger.kernel.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

* James Bottomley (James.Bottomley@HansenPartnership.com) wrote:
> Correct cc's added
> 
> On Mon, 2008-07-07 at 22:25 +1000, Stephen Rothwell wrote:
> > Hi James,
> > 
> > Today's linux-next build (powerpc ppc64_defconfig) failed like this:
> > 
> > drivers/scsi/ibmvscsi/ibmvscsi.c: In function 'map_sg_data':
> > drivers/scsi/ibmvscsi/ibmvscsi.c:431: error: 'FW_FEATURE_CMO' undeclared (first use in this function)
> > drivers/scsi/ibmvscsi/ibmvscsi.c:431: error: (Each undeclared identifier is reported only once
> > drivers/scsi/ibmvscsi/ibmvscsi.c:431: error: for each function it appears in.)
> > drivers/scsi/ibmvscsi/ibmvscsi.c: In function 'ibmvscsi_queuecommand':
> > drivers/scsi/ibmvscsi/ibmvscsi.c:750: error: 'FW_FEATURE_CMO' undeclared (first use in this function)
> > drivers/scsi/ibmvscsi/ibmvscsi.c: In function 'send_mad_adapter_info':
> > drivers/scsi/ibmvscsi/ibmvscsi.c:864: error: 'FW_FEATURE_CMO' undeclared (first use in this function)
> > drivers/scsi/ibmvscsi/ibmvscsi.c: In function 'ibmvscsi_do_host_config':
> > drivers/scsi/ibmvscsi/ibmvscsi.c:1412: error: 'FW_FEATURE_CMO' undeclared (first use in this function)
> > drivers/scsi/ibmvscsi/ibmvscsi.c: At top level:
> > drivers/scsi/ibmvscsi/ibmvscsi.c:1769: error: unknown field 'get_io_entitlement' specified in initializer
> > drivers/scsi/ibmvscsi/ibmvscsi.c:1769: warning: missing braces around initializer
> > drivers/scsi/ibmvscsi/ibmvscsi.c:1769: warning: (near initialization for 'ibmvscsi_driver.driver')
> > drivers/scsi/ibmvscsi/ibmvscsi.c:1769: warning: initialization from incompatible pointer type
> > 
> > Caused because commit 341b56db6804040aa9559e913865108424e3b18b ("[SCSI]
> > ibmvscsi: driver enablement for CMO"), which was 15/16 in a series, has
> > been merged before any of the other patches in the series.  I have
> > reverted that commit.
> 
> Do I detect the fact that IBM sent a patch for a SCSI driver for which
> the core features weren't yet enabled (and which I couldn't check, not
> having a ppc build system)?
> 
> James

I didn't not properly note in the patch description my intent to have
this merged in the linuxppc-dev tree.  The patch is part of a larger set
enabling the feature.  Linux-scsi was CC'ed for this driver for review.

Robert Jennings

Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 56D53DDE10
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2008 08:01:19 +1000 (EST)
Subject: Re: linux-next: scsi tree build failure
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20080707222528.280f0b9e.sfr@canb.auug.org.au>
References: <20080707222528.280f0b9e.sfr@canb.auug.org.au>
Content-Type: text/plain
Date: Tue, 08 Jul 2008 08:00:50 +1000
Message-Id: <1215468050.8970.120.camel@pasglop>
Mime-Version: 1.0
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
	linuxppc-dev@ozlabs.org, linux-next@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-07-07 at 22:25 +1000, Stephen Rothwell wrote:
> Hi James,
> 
> Today's linux-next build (powerpc ppc64_defconfig) failed like this:

James, if you agree, I'll carry this commit in the powerpc tree along
with its dependencies (and your ack).

Cheers,
Ben.

> drivers/scsi/ibmvscsi/ibmvscsi.c: In function 'map_sg_data':
> drivers/scsi/ibmvscsi/ibmvscsi.c:431: error: 'FW_FEATURE_CMO' undeclared (first use in this function)
> drivers/scsi/ibmvscsi/ibmvscsi.c:431: error: (Each undeclared identifier is reported only once
> drivers/scsi/ibmvscsi/ibmvscsi.c:431: error: for each function it appears in.)
> drivers/scsi/ibmvscsi/ibmvscsi.c: In function 'ibmvscsi_queuecommand':
> drivers/scsi/ibmvscsi/ibmvscsi.c:750: error: 'FW_FEATURE_CMO' undeclared (first use in this function)
> drivers/scsi/ibmvscsi/ibmvscsi.c: In function 'send_mad_adapter_info':
> drivers/scsi/ibmvscsi/ibmvscsi.c:864: error: 'FW_FEATURE_CMO' undeclared (first use in this function)
> drivers/scsi/ibmvscsi/ibmvscsi.c: In function 'ibmvscsi_do_host_config':
> drivers/scsi/ibmvscsi/ibmvscsi.c:1412: error: 'FW_FEATURE_CMO' undeclared (first use in this function)
> drivers/scsi/ibmvscsi/ibmvscsi.c: At top level:
> drivers/scsi/ibmvscsi/ibmvscsi.c:1769: error: unknown field 'get_io_entitlement' specified in initializer
> drivers/scsi/ibmvscsi/ibmvscsi.c:1769: warning: missing braces around initializer
> drivers/scsi/ibmvscsi/ibmvscsi.c:1769: warning: (near initialization for 'ibmvscsi_driver.driver')
> drivers/scsi/ibmvscsi/ibmvscsi.c:1769: warning: initialization from incompatible pointer type
> 
> Caused because commit 341b56db6804040aa9559e913865108424e3b18b ("[SCSI]
> ibmvscsi: driver enablement for CMO"), which was 15/16 in a series, has
> been merged before any of the other patches in the series.  I have
> reverted that commit.
> 

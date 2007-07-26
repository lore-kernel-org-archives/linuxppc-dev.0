Return-Path: <SRS0+ad4e5282f64548a64663+1432+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0CE14DDEE1
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jul 2007 17:46:51 +1000 (EST)
Subject: Re: [PATCH] Fix ibmvscsi client for multiplatform iSeries+pSeries
	kernel.
From: David Woodhouse <dwmw2@infradead.org>
To: michael@ellerman.id.au
In-Reply-To: <1185413275.25216.2.camel@concordia.ozlabs.ibm.com>
References: <1185374509.14697.384.camel@pmac.infradead.org>
	<1185413275.25216.2.camel@concordia.ozlabs.ibm.com>
Content-Type: text/plain
Date: Thu, 26 Jul 2007 08:46:37 +0100
Message-Id: <1185435997.14697.432.camel@pmac.infradead.org>
Mime-Version: 1.0
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-07-26 at 11:27 +1000, Michael Ellerman wrote:
> Nice that someone finally fixed this up.
> 
> But I get:
> 
> drivers/scsi/ibmvscsi/ibmvscsi.c:1651: error: 'FW_FEATURE_ISERIES' undeclared (first use in this function)
> drivers/scsi/ibmvscsi/ibmvscsi.c:1651: error: (Each undeclared identifier is reported only once
> drivers/scsi/ibmvscsi/ibmvscsi.c:1651: error: for each function it appears in.)
> drivers/scsi/ibmvscsi/ibmvscsi.c:1653: error: 'FW_FEATURE_VIO' undeclared (first use in this function)
> 
> Missing <asm/firmware.h> ? 

Hm, I wonder why it ever worked for me then...

Ah, it seems that <asm/time.h> only includes <asm/firmware.h> if
CONFIG_PPC_ISERIES. We should include <asm/firmware.h> directly from
ibmvscsi.c rather than relying on it being pulled in indirectly. I'll
send a new patch. Thanks.

-- 
dwmw2

Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D350F2C00A2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Oct 2013 10:20:12 +1100 (EST)
Received: from mail175-ch1 (localhost [127.0.0.1])	by
 mail175-ch1-R.bigfish.com (Postfix) with ESMTP id 0DF3942006B	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Oct 2013 23:20:07 +0000 (UTC)
Received: from CH1EHSMHS037.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.245])	by mail175-ch1.bigfish.com (Postfix) with ESMTP id
 E666B2C0114	for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Oct 2013 23:20:05
 +0000 (UTC)
Date: Wed, 16 Oct 2013 18:20:03 -0500
From: Scott Wood <scottwood@freescale.com>
To: chenhui zhao <chenhui.zhao@freescale.com>
Subject: Re: [4/4] powerpc/mpc8548: Add workaround for erratum NMG_SRIO135
Message-ID: <20131016232003.GA27543@home.buserror.net>
References: <1331025056-15983-4-git-send-email-chenhui.zhao@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1331025056-15983-4-git-send-email-chenhui.zhao@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 06, 2012 at 05:10:56PM +0800, chenhui zhao wrote:
> From: chenhui zhao <chenhui.zhao@freescale.com>
> 
> Issue:
> Applications using lwarx/stwcx instructions in the core to
> compete for a software lock or semaphore with a device on
> RapidIO using read atomic set, clr, inc, or dec in a similar
> manner may falsely result in both masters seeing the lock
> as "available". This could result in data corruption as
> both masters try to modify the same piece of data protected
> by the lock.
> 
> Workaround:
> Set bits 13 and 29 of CCSR offset 0x01010 (EEBPCR register
> of the ECM) during initialization and leave them set
> indefinitely. This may slightly degrade overall system
> performance.
> 
> Refer to SRIO39 in MPC8548 errata document.
> 
> Signed-off-by: Gong Chen <g.chen@freescale.com>
> Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> 
> ---
> arch/powerpc/sysdev/fsl_rio.c |   44 +++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 44 insertions(+), 0 deletions(-)
[snip]
> @@ -358,6 +391,17 @@ int fsl_rio_setup(struct platform_device *dev)
>  				dev->dev.of_node->full_name);
>  		return -EFAULT;
>  	}
> +
> +	/* Fix erratum NMG_SRIO135 */
> +	if (fsl_svr_is(SVR_8548) || fsl_svr_is(SVR_8548_E)) {
> +		rc = fixup_erratum_srio135(&dev->dev);
> +		if (rc) {
> +			dev_err(&dev->dev,
> +				"Failed to fix the erratum NMG_SRIO135.");
> +			return rc;
> +		}
> +	}

This needs to be respun based on the current tree.

-Scott

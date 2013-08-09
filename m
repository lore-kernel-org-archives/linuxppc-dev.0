Return-Path: <B07421@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0184.outbound.messaging.microsoft.com [213.199.154.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E03F82C00A3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Aug 2013 02:31:14 +1000 (EST)
Message-ID: <1376065856.15633.14.camel@snotra.buserror.net>
Subject: Re: Pull request: scottwood/linux.git next
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Date: Fri, 9 Aug 2013 11:30:56 -0500
In-Reply-To: <0C3278E8-558D-445B-A8F5-CCD0868C808C@kernel.crashing.org>
References: <20130808224501.GA8925@home.buserror.net>
 <1376028191.32100.13.camel@pasglop>
 <0C3278E8-558D-445B-A8F5-CCD0868C808C@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-08-09 at 09:43 -0500, Kumar Gala wrote:
> On Aug 9, 2013, at 1:03 AM, Benjamin Herrenschmidt wrote:
> 
> > On Thu, 2013-08-08 at 17:45 -0500, Scott Wood wrote:
> >> The following changes since commit 3b2f64d00c46e1e4e9bd0bb9bb12619adac27a4b:
> >> 
> >>  Linux 3.11-rc2 (2013-07-21 12:05:29 -0700)
> >> 
> >> are available in the git repository at:
> > 
> > Next time, put a little blurb at the head of the pull request giving a
> > rough highlight, like I do when I send a pull request to Linus.
> > 
> > Thanks !
> > 
> > Cheers,
> > Ben.

Oh, sorry -- forgot.

Highlights include:
 - Setting compilation flags properly for the chosen e500 target --
among other things, on 64-bit e500 builds this will prevent the
assembler from replacing lwsync with sync, which caused a significant
slowdown on certain workloads.
 - e6500 perf support
 - MPIC MSI support for t4240/b4860-era chips
 - p1020rdb-pd board support

> Also, I think we should pull a few of the commits in here out and submit for 3.11
> 
>      powerpc/msi: Fix compile error on mpc83xx

This is poorly worded -- there is no compilation error unless you apply
a subsequent patch without this one.  A better subject would have been
"powerpc/mpic: allow fsl_mpic_primary_get_version without CONFIG_MPIC".

>      powerpc/fsl_msi: fix error return code in fsl_of_msi_probe()

This one doesn't seem that critical...

>      powerpc/pci: fix PCI-e check link issue

I agree on this one.

-Scott

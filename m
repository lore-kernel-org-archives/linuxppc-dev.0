Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0189.outbound.protection.outlook.com [207.46.163.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3FE4314009C
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Apr 2014 10:03:38 +1100 (EST)
Message-ID: <1396307005.20849.37.camel@snotra.buserror.net>
Subject: Re: [PATCH 4/4] KVM: PPC: Bookehv: Get vcpu's last instruction for
 emulation
From: Scott Wood <scottwood@freescale.com>
To: Alexander Graf <agraf@suse.de>
Date: Mon, 31 Mar 2014 18:03:25 -0500
In-Reply-To: <53397091.4050601@suse.de>
References: <1392913821-4520-1-git-send-email-mihai.caraman@freescale.com>
 <1392913821-4520-4-git-send-email-mihai.caraman@freescale.com>
 <1395868664.12738.68.camel@snotra.buserror.net> <53397091.4050601@suse.de>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Mihai Caraman <mihai.caraman@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-03-31 at 15:41 +0200, Alexander Graf wrote:
> On 03/26/2014 10:17 PM, Scott Wood wrote:
> > On Thu, 2014-02-20 at 18:30 +0200, Mihai Caraman wrote:
> >> +	/*
> >> +	 * Another thread may rewrite the TLB entry in parallel, don't
> >> +	 * execute from the address if the execute permission is not set
> >> +	 */
> 
> What happens when another thread rewrites the TLB entry in parallel? 
> Does tlbsx succeed? Does it fail? Do we see failure indicated somehow? 
> Are the contents of the MAS registers consistent at this point or 
> inconsistent?

If another thread rewrites the TLB entry, then we use the new TLB entry,
just as if it had raced in hardware.  This check ensures that we don't
execute from the new TLB entry if it doesn't have execute permissions
(just as hardware would).

What happens if the new TLB entry is valid and executable, and the
instruction pointed to is valid, but doesn't trap (and thus we don't
have emulation for it)?

> There has to be a good way to detect such a race and deal with it, no?

How would you detect it?  We don't get any information from the trap
about what physical address the instruction was fetched from, or what
the instruction was.

-Scott

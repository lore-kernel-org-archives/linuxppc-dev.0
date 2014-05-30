Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0186.outbound.protection.outlook.com [207.46.163.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B86821A06EA
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 May 2014 03:01:53 +1000 (EST)
Message-ID: <1401469300.6603.199.camel@snotra.buserror.net>
Subject: Re: [PATCH 2/2] powerpc/e6500: hw tablewalk: fix recursive tlb lock
 on cpu 0
From: Scott Wood <scottwood@freescale.com>
To: Caraman Mihai Claudiu-B02008 <mihai.caraman@freescale.com>
Date: Fri, 30 May 2014 12:01:40 -0500
In-Reply-To: <65f51156027a4c8a90c670d0ba72df3c@BY2PR03MB508.namprd03.prod.outlook.com>
References: <1400795101-8737-1-git-send-email-scottwood@freescale.com>
 <1400795101-8737-2-git-send-email-scottwood@freescale.com>
 <65f51156027a4c8a90c670d0ba72df3c@BY2PR03MB508.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-05-30 at 02:59 -0500, Caraman Mihai Claudiu-B02008 wrote:
> > -----Original Message-----
> > From: Linuxppc-dev [mailto:linuxppc-dev-
> > bounces+mihai.caraman=freescale.com@lists.ozlabs.org] On Behalf Of Scott
> > Wood
> > Sent: Friday, May 23, 2014 12:45 AM
> > To: linuxppc-dev@lists.ozlabs.org
> > Cc: Wood Scott-B07421
> > Subject: [PATCH 2/2] powerpc/e6500: hw tablewalk: fix recursive tlb lock
> > on cpu 0
> > 
> > Commit 82d86de25b9c99db546e17c6f7ebf9a691da557e "TLB lock recursive"
> > introduced a bug whereby cpu 0 uses the same value for "lock held" as
> > is used to indicate that the lock is free.
> 
> Isn't his what spin lock implementation solves by combines paca_index
> with lock_token? Can't we have a common approach?

That would require expanding the lock to 32 bits, is a more intrusive
fix than needed, and invites breakage in the TLB code if the lock_token
mechanism were to change.

> > Add one to the CPU value to ensure we do not use zero as a "lock held"
> > value.
> 
> The CPU value is loaded in r10 from tlb_miss_common_e6500. "TLB lock recursive"
> commit also introduced this misleading comment:
> 
>     We are entered with:
>     r10 = cpu number

I addressed this in v2 that I posted yesterday.

-Scott

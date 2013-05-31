Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 31DD82C02F1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 May 2013 20:11:32 +1000 (EST)
Message-ID: <1369995080.3928.140.camel@pasglop>
Subject: Re: [PATCH 1/3] powerpc/mpc85xx: remove the unneeded pci init
 functions for corenet ds board
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kevin Hao <haokexin@gmail.com>
Date: Fri, 31 May 2013 20:11:20 +1000
In-Reply-To: <20130531064102.GB16514@pek-khao-d1.corp.ad.wrs.com>
References: <1369137900-5748-1-git-send-email-haokexin@gmail.com>
 <1369137900-5748-2-git-send-email-haokexin@gmail.com>
 <1369781529.18630.25@snotra>
 <20130530102034.GB18702@pek-khao-d1.corp.ad.wrs.com>
 <1369940099.14679.14@snotra>
 <20130531064102.GB16514@pek-khao-d1.corp.ad.wrs.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>,
 linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-05-31 at 14:41 +0800, Kevin Hao wrote:
> Hi Ben,
> 
> Could you shed some light on this issue? Do we really has the restriction
> that we have to pick one bus controller as primary even there is no
> ISA bus on the board? I did check the current code and found no code
> has a requirement for this. I also searched the archives and but found
> nothing useful. :-(

You can just pick the first one as primary... The reason we somewhat need
a primary is related to how we handle IO space.

We ioremap the IO space of all busses and assign the base of the primary
one to a global "_IO_BASE". Then any "port" access is an offset from that
which means that non-primary can end up having negative offsets. We fix
up all resources, which works fine ... unless drivers do stupid casts
and the wrap-around fails.

The main reason we did that originally is because we still had a slew of
x86 originated HW that would access hard wired IO ports, especially on things
like CHRP machines, looking for things like 8259 PIC, legacy kbd controllers,
UARTs, etc... at fixed IO port numbers.

We still support some of these boxes (though I do wonder how long since
somebody last booted a Pegasos) so I'm not quite yet keen on getting rid
of that stuff...

Cheers,
Ben.

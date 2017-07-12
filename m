Return-Path: <acme@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x71wm1qSgzDqjY
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Jul 2017 00:46:16 +1000 (AEST)
Date: Wed, 12 Jul 2017 11:46:11 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Jiri Olsa <jolsa@redhat.com>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Andi Kleen <andi@firstfloor.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, mikey@neuling.org
Subject: Re: [GIT PULL] Please pull JSON files for Power9 PMU events
Message-ID: <20170712144611.GN27350@kernel.org>
References: <20170712020827.GB31223@us.ibm.com>
 <87a849luvr.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87a849luvr.fsf@concordia.ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Em Wed, Jul 12, 2017 at 10:09:12PM +1000, Michael Ellerman escreveu:
> Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com> writes:
> > Please pull the JSON files for POWER9 PMU events.

> >       perf vendor events: Add POWER9 PMU events
> >       perf vendor events: Add POWER9 PVRs to mapfile
 
> I think the PVRs need work.
 
> You have:
 
> +004e0100,1,power9.json,core
> +004e0000,1,power9.json,core
 
> The first is P9 DD1, but the second doesn't exist. We have it in the
> kernel, but with a mask of 0xffff0000. From memory the perf code doesn't
> do any masking or anything fancy, it looks for an exact match.
 
> So for starters you should probably drop that one and add 0x004e1200 and
> 0x004e0200.

Could this check be somehow done automatically? Using whatever is in the
kernel sources or some IBM released document?

- Arnaldo

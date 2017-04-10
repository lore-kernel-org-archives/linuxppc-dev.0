Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w1c8z2TmRzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Apr 2017 14:07:47 +1000 (AEST)
Message-ID: <1491797258.4166.205.camel@kernel.crashing.org>
Subject: Re: [PATCH 1/5] powerpc/pseries: do not use msgsndp doorbells on
 POWER9 guests
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@ozlabs.org>
Date: Mon, 10 Apr 2017 14:07:38 +1000
In-Reply-To: <20170410132245.16802599@roar.ozlabs.ibm.com>
References: <20170407125602.31146-1-npiggin@gmail.com>
 <20170407125602.31146-2-npiggin@gmail.com>
 <1491725015.4166.188.camel@kernel.crashing.org>
 <20170410132245.16802599@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-04-10 at 13:22 +1000, Nicholas Piggin wrote:
> On Sun, 09 Apr 2017 18:03:35 +1000
> > Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > On Fri, 2017-04-07 at 22:55 +1000, Nicholas Piggin wrote:
> > > POWER9 hypervisors will not necessarily run guest threads together on
> > > the same core at the same time, so msgsndp should not be used.  
> > 
> > Maybe we shouldn't advertise doorbells at all ?
> 
> Possibly not. I don't know if there is a good way to switch it off
> in the guest from the host with device tree currently. Might be better
> to clear it early in the guest rather than test it here though?

Sure for now. Long term a separate DT entry would be good. Might be
worth re-enabling one day if we have HW virtualization of geust
doorbells.

Cheers,
Ben

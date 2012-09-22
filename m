Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 659872C0091
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Sep 2012 05:55:50 +1000 (EST)
Message-ID: <1348343737.1132.74.camel@pasglop>
Subject: Re: Probing for native availability of isel from userspace
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Date: Sun, 23 Sep 2012 05:55:37 +1000
In-Reply-To: <BB86F53C-6C09-41DB-9FF3-38E3027BCC82@kernel.crashing.org>
References: <alpine.LNX.2.00.1209212355050.8539@linmac>
 <50EE7AAC-3080-4B1B-B741-E3F7F5A57A73@kernel.crashing.org>
 <alpine.LNX.2.00.1209221412010.1468@linmac>
 <20120922102151.GA31314@visitor2.iram.es>
 <alpine.LNX.2.00.1209221936330.3878@linmac>
 <BB86F53C-6C09-41DB-9FF3-38E3027BCC82@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, malc <av1474@comtv.ru>,
 hollis@penguinppc.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2012-09-22 at 21:08 +0200, Segher Boessenkool wrote:
> > Thanks for suggestion, but i'd rather not play with heuristics.
> 
> Have a look at /sys/kernel/debug/powerpc/emulated_instructions/ then?

Userspace should *NEVER* rely on the content of debugfs, it will change
with time, it is not a guaranteed ABI, it's purely for people to look
at... for debugging.

Unfortunately we don't expose ISEL support via features (maybe we
should, this is reasonably easy to fix, except that we are running short
on feature bits and adding a new set of bits isn't totally trivial).

At this stage I would recommend using arch 2.06 as your key/trigger and
either add a handful of known PVR values (mfpvr is emulated) for other
CPUs you know support it (there shouldn't be that many), or just do the
heuristic :-(

Cheers,
Ben.

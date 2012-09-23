Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 16C9D2C0096
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Sep 2012 11:46:06 +1000 (EST)
In-Reply-To: <1348343737.1132.74.camel@pasglop>
References: <alpine.LNX.2.00.1209212355050.8539@linmac>
 <50EE7AAC-3080-4B1B-B741-E3F7F5A57A73@kernel.crashing.org>
 <alpine.LNX.2.00.1209221412010.1468@linmac>
 <20120922102151.GA31314@visitor2.iram.es>
 <alpine.LNX.2.00.1209221936330.3878@linmac>
 <BB86F53C-6C09-41DB-9FF3-38E3027BCC82@kernel.crashing.org>
 <1348343737.1132.74.camel@pasglop>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <35A5B006-1E4E-4355-A6A4-CA5F7371D21C@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Probing for native availability of isel from userspace
Date: Sun, 23 Sep 2012 03:46:06 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
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

>> Have a look at /sys/kernel/debug/powerpc/emulated_instructions/ then?
>
> Userspace should *NEVER* rely on the content of debugfs, it will  
> change
> with time, it is not a guaranteed ABI, it's purely for people to look
> at... for debugging.

malc didn't say what he wants it for...  People are in userspace as
well ;-)

> At this stage I would recommend using arch 2.06 as your key/trigger  
> and
> either add a handful of known PVR values (mfpvr is emulated) for other
> CPUs you know support it (there shouldn't be that many), or just do  
> the
> heuristic :-(

That's for 64-bit; another good option for 64-bit is to just never use
isel, it hardly ever buys you anything.  It is much more useful on the
(older) 32-bit cores that support it.

Why does the kernel emulate this, btw?  I can see emulation is useful
for running older binaries, for instructions that have been removed
from the architecture; but for newly added instructions, or optional
instructions, it hurts more than it helps?


Segher

To: Mike Mager <mike@carts.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MPC8260 + L2 Cache: ever been done? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 22 Apr 2002 11:42:28 PDT."
             <5.1.0.14.2.20020422102923.00af7550@carts.com>
Date: Mon, 22 Apr 2002 23:34:53 +0200
Message-Id: <20020422213458.4F68CFF61@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Mike,

in message <5.1.0.14.2.20020422102923.00af7550@carts.com> you wrote:
>
> Has anyone ever seen an MPC8260-based design with L2
> cache run Linux (or any OS) with some semblance of stability?

Ummm.... you should improve your internal  communication:  Kevin  Fry
<kevin@carts.com>  has asked the same question just 2 days ago, and I
replied:

Yes, for example the TQM8260 modules come in some configurations with
L2 cache. It's a shipping product which runs 100% stable.

> I know there are several designs out there with an 8260 and
> L2, but they usually also have a 750 or some other CPU, and
> the L2 is hooked up to that CPU, not the 8260. I've checked the
> archives and searched online, but have been unable to find
> any information on these two devices working together.

It's working here.

> We have an 8260 design running in 60X-compatible mode with
> 1 to 4 MPC2605 L2 cache devices, and cache size is jumper-

There is only 1 x MPC2605 om the TQM8260 modules.

> selectable. Also on the 60X bus are a DIMM and a 16-bit flash.
> When L2 is turned off, Linux runs fine (we're using 2.4.18).
> When 256kB of L2 is enabled, Linux boots partially and then
> crashes, either freezing or getting infinite machine checks.
> When 512kB or 1MB are enabled, I never see any output from
> Linux. We're using PPCBoot 1.1.2 for booting, and the L2 is
> turned on in Linux (arch/ppc/kernel/head.S).

Never tried it with more than 256kB of L2; but you can check out  and
compare with the TQM8260_L2 resp. TQM8260_L2_266MHz configurations in
PPCBoot.

> location in memory in an infinite loop. It is not doing instruction
> fetches and accessing data from all over memory like Linux does.

Are you really sure it's a cache issue? So far I have seen many  more
cases  where  the  real  cause  of  the  problem  was  improper SDRAM
operation (failing in burst mode).

> init code for the L2 that Motorola provided us in head.S) The
> difficult part about debugging this problem is that Linux crashes
> in different ways at different times, so I've been unable to trigger

That just means you have a  memory  problem,  which  _can_  be  cache
related.

> Some other info: We've tried running the system in write-through
> mode with the same results. We've done this test with two
> versions of the 8260, mask A.1 and the new HiP4 (2k25a). And
> the CPM fifos are all either in local bus RAM or DPRAM in order
> to keep the CPM off the 60X bus (which causes other problems).

It works here for C.2 [6K23A] and A.0(A) [2K25A]; on the  TQM8260  we
cannot  enable  L2  on the A.0 [K22A] because the CPM (running at 133
MHz) has DMA problems there, and we  cannot  easily  reduce  the  CPM
speed to <100MHz on this board.

> If anyone has any answers, ideas, or insights into this problem,
> they'd be greatly appreciated.

All I can say is: it works for us on the only board that I have  with
L2 cache on it...

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Lack of skill dictates economy of style.                - Joey Ramone

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

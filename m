Date: Tue, 3 Jul 2001 04:03:36 -0400 (EDT)
From: "Justin (Gus) Hurwitz" <ghurwitz@dyndns.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Well, those changes broke something
In-Reply-To: <Pine.LNX.3.95.1010702090104.4368F-100000@november.bhjjh.erols.com>
Message-ID: <Pine.LNX.3.95.1010703034852.9083D-100000@november.bhjjh.erols.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm still working on solving the below problem, but I hae a bit more
information about the symptoms- I had thoughthe problem was when I spawned
a new process. It now appears that the problem is occuring when execve
(syscall 11) returns a wonderful demonstration is described below:

Upon booting I'm dropped to a bash prompt (I've no init installed yet).
>From here I execute another 5 or six shells:

bash# sh
sh# sh
sh# sh
sh# sh
sh# sh
sh#

I now execute any command (it doesn't need to be valid):
sh# date   OR  sh# asdfa

the program runs (or trys to run), and upon completion segfaults the
calling process (kernel access of bad area, sig 11). The last reported
syscall is 126 (sigprocmask) in this case; sometimes it's 11 (execve).

I presume that the kernel is in a working state (code wise) and that I
have managed to break it. Please correct me if I am wrong abuot that :)
Otherwise, does anyone have idea as to what I missed when importing
changes to the new kernel?

Thanks,

On Mon, 2 Jul 2001, Justin (Gus) Hurwitz wrote:

>
> I've spent today getting my three week old 2_4_devel tree up to date with
> the new 2_4_devel boot structure. I think that I've amde all of the
> appropriate changes (changed board_init() to platform_init(), added
> platform_set_bat and platform_map_io() functions, and made various
> makefile changes and the like). I have the kernel comiling and booting,
> but I get very regular segfaults.
>
> The kernel uncompresses and mounts the ramdisk just fine, and executes
> a shell, init, or linuxrc script just fine- but it seems that when I start
> another process I get a segfault (I say it seems because I am not sure of
> this).
>
> Anyhow, below are three characteristic suicide notes from the kernel. I am
> unsure how to trace them, due to the odd addresses
> {02000000,FFFF0001,00000000,7FFFFFDB,7FFFFF2C}. Perhaps those calls are
> the cause of the segfaults? But why then are there calls after these odd
> accesses? Also, all three of the below (and indeed, all that I have
> encountered) have NIP= C0006000, which is __fluch_dcache_icache. Might
> this be the problem?
>
> And, what has changed over the past three weeks that could be causing
> these failures? Or, what have I missed in compiling the kernel that could
> be causing these failures?
>
> Thanks- errors are below:

[SNIP]


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

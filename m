Date: Tue, 3 Jul 2001 05:07:21 -0400 (EDT)
From: "Justin (Gus) Hurwitz" <ghurwitz@dyndns.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Well, those changes broke something
In-Reply-To: <Pine.LNX.3.95.1010703034852.9083D-100000@november.bhjjh.erols.com>
Message-ID: <Pine.LNX.3.95.1010703050332.9083E-100000@november.bhjjh.erols.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Problem solved- thanks to those who recommended looking for places I might
have mucked with the memory setup seperate from what the kernel did- I had
been seting up a BATs entry by hand in head.S before- using BAT1, which I
then overwrote in the old MMU_init. I used BAT3 in my board_set_bat() call
in board_setup.c, which left the old entry around in BAT1, creating an
ugly conflict.

--Gus

On Tue, 3 Jul 2001, Justin (Gus) Hurwitz wrote:

>
> I'm still working on solving the below problem, but I hae a bit more
> information about the symptoms- I had thoughthe problem was when I spawned
> a new process. It now appears that the problem is occuring when execve
> (syscall 11) returns a wonderful demonstration is described below:
>
> Upon booting I'm dropped to a bash prompt (I've no init installed yet).
> >From here I execute another 5 or six shells:
>
> bash# sh
> sh# sh
> sh# sh
> sh# sh
> sh# sh
> sh#
>
> I now execute any command (it doesn't need to be valid):
> sh# date   OR  sh# asdfa
>
> the program runs (or trys to run), and upon completion segfaults the
> calling process (kernel access of bad area, sig 11). The last reported
> syscall is 126 (sigprocmask) in this case; sometimes it's 11 (execve).
>
> I presume that the kernel is in a working state (code wise) and that I
> have managed to break it. Please correct me if I am wrong abuot that :)
> Otherwise, does anyone have idea as to what I missed when importing
> changes to the new kernel?
>
> Thanks,


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

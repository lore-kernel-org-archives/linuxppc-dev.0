Message-Id: <5.1.0.14.2.20020221065102.01f08eb8@falcon.si.com>
Date: Thu, 21 Feb 2002 06:57:46 -0500
To: linuxppc-embedded@lists.linuxppc.org
From: Jerry Van Baren <vanbaren_gerald@si.com>
Subject: Re: Software FPU emulation
In-Reply-To: <3C74B50C.CE9EAEB@multitech.co.in>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


98% certainty it is a memory (UPM) problem.  You are probably randomly
misreading an instruction as 0xFFxxxxxx which is a floating point
instruction.  This causes a FP emulation trap.  If you look at where the
trap occurred (SPR register SRR0) and look at the actual memory location in
question with your debugger, you probably will not find a FP instruction in
memory, which means it was misread.

gvb


At 02:21 PM 2/21/2002 +0530, srinivas pulipati wrote:

>hi all,
>
>i have ported linux-2.4.4 to my custmoboard based on mpc860.
>i got the bash prompt succesfully.
>
>but is is crashing sometimes and giving FPU emulation., sig:8.
>sometimes working perfectly.
>
>is it because of UPM programming problem or something else?
>
>thanks
>srinivas
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

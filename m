Message-ID: <3DD4D6EE.5000902@uab.ericsson.se>
Date: Fri, 15 Nov 2002 12:13:50 +0100
From: Hans Feldt <Hans.Feldt@uab.ericsson.se>
MIME-Version: 1.0
To: Shen Rong <rshen@udtech.com.cn>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 8260 - Spurious interrupts again
References: <3DD254F0.3050701@uab.ericsson.se> <01a901c28c85$22aa99a0$e600a8c0@udtech.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On 11/15/02 09:58 AM, Shen Rong wrote:

>     I have the same problem like you, and I added a "sync" at the last line in
> m8260_mask_and_ack like you, and it solves the ploblem. But it is interesting
> that if I add a "sync" above the last line, it's also ok, that's

Well its the write to SIMR that needs a sync before enabling external
interrupts, not the sipnr variable.

> So I think there should be a time delay when we do mask&ack(&following operation maybe).

Don't agree, I believe the missing sync is a bug. I talked a Motorola
FAE yesterday and he says the same thing. It doesn't really matter if
you have the 8260 as a slave or not.

What does the maintainers of this code (Tom Rini?) think about it?

Thanks,
Hans


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

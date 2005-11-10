Return-Path: <kalle.pokki@iki.fi>
Received: from smtp1.song.fi (smtp1.song.fi [194.100.2.121])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F399068703
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 Nov 2005 19:20:37 +1100 (EST)
Received: from [194.100.64.94] (host94.eke.fi [194.100.64.94])
	by smtp1.song.fi (Postfix) with ESMTP id 882265F8ED
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 Nov 2005 10:20:30 +0200 (EET)
Message-ID: <437302CE.8070309@iki.fi>
Date: Thu, 10 Nov 2005 10:20:30 +0200
From: Kalle Pokki <kalle.pokki@iki.fi>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: PowerPC reservations
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

Can someone please help me understand how the memory reservations in 
PowerPC actually work. Let's just assume uniprocessor with a pre-emptive 
scheduler, and take a text-book example of an atomic increment case, 
which is also frequently used in e.g. the Linux kernel. With two atomic 
operations, everything seems to be just fine. But how about with three 
concurrent threads of execution?

 From the following code, assume r3 contains the same address for each 
incrementing operation. If the first atomic increment is pre-empted  in 
the middle, execution then jumps to the second increment (by the 
scheduler). The second increment runs through and succeeds, and 
continues straight to the third increment. Then it is again pre-empted 
in the middle, execution returning to the first increment. Now the 
processor has the reservation with the correct address, and the first 
increment succeeds when still holding the original input value. The 
first and the second increment thus write the same value in memory. 
After the first increment, the scheduler again continues the third 
increment, which doesn't succeed a first, but the second round succeeds. 
However, the value in the address pointed by r3 was not increased by 
three, but by two.

Am I just not getting how this is really supposed to work? Are there 
still some other constructs in use to prevent this, e.g. extra stwcx. 
instructions when changing the thread of execution?

I'm also wondering why the architecture specifically defines the stwcx. 
instruction to have, well, undefined behavior in case the reservation 
address differs from the address of the previous lwarx...

1:      lwarx r6, r0, r3
        addi r6, r6, 1
        stwcx. r6, r0, r3
        bne- 1b

.....

2:      lwarx r7, r0, r3
        addi r7, r7, 1
        stwcx. r7, r0, r3
        bne- 2b

3:      lwarx r8, r0, r3
        addi r8, r8, 1
        stwcx. r8, r0, r3
        bne- 3b

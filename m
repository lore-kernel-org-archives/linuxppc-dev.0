From: Benjamin Herrenschmidt <bh40@calva.net>
To: Gabriel Paubert <paubert@iram.es>
Cc: <linuxppc-dev@lists.linuxppc.org>, <paulus@linuxcare.com.au>
Subject: Re: 2.2.18pre17 again
Date: Tue, 31 Oct 2000 15:48:44 +0100
Message-Id: <19340925082028.17042@192.168.1.2>
In-Reply-To: <Pine.HPX.4.10.10010311315380.15431-100000@gra-ux1.iram.es>
References: <Pine.HPX.4.10.10010311315380.15431-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>Why isn't udelay based on the timebase then ? Easy to scale
>microseconds to timebase.

Because you didn't implement it yet ? :)

>There is a multiplier for mulhwu somewhere in a global variable, I should
>remember the name since I wrote the code, tb_to_us if I'm not messing up.

Do we have that code in 2.2 ? Your time management patches are in 2.4
only AFAIK (nice code BTW).

>It needs some care for 601 because of the different registers (RTC) that
>has the bad habit of jumping from 1e9 to 0. It is trivial to implement as
>a subroutine and check for CPU inside the subroutine. After all it's a
>delay, so performance should not be critical.
>
>udelay:
>	lis	r4,tb_to_us@ha
>	mfpvr	r5
>	lwz	r4,tb_to_us@l(r4)
>	srwi	r5,r5,16
>	mulhwu	r4,r3,r4
>	cmpwi	cr0,r5,1
>	beq	2f
>	mftbl	r5
>1:	mftbl	r3
>	sub	r3,r3,r5
>	cmplw	cr0,r3,r4	# works for delays of up to almost 2^32 tb ticks
>	blt	cr0,1b
>	blr
>
>2:	mfrtcl	r5
>3:	mfrtcl	r3
>	sub.	r3,r3,r5	# if wraparound has occurred
>	bnl+	4f		# bump elapsed time by one second
>	addis	r3,r3,1000000000@ha
>	addi	r3,r3,1000000000@l
>4:	cmplw	r3,r3,r4	# works for delays of up to almost 1 second
>	blt	cr0,3b
>	blr
>
>Caution, untested... BTW, that's the kind of routine in which I'd like to
>tell the compiler that it only uses r3/r4/r5/cr0 so that it can keep more
>variables in the registers of the caller.

What is the max delay supported ? I beleive we should implement it as
__udelay and keept the macro mecanism to catch too high delays.

>	Gabriel.
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

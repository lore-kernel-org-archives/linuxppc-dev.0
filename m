Message-ID: <4085483B.1090604@nortelnetworks.com>
Date: Tue, 20 Apr 2004 11:56:43 -0400
From: Chris Friesen <cfriesen@nortelnetworks.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: asm code
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm trying to do an indirect address lookup in entry.S.  I've added a
lookup table at the end of entry.S as follows:

hrt_ak_offsets:
	.byte HRT_AK_USER_USER_SYNC
	.byte HRT_AK_SIGM_USER_SYNC
	.byte HRT_AK_SIGU_USER_SYNC
	.byte HRT_AK_USER_SIG_SYNC
	.byte HRT_AK_SIGM_SIG_SYNC
	.byte HRT_AK_SIGU_SIG_SYNC
	.byte HRT_AK_USER_USER_ASYN
	.byte HRT_AK_SIGM_USER_ASYN
<etc...>

I then have some code that wants to load up one of these values and use
it as an offset into another struct.  Coming into the following stretch
of code, r6 contains the entry number within hrt_ak_offsets, and r4
contains the base address of the other struct.

	lis	r5,hrt_ak_offsets@ha
	addi	r5,r5,hrt_ak_offsets@l
	lbzx	r6,r6,r5
	add	r10,r4,r6

I'm having a small problem, in that when I run this code it hangs my
kernel.  Any ideas what's wrong?  The values in r6 and r5 seem to match
what I expect, but when I do the lbzx it dies.

Thanks,

Chris

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Date: Thu, 30 Aug 2001 17:09:37 +0200
From: Jure Menart <jure@kom.org>
To: linuxppc dev <linuxppc-dev@lists.linuxppc.org>
Subject: kernel course no. 1
Message-ID: <20010830170937.A21057@hannanges.teden-mladih.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,
I am checking kernel source from penguinppc.org (development tree), and try to
boot it... but, when I checked code in head_4xx.h I saw that code from
'_start' doesn't jump to 'start_here' because of 'strange coding' (sorry, but
it really seems strange to me ;-):

	li	r4,MSR_KERNEL
	lis	r3,start_kernel@h
	ori	r3,r3,start_kernel@l
	mtspr	SRR0,r3
	mtspr	SRR1,r4
	rfi /* enable MMU and jump to start_kernel */

In this part it stops... why don't we just use 'bl start_here'? I tried and it
works, but seems strange why would it be so complicated without a reason. Is
there a reason? :-)

Next thing I would like to know is in 'start_here' at the end... it jumps to
function (?) named '2f'. I can't find what is this '2f' (with other words - I
can't figure out, where code continues)?

OK, just one more thing... is there any 'roadmap' or some other kind of
documentation that would describe this early stage of kernel booting? (like at
first it is '_start', which do this and this and then jumps to 'start_here'
which does initizalization of... etc etc).

That would be it, thanks for answeres in advance...
Jure


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

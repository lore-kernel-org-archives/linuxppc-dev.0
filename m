Date: Sun, 2 Sep 2001 23:55:27 +0200
From: Jure Menart <jure@kom.org>
To: linuxppc dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: kernel course no. 1
Message-ID: <20010902235527.A745@hannanges.teden-mladih.com>
References: <20010830170937.A21057@hannanges.teden-mladih.com> <20010830152904.15461@smtp.adsl.oleane.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010830152904.15461@smtp.adsl.oleane.com>; from benh@kernel.crashing.org on Thu, Aug 30, 2001 at 05:29:04PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi again,
On Thu, Aug 30, 2001 at 05:29:04PM +0200, Benjamin Herrenschmidt wrote:
> >I am checking kernel source from penguinppc.org (development tree), and try to
> >boot it... but, when I checked code in head_4xx.h I saw that code from
> >'_start' doesn't jump to 'start_here' because of 'strange coding' (sorry, but
> >it really seems strange to me ;-):
> >
> >	li	r4,MSR_KERNEL
> >	lis	r3,start_kernel@h
> >	ori	r3,r3,start_kernel@l
> >	mtspr	SRR0,r3
> >	mtspr	SRR1,r4
> >	rfi /* enable MMU and jump to start_kernel */
> >
> >In this part it stops... why don't we just use 'bl start_here'? I tried and it
> >works, but seems strange why would it be so complicated without a reason. Is
> >there a reason? :-)
>
> Yes, and a big one ! Normally, at that point, you are running with MMU off,
> you need to re-enable it before entering the kernel, that's what the "rfi"
> does for you when the proper value is set into SRR1.

OK, thanks for information (I presumed that it is 'catch' with rfi :-), but
I've got problem with booting my kernel anyway. I was wondering why would
booting stop when this 'rfi' occurs... I was thinking it might be problem with
the stack, but I'm not be sure. I don't know how to tell kernel where the
stack 'lies' in memory (I don't use boot that comes with kernel).
Could problem be somewhere else?

[snip]
> >OK, just one more thing... is there any 'roadmap' or some other kind of
> >documentation that would describe this early stage of kernel booting? (like
> >at first it is '_start', which do this and this and then jumps to
> >'start_here' which does initialization of... etc etc).
?

Thanks for any answers...

best wishes, Jure


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

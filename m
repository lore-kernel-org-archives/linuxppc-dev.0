Date: Sun, 06 Apr 2003 04:13:33 +0200
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: check MMU state
In-reply-to: <3E8F2101.3090103@embeddededge.com>
To: Dan Malek <dan@embeddededge.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Reply-To: tglx@linutronix.de
Message-id: <200304060413.33628.tglx@linutronix.de>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
References: <200304051735.25831.tglx@linutronix.de>
 <1049556246.654.7.camel@zion.wanadoo.fr> <3E8F2101.3090103@embeddededge.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Saturday 05 April 2003 20:31, Dan Malek wrote:
> Benjamin Herrenschmidt wrote:
> > Ah well, I was talking about the "common" CPU case (CONFIG_6xx), I don't
> > know about 8xx but since the first thing the code  in head_8xx.S does is
> > "tlbia", I think you are in a bad situation running that with
> > translation enabled and no vectors around to handle the TLB miss...
>
> Well, it's worse then that.....if you have the MMU enabled and require
> taking tlb misses, I'm surprised you get to initial_mmu because we already
> wrote over the exception vectors.
>
> > For machines without BATs, I tend to think that a bootloader loading
> > you with MMU on shall be shot.
>
> We could do like some of the 60x/7xxx processors do.  They boot with
> the MMU enabled, using BATs mapped 1:1 to get certain cache attributes in
> memory spaces (DINK does this).  If you are using large pages on 8xx mapped
> 1:1 for the same cache attributes, it's OK.  If _any_ powerpc boots with
> the MMU enabled and not 1:1 mapping (on memory of interest), you are hosed.
>
> > .... What I'd suggest is that you hack a piggy
> > back loader in the zImage wrapper that shuts MMU off before entering the
> > kernel.
>
> Yep, and it should be done right away before any of the decompress is
> done so the cache management works correctly.
>
> > .... If you _have_ to run vmlinux as is,
>
> You can't on 8xx and most embedded systems.  You need some kind of
> piggyback loader to create the environment variables so Linux will boot
> properly.
I'm working on a PMC board, where I can't modify the bootloader for now. So I
had to go through this. The kernel is loaded via PCI as a plain vmlinux, for
initrd applies the same.

I had to fight some time, but finaly i got it to work. :)

--
Thomas
________________________________________________________________________
linutronix - competence in embedded & realtime linux
http://www.linutronix.de
mail: tglx@linutronix.de


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

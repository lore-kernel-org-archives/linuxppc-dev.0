In-Reply-To: <Pine.HPP.3.96.990215103957.5352f-100000@gra-ux1.iram.es>
Date: Mon, 15 Feb 1999 12:23:01 +0100
To: Gabriel Paubert <paubert@iram.es>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: your mail
Message-Id: <19990215122301.003056@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Feb 15, 1999, Gabriel Paubert <paubert@iram.es> wrote:

>One of the first steps I do in prepboot is to invalidate all the BATs and
>all the TLB entries, to make sur that I start from a known state
>(invalidating the BATs is a pain because it's different in 601 and
>others). But then I'm quite sure I'm called with address translation
>disabled, only that some FW version leave stale values in these registers. 

My bootstrap is now a two-step bootstrap too, written all in asm to avoid
relocation problems. 

>I still had problems with stale TLB entries between prepboot when the 
>kernel enabled the MMU. You have to flush the TLB before starting the
>kernel to be absolutely sure that there the kernel uses only translations 
>it has defined (I discovered that I had added code accessing I/O 
>space before the corresponding BATs were set up due to staale TLB
>entries).

Since the MMU is switched off by the boostrap, I beleive those TLB
entries won't do any harm until the kernel switches the MMU back on,
that's it ? (I just want to make sure I fully understand). So, basically,
I could add to my bootstrap a piece of code that invalidates all BATs and
flush the TLB (I'll look at your preploader code for that).

>Wrong, what is in r31 before ? You may clear unwanted MSR bits:

You are right. I already changed this to rlwinm approx. 5 minutes after
sending the previous mail ;-)
	
>	mfmsr	r0
>	rlwinm  r0,r0,0,17,15
>	mtmsr 	r0
>
>is enough (And if you don't like using rlwinm like this, which is
>guaranteed to work according to the architecture):
>	
>	mfmsr	r0
>	ori	r0,r0,MSR_EE
>	xori	r0,r0,MSR_EE
>	mtmsr	r0
>
>and you never need a sync before or after disabling interrupts. It is
>different when enabling them however, because you have to make
>sure that accesses to the interrupt controller have made it to the bus.  

Ok, so I'll finally remove this sync.

>I would recommend that you take a look at the patch files I have for
>prep (only have a look at the prepboot directory): 
>
>	ftp://vcorr1.iram.es/pub/linux-2.2/mvme2600.generic-patch-2.2.1.gz
>
>it is even probably overkill for what you need. But the Makefile
>(with -m rleocatable), the linker script (ppcboot.lds) and the
>early boot (head.S) are probably good examples (and I tried to keep them
>clean). 

Ok, thanks.


-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>





[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]

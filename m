To: greyham@research.canon.com.au (Graham Stoney)
Cc: dan@netx4.com (Dan Malek),
        linuxppc-embedded@lists.linuxppc.org (LinuxPPC Embedded Mailing List)
Subject: Re: Bizarre initrd problem on CLLF860T
References: <20000418075704.C3E833C970@elph.research.canon.com.au>
From: Marcus Sundberg <erammsu@kieraypc01.p.y.ki.era.ericsson.se>
Date: 18 Apr 2000 10:58:11 +0200
In-Reply-To: greyham@research.canon.com.au's message of "Tue, 18 Apr 2000 17:57:04 +1000 (EST)"
Message-ID: <kfybt37pyzg.fsf@kieraypc01.p.y.ki.era.ericsson.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


greyham@research.canon.com.au (Graham Stoney) writes:

> I am using the MontaVista kernel, with a few trivial local tweaks; namely the
> patches I've posted here over the last few weeks. My initrd problem lies in
> the CPU6 workaround in set_dec in arch/ppc/kernel/head.S, which does, err,
> interesting things to the command line!:
>
>         .globl  set_dec
> set_dec:
>         mfmsr   r5              /* Disable interrupts */
>         li      r4,0
>         ori     r4,r4,MSR_EE
>         andc    r6,r5,r4
>         SYNC                    /* Some chip revs need this... */
>         mtmsr   r6
>         SYNC
>         lis     r7, cmd_line@h			###
>         ori     r7, r7, cmd_line@l		###
>         li      r4, 0x2c00			###
>         stw     r4, 12(r7)			###
>         lwz     r4, 12(r7)			###
>         mtspr   22, r3          /* Update Decrementer */
>         SYNC
>         mtmsr   r5
>         SYNC
>         blr
>
> The lines marked ### look like debug code that shouldn't have made it out to
> the world. It's causing my boot command line "root=/dev/ram" to turn into
> "root=/dev/ra", and triggering the initrd code that tries to remount the real
> root filesystem. If you're using the CPU6 workarounds, I suggest you nuke
> those lines.

Actually they are part of the CPU6 workaround. set_dec() apparently
was overlooked in our version of it, but MontaVista have that fixed.
Unfortunately they fixed it wrong - set_dec() is called before the
command line is processed, unlike _switch() which also use cmd_line
to store the value.

I'd suggest keeping the C-version of set_dec() in ppc/kernel/time.h
where it used to be and change it to the followingcode :

static __inline__ void set_dec(unsigned int val)
{
        unsigned long flags;
	unsigned long dummy_var;
	register unsigned long reg5 __asm__ ("r5") = DEC_ADDR;
	register unsigned long reg4 __asm__ ("r4") = (unsigned long) &dummy_var;

        save_flags(flags);
        cli();
	asm volatile (
		"stw   %3,0(%2) \n\t"
		"lwz   %3,0(%2) \n\t"
		"mtspr %0,%1 \n\t"
		: : "i"(DEC), "r"((val)), "r"(reg4), "r"(reg5)
		: "r4", "r5", "memory");
        restore_flags(flags);
}

//Marcus
--
Signature under construction, please come back later.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

To: greyham@research.canon.com.au (Graham Stoney)
Cc: dan@netx4.com (Dan Malek),
        linuxppc-embedded@lists.linuxppc.org (LinuxPPC Embedded Mailing List)
Subject: Re: Bizarre initrd problem on CLLF860T
References: <20000418075704.C3E833C970@elph.research.canon.com.au> <kfybt37pyzg.fsf@kieraypc01.p.y.ki.era.ericsson.se>
From: Marcus Sundberg <erammsu@kieraypc01.p.y.ki.era.ericsson.se>
Date: 18 Apr 2000 11:10:35 +0200
In-Reply-To: Marcus Sundberg's message of "18 Apr 2000 10:58:11 +0200"
Message-ID: <kfy7ldvpyes.fsf@kieraypc01.p.y.ki.era.ericsson.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Marcus Sundberg <erammsu@kieraypc01.p.y.ki.era.ericsson.se> writes:

> I'd suggest keeping the C-version of set_dec() in ppc/kernel/time.h
> where it used to be and change it to the following code :

[snip]

Or not. ;-)
That didn't come out of the compiler as something useful, this version
works though:

static __inline__ void set_dec(unsigned int val)
{
	unsigned long dummy_var;
	register unsigned long reg5 __asm__ ("r5");
	register unsigned long reg4 __asm__ ("r4");
	unsigned long flags;

	save_flags(flags);
	cli();
	reg4 = (unsigned long) &dummy_var;
	reg5 = DEC_ADDR;
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

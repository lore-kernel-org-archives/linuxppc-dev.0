Date: Thu, 5 Feb 2004 19:52:14 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: MERRITT Nigel <Nigel.Merritt@tenix.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Interrupts on PPC 405Gr
Message-ID: <20040206035214.GC6578@gate.ebshome.net>
References: <200402060337.OAA03632@sprint.tenix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200402060337.OAA03632@sprint.tenix.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Feb 06, 2004 at 02:37:18PM +1100, MERRITT Nigel wrote:
>
> The kernel is 2.4.18 from Timesys.

Well, maybe you should ask them? I wasn't able to find any
downloadable PPC 4xx BSPs on Timesys web site.

> We have a logic analyser hooked up so we know for certain that the
> signal is being generated on the correct line and is entering the UIC.

OK

> CPC0_CR0 is being set using the (probably very wrong) code:
>
>       register_val = mfdcr(CPC0_CR0); // Read value from the register.
>
>       // Set to 0.
>       register_val = register_val & MASK_BIT_NOT_6;
>       register_val = register_val & MASK_BIT_NOT_7;

[snip]

I'd prefer real (hex) values, even better, just print them out after
you set them, i.e.

  printk("0x%08x\n", mfcdr(CPC0_CR0));

I have no idea how you defined all these macros.

> Polarity and trigger settings are being set in a similar manner, i.e:

 [snip]

> Again, how do these get set if not by adjusting the registers?

Well, official PPC kernels have a sane way to do this, look for
ibm4xxPIC_InitSenses in arch/ppc/platforms. Not sure whether Timesys
kernel has it.

And this kind of stuff (e.g. CPC0_CR0, polarity/trigerring settings)
is usually done in firmware not in the kernel.

Try official PPC kernel trees, at least they are known to work on
405 hardware. Maybe you problems are Timesys kernel specific.

Eugene.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

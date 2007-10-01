Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 36786DDE18
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  1 Oct 2007 23:51:25 +1000 (EST)
Date: Mon, 1 Oct 2007 08:55:16 -0500
From: Olof Johansson <olof@lixom.net>
To: Misbah khan <misbah_khan@engineer.com>
Subject: Re: Is it safe to use these Linux function (test_bit(), set_bit(),
	clear_bit()) in character device driver for 2.6.10 ppc kernel.
Message-ID: <20071001135516.GA8572@lixom.net>
References: <12916782.post@talk.nabble.com> <46FBD483.6090403@freescale.com>
	<12934517.post@talk.nabble.com> <46FC8EFE.2000108@mock.com>
	<12937117.post@talk.nabble.com> <12966462.post@talk.nabble.com>
	<20071001042559.GA32255@lixom.net> <12973587.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <12973587.post@talk.nabble.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sun, Sep 30, 2007 at 10:38:32PM -0700, Misbah khan wrote:

> Olof Johansson-2 wrote:
> > 
> > First, PLEASE stop quoting your own text. Do not append > in front of
> > the lines you write yourself in the reply. It makes it impossible to
> > tell what parts are new and what are old.

Please read the above again, since you didn't fix your mailer.

Also, make sure it doesn't prepend spaces in front of the lines you are
writing.

> > I am confused that some people tells me to map the memory noncacheble and
> > some tells me not. could you tell me which is the best approach and please
> > elaborate the reason as well. The part of the code is mentioned above is a
> > reference and my concern are as follows:-

It depends on your application and how the FPGA is attached. Buf if it is
attached outside of the coherence domain (for example on PCI), then you
should map it uncacheable. Otherwise you will have to do manual flushing
of caches to make sure writes make it out to the device, and also flush
any copy in cache before you read any register. In other words, it makes
things considerably more complicated and error-prone.

> > 1. I am mapping 32 KB of memory for which i am using _nocasheble. Is it
> > absolutely fine????

Just use ioremap().

> > 2. I am directly dereferencing the pointer to the mapped region insted of
> > using a wrapper function due to (1) Aready used in the past and have faith
> > in it .

I don't care if you have faith in it or not, it's still not the correct
way to do it. It might work right some of the time by pure luck but it
is the incorrect way of accessing device memory.

> >     (2) I had used functions like ioread32() iowrite32() in the past which
> > is suggested by rubini in his book on Linux device Driver but the output i
> > got was bitswapped .

I assume you mean byte swapped and not bit swapped.

Are your registers on the device big- or little endian?

If they are big endian, use in_be32/out_be32. If they're little endian, use
in_le32/out_le32. That will take care of any swapping for you.

> > 3. test_bit()/clear_bit() are the functions which i am using in my driver
> > and in the way i described above , please let me know that is looks fine
> > in the Implimention

No it is not fine. You cannot use set_bit/clear_bit against noncacheable
memory. EVER.

> >  or shall i read the value and mask the bits rather
> > than beliving in these functions for eg :-
> >
> > dfr_data_ret=*(volatile UINT32 *)((volatile UINT32
> > *)mmap_reg_ptr+DATA_STATUS_REG);
> > 
> > dfr_data_ret&=STATUS_MASK;
> > 
> > Please reply to clear my doubts.

Just do what I told you earlier:

To read the status register, mask out the STATUS_MASK and write it
back, do:

val = in_be32(mmap_reg_ptr + DATA_STATUS_REG);
val &= STATUS_MASK;
out_be32(MMAP_REG_PTR + DATA_STATUS_REG, val);


-Olof

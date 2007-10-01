Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8F49ADDE03
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  1 Oct 2007 15:38:35 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1IcDzE-0006tp-BR
	for linuxppc-embedded@ozlabs.org; Sun, 30 Sep 2007 22:38:32 -0700
Message-ID: <12973587.post@talk.nabble.com>
Date: Sun, 30 Sep 2007 22:38:32 -0700 (PDT)
From: Misbah khan <misbah_khan@engineer.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Is it safe to use these Linux function (test_bit(), set_bit(),
	clear_bit()) in character device driver for 2.6.10 ppc kernel.
In-Reply-To: <20071001042559.GA32255@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <12916782.post@talk.nabble.com> <46FBD483.6090403@freescale.com>
	<12934517.post@talk.nabble.com> <46FC8EFE.2000108@mock.com>
	<12937117.post@talk.nabble.com> <12966462.post@talk.nabble.com>
	<20071001042559.GA32255@lixom.net>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>




Olof Johansson-2 wrote:
> 
> First, PLEASE stop quoting your own text. Do not append > in front of
> the lines you write yourself in the reply. It makes it impossible to
> tell what parts are new and what are old.
> 
> On Sun, Sep 30, 2007 at 07:54:28AM -0700, Misbah khan wrote:
> 
>> >> FPGA is Indeed mapped non cashed here is the part of the code 
>> >> 
>> >> /* Physical bus memory is mapped */
>> >> 	mmap_reg_ptr=(UINT32 *)ioremap_nocache(PHY_MEM_ADDR,PHY_MEM_SIZE);
>> >> 
>> >> And is it ok if I caste FPGA pointer volatile like this will reduce
>> the
>> >> probability of failure 
> 
> You cannot ever use set_bit/clear_bit to uncacheable memory. Ever. It
> uses load-reserve/store-conditional, and they are not legal to use to
> uncacheable memory.
> 
> Also, regular ioremap() is by default uncacheable, so it's quite adequate
> to use in this case, no need to use the _nocache version.
> 
>> >> do you think   in_be32()  could be the best approach than direct
>> >> dereferencing. And about test_bit() function does it looks fine to you 
> 
> You need to use in_be32() + manipulating the value + out_be32(),
> yes. Depending on the rest of your driver you might need to protect it
> with a spinlock, but that's beyond the scope of this question.
> 
> 
> -Olof
> 
> I am confused that some people tells me to map the memory noncacheble and
> some tells me not. could you tell me which is the best approach and please
> elaborate the reason as well. The part of the code is mentioned above is a
> reference and my concern are as follows:-
> 
> 1. I am mapping 32 KB of memory for which i am using _nocasheble. Is it
> absolutely fine????
> 
> 2. I am directly dereferencing the pointer to the mapped region insted of
> using a wrapper function due to (1) Aready used in the past and have faith
> in it .
>     (2) I had used functions like ioread32() iowrite32() in the past which
> is suggested by rubini in his book on Linux device Driver but the output i
> got was bitswapped .
> 
> 3. test_bit()/clear_bit() are the functions which i am using in my driver
> and in the way i described above , please let me know that is looks fine
> in the Implimention or shall i read the value and mask the bits rather
> than beliving in these functions for eg :-
> 
> dfr_data_ret=*(volatile UINT32 *)((volatile UINT32
> *)mmap_reg_ptr+DATA_STATUS_REG);
> 
> dfr_data_ret&=STATUS_MASK;
> 
> Please reply to clear my doubts.
> 
> Misbah
> 
> 
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 

-- 
View this message in context: http://www.nabble.com/Is-it-safe-to-use-these-Linux-function-%28test_bit%28%29%2Cset_bit%28%29%2Cclear_bit%28%29%29-in-character-device-driver-for-2.6.10-ppc-kernel.-tf4527008.html#a12973587
Sent from the linuxppc-embedded mailing list archive at Nabble.com.

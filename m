Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6784DDDE17
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 28 Sep 2007 19:12:37 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1IbBti-0007Qp-6w
	for linuxppc-embedded@ozlabs.org; Fri, 28 Sep 2007 02:12:34 -0700
Message-ID: <12937117.post@talk.nabble.com>
Date: Fri, 28 Sep 2007 02:12:34 -0700 (PDT)
From: Misbah khan <misbah_khan@engineer.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Is it safe to use these Linux function (test_bit(), set_bit(),
	clear_bit()) in character device driver for 2.6.10 ppc kernel.
In-Reply-To: <46FC8EFE.2000108@mock.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <12916782.post@talk.nabble.com> <46FBD483.6090403@freescale.com>
	<12934517.post@talk.nabble.com> <46FC8EFE.2000108@mock.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>




Jeff Mock-2 wrote:
> 
> 
> 
> Misbah khan wrote:
>> 
>> 
>> Scott Wood-2 wrote:
>>> Misbah khan wrote:
>>>> Hi all I am using "test_bit(),set_bit(),clear_bit() etc" API functions 
>>>> provided by the Linux kernel. I want to know that if anybody is used it 
>>>> and have full faith in its operation then please let me know. Driver in 
>>>> the while loop is calling these API's hence i want to make sure that
>>>> its 
>>>> operation will remain stable.
>>> They're used all over the place.  Is there anything about them that you 
>>> find suspect?
>>>
>>> -Scott
>>>
>>> I have devloped a character driver for FPGA which is memory mapped and
>>> using these API's to test a bit , set a bit or to clear a bit in the
>>> memory for eg :-
>>>
>>> /* poll till data is transfered from sdram to dpram */
>>> 		while((test_bit(DFR_BUSY,(UINT32 *)(\
>>> 			(void *)mmap_reg_ptr + DATA_STATUS_REG))==1)\
>>> 			&& (delay < MAX_DELAY_BUSY))
>>> 		{
>>> 			KDEBUG3(" In the Dfr delay loop \n");
>>> 			mdelay(DELAY);
>>> 			delay+=DELAY;
>>> 		}/* End of while(test_bit(FPGA_BUSY,(void *)register name) */
>>>
>>> 		if(delay==MAX_DELAY_BUSY)
>>> 		{
>>> 			KDEBUG1("Out of the the Dfr busy loop \n");
>>> 			return -1;
>>> 		}
>>>
>>> People working for FPGA are sure that they are not making the bit high
>>> where in my driver is returning -1 from the kernel space aborting it
>>> after
>>> running for few minutes or so . Please let me know that This function is
>>> stable and i should tell them that the driver is stable in its operation
>>> and they should check it from there side.
>>>
> 
> 
> I think a more more likely source of the problem is that the FPGA
> pointer is not cast volatile, or perhaps the FPGA is mapped cached and 
> the hardware doesn't always get touched when you think it does.  The bit 
> manipulation macros are probably fine.
> 
> jeff
> 
> FPGA is Indeed mapped non cashed here is the part of the code 
> 
> /* Physical bus memory is mapped */
> 	mmap_reg_ptr=(UINT32 *)ioremap_nocache(PHY_MEM_ADDR,PHY_MEM_SIZE);
> 
> And is it ok if I caste FPGA pointer volatile like this will reduce the
> probability of failure 
> 
> /* poll till data is transfered from sdram to dpram */
> 		while((test_bit(DFR_BUSY,(volatile UINT32 *)(\
> 			(volatile UINT32 *)mmap_reg_ptr + DATA_STATUS_REG))==1)\
> 			&& (delay < MAX_DELAY_BUSY))
> 		{
> 			KDEBUG3(" In the Dfr delay loop \n");
> 			mdelay(DELAY);
> 			delay+=DELAY;
> 		}/* End of while(test_bit(FPGA_BUSY,(void *)register name) */
> 
> 		if(delay==MAX_DELAY_BUSY)
> 		{
> 			KDEBUG1("Out of the the Dfr busy loop \n");
> 			return CASHEL_FAILURE;
> 		}
> __________________
> 
> is there anything else that we could do to rely fully in our code.
> 
> Misbah
> _____________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 

-- 
View this message in context: http://www.nabble.com/Is-it-safe-to-use-these-Linux-function-%28test_bit%28%29%2Cset_bit%28%29%2Cclear_bit%28%29%29-in-character-device-driver-for-2.6.10-ppc-kernel.-tf4527008.html#a12937117
Sent from the linuxppc-embedded mailing list archive at Nabble.com.

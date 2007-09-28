Return-Path: <jeff@mock.com>
Received: from mail.mock.com (gw.mock.com [209.157.146.194])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.mock.com", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 309E3DDE11
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 28 Sep 2007 15:20:04 +1000 (EST)
Message-ID: <46FC8EFE.2000108@mock.com>
Date: Thu, 27 Sep 2007 22:19:58 -0700
From: Jeff Mock <jeff@mock.com>
MIME-Version: 1.0
To: Misbah khan <misbah_khan@engineer.com>
Subject: Re: Is it safe to use these Linux function (test_bit(), set_bit(),
	clear_bit()) in character device driver for 2.6.10 ppc kernel.
References: <12916782.post@talk.nabble.com> <46FBD483.6090403@freescale.com>
	<12934517.post@talk.nabble.com>
In-Reply-To: <12934517.post@talk.nabble.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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



Misbah khan wrote:
> 
> 
> Scott Wood-2 wrote:
>> Misbah khan wrote:
>>> Hi all I am using "test_bit(),set_bit(),clear_bit() etc" API functions 
>>> provided by the Linux kernel. I want to know that if anybody is used it 
>>> and have full faith in its operation then please let me know. Driver in 
>>> the while loop is calling these API's hence i want to make sure that its 
>>> operation will remain stable.
>> They're used all over the place.  Is there anything about them that you 
>> find suspect?
>>
>> -Scott
>>
>> I have devloped a character driver for FPGA which is memory mapped and
>> using these API's to test a bit , set a bit or to clear a bit in the
>> memory for eg :-
>>
>> /* poll till data is transfered from sdram to dpram */
>> 		while((test_bit(DFR_BUSY,(UINT32 *)(\
>> 			(void *)mmap_reg_ptr + DATA_STATUS_REG))==1)\
>> 			&& (delay < MAX_DELAY_BUSY))
>> 		{
>> 			KDEBUG3(" In the Dfr delay loop \n");
>> 			mdelay(DELAY);
>> 			delay+=DELAY;
>> 		}/* End of while(test_bit(FPGA_BUSY,(void *)register name) */
>>
>> 		if(delay==MAX_DELAY_BUSY)
>> 		{
>> 			KDEBUG1("Out of the the Dfr busy loop \n");
>> 			return -1;
>> 		}
>>
>> People working for FPGA are sure that they are not making the bit high
>> where in my driver is returning -1 from the kernel space aborting it after
>> running for few minutes or so . Please let me know that This function is
>> stable and i should tell them that the driver is stable in its operation
>> and they should check it from there side.
>>


I think a more more likely source of the problem is that the FPGA
pointer is not cast volatile, or perhaps the FPGA is mapped cached and 
the hardware doesn't always get touched when you think it does.  The bit 
manipulation macros are probably fine.

jeff

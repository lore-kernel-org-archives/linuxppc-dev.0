Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C2542DDE05
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 29 Sep 2007 02:10:01 +1000 (EST)
Message-ID: <46FD273A.1050503@freescale.com>
Date: Fri, 28 Sep 2007 11:09:30 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Misbah khan <misbah_khan@engineer.com>
Subject: Re: Is it safe to use these Linux function (test_bit(), set_bit(),
	clear_bit()) in character device driver for 2.6.10 ppc kernel.
References: <12916782.post@talk.nabble.com> <46FBD483.6090403@freescale.com>
	<12934517.post@talk.nabble.com>
In-Reply-To: <12934517.post@talk.nabble.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
>> They're used all over the place.  Is there anything about them that you 
>> find suspect?
>>
>> -Scott
>>
>> I have devloped a character driver for FPGA which is memory mapped and
>> using these API's to test a bit , set a bit or to clear a bit in the
>> memory for eg :-

Please don't use quote markers on newly added text.

>> /* poll till data is transfered from sdram to dpram */
>> 		while((test_bit(DFR_BUSY,(UINT32 *)(\
>> 			(void *)mmap_reg_ptr + DATA_STATUS_REG))==1)\
>> 			&& (delay < MAX_DELAY_BUSY))

You should use in_be32() rather than direct dereferencing.

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
>> running for few minutes or so .

I don't suppose the "few minutes" corresponds to MAX_DELAY_BUSY?

-Scott

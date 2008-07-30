Return-Path: <hbausley@deltatau.com>
Received: from mail.deltatau.com (smtp.deltatau.com [64.60.44.211])
	by ozlabs.org (Postfix) with ESMTP id 64DCFDDF81
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 31 Jul 2008 04:38:10 +1000 (EST)
Message-ID: <252a01c8f272$c10a4b50$0109220a@deltatau.local>
From: "Henry Bausley" <hbausley@deltatau.com>
To: "Josh Boyer" <jwboyer@linux.vnet.ibm.com>
References: <23b401c8f10b$54ecf9d0$0109220a@deltatau.local>
	<20080729200225.57634f94@zod.rchland.ibm.com>
Subject: Re: Writing to CPLD mapped to EBC Port of AMCC440EP
Date: Wed, 30 Jul 2008 11:33:25 -0700
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Our board is based upon the Yosemite.  But we have modified the CPLD and 
made our own custom hardware, thats why the parameters for ioremap are 
different.  The system is based on the 2.6.14-rtl that has worked absolutely 
perfect for a couple of years which we got from FSM Labs.

I am porting to the 2.6.24 kernel Denx with xenomai and had the problem.  It 
turns out the default value if the EBC0_CFG register  was 0x84400000 in the 
system and we needed to change it to 0xBC400000 to increase the Ready 
Timeout.  We were getting a machine check error.

Thank's a lot for your input!!!



----- Original Message ----- 
From: "Josh Boyer" <jwboyer@linux.vnet.ibm.com>
To: "Henry Bausley" <hbausley@deltatau.com>
Cc: <linuxppc-embedded@ozlabs.org>
Sent: Tuesday, July 29, 2008 5:02 PM
Subject: Re: Writing to CPLD mapped to EBC Port of AMCC440EP


> On Mon, 28 Jul 2008 16:40:35 -0700
> "Henry Bausley" <hbausley@deltatau.com> wrote:
>
>>
>> I am attempting to write to a CPLD mapped to the EBC port of a AMCC 
>> 440EP.  When I attempt to write using an unsigned variable
>> ie. unsigned *pbase = (unsigned char *)ioremap64(0x8F000000,0x1000000);
>> I get a kernel access of bad area, sig: 11 fault.  However, if I change 
>> to an unsigned char ie. unsigned char *pbase = (unsigned char 
>> *)ioremap64(0x8F000000,
>> 0x1000000); The system doesn't crash.  I need to write using an unsigned. 
>> Does any one have any ideas what I am doing wrong?
>
> The documentation I have for the Bamboo board says the EPLD is at
> address 0x80002000 and is only 8 bytes in size.  Similarly, the
> Yosemite board CPLD is at 0x80002000 and is only 16 bytes in size.  Why
> you are ioremapping 16MiB at 0x8F000000 I have no idea.
>
> Also, the individual registers of the EPLD/CPLD on both boards are only
> 8 bits, so an unsigned char seems appropriate.  If you have a custom
> board that does something totally different from how the eval boards
> are set up, then I'm not sure many people will be able to help you
> without documentation for that board.
>
> josh 

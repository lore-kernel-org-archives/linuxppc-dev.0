Return-Path: <Bruce_Leonard@selinc.com>
Received: from tesla.selinc.com (tesla.selinc.com [12.110.71.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "tesla.selinc.com", Issuer "RSA Data Security,
	Inc." (verified OK)) by ozlabs.org (Postfix) with ESMTP id 412E6DDE26
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Feb 2008 11:22:23 +1100 (EST)
In-Reply-To: <47B8285C.40204@grandegger.com>
To: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: Frustrated question with insmod
MIME-Version: 1.0
Message-ID: <OF5B1D6538.27F4BDEE-ON882573F4.0000830F-882573F4.0001FF46@selinc.com>
From: Bruce_Leonard@selinc.com
Date: Mon, 18 Feb 2008 16:22:16 -0800
Content-Type: text/plain; charset="US-ASCII"
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

> Bruce_Leonard@selinc.com wrote:
> > Sorry if this is the wrong place to post this question.  I'm 
developing a 
> > NAND flash driver and I need to do some detailed dubugging using GDB 
with 
> > a BDI2K.  According to the Denx web site, to find out the address that 
the 
> > module is loading at you load it using the -m parameter to insmod 
(i.e., 
> > "insmod -m mymodule").  However, every version of insmod I've tried 
> > doesn't recognize ANY options much less -m.  Can anyone please point 
me in 
> > the right direction, or give me another way of knowing what the load 
> > address of my module is?
> 
> # cat /sys/module/<name>/sections/.text
> 
> Do not forget to enable CONFIG_KALLSYMS.
> 

Well, okay I guess the address I'm getting is the right one because both 
the above cat and 'cat /proc/modules' gives me the same thing, 0xe1188000. 
 I've got CONFIG_KALLSYMS and CONFIG_KALLSYMS_ALL set, though 
CONFIG_KALLSYMS_EXTRA_PASS is not set, don't know if that makes a 
difference.

So it would seem that there's something wrong with my BDI setup that isn't 
allowing address translation in the kernel's dynamically allocated memory 
area.  I've got PTBASE set to 0xf0 in the BDI config file so it should be 
finding the virtual address of the page tables just fine.  I've also got 
CONFIG_BDI_SWITCH set in .config and I know that works with the BDI, 
because I can set breakpoints at places in the kernel code that are called 
by my module (like nand_scan_ident() ) and everything works just fine. 
It's just when I try to access memory in the dynamic area where my module 
is located that the BDI can't do an address translation.  At least I 
assume it's the BDI, because I can load the module and use it with out 
GDB/BDI, so the processor and kernel must be able to handle the addresses 
okay.  Can anyone think of where I should go dig?  I've had this working 
exactly once in the past, but I don't know what I've changed to cause it 
to stop working.

Thanks.

Bruce

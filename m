Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id D30CBDDF27
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Feb 2008 01:04:55 +1100 (EST)
Message-ID: <47BC3383.6060002@grandegger.com>
Date: Wed, 20 Feb 2008 15:04:51 +0100
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Bruce_Leonard@selinc.com
Subject: Re: Frustrated question with insmod
References: <OF5B1D6538.27F4BDEE-ON882573F4.0000830F-882573F4.0001FF46@selinc.com>
In-Reply-To: <OF5B1D6538.27F4BDEE-ON882573F4.0000830F-882573F4.0001FF46@selinc.com>
Content-Type: text/plain; charset=ISO-8859-1
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

Bruce_Leonard@selinc.com wrote:
>> Bruce_Leonard@selinc.com wrote:
>>> Sorry if this is the wrong place to post this question.  I'm 
> developing a 
>>> NAND flash driver and I need to do some detailed dubugging using GDB 
> with 
>>> a BDI2K.  According to the Denx web site, to find out the address that 
> the 
>>> module is loading at you load it using the -m parameter to insmod 
> (i.e., 
>>> "insmod -m mymodule").  However, every version of insmod I've tried 
>>> doesn't recognize ANY options much less -m.  Can anyone please point 
> me in 
>>> the right direction, or give me another way of knowing what the load 
>>> address of my module is?
>> # cat /sys/module/<name>/sections/.text
>>
>> Do not forget to enable CONFIG_KALLSYMS.
>>
> 
> Well, okay I guess the address I'm getting is the right one because both 
> the above cat and 'cat /proc/modules' gives me the same thing, 0xe1188000. 
>  I've got CONFIG_KALLSYMS and CONFIG_KALLSYMS_ALL set, though 
> CONFIG_KALLSYMS_EXTRA_PASS is not set, don't know if that makes a 
> difference.
> 
> So it would seem that there's something wrong with my BDI setup that isn't 
> allowing address translation in the kernel's dynamically allocated memory 
> area.  I've got PTBASE set to 0xf0 in the BDI config file so it should be 
> finding the virtual address of the page tables just fine.  I've also got 
> CONFIG_BDI_SWITCH set in .config and I know that works with the BDI, 
> because I can set breakpoints at places in the kernel code that are called 
> by my module (like nand_scan_ident() ) and everything works just fine. 
> It's just when I try to access memory in the dynamic area where my module 
> is located that the BDI can't do an address translation.  At least I 
> assume it's the BDI, because I can load the module and use it with out 
> GDB/BDI, so the processor and kernel must be able to handle the addresses 
> okay.  Can anyone think of where I should go dig?  I've had this working 
> exactly once in the past, but I don't know what I've changed to cause it 
> to stop working.

Try to specify the addresses of the other sections listed by "cat
/sys/module/my-mod/sections/:

  add-symbol-file my-mod.o 0xcf030060\
   -s .rodata 0xcf030354\
   -s .data   0xcf030488\
   -s .sdata  0xcf030488\
   -s .bss    0xcf030519\
   -s .sbss   0xcf03051c

Wolfgang.

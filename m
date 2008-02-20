Return-Path: <Bruce_Leonard@selinc.com>
Received: from tesla.selinc.com (tesla.selinc.com [12.110.71.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "tesla.selinc.com", Issuer "RSA Data Security,
	Inc." (verified OK)) by ozlabs.org (Postfix) with ESMTP id 4AA29DE299
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Feb 2008 06:42:06 +1100 (EST)
In-Reply-To: <47BC3383.6060002@grandegger.com>
To: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: Frustrated question with insmod
MIME-Version: 1.0
Message-ID: <OFC0D67C81.314CAA65-ON882573F5.006BA6F8-882573F5.006C329E@selinc.com>
From: Bruce_Leonard@selinc.com
Date: Wed, 20 Feb 2008 11:41:50 -0800
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

> 
> Try to specify the addresses of the other sections listed by "cat
> /sys/module/my-mod/sections/:
> 
>   add-symbol-file my-mod.o 0xcf030060\
>    -s .rodata 0xcf030354\
>    -s .data   0xcf030488\
>    -s .sdata  0xcf030488\
>    -s .bss    0xcf030519\
>    -s .sbss   0xcf03051c
> 
> Wolfgang.

Thanks to all for the help.  What I've finally figured out is this: even 
though I know in advance what address my module is going to be loaded at, 
until the module is actually loaded the memory "doesn't exist", i.e., 
there's no entry in the page tables.  So I set the breakpoint at an 
address that doesn't have a translation and when I tell GDB to go it tries 
to access that memory, which doesn't exist, so I get the MMU error.  So 
I've figured out the problem is, but I'm not sure of the solution.  I 
think if I tell the BDI to use HW breakpoints rather than SW breakpoints 
it will probably work.

Again, thanks for all the suggestions, especially about how to get the -m 
option working for insmod.

Bruce

Return-Path: <hbausley@deltatau.com>
Received: from mail.deltatau.com (smtp.deltatau.com [64.60.44.211])
	by ozlabs.org (Postfix) with ESMTP id 5F5D3DDE24
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  5 Nov 2008 06:10:41 +1100 (EST)
Subject: Re: Accessing PCI-E resources on 460EX
From: Henry Bausley <hbausley@deltatau.com>
To: Felix Radensky <felix@embedded-sol.com>
In-Reply-To: <490F80E1.1060909@embedded-sol.com>
References: <490F6882.6050101@embedded-sol.com>
	<16691A8B34B5D9458EA3A1C37A11555A0137F852@tanisys-ex2.Tanisys.Local>
	<490F80E1.1060909@embedded-sol.com>
Content-Type: text/plain
Date: Tue, 04 Nov 2008 10:40:22 -0800
Message-Id: <1225824022.12185.11.camel@lt-linuxhenry>
Mime-Version: 1.0
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

Did you try mmap2.  It probable is not in glibc so you will have to call
it using syscall.

#include <sys/syscall.h>

unsigned *pdata  = (unsigned *)syscall(__NR_mmap2,0,0x100000,PROT_READ|
PROT_WRITE,MAP_SHARED,fd, 0xe80000 );

The address is in page offsets that why the address is 0xe80000.


On Tue, 2008-11-04 at 00:53 +0200, Felix Radensky wrote:
> Ayman El-Khashab wrote:
> >
> > What works for me is using the mmap64 as in the following example to
> > map the physical address, fd is the file descriptor for /dev/mem
> >
> > off64_t offset = static_cast<off64_t>(your physical address);
> > void * const p =
> > mmap64(0,256,PROT_WRITE|PROT_READ,MAP_SHARED,fd,offset);
> >
> > The only thing to note is that the address you pass should be aligned 
> > to the page boundry even though some devices are not.
> >   
> 
> Thanks, Ayman. I've tried that, but I'm still getting the same error.
> My physical address is 0xe80000000, length is 0x100000.
> 
> Felix.
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded

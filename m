Return-Path: <bgat@billgatliff.com>
Received: from venus.billgatliff.com (venus.billgatliff.com [209.251.101.201])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 02DA2DDE41
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 Jul 2007 02:29:04 +1000 (EST)
Message-ID: <46A8CBC0.8010909@billgatliff.com>
Date: Thu, 26 Jul 2007 11:28:48 -0500
From: Bill Gatliff <bgat@billgatliff.com>
MIME-Version: 1.0
To: Bill Gatliff <bgat@billgatliff.com>,  gdb@sourceware.org,
	linuxppc-embedded@ozlabs.org
Subject: Re: Gdbserver syscall clobber
References: <469B922D.3050701@billgatliff.com>
	<20070716155348.GA5281@caradoc.them.org>
	<469E550E.5080905@billgatliff.com>
	<20070718183143.GA25324@caradoc.them.org>
	<46A4D1F5.1060005@billgatliff.com>
	<20070723161512.GA3235@caradoc.them.org>
In-Reply-To: <20070723161512.GA3235@caradoc.them.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Daniel Jacobowitz wrote:
> Look around do_signal:
>
>                         regs->nip -= 4; /* Back up & retry system call */
>
> If your kernel has corrupted the register containing the syscall
> number at this point, that would explain your problem.  It will then
> do the wrong syscall.  I guess PPC only backs up one instruction.
>
>   

Found the code in do_signal, right where you said it would be.  I threw 
in a printk or two to see what's up when an ERESTARTSYS is detected, and 
started getting OOPSes all over the place.  Apparently that's not a good 
place for printk.  :)

Before I go on, can anyone confirm that gdbserver and/or strace _ever_ 
worked with circa 2.4.16 PPC kernels?



b.g.

-- 
Bill Gatliff
bgat@billgatliff.com

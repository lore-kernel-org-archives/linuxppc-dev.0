Return-Path: <a.woellert@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.196])
	by ozlabs.org (Postfix) with ESMTP id 3EC0F67C5A
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Jul 2005 15:45:36 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id i13so347835wra
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Jul 2005 22:45:35 -0700 (PDT)
Message-ID: <42D5FBBF.8030302@gmail.com>
Date: Thu, 14 Jul 2005 07:44:31 +0200
From: =?ISO-8859-1?Q?Anton_W=F6llert?= <a.woellert@gmail.com>
MIME-Version: 1.0
To: Theo Gjaltema <gjalt007@chello.nl>,  linuxppc-embedded@ozlabs.org
References: <42C1AAC1.4060702@gmail.com>	<20050629085913.GA2153@logos.cnet>	<faba7798050630071347d4ad63@mail.gmail.com>	<20050701094438.GA11121@logos.cnet>	<1120229717.21507.9.camel@jmcmullan.timesys>	<20050701101713.GC11121@logos.cnet>	<1120244191.18872.3.camel@jmcmullan.timesys>	<17096.61878.43282.752343@astp0002.localdomain>	<20050708003639.GA5174@dmt.cnet>	<17104.52971.2458.935609@astp0002.localdomain>
	<42D5361B.2070402@chello.nl>
In-Reply-To: <42D5361B.2070402@chello.nl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: Re: mpc8xx and ld.so problem
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Theo Gjaltema wrote:

 > Has anyone an idea why only this large application failed? busybox_1.0
 > and more applications work fine.
 > system is a: mcp862/32Mb SDRAM started from u-boot 0.4.1,
 > kernel enhanced with atm/utopia driver.
 >
 > This driver causes the CPM sometimes to hang when performing a memset,
 > can this be caused by the same problem?
 > (CPM stops responding, console buffers are not flused anymore and
 > kernel stops waiting for buffers)
 >
 > Greetings,
 >   Theo Gjaltema
 >

the problem ( so i think ) is, that larger applications will need more 
space, which in turn is satisfied by malloc (or mmap with fd = -1). 
these allocated pages are not real initialized after malloc ( they will 
be initialized completely, if a write on it is done, which will cause 
the page fault handler, that does the hardware mmu-stuff, so that a 
write can be done). so they will cause a page fault on a first access. 
no problem so long, but when the memset.S routine in libc tries to set 
all to zero, it uses the dcbz instructions. this instruction then causes 
a page fault or better a TLB miss (if i'm right). after the exception is 
raised, the address where the write to was done is looked up in the DAR 
(data address register), which could be bogus on the dcb* instruction 
(on 8xx, where is the errata for that?).
to sum up, the chance, that a memset( .., '\0', ..) with dcbz is done on 
a page (that has just registered structures in the kernel, and not 
cached in the tlb or even marked as writeable) is bigger :)

that's my opinion. if someone has more knowledge about that, or if i'm 
wrong - please! correct me.

anton

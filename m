Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0BFD1DDE01
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Oct 2007 17:34:47 +1000 (EST)
Subject: Re: ppc manual paging question
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Wang, Baojun" <wangbj@lzu.edu.cn>
In-Reply-To: <200710221417.43544.wangbj@lzu.edu.cn>
References: <200710221203.24157.wangbj@lzu.edu.cn>
	<200710221350.31688.wangbj@lzu.edu.cn> <393033430.04221@lzu.edu.cn>
	<200710221417.43544.wangbj@lzu.edu.cn>
Content-Type: text/plain
Date: Mon, 22 Oct 2007 17:34:24 +1000
Message-Id: <1193038464.6745.70.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, rtlinuxgpl@upv.es,
	Miguel Masmano <mimastel@doctor.upv.es>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Sorry I didn't realized that. I've finished looking pem64b.pdf, but it's 
> almost nothing like in ppc 4xx/44x.

You'll have to get yourself a 44x manual :-)

> > It's a software loaded TLB, you'll have to put translations in the TLB
> > yourself. You'll need to design your own data structures for that, tho
> > you can use a page table for tracking, like we do in linux, and then
> > have your own TLB miss handler to fill the TLB from that.

> OK, Shall I look for the DataTLBError code in head.S? I realized that I've got 
> DataTLBError sometimes via BDI2000/kgdb (the fault address is within 
> DataTLBError), Shall I should also look for arch/ppc/mm/fault.c?

head_44x.S is where you'll find some guidance

> > Your initial code probably need to bolt a TLB entry for the kernel
> > itself.
> I don't understand this clearly, how can I do this?

Well, you insert a TLB entry manually and avoid replacing it later on

Ben.

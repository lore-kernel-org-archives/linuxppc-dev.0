Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9B4ECDDE34
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Oct 2007 18:04:39 +1000 (EST)
Subject: Re: ppc manual paging question
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Wang, Baojun" <wangbj@lzu.edu.cn>
In-Reply-To: <200710221542.10592.wangbj@lzu.edu.cn>
References: <200710221203.24157.wangbj@lzu.edu.cn>
	<200710221417.43544.wangbj@lzu.edu.cn> <393039004.29574@lzu.edu.cn>
	<200710221542.10592.wangbj@lzu.edu.cn>
Content-Type: text/plain
Date: Mon, 22 Oct 2007 18:04:14 +1000
Message-Id: <1193040254.6745.76.camel@pasglop>
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


> Yup, I've found how does the kernel handle tlbs, I think the most important 
> thing is I forgot read/write the SPRN_SPRG3 register as _switch does.

SPRG3 is for use by the operating system for whatever you want... if you
are copying linux code, then you probably indeed want to get that right
but you don't have to use SPRG3.

> I've add the _PAGE_PRESENT flag to the related PTE

Hrm.. that has nothing ot do with the PTE. Bolting is more a property of
your replacement algorithm in the TLB miss handler.

Ben.

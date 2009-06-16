Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id B8E36B7116
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 16 Jun 2009 11:31:23 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 10D03DDD1B
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Jun 2009 11:31:22 +1000 (EST)
Subject: Re: [OOPS] hugetlbfs tests with 2.6.30-rc8-git1
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sachin Sant <sachinp@in.ibm.com>
In-Reply-To: <4A3645EE.5060103@in.ibm.com>
References: <4A290195.3080807@in.ibm.com> <1244233062.31984.6.camel@pasglop>
	<4A34E12B.4010000@in.ibm.com> <1245027396.7705.23.camel@concordia>
	<4A3645EE.5060103@in.ibm.com>
Content-Type: text/plain
Date: Tue, 16 Jun 2009 11:30:28 +1000
Message-Id: <1245115828.12400.48.camel@pasglop>
Mime-Version: 1.0
Cc: Mel Gorman <mel@csn.ul.ie>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2009-06-15 at 18:30 +0530, Sachin Sant wrote:

>  278:   2f 80 00 00     cmpwi   cr7,r0,0
>         } else {
>                 vsid = get_kernel_vsid(addr, mmu_kernel_ssize);
>                 ssize = mmu_kernel_ssize;
>         }
>         vaddr = hpt_va(addr, vsid, ssize);
>         rpte = __real_pte(__pte(pte), ptep);
>  27c:   eb 89 80 00     ld      r28,-32768(r9)  

I think I know what the problem is. I'll send a tentative patch as soon
as I got to test it a bit here.

Cheers,
Ben.

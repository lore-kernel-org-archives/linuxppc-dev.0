Return-Path: <FENKES@de.ibm.com>
Received: from mtagate4.de.ibm.com (mtagate4.de.ibm.com [195.212.29.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate4.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E6029DDD0A
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 00:27:09 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate4.de.ibm.com (8.13.8/8.13.8) with ESMTP id l8DER5IG140510
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Sep 2007 14:27:05 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.5) with
	ESMTP id l8DER5sj2109488
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Sep 2007 16:27:05 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l8DER4jv030812
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Sep 2007 16:27:05 +0200
In-Reply-To: <adaps0nmbfa.fsf@cisco.com>
To: Roland Dreier <rdreier@cisco.com>
MIME-Version: 1.0
Subject: Re: [PATCH] IB/ehca: Make sure user pages are from hugetlb before
	using MR large pages
From: Joachim Fenkes <FENKES@de.ibm.com>
Message-ID: <OF2FF112E2.22D1AA53-ONC1257355.00360D85-C1257355.004F61C6@de.ibm.com>
Date: Thu, 13 Sep 2007 16:27:03 +0200
Content-Type: text/plain; charset="US-ASCII"
Cc: OF-EWG <ewg@lists.openfabrics.org>, LKML <linux-kernel@vger.kernel.org>,
	LinuxPPC-Dev <linuxppc-dev@ozlabs.org>,
	Christoph Raisch <raisch@de.ibm.com>,
	OF-General <general@lists.openfabrics.org>,
	Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Roland Dreier <rdreier@cisco.com> wrote on 13.09.2007 06:33:45:

>  > -#define HCA_CAP_MR_PGSIZE_4K  1
>  > -#define HCA_CAP_MR_PGSIZE_64K 2
>  > -#define HCA_CAP_MR_PGSIZE_1M  4
>  > -#define HCA_CAP_MR_PGSIZE_16M 8
>  > +#define HCA_CAP_MR_PGSIZE_4K  0x80000000
>  > +#define HCA_CAP_MR_PGSIZE_64K 0x40000000
>  > +#define HCA_CAP_MR_PGSIZE_1M  0x20000000
>  > +#define HCA_CAP_MR_PGSIZE_16M 0x10000000
> 
> Not sure I understand what this has to do with things... is this an
> unrelated fix?

Kinda. I can put it into its own patch if you want.
 
> I would suggest extending ib_umem_get() to check the vmas and adding a
> member to struct ib_umem to say whether the memory is entirely covered
> by hugetlb pages or not.

I like that approach - one patch coming right up! =)
 
>  > +      default: /* out of mem */
>  > +         ib_mr = ERR_PTR(-ENOMEM);
>  > +         goto reg_user_mr_exit1;
> 
> It seems like it would be better to just assume the memory is not from
> a hugetlb is ehca_is_mem_hugetlb() fails its memory allocation and
> fall back to the PAGE_SIZE case rather than failing entirely.

If ehca_is_mem_hugetlb() runs out of memory, ehca_reg_mr() is rather 
unlikely to get the memory, but it's worth a try, I'll give you that. I'll 
make the umem patch work that way.

Joachim

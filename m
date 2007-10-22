Return-Path: <root@hofr.at>
Received: from mail.hofr.at (unknown [194.112.174.227])
	by ozlabs.org (Postfix) with ESMTP id 7BC87DDE34
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Oct 2007 17:54:03 +1000 (EST)
Date: Mon, 22 Oct 2007 09:53:58 +0200 (CEST)
From: Nicholas Mc Guire <der.herr@hofr.at>
To: "Wang, Baojun" <wangbj@lzu.edu.cn>
Subject: Re: [Rtlinuxgpl] ppc manual paging question
In-Reply-To: <393096168.21831@eyou.net>
Message-ID: <Pine.LNX.4.60.0710220944590.1639@rtl14.hofr.at>
References: <200710221203.24157.wangbj@lzu.edu.cn>
	<200710221350.31688.wangbj@lzu.edu.cn>
	<393033430.04221@lzu.edu.cn> <393096168.21831@eyou.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: rtlinuxgpl@upv.es, Miguel Masmano <mimastel@doctor.upv.es>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

> OK, Shall I look for the DataTLBError code in head.S? I realized that I've got
> DataTLBError sometimes via BDI2000/kgdb (the fault address is within
> DataTLBError), Shall I should also look for arch/ppc/mm/fault.c?
>
if you end up in fault.c (via call to handle_page_fault) then I think you 
allready had an invalid access - you should not have ended there if the 
tlb entries would have been loaded properly from where ever XM put them
(not in any pgd that linux knows of) - no COW or lazy mechanism available
as the pgd of the domains are not handled in fault.c .

hofrat
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFHHFcZnU7rXZKfY2oRAtKLAJ4pdGYGSrv/WFEraJiiHdeGndVupwCgiz56
Le5QyhS1dpfdgb0pbe5hLRk=
=PutX
-----END PGP SIGNATURE-----

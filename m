Return-Path: <RAISCH@de.ibm.com>
Received: from mtagate1.de.ibm.com (mtagate1.de.ibm.com [195.212.29.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate1.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E1BF3DDED4
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 23:49:11 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate1.de.ibm.com (8.13.8/8.13.8) with ESMTP id l6ADn7J1088740
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 13:49:07 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.3) with
	ESMTP id l6ADn7VA2142406
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 15:49:07 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l6ADn6al024052
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 15:49:07 +0200
In-Reply-To: <adazm25w998.fsf@cisco.com>
Subject: Re: [PATCH 06/13] IB/ehca: Set SEND_GRH flag for all non-LL UD QPs on
	eHCA2
To: Roland Dreier <rdreier@cisco.com>
Message-ID: <OF5A4240D2.61426860-ONC1257314.0047B786-C1257314.004BE620@de.ibm.com>
From: Christoph Raisch <RAISCH@de.ibm.com>
Date: Tue, 10 Jul 2007 18:35:49 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Joachim Fenkes <fenkes@de.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
	LinuxPPC-Dev <linuxppc-dev@ozlabs.org>,
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



> What decides if a QP is LL or not?
>
>  - R.
Currently we use a high bit in the QP type, which is not how we want to
keep it permanently.
What would you suggest, add two additional LL QP types, or change something
more fundamental
in libibverbs and kernel ib core?
We think we can get along quite well with the existing parameters in the
current create QP.
The current user-kernel interface is ok for these new QPs for post_send +
post_recv,
but unfortunately the libibverbs userspace calls don't match exactly how
the LL queues are to be used.
We would need something like the LL QP interface in libehca in libibverbs
to keep that interface generic.

We didn't see a usage yet for LL QP in kernel, so maybe we should continue
that
discussion on general@openfabrics only.
We could provide example code in libehca/samples if needed.


Gruss / Regards
Christoph + Nam

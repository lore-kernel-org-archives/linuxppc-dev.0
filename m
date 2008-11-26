Return-Path: <FENKES@de.ibm.com>
Received: from mtagate7.de.ibm.com (mtagate7.de.ibm.com [195.212.29.156])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate7.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EEBFEDDDCA
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Nov 2008 00:45:06 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate7.de.ibm.com (8.13.8/8.13.8) with ESMTP id mAQDiwVZ573910
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Nov 2008 13:44:58 GMT
Received: from d12av05.megacenter.de.ibm.com (d12av05.megacenter.de.ibm.com
	[9.149.165.216])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v9.1) with
	ESMTP id mAQDiwHY3956752
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Nov 2008 14:44:58 +0100
Received: from d12av05.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av05.megacenter.de.ibm.com (8.13.1/8.13.3) with ESMTP id
	mAQDiwLf008237
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Nov 2008 14:44:58 +0100
In-Reply-To: <aday6z7csb4.fsf@cisco.com>
References: <200806061835.43802.fenkes@de.ibm.com>	<48499C11.7030504@gmail.com>
	<200811251358.06729.fenkes@de.ibm.com> <aday6z7csb4.fsf@cisco.com>
To: Roland Dreier <rdreier@cisco.com>
MIME-Version: 1.0
Subject: Re: [PATCH] IB/ehca: Change misleading error message
From: Joachim Fenkes <FENKES@de.ibm.com>
Message-ID: <OFDC616681.53A831E8-ONC125750D.0046F124-C125750D.004B8673@de.ibm.com>
Date: Wed, 26 Nov 2008 14:44:56 +0100
Content-Type: text/plain; charset="US-ASCII"
Cc: OF-EWG <ewg@lists.openfabrics.org>, LKML <linux-kernel@vger.kernel.org>,
	LinuxPPC-Dev <linuxppc-dev@ozlabs.org>,
	Christoph Raisch <RAISCH@de.ibm.com>,
	Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>,
	OF-General <general@lists.openfabrics.org>,
	Alexander Schmidt1 <ALEXSCHM@de.ibm.com>,
	Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Roland Dreier <rdreier@cisco.com> wrote on 26.11.2008 00:13:51:

> That's too bad... I applied this patch but out of curiousity, why
> doesn't the hot-remove/hot-add work?  I would have thought that
> re-registering all of memory after the hot-add would do the right thing.

That's right, but right now, we simply try to register all of memory from 
KERNELBASE to high_memory, which works right until we have memory holes in 
the middle; then the hypervisor will reject our page registrations. Same 
goes for huge (16GB) pages, by the way. We're working on a solution to 
this.

Cheers,
  Joachim

Return-Path: <RAISCH@de.ibm.com>
Received: from mtagate8.de.ibm.com (mtagate8.de.ibm.com [195.212.29.157])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate8.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E4B7BDDDEB
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Nov 2007 19:55:09 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate8.de.ibm.com (8.13.8/8.13.8) with ESMTP id lA68t4Gc355918
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Nov 2007 08:55:04 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.6) with
	ESMTP id lA68t4qo1089738
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Nov 2007 09:55:04 +0100
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id lA68t3u8022298
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Nov 2007 09:55:03 +0100
Subject: problem in follow_hugetlb_page on ppc64 architecture with
	get_user_pages
To: linux-kernel <linux-kernel@vger.kernel.org>,
	linux-ppc <linuxppc-dev@ozlabs.org>, general@lists.openfabrics.org
Message-ID: <OF6FC435A0.F59C9AD9-ONC125738B.002A5195-C125738B.002A424A@de.ibm.com>
From: Christoph Raisch <RAISCH@de.ibm.com>
Date: Tue, 6 Nov 2007 08:42:40 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Roland Dreier <rdreier@cisco.com>, Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hello,
if get_user_pages is used on a hugetlb vma, and there was no previous write
to the pages,
follow_hugetlb_page will call
ret = hugetlb_fault(mm, vma, vaddr, 0),
although the page should be used for write access in get_user_pages.

We currently see this when testing Infiniband on ppc64 with ehca +
hugetlbfs.
>From reading the code this should also be an issue on other architectures.
Roland, Adam, are you aware of anything in this area with mellanox
Infiniband cards or other usages with I/O adapters?

Gruss / Regards
Christoph R. + Nam Ng.

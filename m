Return-Path: <hnguyen@linux.vnet.ibm.com>
Received: from mtagate6.uk.ibm.com (mtagate6.uk.ibm.com [195.212.29.139])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate6.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4D36CDDF86
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 06:11:21 +1100 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate6.uk.ibm.com (8.13.8/8.13.8) with ESMTP id l0BJBHsl135238
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jan 2007 19:11:17 GMT
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
	[9.149.37.228])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with
	ESMTP id l0BJBHaX1732630
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jan 2007 19:11:17 GMT
Received: from d06av02.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av02.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l0BJBGfl030582
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jan 2007 19:11:16 GMT
From: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
To: Roland Dreier <rdreier@cisco.com>, hch@infradead.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	openfabrics-ewg@openib.org, openib-general@openib.org
Subject: [PATCH/RFC 2.6.21 0/5] ehca: remove use of do_mmap() from kernel space
Date: Thu, 11 Jan 2007 20:07:33 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200701112007.33854.hnguyen@linux.vnet.ibm.com>
Cc: raisch@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Roland and Christoph H.!
Here is a set of patches for ehca, whose main purpose is to remove unproper use of
do_mmap() in ehca kernel space as suggested by Christoph H. Other "small" changes
are:
* Remove "dead" prototype declarations (those without code implementation)

Now detail on mmap() rework:
- For eHCA hardware register block we use remap_pfn_range() as previously.
- For queue pages we call pattern vm_insert_page() to register each allocated
kernel page.
- For each mmap-ed resource (hardware register block, send/recv and completion
queue) we introduce a use counter that is incremented and decremented by
the call-backs open()/close(). Destroying a completion queue or queue pair
will succeed only if all associated counters are zero. That means those resources
must be mmap-ed and munmap-ed properly in user space.
The actual calls of mmap64() and munmap() are done then in ehca user space lib,
ie. libehca, for which I will send a separate patch for another review (by ofed
group).

Thanks
Nam


 ehca_classes.h |   29 +-----
 ehca_cq.c      |   65 +++-----------
 ehca_iverbs.h  |   10 --
 ehca_main.c    |    6 -
 ehca_qp.c      |   78 +++--------------
 ehca_uverbs.c  |  253 ++++++++++++++++++---------------------------------------
 6 files changed, 121 insertions(+), 320 deletions(-)

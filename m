Return-Path: <hnguyen@linux.vnet.ibm.com>
Received: from mtagate6.de.ibm.com (mtagate6.de.ibm.com [195.212.29.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate6.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E0890DDEE0
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 04:10:57 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate6.de.ibm.com (8.13.8/8.13.8) with ESMTP id l0BHAq9U186156
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jan 2007 17:10:52 GMT
Received: from d12av01.megacenter.de.ibm.com (d12av01.megacenter.de.ibm.com
	[9.149.165.212])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with
	ESMTP id l0BHAqNI2498754
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jan 2007 18:10:52 +0100
Received: from d12av01.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av01.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l0BHApkl008923
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jan 2007 18:10:51 +0100
From: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
To: Roland Dreier <rdreier@cisco.com>, hch@infradead.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	openfabrics-ewg@openib.org, openib-general@openib.org
Subject: [PATCH 2.6.21 0/8] ehca: remove use of do_mmap() from kernel space
	and minor cleanup
Date: Thu, 11 Jan 2007 18:07:08 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200701111807.08593.hnguyen@linux.vnet.ibm.com>
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
* Use SLAB_ defines instead GFP_ ones when allocating memory from slab cache

Actually I should separate those patches for more clarity. Unfortunately that
code cleanup above has been incorporated much earlier in our repository, and
I had not paid attention on when I started to rework the mmap() stuff. Sorry
for this inconvenience!

Now more detail on mmap() rework:
- For eHCA hardware register block we use remap_pfn_range() as previously.
- For queue pages we call pattern vm_insert_page() to register each allocated
kernel page.
- For each mmap-ed resource (hardware register block, send/recv and completion
queue) we introduce a use counter that is incremented and decremented by
the call-backs open()/close(). Destroying a completion queue or queue pair
will succeed only if all associated counters are zero. That means those resources
must be mmap-ed resp. munmap-ed properly by user space.

Thanks
Nam

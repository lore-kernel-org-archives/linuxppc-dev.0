Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 795B91007E5
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 26 Jun 2010 09:17:03 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH] Faster MMU lookups for Book3s
Date: Sat, 26 Jun 2010 01:16:55 +0200
Message-Id: <1277507817-626-1-git-send-email-agraf@suse.de>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	KVM list <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Book3s suffered from my really bad shadow MMU implementation so far. So
I finally got around to implement a combined hash and list mechanism that
allows for much faster lookup of mapped pages.

To show that it really is faster, I tried to run simple process spawning
code inside the guest with and without these patches:

[without]

debian-powerpc:~# time for i in {1..1000}; do /bin/echo hello > /dev/null; done

real    0m20.235s
user    0m10.418s
sys     0m9.766s

[with]

debian-powerpc:~# time for i in {1..1000}; do /bin/echo hello > /dev/null; done

real    0m14.659s
user    0m8.967s
sys     0m5.688s

So as you can see, performance improved significantly.

Alexander Graf (2):
  KVM: PPC: Add generic hpte management functions
  KVM: PPC: Make use of hash based Shadow MMU

 arch/powerpc/include/asm/kvm_book3s.h |    7 +
 arch/powerpc/include/asm/kvm_host.h   |   18 ++-
 arch/powerpc/kvm/Makefile             |    2 +
 arch/powerpc/kvm/book3s_32_mmu_host.c |  104 ++-----------
 arch/powerpc/kvm/book3s_64_mmu_host.c |   98 +-----------
 arch/powerpc/kvm/book3s_mmu_hpte.c    |  286 +++++++++++++++++++++++++++++++++
 6 files changed, 327 insertions(+), 188 deletions(-)
 create mode 100644 arch/powerpc/kvm/book3s_mmu_hpte.c

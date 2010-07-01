Return-Path: <mtosatti@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id C978E1007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  2 Jul 2010 02:17:40 +1000 (EST)
Date: Thu, 1 Jul 2010 12:40:29 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 0/2] Faster MMU lookups for Book3s v3
Message-ID: <20100701154029.GB23469@amt.cnet>
References: <1277903926-12786-1-git-send-email-agraf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1277903926-12786-1-git-send-email-agraf@suse.de>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	KVM list <kvm@vger.kernel.org>, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 30, 2010 at 03:18:44PM +0200, Alexander Graf wrote:
> Book3s suffered from my really bad shadow MMU implementation so far. So
> I finally got around to implement a combined hash and list mechanism that
> allows for much faster lookup of mapped pages.
> 
> To show that it really is faster, I tried to run simple process spawning
> code inside the guest with and without these patches:
> 
> [without]
> 
> debian-powerpc:~# time for i in {1..1000}; do /bin/echo hello > /dev/null; done
> 
> real    0m20.235s
> user    0m10.418s
> sys     0m9.766s
> 
> [with]
> 
> debian-powerpc:~# time for i in {1..1000}; do /bin/echo hello > /dev/null; done
> 
> real    0m14.659s
> user    0m8.967s
> sys     0m5.688s
> 
> So as you can see, performance improved significantly.
> 
> v2 -> v3:
> 
>   - use hlist
>   - use global slab cache
> 
> Alexander Graf (2):
>   KVM: PPC: Add generic hpte management functions
>   KVM: PPC: Make use of hash based Shadow MMU
> 
>  arch/powerpc/include/asm/kvm_book3s.h |    9 +
>  arch/powerpc/include/asm/kvm_host.h   |   17 ++-
>  arch/powerpc/kvm/Makefile             |    2 +
>  arch/powerpc/kvm/book3s.c             |   14 ++-
>  arch/powerpc/kvm/book3s_32_mmu_host.c |  104 ++-----------
>  arch/powerpc/kvm/book3s_64_mmu_host.c |   98 +-----------
>  arch/powerpc/kvm/book3s_mmu_hpte.c    |  277 +++++++++++++++++++++++++++++++++
>  7 files changed, 331 insertions(+), 190 deletions(-)
>  create mode 100644 arch/powerpc/kvm/book3s_mmu_hpte.c

Applied, thanks.

Return-Path: <avi@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id C3F57B70CE
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 23 Aug 2010 02:46:33 +1000 (EST)
Message-ID: <4C715466.30405@redhat.com>
Date: Sun, 22 Aug 2010 19:46:30 +0300
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 00/26] KVM: PPC: Mid-August patch queue
References: <1282053481-18787-1-git-send-email-agraf@suse.de>
In-Reply-To: <1282053481-18787-1-git-send-email-agraf@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

  On 08/17/2010 04:57 PM, Alexander Graf wrote:
> Howdy,
>
> This is my local patch queue with stuff that has accumulated over the last
> weeks on KVM for PPC with some last minute fixes, speedups and debugging help
> that I needed for the KVM Forum ;-).
>
> The highlights of this set are:
>
>    - Converted most important debug points to tracepoints
>    - Flush less PTEs (speedup)
>    - Go back to our own hash (less duplicates)
>    - Make SRs guest settable (speedup for 32 bit guests)
>    - Remove r30/r31 restrictions from PV hooks (speedup!)
>    - Fix random breakages
>    - Fix random guest stalls
>    - 440GP host support (Thanks Hollis!)
>
> Keep in mind that this is the first version that is stable on PPC32 hosts.
> All versions prior to this could occupy otherwise used segment entries and
> thus crash your machine :-).
>
> After finally meeting Avi again, we also agreed to give pulls a try. So
> here we go - this is my tree online:
>
>   arch/powerpc/include/asm/kvm_book3s.h |   25 ++--
>   arch/powerpc/include/asm/kvm_para.h   |    3 +
>   arch/powerpc/kernel/asm-offsets.c     |    1 +
>   arch/powerpc/kernel/kvm.c             |  144 ++++++++++++++++++---
>   arch/powerpc/kernel/kvm_emul.S        |   75 +++++++++--
>   arch/powerpc/kvm/44x.c                |    3 +-
>   arch/powerpc/kvm/44x_tlb.c            |    1 +
>   arch/powerpc/kvm/book3s.c             |   54 ++++----
>   arch/powerpc/kvm/book3s_32_mmu.c      |   83 +++++++------
>   arch/powerpc/kvm/book3s_32_mmu_host.c |   67 ++++++----
>   arch/powerpc/kvm/book3s_64_mmu_host.c |   59 +++------
>   arch/powerpc/kvm/book3s_emulate.c     |   48 +++-----
>   arch/powerpc/kvm/book3s_mmu_hpte.c    |   38 ++----
>   arch/powerpc/kvm/booke.c              |    8 +-
>   arch/powerpc/kvm/powerpc.c            |    5 +-
>   arch/powerpc/kvm/trace.h              |  230 +++++++++++++++++++++++++++++++++
>   16 files changed, 614 insertions(+), 230 deletions(-)

   Documentation/kvm/ppc-pv.txt +++++++++++++++++++++++++++

?

-- 
error compiling committee.c: too many arguments to function

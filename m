Return-Path: <paulus@ozlabs.org>
Date: Tue, 13 Dec 2011 09:23:48 +1100
From: Paul Mackerras <paulus@samba.org>
To: Alexander Graf <agraf@suse.de>
Subject: [PATCH v3 00/14] KVM: PPC: Update Book3S HV memory handling
Message-ID: <20111212222347.GA18868@bloggs.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series of patches updates the Book3S-HV KVM code that manages the
guest hashed page table (HPT) to enable several things:

* MMIO emulation and MMIO pass-through

* Use of small pages (4kB or 64kB, depending on config) to back the
  guest memory

* Pageable guest memory - i.e. backing pages can be removed from the
  guest and reinstated on demand, using the MMU notifier mechanism

* Guests can be given read-only access to pages even though they think
  they have mapped them read/write.  When they try to write to them
  their access is upgraded to read/write.  This allows KSM to share
  pages between guests.

On PPC970 we have no way to get DSIs and ISIs to come to the
hypervisor, so we can't do MMIO emulation or pageable guest memory.
On POWER7 we set the VPM1 bit in the LPCR to make all DSIs and ISIs
come to the hypervisor (host) as HDSIs or HISIs.

This code is working well in my tests.  The sporadic crashes that I
was seeing earlier are fixed by the second patch in the series.
Somewhat to my surprise, when I implemented the last patch in the
series I started to see KSM coalescing pages without any further
effort on my part -- my tests were on a machine with Fedora 16
installed, and it has ksmtuned running by default.

This series is on top of Alex Graf's kvm-ppc-next branch.  The first
patch in my series fixes a bug in one of the patches in that branch
("KVM: PPC: booke: Improve timer register emulation").

These patches only touch arch/powerpc except for patch 12, which adds
a couple of barriers to allow mmu_notifier_retry() to be used outside
of the kvm->mmu_lock.

Paul.

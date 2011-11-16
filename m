Return-Path: <paulus@ozlabs.org>
Date: Thu, 17 Nov 2011 09:50:55 +1100
From: Paul Mackerras <paulus@samba.org>
To: kvm-ppc@vger.kernel.org
Subject: [RFC PATCH 0/11] KVM: PPC: Update Book3S HV memory handling
Message-ID: <20111116225055.GA26985@bloggs.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, Alexander Graf <agraf@suse.de>
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
  guest and reinstated on demand, using the MMU notifier mechanism.

On PPC970 we have no way to get DSIs and ISIs to come to the
hypervisor, so we can't do MMIO emulation or pageable guest memory.
On POWER7 we set the VPM1 bit in the LPCR to make all DSIs and ISIs
come to the hypervisor (host) as HDSIs or HISIs.

This series is RFC for the moment, although the first 5 or so patches
are pretty solid and could go in.  I am going to rework the later
patches to use HPTEs with V=0 for the absent pages rather than key=31,
which will require handling the HPTE-not-present HDSIs we will get and
differentiating the case where the guest has created a HPTE but the
underlying page is not resident from the case where the guest has
created no HPTE for the address.

Paul.

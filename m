Return-Path: <paulus@ozlabs.org>
Date: Thu, 15 Dec 2011 23:00:18 +1100
From: Paul Mackerras <paulus@samba.org>
To: Alexander Graf <agraf@suse.de>
Subject: [PATCH 0/5] Make use of hardware reference and change bits in HPT
Message-ID: <20111215120018.GA20629@bloggs.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series of patches builds on top of my previous series and
modifies the Book3S HV memory management code to use the hardware
reference and change bits in the guest hashed page table.  This makes
kvm_age_hva() more efficient, lets us implement the dirty page
tracking properly (which in turn means that things like VGA emulation
in qemu can work), and also means that we can supply hardware
reference and change information to the guest -- not that Linux guests
currently use that information, but possibly they will want it in
future, and there is an interface defined in PAPR for it.

Paul.

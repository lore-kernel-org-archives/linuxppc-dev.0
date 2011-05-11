Return-Path: <paulus@ozlabs.org>
Date: Wed, 11 May 2011 20:34:43 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org, kvm@vger.kernel.org
Subject: [PATCH 0/13] Hypervisor-mode KVM on POWER7
Message-ID: <20110511103443.GA2837@brick.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alexander Graf <agraf@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The following series of patches enable KVM to exploit the hardware
hypervisor mode on 64-bit Power ISA Book3S machines.  At present only
POWER7 is supported, but it would be easy to add other processors.

Running the KVM host in hypervisor mode means that the guest can use
both supervisor mode and user mode.  That means that the guest can
execute supervisor-privilege instructions and access supervisor-
privilege registers.  In addition the hardware directs most exceptions
to the guest.  Thus we don't need to emulate any instructions in the
host.  Generally, the only times we need to exit the guest are when it
does a hypercall or when an external interrupt or host timer
(decrementer) interrupt occurs.

The focus of this KVM implementation is to run guests that use the
PAPR (Power Architecture Platform Requirements) paravirtualization
interface, which is the interface supplied by PowerVM on IBM pSeries
machines.

These patches are against Ben Herrenschmidt's next branch in his tree
at git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git.

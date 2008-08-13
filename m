Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18594.14443.340604.693747@cargo.ozlabs.ibm.com>
Date: Wed, 13 Aug 2008 11:27:07 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 0/5] Relocatable 64-bit kernel using linker PIE support
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The following series of patches implement support for a relocatable
kernel by building it as a position-independent executable (PIE).
When the linker is given the -pie flag, it creates an executable that
contains dynamic relocations which can be used to relocate the image
at boot time for any desired base address.  This patch series adds a
CONFIG_RELOCATABLE config option for 64-bit which links the kernel
with -pie and arranges to process the relocations in early boot.

With the first 4 patches applied, a relocatable kernel will still copy
itself down to real address 0.  The last patch changes things so that
a relocatable kernel will run wherever it was loaded.  This last patch
is pretty much just a proof of concept since it doesn't do anything to
ensure appropriate alignment of the base address (the base address
needs to be 16kB aligned).  We probably want to work out whether we
are a kdump kernel and run in-place if so, or copy down to 0 if not.

Paul.

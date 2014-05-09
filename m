Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B402A141721
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 May 2014 17:54:06 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 9 May 2014 17:54:06 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 96F222BB0055
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 May 2014 17:54:02 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s497Wooh7537116
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 May 2014 17:32:50 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s497s1XD031239
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 May 2014 17:54:02 +1000
Date: Fri, 9 May 2014 17:54:01 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC v2 00/10] EEH Support for VFIO PCI devices on
 PowerKVM guest
Message-ID: <20140509075401.GA23803@shangw>
References: <1399621782-23281-1-git-send-email-gwshan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1399621782-23281-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: aik@ozlabs.ru, agraf@suse.de, kvm-ppc@vger.kernel.org,
 alex.williamson@redhat.com, qiudayu@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, May 09, 2014 at 05:49:32PM +1000, Gavin Shan wrote:

Sorry for having missed cc'ing Alex Graf. Amending it.

>The series of patches intends to support EEH for PCI devices, which are
>passed through to PowerKVM based guest via VFIO. The implementation is
>straightforward based on the issues or problems we have to resolve to
>support EEH for PowerKVM based guest.
>
>- Emulation for EEH RTAS requests. All EEH RTAS requests goes to QEMU firstly.
>  If QEMU can't handle it, the request will be sent to host via newly introduced
>  VFIO container IOCTL command (VFIO_EEH_INFO) and gets handled in host kernel.
>
>- The error injection infrastructure need support request from the userland
>  utility "errinjct" and PowerKVM based guest. The userland utility "errinjct"
>  works on pSeries platform well with dedicated syscall, which helps invoking
>  RTAS service to fulfil error injection in kernel. From the perspective, it's
>  reasonable to extend the syscall to support PowerNV platform so that OPAL call
>  can be invoked in host kernel for injecting errors. The data transported
>  between userland and kerenl is still following "struct rtas_args" for both
>  cases of PowerNV (OPAL) and pSeries (RTAS).
>
>The series of patches requires corresponding firmware changes from Mike Qiu to
>support error injection and QEMU changes to support EEH for guest. QEMU patchset
>will be sent separately.
>
>Change log
>==========
>v1 -> v2:
>	* EEH RTAS requests are routed to QEMU, and then possiblly to host kerenl.
>	  The mechanism KVM in-kernel handling is dropped.
>	* Error injection is reimplemented based syscall, instead of KVM in-kerenl
>	  handling. The logic for error injection token management is moved to
>	  QEMU. The error injection request is routed to QEMU and then possiblly
>	  to host kernel.
>
>Testing on P7
>=============
>
>- Emulex adapter
>
>Testing on P8
>=============
>
>- Need more testing after design is finalized.
>
>-----
>
>Gavin Shan (10):
>  drivers/vfio: Introduce CONFIG_VFIO_EEH
>  powerpc/eeh: Info to trace passed devices
>  powerpc/eeh: Search EEH device by guest address
>  powerpc/eeh: Search EEH PE by guest address
>  drivers/vfio: New IOCTL command VFIO_EEH_INFO
>  powerpc/eeh: Avoid event on passed PE
>  powerpc/powernv: Sync OPAL header file with firmware
>  powerpc: Extend syscall ppc_rtas()
>  powerpc/powernv: Implement ppc_call_opal()
>  powerpc/powernv: Error injection infrastructure
>
>arch/powerpc/include/asm/eeh.h                 |  52 +++++++++++++
>arch/powerpc/include/asm/opal.h                |  74 +++++++++++++++++-
>arch/powerpc/include/asm/rtas.h                |  10 ++-
>arch/powerpc/include/asm/syscalls.h            |   2 +-
>arch/powerpc/include/asm/systbl.h              |   2 +-
>arch/powerpc/include/uapi/asm/unistd.h         |   2 +-
>arch/powerpc/kernel/eeh.c                      |   8 ++
>arch/powerpc/kernel/eeh_pe.c                   |  80 +++++++++++++++++++
>arch/powerpc/kernel/rtas.c                     |  57 +++-----------
>arch/powerpc/kernel/syscalls.c                 |  50 ++++++++++++
>arch/powerpc/platforms/powernv/Makefile        |   3 +-
>arch/powerpc/platforms/powernv/eeh-ioda.c      |   3 +-
>arch/powerpc/platforms/powernv/eeh-vfio.c      | 584 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>arch/powerpc/platforms/powernv/errinject.c     | 222 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>arch/powerpc/platforms/powernv/opal-wrappers.S |   1 +
>arch/powerpc/platforms/powernv/opal.c          |  93 ++++++++++++++++++++++
>drivers/vfio/Kconfig                           |   6 ++
>drivers/vfio/vfio_iommu_spapr_tce.c            |  12 +++
>include/uapi/linux/vfio.h                      |  61 +++++++++++++++
>kernel/sys_ni.c                                |   2 +-
>20 files changed, 1271 insertions(+), 53 deletions(-)
>create mode 100644 arch/powerpc/platforms/powernv/eeh-vfio.c
>create mode 100644 arch/powerpc/platforms/powernv/errinject.c
>
>Thanks,
>Gavin

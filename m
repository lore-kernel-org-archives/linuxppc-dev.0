Return-Path: <qiudayu@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1882C140079
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 May 2014 16:34:41 +1000 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <qiudayu@linux.vnet.ibm.com>;
 Thu, 15 May 2014 12:04:36 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 8B197394005C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 May 2014 12:04:33 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4F6YnrM13893710
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 May 2014 12:04:50 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s4F6YVsO023245
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 May 2014 12:04:32 +0530
Message-ID: <53745FF3.6050102@linux.vnet.ibm.com>
Date: Thu, 15 May 2014 14:34:27 +0800
From: Mike Qiu <qiudayu@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC v3 0/8] EEH Support for VFIO PCI device
References: <1400040722-29608-1-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1400040722-29608-1-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: aik@ozlabs.ru, agraf@suse.de, kvm-ppc@vger.kernel.org,
 alex.williamson@redhat.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Gavin,

Can error injection be done if EEH is not enbaled?

Thanks
Mike

On 05/14/2014 12:11 PM, Gavin Shan wrote:
> The series of patches intends to support EEH for PCI devices, which are
> passed through to PowerKVM based guest via VFIO. The implementation is
> straightforward based on the issues or problems we have to resolve to
> support EEH for PowerKVM based guest.
>
> - Emulation for EEH RTAS requests. All EEH RTAS requests goes to QEMU firstly.
>    If QEMU can't handle it, the request will be sent to host via newly introduced
>    VFIO container IOCTL command (VFIO_EEH_INFO) and gets handled in host kernel.
>
> - The error injection infrastructure need support request from the userland
>    utility "errinjct" and PowerKVM based guest. The userland utility "errinjct"
>    works on pSeries platform well with dedicated syscall, which helps invoking
>    RTAS service to fulfil error injection in kernel. From the perspective, it's
>    reasonable to extend the syscall to support PowerNV platform so that OPAL call
>    can be invoked in host kernel for injecting errors. The data transported
>    between userland and kerenl is still following "struct rtas_args" for both
>    cases of PowerNV (OPAL) and pSeries (RTAS).
>
> The series of patches requires corresponding firmware changes from Mike Qiu to
> support error injection and QEMU changes to support EEH for guest. QEMU patchset
> will be sent separately.
>
> Change log
> ==========
> v1 -> v2:
> 	* EEH RTAS requests are routed to QEMU, and then possiblly to host kerenl.
> 	  The mechanism KVM in-kernel handling is dropped.
> 	* Error injection is reimplemented based syscall, instead of KVM in-kerenl
> 	  handling. The logic for error injection token management is moved to
> 	  QEMU. The error injection request is routed to QEMU and then possiblly
> 	  to host kernel.
> v2 -> v3:
> 	* Make the fields in struct eeh_vfio_pci_addr, struct vfio_eeh_info based
> 	  on the comments from Alexey.
> 	* Define macros for EEH VFIO operations (Alexey).
> 	* Clear frozen state after successful PE reset.
> 	* Merge original [PATCH 1/2/3] to one.
>
> Testing on P7
> =============
>
> - Emulex adapter
>
> Testing on P8
> =============
>
> - Need more testing after design is finalized.
>
> -----
>
> Gavin Shan (8):
>    drivers/vfio: Introduce CONFIG_VFIO_EEH
>    powerpc/eeh: Info to trace passed devices
>    drivers/vfio: New IOCTL command VFIO_EEH_INFO
>    powerpc/eeh: Avoid event on passed PE
>    powerpc/powernv: Sync OPAL header file with firmware
>    powerpc: Extend syscall ppc_rtas()
>    powerpc/powernv: Implement ppc_call_opal()
>    powerpc/powernv: Error injection infrastructure
>
>   arch/powerpc/include/asm/eeh.h                 |  52 +++
>   arch/powerpc/include/asm/opal.h                |  74 ++-
>   arch/powerpc/include/asm/rtas.h                |  10 +-
>   arch/powerpc/include/asm/syscalls.h            |   2 +-
>   arch/powerpc/include/asm/systbl.h              |   2 +-
>   arch/powerpc/include/uapi/asm/unistd.h         |   2 +-
>   arch/powerpc/kernel/eeh.c                      |   8 +
>   arch/powerpc/kernel/eeh_pe.c                   |  80 ++++
>   arch/powerpc/kernel/rtas.c                     |  57 +--
>   arch/powerpc/kernel/syscalls.c                 |  50 +++
>   arch/powerpc/platforms/powernv/Makefile        |   3 +-
>   arch/powerpc/platforms/powernv/eeh-ioda.c      |   3 +-
>   arch/powerpc/platforms/powernv/eeh-vfio.c      | 593 +++++++++++++++++++++++++
>   arch/powerpc/platforms/powernv/errinject.c     | 224 ++++++++++
>   arch/powerpc/platforms/powernv/opal-wrappers.S |   1 +
>   arch/powerpc/platforms/powernv/opal.c          |  93 ++++
>   drivers/vfio/Kconfig                           |   6 +
>   drivers/vfio/vfio_iommu_spapr_tce.c            |  12 +
>   include/uapi/linux/vfio.h                      |  57 +++
>   kernel/sys_ni.c                                |   2 +-
>   20 files changed, 1278 insertions(+), 53 deletions(-)
>   create mode 100644 arch/powerpc/platforms/powernv/eeh-vfio.c
>   create mode 100644 arch/powerpc/platforms/powernv/errinject.c
>
> Thanks,
> Gavin
>

Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 63BFA1A08A5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 May 2014 22:21:52 +1000 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 20 May 2014 22:21:52 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 2B3F92BB004A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 May 2014 22:21:50 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4KCLYjM10617132
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 May 2014 22:21:34 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s4KCLnts027591
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 May 2014 22:21:49 +1000
Date: Tue, 20 May 2014 22:21:48 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 3/4] drivers/vfio: New IOCTL command VFIO_EEH_INFO
Message-ID: <20140520122147.GA26483@shangw>
References: <1400574612-19411-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1400574612-19411-4-git-send-email-gwshan@linux.vnet.ibm.com>
 <537B3AA7.7040106@suse.de> <537B3C68.8080102@suse.de>
 <20140520114031.GA20397@shangw> <537B4015.7030404@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <537B4015.7030404@suse.de>
Cc: aik@ozlabs.ru, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 kvm-ppc@vger.kernel.org, alex.williamson@redhat.com,
 qiudayu@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 20, 2014 at 01:44:21PM +0200, Alexander Graf wrote:
>
>On 20.05.14 13:40, Gavin Shan wrote:
>>On Tue, May 20, 2014 at 01:28:40PM +0200, Alexander Graf wrote:
>>>On 20.05.14 13:21, Alexander Graf wrote:
>>>>On 20.05.14 10:30, Gavin Shan wrote:
>>>>>The patch adds new IOCTL command VFIO_EEH_OP to VFIO PCI device
>>>>>to support EEH functionality for PCI devices, which have been
>>>>>passed from host to guest via VFIO.
>>>>>
>>>>>Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>>>>---
>>>>>  arch/powerpc/platforms/powernv/Makefile   |   1 +
>>>>>  arch/powerpc/platforms/powernv/eeh-vfio.c | 445
>>>>>++++++++++++++++++++++++++++++
>>>>>  drivers/vfio/pci/vfio_pci.c               |  24 +-
>>>>>  drivers/vfio/pci/vfio_pci_private.h       |  16 ++
>>>>>  include/uapi/linux/vfio.h                 |  43 +++
>>>>>  5 files changed, 523 insertions(+), 6 deletions(-)
>>>>>  create mode 100644 arch/powerpc/platforms/powernv/eeh-vfio.c
>>>>Why doesn't this code live inside the vfio module? If I don't load
>>>>the vfio module, I don't need that code to waste memory in my
>>>>kernel, no?
>>Yes, It saves some memory.
>>
>>>So I think from a modeling point of view, you want VFIO code that
>>>calls reasonably generic helpers inside the kernel to deal with
>>>errors.
>>>
>>>The "generic helpers" don't have anything to do with VFIO. Everything
>>>that interfaces via ioctls with user space is 100% VFIO code.
>>>
>>>The latter should be tristate inside vfio.ko, the former can be =y.
>>>
>>The main reason I put eeh-vfio.c to arch/powerpc/platforms/powernv/ is
>>the source file needs access data structures (struct pnv_phb) defined
>>in "pci.h" under that directory.
>
>Then create a good in-kernel framework from that directory and make
>use of it from the VFIO code :). But please don't mesh together VFIO,
>powernv EEH handling and RTAS.
>

Yeah. How about this? :-)

- Move eeh-vfio.c to drivers/vfio/pci/
- From eeh-vfio.c, dereference arch/powerpc/kernel/eeh.c::eeh_ops, which
  is arch/powerpc/plaforms/powernv/eeh-powernv.c::powernv_eeh_ops. Call
  to the corresponding callbacks in "eeh_ops" based on incoming RTAS request.

  The file would be renamed to "vfio_eeh.c" as well after moving to VFIO
  driver directory.

Thanks,
Gavin

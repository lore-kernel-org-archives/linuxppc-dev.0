Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp08.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D1F972C00A0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Aug 2013 12:51:08 +1000 (EST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Tue, 20 Aug 2013 08:09:56 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 999C11258043
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Aug 2013 08:20:38 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r7K2qLvd36241422
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Aug 2013 08:22:21 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r7K2oqBR028015
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Aug 2013 08:20:52 +0530
Received: from [9.65.233.1] (sig-9-65-233-1.mts.ibm.com [9.65.233.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 r7K2oo3P027938
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Aug 2013 08:20:51 +0530
Message-ID: <5212D989.8090103@linux.vnet.ibm.com>
Date: Mon, 19 Aug 2013 21:50:49 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2] Correct Memory Hotplug for Power
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Memory hotplug on Power is currently broken, these two patches correct the
issues needed to get memory hotplug working again.

This update marks memory resources that are added at boot time are also
marked as busy. It sounds a bit counter intuitive but the core mm code will
not free memory resources if they are not marked as busy.

This also ensures that bootmem memory is is registered at boot time. A
previous commit (46723bfa540...) that enabled memory hotplug remove with
SPARSE_VMEMMAP enabled broke this on Power.

Additional patches to follow to correct the current memory hotplug
implementation on Power.

Nathan Fontenot

Updates for v2:

- The WARN_ONCE is removed from the added register_page_bootmem_memmap()
routine. I have been able to verify that memory hotplug works with
SPARSE_VMEMMAP enabled and do not think the warning is needed.

---
 arch/powerpc/mm/mem.c           |    9 +++++++++
 linux/arch/powerpc/mm/init_64.c |    4 ++++
 linux/arch/powerpc/mm/mem.c     |    2 +-
 linux/mm/Kconfig                |    2 +-
 4 files changed, 15 insertions(+), 2 deletions(-)

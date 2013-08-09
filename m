Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp05.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BCABA2C00A9
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Aug 2013 01:29:31 +1000 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Fri, 9 Aug 2013 20:53:15 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 795543940053
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Aug 2013 20:59:15 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r79FTJ7Z40698108
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Aug 2013 20:59:19 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r79FTMUJ031098
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Aug 2013 20:59:22 +0530
Received: from [9.41.105.123] ([9.41.105.123])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 r79FTJYx030844
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Aug 2013 20:59:20 +0530
Message-ID: <52050ACE.4090001@linux.vnet.ibm.com>
Date: Fri, 09 Aug 2013 10:29:18 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/2] Correct memory hotplug remove
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
---

 arch/powerpc/mm/mem.c             |    2 +-
 powerpc/arch/powerpc/mm/init_64.c |    6 ++++++
 powerpc/arch/powerpc/mm/mem.c     |    9 +++++++++
 powerpc/mm/Kconfig                |    2 +-
 4 files changed, 17 insertions(+), 2 deletions(-)

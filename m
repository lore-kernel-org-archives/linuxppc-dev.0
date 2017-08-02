Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xMkfg011KzDrfp
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Aug 2017 17:03:06 +1000 (AEST)
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Subject: Question on hugepages_supported()
Message-ID: <bbc6ae12-1705-32e1-109b-baefead9444b@c-s.fr>
Date: Wed, 2 Aug 2017 09:03:02 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In include/linux/hugetlb.h, we find the following statement

#ifndef hugepages_supported
/*
  * Some platform decide whether they support huge pages at boot
  * time. Some of them, such as powerpc, set HPAGE_SHIFT to 0
  * when there is no such support
  */
#define hugepages_supported() (HPAGE_SHIFT != 0)
#endif

But in arch/powerpc/include/asm/page.h we find:

#ifdef CONFIG_HUGETLB_PAGE
extern unsigned int HPAGE_SHIFT;
#else
#define HPAGE_SHIFT PAGE_SHIFT
#endif


Is that correct ? SHouldn't HPAGE_SHIFT be defined to 0 when 
CONFIG_HUGETLB_PAGE is not defined ?

Christophe

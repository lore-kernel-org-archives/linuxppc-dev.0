Return-Path: <riel@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id E1AE32C00AE
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 16 Mar 2014 06:25:42 +1100 (EST)
Message-ID: <5324A92A.3040309@redhat.com>
Date: Sat, 15 Mar 2014 15:25:30 -0400
From: Rik van Riel <riel@redhat.com>
MIME-Version: 1.0
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
Subject: Re: [PATCH] powerpc/mm: Make sure a local_irq_disable prevent a
 parallel THP split
References: <1394880478-770-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1394880478-770-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/15/2014 06:47 AM, Aneesh Kumar K.V wrote:
> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> 
> We have generic code like the one in get_futex_key that assume that
> a local_irq_disable prevents a parallel THP split. Support that by
> adding a dummy smp call function after setting _PAGE_SPLITTING. Code
> paths like get_user_pages_fast still need to check for _PAGE_SPLITTING
> after disabling IRQ which indicate that a parallel THP splitting is
> ongoing. Now if they don't find _PAGE_SPLITTING set, then we can be
> sure that parallel split will now block in pmdp_splitting flush
> until we enables IRQ
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Acked-by: Rik van Riel <riel@redhat.com>

-- 
All rights reversed

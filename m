Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wyDWt5p2wzDr3l
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jun 2017 17:12:42 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5S79Q4R084040
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jun 2017 03:12:40 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bc45q7pm9-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jun 2017 03:12:39 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Wed, 28 Jun 2017 01:12:39 -0600
Date: Wed, 28 Jun 2017 00:12:28 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 khandual@linux.vnet.ibm.com, bsingharora@gmail.com,
 dave.hansen@intel.com, hbabu@us.ibm.com, arnd@arndb.de,
 akpm@linux-foundation.org, corbet@lwn.net, mingo@redhat.com
Subject: Re: [RFC v4 09/17] powerpc: call the hash functions with the correct
 pkey value
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1498558319-32466-1-git-send-email-linuxram@us.ibm.com>
 <1498558319-32466-10-git-send-email-linuxram@us.ibm.com>
 <5e4fa932-4313-5376-2147-a6431bbec16b@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5e4fa932-4313-5376-2147-a6431bbec16b@linux.vnet.ibm.com>
Message-Id: <20170628071228.GA5561@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 27, 2017 at 08:54:07PM +0530, Aneesh Kumar K.V wrote:
> 
> 
> On Tuesday 27 June 2017 03:41 PM, Ram Pai wrote:
> >Pass the correct protection key value to the hash functions on
> >page fault.
> >
> >Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> >---
> >  arch/powerpc/include/asm/pkeys.h | 11 +++++++++++
> >  arch/powerpc/mm/hash_utils_64.c  |  4 ++++
> >  arch/powerpc/mm/mem.c            |  6 ++++++
> >  3 files changed, 21 insertions(+)
> >
> >diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
> >index ef1c601..1370b3f 100644
> >--- a/arch/powerpc/include/asm/pkeys.h
> >+++ b/arch/powerpc/include/asm/pkeys.h
> >@@ -74,6 +74,17 @@ static inline bool mm_pkey_is_allocated(struct mm_struct *mm, int pkey)
> >  }
> >
> >  /*
> >+ * return the protection key of the vma corresponding to the
> >+ * given effective address @ea.
> >+ */
> >+static inline int mm_pkey(struct mm_struct *mm, unsigned long ea)
> >+{
> >+	struct vm_area_struct *vma = find_vma(mm, ea);
> >+	int pkey = vma ? vma_pkey(vma) : 0;
> >+	return pkey;
> >+}
> >+
> >+/*
> >
> 
> That is not going to work in hash fault path right ? We can't do a
> find_vma there without holding the mmap_sem

There is a fundamental problem with this new design. Looks like we can't
hold a lock in that path, without badly hurting the performance.

I am moving back to the old design. Cant by-pass the pte. The
keys will be programmed into the pte which will than be used
to program the hpte.

RP

Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xCjhl6DSNzDrCy
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 15:52:07 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6K5pm3U053576
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 01:52:05 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2btpr7r065-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 01:52:04 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 20 Jul 2017 15:52:02 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v6K5pxDD10813614
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 15:51:59 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v6K5pnrd008452
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 15:51:50 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Ram Pai <linuxram@us.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 khandual@linux.vnet.ibm.com, bsingharora@gmail.com,
 dave.hansen@intel.com, hbabu@us.ibm.com, linuxram@us.ibm.com,
 arnd@arndb.de, akpm@linux-foundation.org, corbet@lwn.net,
 mingo@redhat.com, mhocko@kernel.org
Subject: Re: [RFC v6 01/62] powerpc: Free up four 64K PTE bits in 4K backed
 HPTE pages
In-Reply-To: <1500177424-13695-2-git-send-email-linuxram@us.ibm.com>
References: <1500177424-13695-1-git-send-email-linuxram@us.ibm.com>
 <1500177424-13695-2-git-send-email-linuxram@us.ibm.com>
Date: Thu, 20 Jul 2017 11:21:51 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87d18vr6yw.fsf@skywalker.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


.....

>  	/*
> @@ -116,8 +104,8 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
>  		 * On hash insert failure we use old pte value and we don't
>  		 * want slot information there if we have a insert failure.
>  		 */
> -		old_pte &= ~(H_PAGE_HASHPTE | H_PAGE_F_GIX | H_PAGE_F_SECOND);
> -		new_pte &= ~(H_PAGE_HASHPTE | H_PAGE_F_GIX | H_PAGE_F_SECOND);
> +		old_pte &= ~(H_PAGE_HASHPTE);
> +		new_pte &= ~(H_PAGE_HASHPTE);
>  		goto htab_insert_hpte;
>  	}

With the current path order and above hunk we will breaks the bisect I guess. With the above, when
we convert a 64k hpte to 4khpte, since this is the first patch, we
should clear that H_PAGE_F_GIX and H_PAGE_F_SECOND. We still use them
for 64k. I guess you should move this hunk to second patch.


-aneesh

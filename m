Return-Path: <dave.hansen@intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4030cZ2jtKzF0W7
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Mar 2018 09:34:06 +1100 (AEDT)
Subject: Re: [PATCH v12 21/22] selftests/vm: sub-page allocator
To: Ram Pai <linuxram@us.ibm.com>, shuahkh@osg.samsung.com,
 linux-kselftest@vger.kernel.org
References: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com>
 <1519264541-7621-22-git-send-email-linuxram@us.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 x86@kernel.org, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, mingo@redhat.com, akpm@linux-foundation.org,
 benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com,
 arnd@arndb.de
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <f2c8f721-b107-3bdc-3c09-01b9849c4ce2@intel.com>
Date: Fri, 16 Mar 2018 15:33:56 -0700
MIME-Version: 1.0
In-Reply-To: <1519264541-7621-22-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/21/2018 05:55 PM, Ram Pai wrote:
...
> @@ -888,6 +917,7 @@ void setup_hugetlbfs(void)
>  void *(*pkey_malloc[])(long size, int prot, u16 pkey) = {
>  
>  	malloc_pkey_with_mprotect,
> +	malloc_pkey_with_mprotect_subpage,
>  	malloc_pkey_anon_huge,
>  	malloc_pkey_hugetlb
>  /* can not do direct with the pkey_mprotect() API:


I think I'd rather have an #ifdef on the array entries than have the
malloc entry do nothing on x86.  Maybe have a ppc-specific section at
the end?

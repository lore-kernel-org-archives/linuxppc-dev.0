Return-Path: <dave.hansen@intel.com>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x6VZv5SZBzDqb7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jul 2017 04:13:59 +1000 (AEST)
Subject: Re: [RFC v5 34/38] procfs: display the protection-key number
 associated with a vma
To: Ram Pai <linuxram@us.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <1499289735-14220-1-git-send-email-linuxram@us.ibm.com>
 <1499289735-14220-35-git-send-email-linuxram@us.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, hbabu@us.ibm.com, arnd@arndb.de,
 akpm@linux-foundation.org, corbet@lwn.net, mingo@redhat.com
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <8b0827c9-9fc9-c2d5-d1a5-52d9eef8965e@intel.com>
Date: Tue, 11 Jul 2017 11:13:56 -0700
MIME-Version: 1.0
In-Reply-To: <1499289735-14220-35-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/05/2017 02:22 PM, Ram Pai wrote:
> +#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
> +void arch_show_smap(struct seq_file *m, struct vm_area_struct *vma)
> +{
> +	seq_printf(m, "ProtectionKey:  %8u\n", vma_pkey(vma));
> +}
> +#endif /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */

This seems like kinda silly unnecessary duplication.  Could we just put
this in the fs/proc/ code and #ifdef it on ARCH_HAS_PKEYS?

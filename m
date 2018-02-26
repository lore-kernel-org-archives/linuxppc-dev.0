Return-Path: <dave.hansen@intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zqvjD1mX6zDrL0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Feb 2018 08:14:38 +1100 (AEDT)
Subject: Re: [PATCH v12 2/3] mm, powerpc, x86: introduce an additional vma bit
 for powerpc pkey
To: Ram Pai <linuxram@us.ibm.com>, mpe@ellerman.id.au, mingo@redhat.com,
 akpm@linux-foundation.org
References: <1519257138-23797-1-git-send-email-linuxram@us.ibm.com>
 <1519257138-23797-3-git-send-email-linuxram@us.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com,
 corbet@lwn.net, arnd@arndb.de, fweimer@redhat.com, msuchanek@suse.com
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <d3f6b6a1-8319-449a-804e-bf9d1dedbb5f@intel.com>
Date: Mon, 26 Feb 2018 13:14:34 -0800
MIME-Version: 1.0
In-Reply-To: <1519257138-23797-3-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/21/2018 03:52 PM, Ram Pai wrote:
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index ad207ad..d534f46 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -231,9 +231,10 @@ extern int overcommit_kbytes_handler(struct ctl_table *, int, void __user *,
>  #ifdef CONFIG_ARCH_HAS_PKEYS
>  # define VM_PKEY_SHIFT	VM_HIGH_ARCH_BIT_0
>  # define VM_PKEY_BIT0	VM_HIGH_ARCH_0	/* A protection key is a 4-bit value */
> -# define VM_PKEY_BIT1	VM_HIGH_ARCH_1
> +# define VM_PKEY_BIT1	VM_HIGH_ARCH_1	/* on x86 and 5-bit value on ppc64   */
>  # define VM_PKEY_BIT2	VM_HIGH_ARCH_2
>  # define VM_PKEY_BIT3	VM_HIGH_ARCH_3
> +# define VM_PKEY_BIT4	VM_HIGH_ARCH_4
>  #endif /* CONFIG_ARCH_HAS_PKEYS */

I think I would prefer if VM_PKEY_BIT4 was unusable on x86, or #defined
to 0.  We don't want folks using a bit that can not be programmed into
the hardware.

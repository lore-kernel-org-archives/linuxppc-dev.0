Return-Path: <dave.hansen@intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4030NX4dDKzF1BL
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Mar 2018 09:23:39 +1100 (AEDT)
Subject: Re: [PATCH v12 13/22] selftests/vm: powerpc implementation for
 generic abstraction
To: Ram Pai <linuxram@us.ibm.com>, shuahkh@osg.samsung.com,
 linux-kselftest@vger.kernel.org
References: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com>
 <1519264541-7621-14-git-send-email-linuxram@us.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 x86@kernel.org, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, mingo@redhat.com, akpm@linux-foundation.org,
 benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com,
 arnd@arndb.de
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <5e27e966-d1b9-e56d-45cd-43524fd4448c@intel.com>
Date: Fri, 16 Mar 2018 15:23:28 -0700
MIME-Version: 1.0
In-Reply-To: <1519264541-7621-14-git-send-email-linuxram@us.ibm.com>
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
>  static inline u32 pkey_to_shift(int pkey)
>  {
> +#if defined(__i386__) || defined(__x86_64__) /* arch */
>  	return pkey * PKEY_BITS_PER_PKEY;
> +#elif __powerpc64__ /* arch */
> +	return (NR_PKEYS - pkey - 1) * PKEY_BITS_PER_PKEY;
> +#endif /* arch */
>  }

I really detest the #if #else style.  Can't we just have a pkey_ppc.h
and a pkey_x86.h or something?

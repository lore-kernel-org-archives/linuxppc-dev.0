Return-Path: <dave.hansen@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41W1RQ6rWjzF3Hf
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jul 2018 01:34:41 +1000 (AEST)
Subject: Re: [PATCH v14 07/22] selftests/vm: generic function to handle shadow
 key register
To: Ram Pai <linuxram@us.ibm.com>, shuahkh@osg.samsung.com,
 linux-kselftest@vger.kernel.org
References: <1531835365-32387-1-git-send-email-linuxram@us.ibm.com>
 <1531835365-32387-8-git-send-email-linuxram@us.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 x86@kernel.org, linux-arch@vger.kernel.org, mingo@redhat.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, fweimer@redhat.com,
 msuchanek@suse.de, aneesh.kumar@linux.vnet.ibm.com
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <ed8baf0c-7ccf-aa99-a88b-9b7697af89f4@intel.com>
Date: Wed, 18 Jul 2018 08:34:37 -0700
MIME-Version: 1.0
In-Reply-To: <1531835365-32387-8-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/17/2018 06:49 AM, Ram Pai wrote:
> -	shifted_pkey_reg = (pkey_reg >> (pkey * PKEY_BITS_PER_PKEY));
> +	shifted_pkey_reg = right_shift_bits(pkey, pkey_reg);
>  	dprintf2("%s() shifted_pkey_reg: "PKEY_REG_FMT"\n", __func__,
>  			shifted_pkey_reg);
>  	masked_pkey_reg = shifted_pkey_reg & mask;

I'm not a fan of how this looks.  This is almost certainly going to get
the argument order mixed up at some point.

Why do we need this?  The description doesn't say.

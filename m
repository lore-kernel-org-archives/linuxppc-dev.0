Return-Path: <dave.hansen@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 402zqS0QDfzDqfm
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Mar 2018 08:58:26 +1100 (AEDT)
Subject: Re: [PATCH v12 04/22] selftests/vm: typecast the pkey register
To: Ram Pai <linuxram@us.ibm.com>, shuahkh@osg.samsung.com,
 linux-kselftest@vger.kernel.org
References: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com>
 <1519264541-7621-5-git-send-email-linuxram@us.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 x86@kernel.org, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, mingo@redhat.com, akpm@linux-foundation.org,
 benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com,
 arnd@arndb.de
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <00081300-e891-3381-3acd-e3312e54fb58@intel.com>
Date: Fri, 16 Mar 2018 14:58:16 -0700
MIME-Version: 1.0
In-Reply-To: <1519264541-7621-5-git-send-email-linuxram@us.ibm.com>
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
> -static inline unsigned int _rdpkey_reg(int line)
> +static inline pkey_reg_t _rdpkey_reg(int line)
>  {
> -	unsigned int pkey_reg = __rdpkey_reg();
> +	pkey_reg_t pkey_reg = __rdpkey_reg();
>  
> -	dprintf4("rdpkey_reg(line=%d) pkey_reg: %x shadow: %x\n",
> +	dprintf4("rdpkey_reg(line=%d) pkey_reg: %016lx shadow: %016lx\n",
>  			line, pkey_reg, shadow_pkey_reg);
>  	assert(pkey_reg == shadow_pkey_reg);

Hmm.  So we're using %lx for an int?  Doesn't the compiler complain
about this?

Return-Path: <dave.hansen@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x6VXT2jwJzDqgR
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jul 2017 04:11:53 +1000 (AEST)
Subject: Re: [RFC v5 12/38] mm: ability to disable execute permission on a key
 at creation
To: Ram Pai <linuxram@us.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <1499289735-14220-1-git-send-email-linuxram@us.ibm.com>
 <1499289735-14220-13-git-send-email-linuxram@us.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, hbabu@us.ibm.com, arnd@arndb.de,
 akpm@linux-foundation.org, corbet@lwn.net, mingo@redhat.com
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <3bd2ffd4-33ad-ce23-3db1-d1292e69ca9b@intel.com>
Date: Tue, 11 Jul 2017 11:11:46 -0700
MIME-Version: 1.0
In-Reply-To: <1499289735-14220-13-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/05/2017 02:21 PM, Ram Pai wrote:
> Currently sys_pkey_create() provides the ability to disable read
> and write permission on the key, at  creation. powerpc  has  the
> hardware support to disable execute on a pkey as well.This patch
> enhances the interface to let disable execute  at  key  creation
> time. x86 does  not  allow  this.  Hence the next patch will add
> ability  in  x86  to  return  error  if  PKEY_DISABLE_EXECUTE is
> specified.
> 
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> ---
>  include/uapi/asm-generic/mman-common.h |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
> index 8c27db0..bf4fa07 100644
> --- a/include/uapi/asm-generic/mman-common.h
> +++ b/include/uapi/asm-generic/mman-common.h
> @@ -74,7 +74,9 @@
>  
>  #define PKEY_DISABLE_ACCESS	0x1
>  #define PKEY_DISABLE_WRITE	0x2
> +#define PKEY_DISABLE_EXECUTE	0x4
>  #define PKEY_ACCESS_MASK	(PKEY_DISABLE_ACCESS |\
> -				 PKEY_DISABLE_WRITE)
> +				 PKEY_DISABLE_WRITE  |\
> +				 PKEY_DISABLE_EXECUTE)

If you do this, it breaks bisection.  Can you please just do this in one
patch?

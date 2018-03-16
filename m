Return-Path: <dave.hansen@intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4030HZ6BGGzF1HG
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Mar 2018 09:19:22 +1100 (AEDT)
Subject: Re: [PATCH v12 11/22] selftests/vm: pkey register should match shadow
 pkey
To: Ram Pai <linuxram@us.ibm.com>, shuahkh@osg.samsung.com,
 linux-kselftest@vger.kernel.org
References: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com>
 <1519264541-7621-12-git-send-email-linuxram@us.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 x86@kernel.org, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, mingo@redhat.com, akpm@linux-foundation.org,
 benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com,
 arnd@arndb.de
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <e9270064-4951-26dc-aeb0-1378fd7ab542@intel.com>
Date: Fri, 16 Mar 2018 15:19:12 -0700
MIME-Version: 1.0
In-Reply-To: <1519264541-7621-12-git-send-email-linuxram@us.ibm.com>
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
> expected_pkey_fault() is comparing the contents of pkey
> register with 0. This may not be true all the time. There
> could be bits set by default by the architecture
> which can never be changed. Hence compare the value against
> shadow pkey register, which is supposed to track the bits
> accurately all throughout
> 
> cc: Dave Hansen <dave.hansen@intel.com>
> cc: Florian Weimer <fweimer@redhat.com>
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> ---
>  tools/testing/selftests/vm/protection_keys.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
> index 254b66d..6054093 100644
> --- a/tools/testing/selftests/vm/protection_keys.c
> +++ b/tools/testing/selftests/vm/protection_keys.c
> @@ -926,10 +926,10 @@ void expected_pkey_fault(int pkey)
>  	pkey_assert(last_pkey_faults + 1 == pkey_faults);
>  	pkey_assert(last_si_pkey == pkey);
>  	/*
> -	 * The signal handler shold have cleared out PKEY register to let the
> +	 * The signal handler shold have cleared out pkey-register to let the

Heh, you randomly changed the formatting and didn't bother with my awful
typo. :)

>  	 * test program continue.  We now have to restore it.
>  	 */
> -	if (__rdpkey_reg() != 0)
> +	if (__rdpkey_reg() != shadow_pkey_reg)
>  		pkey_assert(0);
>  
>  	__wrpkey_reg(shadow_pkey_reg);
> 

I don't think this should be "shadow_pkey_reg".  This was just trying to
double-check that the signal handler messed around with PKRU the way we
expected.

We could also just check that the disable bits for 'pkey' are clear at
this point.  That would be almost as good.

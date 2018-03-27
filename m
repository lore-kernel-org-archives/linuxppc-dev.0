Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 409CT9370dzF26b
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Mar 2018 12:04:13 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2R142Pa106305
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Mar 2018 21:04:10 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gy868fara-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Mar 2018 21:04:10 -0400
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Tue, 27 Mar 2018 02:04:05 +0100
Date: Mon, 26 Mar 2018 18:03:53 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: mpe@ellerman.id.au, mingo@redhat.com, akpm@linux-foundation.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 dave.hansen@intel.com, benh@kernel.crashing.org, paulus@samba.org,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 hbabu@us.ibm.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com,
 fweimer@redhat.com, msuchanek@suse.com, tglx@linutronix.de,
 shuah@kernel.org
Subject: Re: [PATCH] powerpc, pkey: make protection key 0 less special
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1522107101-16083-1-git-send-email-linuxram@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1522107101-16083-1-git-send-email-linuxram@us.ibm.com>
Message-Id: <20180327010353.GC5743@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Mar 26, 2018 at 04:31:41PM -0700, Ram Pai wrote:
> Applications need the ability to associate an address-range with some
> key and latter revert to its initial default key. Pkey-0 comes close to
> providing this function but falls short, because the current
> implementation disallows applications to explicitly associate pkey-0 to
> the address range.
> 
> Lets make pkey-0 less special and treat it almost like any other key.
> Thus it can be explicitly associated with any address range, and can be
> freed. This gives the application more flexibility and power.  The
> ability to free pkey-0 must be used responsibily, since pkey-0 is
> associated with almost all address-range by default.
> 
> Even with this change pkey-0 continues to be slightly more special
> from the following point of view.
> (a) it is implicitly allocated.
> (b) it is the default key assigned to any address-range.
> 
> Tested on powerpc.

This patch is not entirely correct.
> 
> cc: Thomas Gleixner <tglx@linutronix.de>
> cc: Dave Hansen <dave.hansen@intel.com>
> cc: Michael Ellermen <mpe@ellerman.id.au>
> cc: Ingo Molnar <mingo@kernel.org>
> cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> ---
>  arch/powerpc/include/asm/pkeys.h | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
> index 0409c80..9c7d3bd 100644
> --- a/arch/powerpc/include/asm/pkeys.h
> +++ b/arch/powerpc/include/asm/pkeys.h
> @@ -101,10 +101,18 @@ static inline u16 pte_to_pkey_bits(u64 pteflags)
> 
>  static inline bool mm_pkey_is_allocated(struct mm_struct *mm, int pkey)
>  {
> -	/* A reserved key is never considered as 'explicitly allocated' */
> -	return ((pkey < arch_max_pkey()) &&
> -		!__mm_pkey_is_reserved(pkey) &&
> -		__mm_pkey_is_allocated(mm, pkey));
> +	/* pkey 0 is allocated by default. */
> +	if (!pkey)
> +		return true;

This is wrong. pkey-0 should not be treated any special here. Will fix
this and send a new patch. Sorry for the noise.

RP

Return-Path: <dave.hansen@intel.com>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40d2sf2qsMzDr4K
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 May 2018 05:59:29 +1000 (AEST)
Subject: Re: [PATCH v3] powerpc, pkey: make protection key 0 less special
To: Ram Pai <linuxram@us.ibm.com>, mpe@ellerman.id.au
References: <1525461778-26265-1-git-send-email-linuxram@us.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org,
 paulus@samba.org, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 hbabu@us.ibm.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com,
 fweimer@redhat.com, msuchanek@suse.com, Ulrich.Weigand@de.ibm.com,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <373dffe1-4752-5eb0-f97c-a06fe0e0fdb5@intel.com>
Date: Fri, 4 May 2018 12:59:27 -0700
MIME-Version: 1.0
In-Reply-To: <1525461778-26265-1-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/04/2018 12:22 PM, Ram Pai wrote:
> @@ -407,9 +414,6 @@ static bool pkey_access_permitted(int pkey, bool write, bool execute)
>  	int pkey_shift;
>  	u64 amr;
>  
> -	if (!pkey)
> -		return true;
> -
>  	if (!is_pkey_enabled(pkey))
>  		return true;

Looks fine to me.  Obviously doesn't have any impact on x86 or the
generic code.

One question, though.  Which other check makes up for this removed !pkey
check?

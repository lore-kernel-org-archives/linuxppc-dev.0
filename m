Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C6C421A005D
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Mar 2016 12:08:03 +1100 (AEDT)
Date: Wed, 2 Mar 2016 11:38:26 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH 1/2] powerpc/mm: Update prot_none implementation
 using _PAGE_READ
Message-ID: <20160302003826.GA3160@oak.ozlabs.ibm.com>
References: <1456456850-2679-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1456456850-2679-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Feb 26, 2016 at 08:50:49AM +0530, Aneesh Kumar K.V wrote:
> Now that we have _PAGE_READ use that to implement prot none. With this
> prot_none is _PAGE_PRESENT with none of the access bits set. While
> hashing we map that to PP bit 00.
> 
> With this implementation, we will now take a prot fault for prot none
> ptes, whereas before, we never inserted such a pte to hash. Hence we
> always got nohpte fault before.
> 
> This is in preparation to remove _PAGE_USER from book3s 64

Mostly looks good, but I have a comment:

> @@ -176,10 +177,12 @@
>  #define PAGE_SHARED	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_RW)
>  #define PAGE_SHARED_X	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_RW | \
>  				 _PAGE_EXEC)

Don't we need _PAGE_READ in PAGE_SHARED[_X] now?

Paul.

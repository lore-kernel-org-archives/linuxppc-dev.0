Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zqWH85gpGzF1BK
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Feb 2018 16:54:12 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Khalid Aziz <khalid.aziz@oracle.com>, akpm@linux-foundation.org,
 benh@kernel.crashing.org, paulus@samba.org, davem@davemloft.net,
 dave.hansen@linux.intel.com
Cc: Khalid Aziz <khalid.aziz@oracle.com>, bsingharora@gmail.com,
 nborisov@suse.com, aarcange@redhat.com, anthony.yznaga@oracle.com,
 mgorman@suse.de, linuxram@us.ibm.com, kirill.shutemov@linux.intel.com,
 dan.j.williams@intel.com, jack@suse.cz, ross.zwisler@linux.intel.com,
 gregkh@linuxfoundation.org, tglx@linutronix.de, mhocko@suse.com,
 n-horiguchi@ah.jp.nec.com, jglisse@redhat.com, henry.willard@oracle.com,
 aneesh.kumar@linux.vnet.ibm.com, khandual@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, sparclinux@vger.kernel.org,
 Khalid Aziz <khalid@gonehiking.org>
Subject: Re: [PATCH v12 07/11] mm: Add address parameter to
 arch_validate_prot()
In-Reply-To: <349751cbd54fda6f4a223f941aa71bbfe7be77ce.1519227112.git.khalid.aziz@oracle.com>
References: <cover.1519227112.git.khalid.aziz@oracle.com>
 <349751cbd54fda6f4a223f941aa71bbfe7be77ce.1519227112.git.khalid.aziz@oracle.com>
Date: Mon, 26 Feb 2018 16:54:12 +1100
Message-ID: <87d10s9tyz.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Khalid Aziz <khalid.aziz@oracle.com> writes:

> A protection flag may not be valid across entire address space and
> hence arch_validate_prot() might need the address a protection bit is
> being set on to ensure it is a valid protection flag. For example, sparc
> processors support memory corruption detection (as part of ADI feature)
> flag on memory addresses mapped on to physical RAM but not on PFN mapped
> pages or addresses mapped on to devices. This patch adds address to the
> parameters being passed to arch_validate_prot() so protection bits can
> be validated in the relevant context.
>
> Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
> Cc: Khalid Aziz <khalid@gonehiking.org>
> Reviewed-by: Anthony Yznaga <anthony.yznaga@oracle.com>
> ---
> v8:
> 	- Added addr parameter to powerpc arch_validate_prot() (suggested
> 	  by Michael Ellerman)
> v9:
> 	- new patch
>
>  arch/powerpc/include/asm/mman.h | 4 ++--
>  arch/powerpc/kernel/syscalls.c  | 2 +-

These changes look fine to me:

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers

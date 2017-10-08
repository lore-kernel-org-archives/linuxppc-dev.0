Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y9JnD2NMKzDqhb
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Oct 2017 10:02:55 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v98Mx92t118702
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 8 Oct 2017 19:02:53 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dfncenvga-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Oct 2017 19:02:52 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Sun, 8 Oct 2017 17:02:52 -0600
Date: Sun, 8 Oct 2017 18:02:43 -0500
From: Ram Pai <linuxram@us.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org, paulus@samba.org,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org,
 bauerman@linux.vnet.ibm.com, ebiederm@xmission.com
Subject: Re: [PATCH 03/25] powerpc: track allocation status of all pkeys
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1504910713-7094-1-git-send-email-linuxram@us.ibm.com>
 <1504910713-7094-12-git-send-email-linuxram@us.ibm.com>
 <87376vcm28.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <87376vcm28.fsf@concordia.ellerman.id.au>
Message-Id: <20171008230243.GA5675@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Oct 07, 2017 at 09:02:55PM +1100, Michael Ellerman wrote:
> Ram Pai <linuxram@us.ibm.com> writes:
> 
> > Total 32 keys are available on power7 and above. However
> > pkey 0,1 are reserved. So effectively we  have  30 pkeys.
> >
> > On 4K kernels, we do not  have  5  bits  in  the  PTE to
> > represent  all the keys; we only have 3bits.Two of those
> > keys are reserved; pkey 0 and pkey 1. So effectively  we
> > have 6 pkeys.
> >
> > This patch keeps track of reserved keys, allocated  keys
> > and keys that are currently free.
> >
> > Also it  adds  skeletal  functions  and macros, that the
> > architecture-independent code expects to be available.
> >
> > Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> > ---
> >  arch/powerpc/include/asm/book3s/64/mmu.h |    9 ++++
> >  arch/powerpc/include/asm/mmu_context.h   |    1 +
> >  arch/powerpc/include/asm/pkeys.h         |   72 ++++++++++++++++++++++++++++--
> >  arch/powerpc/mm/mmu_context_book3s64.c   |    2 +
> >  arch/powerpc/mm/pkeys.c                  |   28 ++++++++++++
> >  5 files changed, 108 insertions(+), 4 deletions(-)
> 
> This doesn't build for me, with pseries_le_defconfig. I assume it built
> for you. So something has changed upstream maybe?
> 

Yes. :(
The following commit upstream broke my patches.
df3735c5b40fad8d0d28eb8ab065fe955b3347ee

Will fix and send you a patch.

RP



> 
> In file included from ../include/linux/pkeys.h:8:0,
>                  from ../mm/mprotect.c:26:
> ../mm/mprotect.c: In function ‘do_mprotect_pkey’:
> ../arch/powerpc/include/asm/pkeys.h:27:29: error: ‘VM_PKEY_BIT0’ undeclared (first use in this function)
>  #define ARCH_VM_PKEY_FLAGS (VM_PKEY_BIT0 | VM_PKEY_BIT1 | VM_PKEY_BIT2 | \
>                              ^
..snip...

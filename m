Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wszdK0qTwzDq88
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 19:17:40 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5L9EmvS054949
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 05:17:38 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2b70evfxfg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 05:17:38 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Wed, 21 Jun 2017 03:17:37 -0600
Date: Wed, 21 Jun 2017 02:17:24 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 khandual@linux.vnet.ibm.com, bsingharora@gmail.com,
 dave.hansen@intel.com, hbabu@us.ibm.com
Subject: Re: [RFC v2 07/12] powerpc: Macro the mask used for checking DSI
 exception
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1497671564-20030-1-git-send-email-linuxram@us.ibm.com>
 <1497671564-20030-8-git-send-email-linuxram@us.ibm.com>
 <87r2ydajk9.fsf@skywalker.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87r2ydajk9.fsf@skywalker.in.ibm.com>
Message-Id: <20170621091724.GJ5845@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 21, 2017 at 12:55:42PM +0530, Aneesh Kumar K.V wrote:
> Ram Pai <linuxram@us.ibm.com> writes:
> 
> > Replace the magic number used to check for DSI exception
> > with a meaningful value.
> >
> > Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> > ---
> >  arch/powerpc/include/asm/reg.h       | 9 ++++++++-
> >  arch/powerpc/kernel/exceptions-64s.S | 2 +-
> >  2 files changed, 9 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
> > index 7e50e47..2dcb8a1 100644
> > --- a/arch/powerpc/include/asm/reg.h
> > +++ b/arch/powerpc/include/asm/reg.h
> > @@ -272,16 +272,23 @@
> >  #define SPRN_DAR	0x013	/* Data Address Register */
> >  #define SPRN_DBCR	0x136	/* e300 Data Breakpoint Control Reg */
> >  #define SPRN_DSISR	0x012	/* Data Storage Interrupt Status Register */
> > +#define   DSISR_BIT32		0x80000000	/* not defined */
> >  #define   DSISR_NOHPTE		0x40000000	/* no translation found */
> > +#define   DSISR_PAGEATTR_CONFLT	0x20000000	/* page attribute conflict */
> > +#define   DSISR_BIT35		0x10000000	/* not defined */
> >  #define   DSISR_PROTFAULT	0x08000000	/* protection fault */
> >  #define   DSISR_BADACCESS	0x04000000	/* bad access to CI or G */
> >  #define   DSISR_ISSTORE		0x02000000	/* access was a store */
> >  #define   DSISR_DABRMATCH	0x00400000	/* hit data breakpoint */
> > -#define   DSISR_NOSEGMENT	0x00200000	/* SLB miss */
> >  #define   DSISR_KEYFAULT	0x00200000	/* Key fault */
> > +#define   DSISR_BIT43		0x00100000	/* not defined */
> >  #define   DSISR_UNSUPP_MMU	0x00080000	/* Unsupported MMU config */
> >  #define   DSISR_SET_RC		0x00040000	/* Failed setting of R/C bits */
> >  #define   DSISR_PGDIRFAULT      0x00020000      /* Fault on page directory */
> > +#define   DSISR_PAGE_FAULT_MASK (DSISR_BIT32 | \
> > +				DSISR_PAGEATTR_CONFLT | \
> > +				DSISR_BADACCESS |       \
> > +				DSISR_BIT43)
> >  #define SPRN_TBRL	0x10C	/* Time Base Read Lower Register (user, R/O) */
> >  #define SPRN_TBRU	0x10D	/* Time Base Read Upper Register (user, R/O) */
> >  #define SPRN_CIR	0x11B	/* Chip Information Register (hyper, R/0) */
> > diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
> > index ae418b8..3fd0528 100644
> > --- a/arch/powerpc/kernel/exceptions-64s.S
> > +++ b/arch/powerpc/kernel/exceptions-64s.S
> > @@ -1411,7 +1411,7 @@ USE_TEXT_SECTION()
> >  	.balign	IFETCH_ALIGN_BYTES
> >  do_hash_page:
> >  #ifdef CONFIG_PPC_STD_MMU_64
> > -	andis.	r0,r4,0xa410		/* weird error? */
> > +	andis.	r0,r4,DSISR_PAGE_FAULT_MASK@h
> >  	bne-	handle_page_fault	/* if not, try to insert a HPTE */
> >  	andis.  r0,r4,DSISR_DABRMATCH@h
> >  	bne-    handle_dabr_fault
> 
> 
> Thanks for doing this. I always wondered what that 0xa410 indicates. Now
> tha it is documented, I am wondering are those the only DSISR values
> that we want to check early ? You also added few bit positions that is
> expected to carry value 0 ? But then excluded BIT35. Any reason ?

I did not look deeply into why the exact number 0xa410 was used in the
past.  I built the macro DSISR_PAGE_FAULT_MASK using whatever bits make
up 0xa410.  BIT35 if added to the DSISR_PAGE_FAULT_MASK would make it
0xb410. So I did not consider it.

However the macro for BIT35 is already defined in this patch, if that is what you were
looking for.
+#define   DSISR_BIT35              0x10000000      /* not defined */

RP

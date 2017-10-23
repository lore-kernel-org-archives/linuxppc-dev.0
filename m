Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yLNzP1RsvzDqZq
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Oct 2017 04:43:12 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9NHd3Bg009677
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Oct 2017 13:43:10 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dsj2qrpv0-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Oct 2017 13:43:09 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Mon, 23 Oct 2017 11:43:09 -0600
Date: Mon, 23 Oct 2017 10:43:00 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, paulus@samba.org,
 khandual@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com
Subject: Re: [PATCH 02/25] powerpc: define an additional vma bit for
 protection keys.
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1504910713-7094-1-git-send-email-linuxram@us.ibm.com>
 <1504910713-7094-11-git-send-email-linuxram@us.ibm.com>
 <87vaj68bc0.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87vaj68bc0.fsf@linux.vnet.ibm.com>
Message-Id: <20171023174300.GB5454@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Oct 23, 2017 at 02:55:51PM +0530, Aneesh Kumar K.V wrote:
> Ram Pai <linuxram@us.ibm.com> writes:
> 
> > powerpc needs an additional vma bit to support 32 keys.
> > Till the additional vma bit lands in include/linux/mm.h
> > we have to define  it  in powerpc specific header file.
> > This is  needed to get pkeys working on power.
> >
> > Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> > ---
> >  arch/powerpc/include/asm/pkeys.h |   18 ++++++++++++++++++
> >  1 files changed, 18 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
> > index c02305a..44e01a2 100644
> > --- a/arch/powerpc/include/asm/pkeys.h
> > +++ b/arch/powerpc/include/asm/pkeys.h
> > @@ -3,6 +3,24 @@
> >
> >  extern bool pkey_inited;
> >  extern bool pkey_execute_disable_support;
> > +
> > +/*
> > + * powerpc needs an additional vma bit to support 32 keys.
> > + * Till the additional vma bit lands in include/linux/mm.h
> > + * we have to carry the hunk below. This is  needed to get
> > + * pkeys working on power. -- Ram
> > + */
> > +#ifndef VM_HIGH_ARCH_BIT_4
> > +#define VM_HIGH_ARCH_BIT_4	36
> > +#define VM_HIGH_ARCH_4	BIT(VM_HIGH_ARCH_BIT_4)
> > +#define VM_PKEY_SHIFT VM_HIGH_ARCH_BIT_0
> > +#define VM_PKEY_BIT0	VM_HIGH_ARCH_0
> > +#define VM_PKEY_BIT1	VM_HIGH_ARCH_1
> > +#define VM_PKEY_BIT2	VM_HIGH_ARCH_2
> > +#define VM_PKEY_BIT3	VM_HIGH_ARCH_3
> > +#define VM_PKEY_BIT4	VM_HIGH_ARCH_4
> > +#endif
> > +
> >  #define ARCH_VM_PKEY_FLAGS 0
> 
> Do we want them in pkeys.h ? Even if they are arch specific for the
> existing ones we have them in include/linux/mm.h. IIUC, vmflags details
> are always in mm.h? This will be the first exception to that?

I am trying to get the real fix in include/linux/mm.h  
If that happens sooner than this hunk is not needed. 
Till then this is an exception, but it is the **ONLY** exception.

I think your point is to have this hunk in include/linux/mm.h  ?

If yes, than it would be easier to push the real fix in
include/linux/mm.h  instead of pushing this hunk in the there.

RP

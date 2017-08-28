Return-Path: <srs0=h+48=76=linux.vnet.ibm.com=sukadev@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xgg8b22glzDqG1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Aug 2017 15:20:47 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xgg8b1JNrz8t8p
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Aug 2017 15:20:47 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xgg8Z50C4z9sP3
 for <linuxppc-dev@ozlabs.org>; Mon, 28 Aug 2017 15:20:46 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7S5JMY5101179
 for <linuxppc-dev@ozlabs.org>; Mon, 28 Aug 2017 01:20:45 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cm3uf1nm6-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Mon, 28 Aug 2017 01:20:44 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Sun, 27 Aug 2017 23:20:44 -0600
Date: Sun, 27 Aug 2017 22:20:39 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
 stewart@linux.vnet.ibm.com, apopple@au1.ibm.com, hbabu@us.ibm.com,
 oohall@gmail.com, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 12/12] powerpc/vas: Define copy/paste interfaces
References: <1503556688-15412-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1503556688-15412-13-git-send-email-sukadev@linux.vnet.ibm.com>
 <87shgfuda6.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87shgfuda6.fsf@concordia.ellerman.id.au>
Message-Id: <20170828052039.GG12907@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman [mpe@ellerman.id.au] wrote:
> Hi Suka,
> 
> A few more things ...
> 
> Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com> writes:
> 
> > diff --git a/arch/powerpc/platforms/powernv/copy-paste.h b/arch/powerpc/platforms/powernv/copy-paste.h
> > new file mode 100644
> > index 0000000..7783bb8
> > --- /dev/null
> > +++ b/arch/powerpc/platforms/powernv/copy-paste.h
> > @@ -0,0 +1,74 @@
> > +/*
> > + * Copyright 2016 IBM Corp.
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public License
> > + * as published by the Free Software Foundation; either version
> > + * 2 of the License, or (at your option) any later version.
> > + */
> > +
> > +/*
> > + * Macros taken from tools/testing/selftests/powerpc/context_switch/cp_abort.c
> > + */
> 
> These are both out of date, they're changed in v3.0B.
> 
> > +#define PASTE(RA, RB, L, RC) \
> > +	.long (0x7c00070c | (RA) << (31-15) | (RB) << (31-20) \
> > +			  | (L) << (31-10) | (RC) << (31-31))
> 
> You should define PPC_PASTE() in ppc-opcode.h
> 
> We already have PPC_INST_PASTE, so use that.
> 
> L and RC are gone.

Ok. I thought they would come back later, but of course we can update
these kernel-only calls then.

> 
> > +
> > +#define COPY(RA, RB, L) \
> > +	.long (0x7c00060c | (RA) << (31-15) | (RB) << (31-20) \
> > +			  | (L) << (31-10))
> 
> Use PPC_COPY().
> 

Ok

> > +
> > +#define CR0_FXM		"0x80"
> 
> I don't think a #define for this helps readability.
> 
> > +#define CR0_SHIFT	28
> > +#define CR0_MASK	0xF
> 
> Not used.

Will need them now to return value in cr0?
> 
> > +/*
> > + * Copy/paste instructions:
> > + *
> > + *	copy RA,RB,L
> > + *		Copy contents of address (RA) + effective_address(RB)
> > + *		to internal copy-buffer.
> > + *
> > + *		L == 1 indicates this is the first copy.
> > + *
> > + *		L == 0 indicates its a continuation of a prior first copy.
> > + *
> > + *	paste RA,RB,L
> > + *		Paste contents of internal copy-buffer to the address
> > + *		(RA) + effective_address(RB)
> > + *
> > + *		L == 0 indicates its a continuation of a prior paste. i.e.
> > + *		don't wait for the completion or update status.
> > + *
> > + *		L == 1 indicates this is the last paste in the group (i.e.
> > + *		wait for the group to complete and update status in CR0).
> > + *
> > + *	For Power9, the L bit must be 'true' in both copy and paste.
> > + */
> > +
> > +static inline int vas_copy(void *crb, int offset, int first)
> > +{
> > +	WARN_ON_ONCE(!first);
> 
> Please change the API to not require unused parameters.
> 
> Same for offset.

Ok, Haren's NX patches will need to drop those parameters as well.

> 
> > +
> > +	__asm__ __volatile(stringify_in_c(COPY(%0, %1, %2))";"
> 
> I've never seen __volatile before.
> 
> Just use: asm volatile

ok
> 
> 
> > +		:
> > +		: "b" (offset), "b" (crb), "i" (1)
> > +		: "memory");
> > +
> > +	return 0;
> > +}
> > +
> > +static inline int vas_paste(void *paste_address, int offset, int last)
> > +{
> > +	unsigned long long cr;
> 
> cr is 32-bits actually.

ok
> 
> > +	WARN_ON_ONCE(!last);
> > +
> > +	cr = 0;
> > +	__asm__ __volatile(stringify_in_c(PASTE(%1, %2, 1, 1))";"
> > +		"mfocrf %0," CR0_FXM ";"
> > +		: "=r" (cr)
> > +		: "b" (paste_address), "b" (offset)
> > +		: "memory");
> 
> You need cr0 in the clobbers.

ok
> 
> > +
> > +	return cr;
> 
> I think it would be more natural if you just returned CR0, so if you did
> shift and mask with the CR0 constants you have above.
> 
ok

> 
> > diff --git a/arch/powerpc/platforms/powernv/vas-window.c b/arch/powerpc/platforms/powernv/vas-window.c
> > index 70762c3..73081b4 100644
> > --- a/arch/powerpc/platforms/powernv/vas-window.c
> > +++ b/arch/powerpc/platforms/powernv/vas-window.c
> > @@ -1040,6 +1041,57 @@ struct vas_window *vas_tx_win_open(int vasid, enum vas_cop_type cop,
> >  }
> >  EXPORT_SYMBOL_GPL(vas_tx_win_open);
> >  
> > +int vas_copy_crb(void *crb, int offset, bool first)
> > +{
> > +	if (!vas_initialized())
> > +		return -1;
> > +
> > +	return vas_copy(crb, offset, first);
> > +}
> > +EXPORT_SYMBOL_GPL(vas_copy_crb);
> > +
> > +#define RMA_LSMP_REPORT_ENABLE PPC_BIT(53)
> > +int vas_paste_crb(struct vas_window *txwin, int offset, bool last, bool re)
> > +{
> > +	int rc;
> > +	uint64_t val;
> > +	void *addr;
> > +
> > +	if (!vas_initialized())
> > +		return -1;
> 
> This is in the fast path, or at least the runtime path. So I don't think
> these checks are wanted, how would we have got this far if vas wasn't
> initialised?

Yes, I have dropped vas_initialized() now.
> 
> 
> 
> cheers

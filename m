Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xgqhV6rY3zDq66
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Aug 2017 21:45:30 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
 stewart@linux.vnet.ibm.com, apopple@au1.ibm.com, hbabu@us.ibm.com,
 oohall@gmail.com, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 12/12] powerpc/vas: Define copy/paste interfaces
In-Reply-To: <20170828052039.GG12907@us.ibm.com>
References: <1503556688-15412-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1503556688-15412-13-git-send-email-sukadev@linux.vnet.ibm.com>
 <87shgfuda6.fsf@concordia.ellerman.id.au> <20170828052039.GG12907@us.ibm.com>
Date: Mon, 28 Aug 2017 21:45:29 +1000
Message-ID: <87a82jvrty.fsf@concordia.ellerman.id.au>
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

Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com> writes:

> Michael Ellerman [mpe@ellerman.id.au] wrote:
>> Hi Suka,
>> 
>> A few more things ...
>> 
>> Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com> writes:
>> 
>> > diff --git a/arch/powerpc/platforms/powernv/copy-paste.h b/arch/powerpc/platforms/powernv/copy-paste.h
>> > new file mode 100644
>> > index 0000000..7783bb8
>> > --- /dev/null
>> > +++ b/arch/powerpc/platforms/powernv/copy-paste.h
>> > @@ -0,0 +1,74 @@
>> > +/*
>> > + * Copyright 2016 IBM Corp.
>> > + *
>> > + * This program is free software; you can redistribute it and/or
>> > + * modify it under the terms of the GNU General Public License
>> > + * as published by the Free Software Foundation; either version
>> > + * 2 of the License, or (at your option) any later version.
>> > + */
>> > +
>> > +/*
>> > + * Macros taken from tools/testing/selftests/powerpc/context_switch/cp_abort.c
>> > + */
>> 
>> These are both out of date, they're changed in v3.0B.
>> 
>> > +#define PASTE(RA, RB, L, RC) \
>> > +	.long (0x7c00070c | (RA) << (31-15) | (RB) << (31-20) \
>> > +			  | (L) << (31-10) | (RC) << (31-31))
>> 
>> You should define PPC_PASTE() in ppc-opcode.h
>> 
>> We already have PPC_INST_PASTE, so use that.
>> 
>> L and RC are gone.
>
> Ok. I thought they would come back later, but of course we can update
> these kernel-only calls then.

Possible, but if they do we can update them then.

>> > +#define CR0_SHIFT	28
>> > +#define CR0_MASK	0xF
>> 
>> Not used.
>
> Will need them now to return value in cr0?

Yes.

>> > +/*
>> > + * Copy/paste instructions:
>> > + *
>> > + *	copy RA,RB,L
>> > + *		Copy contents of address (RA) + effective_address(RB)
>> > + *		to internal copy-buffer.
>> > + *
>> > + *		L == 1 indicates this is the first copy.
>> > + *
>> > + *		L == 0 indicates its a continuation of a prior first copy.
>> > + *
>> > + *	paste RA,RB,L
>> > + *		Paste contents of internal copy-buffer to the address
>> > + *		(RA) + effective_address(RB)
>> > + *
>> > + *		L == 0 indicates its a continuation of a prior paste. i.e.
>> > + *		don't wait for the completion or update status.
>> > + *
>> > + *		L == 1 indicates this is the last paste in the group (i.e.
>> > + *		wait for the group to complete and update status in CR0).
>> > + *
>> > + *	For Power9, the L bit must be 'true' in both copy and paste.
>> > + */
>> > +
>> > +static inline int vas_copy(void *crb, int offset, int first)
>> > +{
>> > +	WARN_ON_ONCE(!first);
>> 
>> Please change the API to not require unused parameters.
>> 
>> Same for offset.
>
> Ok, Haren's NX patches will need to drop those parameters as well.

That's fine, I'm merging them all via my tree. I can fix that up.

cheers

Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41B2cJ1nM2zF0xv
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jun 2018 10:28:32 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Ram Pai <linuxram@us.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, dave.hansen@intel.com,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, Ulrich.Weigand@de.ibm.com,
 fweimer@redhat.com, luto@kernel.org, msuchanek@suse.de
Subject: Re: [PATCH v2 4/6] powerpc/pkeys: Preallocate execute-only key
In-Reply-To: <20180619163813.GG5294@ram.oc3035372033.ibm.com>
References: <1528936144-6696-1-git-send-email-linuxram@us.ibm.com>
 <1528936144-6696-5-git-send-email-linuxram@us.ibm.com>
 <871sd3x842.fsf@concordia.ellerman.id.au>
 <20180619163813.GG5294@ram.oc3035372033.ibm.com>
Date: Thu, 21 Jun 2018 10:28:31 +1000
Message-ID: <87h8lxvv80.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ram Pai <linuxram@us.ibm.com> writes:
> On Tue, Jun 19, 2018 at 10:40:13PM +1000, Michael Ellerman wrote:
>> Ram Pai <linuxram@us.ibm.com> writes:
>>=20
>> > execute-only key is allocated dynamically. This is a problem.  When a
>> > thread implicitly creates a execute-only key, and resets UAMOR for that
>> > key, the UAMOR value does not percolate to all the other threads.  Any
>> > other thread may ignorantly change the permissions on the key.  This c=
an
>> > cause the key to be not execute-only for that thread.
>> >
>> > Preallocate the execute-only key and ensure that no thread can change
>> > the permission of the key, by resetting the corresponding bit in UAMOR.
>>=20
>> OK this is a non-ABI changing bug fix AFAICS.
>>=20
>> I'll add:
>>=20
>>   Fixes: 5586cf61e108 ("powerpc: introduce execute-only pkey")
>>   Cc: stable@vger.kernel.org # v4.16+
>>=20
>> > diff --git a/arch/powerpc/mm/pkeys.c b/arch/powerpc/mm/pkeys.c
>> > index b681bec..1f2389f 100644
>> > --- a/arch/powerpc/mm/pkeys.c
>> > +++ b/arch/powerpc/mm/pkeys.c
>> > @@ -25,6 +25,7 @@
>> >  #define IAMR_EX_BIT 0x1UL
>> >  #define PKEY_REG_BITS (sizeof(u64)*8)
>> >  #define pkeyshift(pkey) (PKEY_REG_BITS - ((pkey+1) * AMR_BITS_PER_PKE=
Y))
>> > +#define EXECUTE_ONLY_KEY 2
>>=20
>> Do we ensure we have at least 3 keys anywhere?
>
> No. Good to add. Can this be different patch?

Yes please.

> However we do not have any systems with less than 16keys AFAICT.

It's controllable by firmware so we have between 0 and =E2=88=9E keys :)

But yeah you're right it's unlikely to be a bug anyone hits in practice.

cheers

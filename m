Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHcXR3fjLzDqT0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 16:13:43 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Ram Pai <linuxram@us.ibm.com>, Laurent Dufour <ldufour@linux.vnet.ibm.com>
Cc: mhocko@kernel.org, paulus@samba.org, aneesh.kumar@linux.vnet.ibm.com,
 bauerman@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 khandual@linux.vnet.ibm.com
Subject: Re: [RFC v7 16/25] powerpc: helper to validate key-access permissions
 of a pte
In-Reply-To: <20171018215603.GN5617@ram.oc3035372033.ibm.com>
References: <1501459946-11619-1-git-send-email-linuxram@us.ibm.com>
 <1501459946-11619-17-git-send-email-linuxram@us.ibm.com>
 <50c2a845-93aa-519f-732f-ee0d44be687c@linux.vnet.ibm.com>
 <20171018215603.GN5617@ram.oc3035372033.ibm.com>
Date: Thu, 19 Oct 2017 16:13:43 +1100
Message-ID: <87zi8nlny0.fsf@concordia.ellerman.id.au>
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

Ram Pai <linuxram@us.ibm.com> writes:
> On Wed, Oct 18, 2017 at 06:08:34PM +0200, Laurent Dufour wrote:
>> On 31/07/2017 02:12, Ram Pai wrote:
>> > diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
>> > index 4b7e3f4..ba7bff6 100644
>> > --- a/arch/powerpc/include/asm/pkeys.h
>> > +++ b/arch/powerpc/include/asm/pkeys.h
>> > @@ -85,6 +85,18 @@ static inline u64 pte_to_hpte_pkey_bits(u64 pteflags)
>> >  		((pteflags & H_PAGE_PKEY_BIT4) ? HPTE_R_KEY_BIT4 : 0x0UL));
>> >  }
>> > 
>> > +static inline u16 pte_to_pkey_bits(u64 pteflags)
>> > +{
>> > +	if (!pkey_inited)
>> > +		return 0x0UL;
>> 
>> Is it really needed to make such a check in this low level function ?
>> The only caller is already checking for pkey_inited before making the call.
>
> There are two callers to this function. get_pte_pkey() is one among
> them and it calls this function ignorant of the status of the
> pkey-subsystem.

But if none of the bits are set it will return 0 anyway right?

cheers

Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tDzxY2stlzDvh5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2016 21:36:49 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: kvm-ppc@vger.kernel.org, benh@kernel.crashing.org, paulus@samba.org,
 agraf@suse.com
Subject: Re: [PATCH V3 1/2] powerpc: Define new ISA v3.00 logical PVR value
 and PCR register value
In-Reply-To: <1478647124.2415.6.camel@gmail.com>
References: <1477975263-29045-1-git-send-email-sjitindarsingh@gmail.com>
 <1477975263-29045-2-git-send-email-sjitindarsingh@gmail.com>
 <87y40ujsam.fsf@concordia.ellerman.id.au> <1478647124.2415.6.camel@gmail.com>
Date: Thu, 10 Nov 2016 21:36:48 +1100
Message-ID: <874m3fk4e7.fsf@concordia.ellerman.id.au>
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

Suraj Jitindar Singh <sjitindarsingh@gmail.com> writes:

> On Tue, 2016-11-08 at 19:21 +1100, Michael Ellerman wrote:
>> Suraj Jitindar Singh <sjitindarsingh@gmail.com> writes:
>> 
>> > 
>> > ISA 3.00 adds the logical PVR value 0x0f000005, so add a definition
>> > for
>> > this.
>> > 
>> > Define PCR_ARCH_207 to reflect ISA 2.07 compatibility mode in the
>> > processor
>> > compatibility register (PCR). Also define a dummy ISA 3.00
>> > compatibility
>> > mode PCR_ARCH_300 to be used in the next patch to help with
>> > determining the
>> > PCR value.
>> What's "dummy" about the PCR value?

> Then next patch needs some PCR bit to specify that we want to emulate
> v3.00 and/or that the host can emulate v3.00 to follow the pattern used
> to determine that the host is capable of emulating the given compat
> level and for determining which PCR bits to set. But no such bit is
> defined for V3.00 compat mode yet so a "dummy" one is used to represent
> this even though it's never defined in the ISA.
>> 
>> AFAICS that value is reserved in the ISA.

> Yes it is a reserved bit in the PCR register but it will never actually
> be set, it will always be cleared by "host_pcr_bit - guest_pcr_bit;"

>> 
>> Are we assuming/hoping that ISA 4.0 will use 0x10 to mean ISA 3.0 ?

> Basically yes, and although I know nothing's given, it would follow the
> current pattern for whatever the next ISA version is to use 0x10 to
> mean V3.00 compat mode. Otherwise this will need to be updated at some
> point when that's released... In fact if the compat bits are no longer
> sequential this will need rewriting.


OK thanks.

Please send a v4 with that detail in a comment and a better explanation
in the change log.

I think a block comment before the #define would be best, ie. something
like:

#define   PCR_ARCH_207	0x8		/* Architecture 2.07 */

/*
 * All that helpful detail from above ...
 */
#define   PCR_ARCH_300	0x10


We should also ask if we can get 0x10 reserved in the ISA to mean 3.00.

cheers

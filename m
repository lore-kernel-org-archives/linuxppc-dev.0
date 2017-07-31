Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xLffW1StxzDsSY
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 22:59:15 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Ram Pai <linuxram@us.ibm.com>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: linux-arch@vger.kernel.org, corbet@lwn.net, arnd@arndb.de,
 linux-doc@vger.kernel.org, x86@kernel.org, dave.hansen@intel.com,
 linux-kernel@vger.kernel.org, mhocko@kernel.org, linux-mm@kvack.org,
 mingo@redhat.com, paulus@samba.org, aneesh.kumar@linux.vnet.ibm.com,
 linux-kselftest@vger.kernel.org, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, khandual@linux.vnet.ibm.com
Subject: Re: [RFC v6 19/62] powerpc: ability to create execute-disabled pkeys
In-Reply-To: <20170729232446.GG5664@ram.oc3035372033.ibm.com>
References: <1500177424-13695-1-git-send-email-linuxram@us.ibm.com>
 <1500177424-13695-20-git-send-email-linuxram@us.ibm.com>
 <87bmo63p7c.fsf@linux.vnet.ibm.com>
 <20170729232446.GG5664@ram.oc3035372033.ibm.com>
Date: Mon, 31 Jul 2017 22:59:14 +1000
Message-ID: <87zibk4va5.fsf@concordia.ellerman.id.au>
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

> On Thu, Jul 27, 2017 at 11:54:31AM -0300, Thiago Jung Bauermann wrote:
>> 
>> Ram Pai <linuxram@us.ibm.com> writes:
>> 
>> > --- a/arch/powerpc/include/asm/pkeys.h
>> > +++ b/arch/powerpc/include/asm/pkeys.h
>> > @@ -2,6 +2,18 @@
>> >  #define _ASM_PPC64_PKEYS_H
>> >
>> >  extern bool pkey_inited;
>> > +/* override any generic PKEY Permission defines */
>> > +#undef  PKEY_DISABLE_ACCESS
>> > +#define PKEY_DISABLE_ACCESS    0x1
>> > +#undef  PKEY_DISABLE_WRITE
>> > +#define PKEY_DISABLE_WRITE     0x2
>> > +#undef  PKEY_DISABLE_EXECUTE
>> > +#define PKEY_DISABLE_EXECUTE   0x4
>> > +#undef  PKEY_ACCESS_MASK
>> > +#define PKEY_ACCESS_MASK       (PKEY_DISABLE_ACCESS |\
>> > +				PKEY_DISABLE_WRITE  |\
>> > +				PKEY_DISABLE_EXECUTE)
>> > +
>> 
>> Is it ok to #undef macros from another header? Especially since said
>> header is in uapi (include/uapi/asm-generic/mman-common.h).
>> 
>> Also, it's unnecessary to undef the _ACCESS and _WRITE macros since they
>> are identical to the original definition. And since these macros are
>> originally defined in an uapi header, the powerpc-specific ones should
>> be in an uapi header as well, if I understand it correctly.
>
> The architectural neutral code allows the implementation to define the
> macros to its taste. powerpc headers due to legacy reason includes the
> include/uapi/asm-generic/mman-common.h header. That header includes the
> generic definitions of only PKEY_DISABLE_ACCESS and PKEY_DISABLE_WRITE.
> Unfortunately we end up importing them. I dont want to depend on them.
> Any changes there could effect us. Example if the generic uapi header
> changed PKEY_DISABLE_ACCESS to 0x4, we will have a conflict with
> PKEY_DISABLE_EXECUTE.  Hence I undef them and define the it my way.

Don't do that.

The generic header can't change the values, it's an ABI.

Doing it this way risks the uapi value diverging from the value used in
the powerpc code (due to a change in the powerpc version), which would
mean userspace and the kernel wouldn't agree on what the values meant
... which would be exciting.

cheers

Return-Path: <bsingharora@gmail.com>
Received: from mail-qt0-x241.google.com (mail-qt0-x241.google.com
 [IPv6:2607:f8b0:400d:c0d::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x7WHS6BXXzDqk6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Jul 2017 19:49:08 +1000 (AEST)
Received: by mail-qt0-x241.google.com with SMTP id v31so5349163qtb.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Jul 2017 02:49:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170713075502.GG5525@ram.oc3035372033.ibm.com>
References: <1499289735-14220-1-git-send-email-linuxram@us.ibm.com>
 <1499289735-14220-16-git-send-email-linuxram@us.ibm.com>
 <20170712152601.3b2f52ed@firefly.ozlabs.ibm.com>
 <20170713075502.GG5525@ram.oc3035372033.ibm.com>
From: Balbir Singh <bsingharora@gmail.com>
Date: Thu, 13 Jul 2017 19:49:05 +1000
Message-ID: <CAKTCnzmDd2K0gc=0gvNn7Q_QBPqmQdwppnpU-J9B1AMva7w8sA@mail.gmail.com>
Subject: Re: [RFC v5 15/38] powerpc: helper function to read,write
 AMR,IAMR,UAMOR registers
To: Ram Pai <linuxram@us.ibm.com>
Cc: "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-arch <linux-arch@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
 "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 linux-kselftest@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Aneesh Kumar KV <aneesh.kumar@linux.vnet.ibm.com>,
 Dave Hansen <dave.hansen@intel.com>,
 "Haren Myneni/Beaverton/IBM" <hbabu@us.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 13, 2017 at 5:55 PM, Ram Pai <linuxram@us.ibm.com> wrote:
> On Wed, Jul 12, 2017 at 03:26:01PM +1000, Balbir Singh wrote:
>> On Wed,  5 Jul 2017 14:21:52 -0700
>> Ram Pai <linuxram@us.ibm.com> wrote:
>>
>> > Implements helper functions to read and write the key related
>> > registers; AMR, IAMR, UAMOR.
>> >
>> > AMR register tracks the read,write permission of a key
>> > IAMR register tracks the execute permission of a key
>> > UAMOR register enables and disables a key
>> >
>> > Signed-off-by: Ram Pai <linuxram@us.ibm.com>
>> > ---
>> >  arch/powerpc/include/asm/book3s/64/pgtable.h |   60 ++++++++++++++++++++++++++
>> >  1 files changed, 60 insertions(+), 0 deletions(-)
>> >
>> > diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
>> > index 85bc987..435d6a7 100644
>> > --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
>> > +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
>> > @@ -428,6 +428,66 @@ static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
>> >             pte_update(mm, addr, ptep, 0, _PAGE_PRIVILEGED, 1);
>> >  }
>> >
>> > +#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
>> > +
>> > +#include <asm/reg.h>
>> > +static inline u64 read_amr(void)
>> > +{
>> > +   return mfspr(SPRN_AMR);
>> > +}
>> > +static inline void write_amr(u64 value)
>> > +{
>> > +   mtspr(SPRN_AMR, value);
>> > +}
>> > +static inline u64 read_iamr(void)
>> > +{
>> > +   return mfspr(SPRN_IAMR);
>> > +}
>> > +static inline void write_iamr(u64 value)
>> > +{
>> > +   mtspr(SPRN_IAMR, value);
>> > +}
>> > +static inline u64 read_uamor(void)
>> > +{
>> > +   return mfspr(SPRN_UAMOR);
>> > +}
>> > +static inline void write_uamor(u64 value)
>> > +{
>> > +   mtspr(SPRN_UAMOR, value);
>> > +}
>> > +
>> > +#else /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
>> > +
>> > +static inline u64 read_amr(void)
>> > +{
>> > +   WARN(1, "%s called with MEMORY PROTECTION KEYS disabled\n", __func__);
>> > +   return -1;
>> > +}
>>
>> Why do we need to have a version here if we are going to WARN(), why not
>> let the compilation fail if called from outside of CONFIG_PPC64_MEMORY_PROTECTION_KEYS?
>> Is that the intention?
>
> I did not want to stop someone; kernel module for example, from calling
> these interfaces from outside the pkey domain.
>
> Either way can be argued to be correct, I suppose.

Nope, build failures are better than run time failures, otherwise the
kernel will split its guts warning and warning here.

Balbir Singh.

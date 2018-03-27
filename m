Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 409H6d75SmzF261
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Mar 2018 14:48:25 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Ram Pai <linuxram@us.ibm.com>, Balbir Singh <bsingharora@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>,
 "akpm\@linux-foundation.org" <akpm@linux-foundation.org>,
 "open list\:LINUX FOR POWERPC \(32-BIT AND 64-BIT\)"
 <linuxppc-dev@lists.ozlabs.org>, linux-mm <linux-mm@kvack.org>,
 "maintainer\:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
 linux-arch <linux-arch@vger.kernel.org>,
 "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Dave Hansen <dave.hansen@intel.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Aneesh Kumar KV <aneesh.kumar@linux.vnet.ibm.com>,
 "Haren Myneni\/Beaverton\/IBM" <hbabu@us.ibm.com>,
 Michal Hocko <mhocko@kernel.org>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 "Eric W. Biederman" <ebiederm@xmission.com>, Jonathan Corbet <corbet@lwn.net>,
 Arnd Bergmann <arnd@arndb.de>, fweimer@redhat.com, msuchanek@suse.com,
 Thomas Gleixner <tglx@linutronix.de>, Ulrich.Weigand@de.ibm.com,
 Ram Pai <ram.n.pai@gmail.com>
Subject: Re: [PATCH v4] mm, pkey: treat pkey-0 special
In-Reply-To: <20180316193152.GG1060@ram.oc3035372033.ibm.com>
References: <1521196416-18157-1-git-send-email-linuxram@us.ibm.com>
 <CAKTCnzmSCT+VecdSRpyY2Rb_AW2ngCi3UTZfLE3VOLNSQn6vsA@mail.gmail.com>
 <20180316193152.GG1060@ram.oc3035372033.ibm.com>
Date: Tue, 27 Mar 2018 14:48:21 +1100
Message-ID: <87o9jaji0q.fsf@concordia.ellerman.id.au>
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

> On Fri, Mar 16, 2018 at 10:02:22PM +1100, Balbir Singh wrote:
>> On Fri, Mar 16, 2018 at 9:33 PM, Ram Pai <linuxram@us.ibm.com> wrote:
>> > Applications need the ability to associate an address-range with some
>> > key and latter revert to its initial default key. Pkey-0 comes close to
>> > providing this function but falls short, because the current
>> > implementation disallows applications to explicitly associate pkey-0 to
>> > the address range.
>> >
>> > Clarify the semantics of pkey-0 and provide the corresponding
>> > implementation.
>> >
>> > Pkey-0 is special with the following semantics.
>> > (a) it is implicitly allocated and can never be freed. It always exists.
>> > (b) it is the default key assigned to any address-range.
>> > (c) it can be explicitly associated with any address-range.
>> >
>> > Tested on powerpc only. Could not test on x86.
>> 
>> Ram,
>> 
>> I was wondering if we should check the AMOR values on the ppc side to make sure
>> that pkey0 is indeed available for use as default. I am still of the
>> opinion that we
>
> AMOR cannot be read/written by the OS in priviledge-non-hypervisor-mode.
> We could try testing if key-0 is available to the OS by temproarily
> changing the bits key-0 bits of AMR or IAMR register. But will be
> dangeorous to do, for you might disable read,execute of all the pages,
> since all pages are asscoiated with key-0 bydefault.

No we should do what firmware tells us. If it says key 0 is available we
use it, otherwise we don't.

Now if you notice the way the firmware API (device tree property) is
defined, it tells us how many keys are available, counting from 0.

So for pkey 0 to be reserved there must be 0 keys available.

End of story.

cheers

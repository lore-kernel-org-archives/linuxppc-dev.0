Return-Path: <bsingharora@gmail.com>
Received: from mail-vk0-x244.google.com (mail-vk0-x244.google.com
 [IPv6:2607:f8b0:400c:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 409HkP63mjzF26t
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Mar 2018 15:15:57 +1100 (AEDT)
Received: by mail-vk0-x244.google.com with SMTP id n124so2531740vkd.6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Mar 2018 21:15:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87o9jaji0q.fsf@concordia.ellerman.id.au>
References: <1521196416-18157-1-git-send-email-linuxram@us.ibm.com>
 <CAKTCnzmSCT+VecdSRpyY2Rb_AW2ngCi3UTZfLE3VOLNSQn6vsA@mail.gmail.com>
 <20180316193152.GG1060@ram.oc3035372033.ibm.com>
 <87o9jaji0q.fsf@concordia.ellerman.id.au>
From: Balbir Singh <bsingharora@gmail.com>
Date: Tue, 27 Mar 2018 15:15:53 +1100
Message-ID: <CAKTCnzmhGqLZG+WVf+8MS4wYeY8PkiGS0G5NpCStGd4mi=w5pA@mail.gmail.com>
Subject: Re: [PATCH v4] mm, pkey: treat pkey-0 special
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Ram Pai <linuxram@us.ibm.com>, Ingo Molnar <mingo@redhat.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>, linux-mm <linux-mm@kvack.org>,
 "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
 linux-arch <linux-arch@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Dave Hansen <dave.hansen@intel.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Aneesh Kumar KV <aneesh.kumar@linux.vnet.ibm.com>,
 "Haren Myneni/Beaverton/IBM" <hbabu@us.ibm.com>,
 Michal Hocko <mhocko@kernel.org>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 Jonathan Corbet <corbet@lwn.net>, Arnd Bergmann <arnd@arndb.de>,
 fweimer@redhat.com, msuchanek@suse.com,
 Thomas Gleixner <tglx@linutronix.de>, Ulrich.Weigand@de.ibm.com,
 Ram Pai <ram.n.pai@gmail.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 27, 2018 at 2:48 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> Ram Pai <linuxram@us.ibm.com> writes:
>
>> On Fri, Mar 16, 2018 at 10:02:22PM +1100, Balbir Singh wrote:
>>> On Fri, Mar 16, 2018 at 9:33 PM, Ram Pai <linuxram@us.ibm.com> wrote:
>>> > Applications need the ability to associate an address-range with some
>>> > key and latter revert to its initial default key. Pkey-0 comes close to
>>> > providing this function but falls short, because the current
>>> > implementation disallows applications to explicitly associate pkey-0 to
>>> > the address range.
>>> >
>>> > Clarify the semantics of pkey-0 and provide the corresponding
>>> > implementation.
>>> >
>>> > Pkey-0 is special with the following semantics.
>>> > (a) it is implicitly allocated and can never be freed. It always exists.
>>> > (b) it is the default key assigned to any address-range.
>>> > (c) it can be explicitly associated with any address-range.
>>> >
>>> > Tested on powerpc only. Could not test on x86.
>>>
>>> Ram,
>>>
>>> I was wondering if we should check the AMOR values on the ppc side to make sure
>>> that pkey0 is indeed available for use as default. I am still of the
>>> opinion that we
>>
>> AMOR cannot be read/written by the OS in priviledge-non-hypervisor-mode.
>> We could try testing if key-0 is available to the OS by temproarily
>> changing the bits key-0 bits of AMR or IAMR register. But will be
>> dangeorous to do, for you might disable read,execute of all the pages,
>> since all pages are asscoiated with key-0 bydefault.
>
> No we should do what firmware tells us. If it says key 0 is available we
> use it, otherwise we don't.
>
> Now if you notice the way the firmware API (device tree property) is
> defined, it tells us how many keys are available, counting from 0.
>

I could not find counting from 0 anywhere, are we expected to look
at the AMOR and figure out what we have access to? Why do we
assume they'll be contiguous, it makes our life easy, but I really
could not find any documentation on it

> So for pkey 0 to be reserved there must be 0 keys available.
>
> End of story.
>
> cheers

Cheers,
Balbir Singh.

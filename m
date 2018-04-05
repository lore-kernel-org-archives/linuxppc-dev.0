Return-Path: <bsingharora@gmail.com>
Received: from mail-vk0-x242.google.com (mail-vk0-x242.google.com
 [IPv6:2607:f8b0:400c:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40H27b2fSyzF1l6
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Apr 2018 22:24:11 +1000 (AEST)
Received: by mail-vk0-x242.google.com with SMTP id b16so14328467vka.5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Apr 2018 05:24:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAOSf1CFy0im+H368Krr2QVteAumq58CRF_Kfatyv7wvj1n4AGw@mail.gmail.com>
References: <20180405071500.22320-1-bsingharora@gmail.com>
 <20180405071500.22320-3-bsingharora@gmail.com>
 <CAOSf1CFy0im+H368Krr2QVteAumq58CRF_Kfatyv7wvj1n4AGw@mail.gmail.com>
From: Balbir Singh <bsingharora@gmail.com>
Date: Thu, 5 Apr 2018 22:24:07 +1000
Message-ID: <CAKTCnzngahex_sL2raoHFuXqTxgVV7a57R9YmcT1TN-ROsFXnw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] powerpc/memcpy: Add memcpy_mcsafe for pmem
To: Oliver <oohall@gmail.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
 Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 5, 2018 at 9:26 PM, Oliver <oohall@gmail.com> wrote:
> On Thu, Apr 5, 2018 at 5:14 PM, Balbir Singh <bsingharora@gmail.com> wrote:
>> The pmem infrastructure uses memcpy_mcsafe in the pmem
>> layer so as to convert machine check excpetions into
>> a return value on failure in case a machine check
>> exception is encoutered during the memcpy.
>>
>
> Would it be possible to move the bulk of the copyuser code into a
> seperate file which can be #included once the these err macros are
> defined? Anton's memcpy is pretty hairy and I don't think anyone wants
> to have multiple copies of it in the tree, even in a cut down form.
>

I've split it out for now, in the future that might be a good thing to do.
The copy_tofrom_user_power7 falls backs on __copy_tofrom_user_base
to track exactly how much is left over. Adding these changes there would
create a larger churn and need way more testing. I've taken this short-cut
for now with a promise to fix that as the semantics of memcpy_mcsafe()
change to do more accurate tracking of how much was copied over.

Balbir Singh.

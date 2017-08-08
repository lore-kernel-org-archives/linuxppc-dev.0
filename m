Return-Path: <robh@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xRd8q4209zDqkp
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Aug 2017 01:09:15 +1000 (AEST)
Received: from mail-qt0-f180.google.com (mail-qt0-f180.google.com
 [209.85.216.180])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9C7B322DA6
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Aug 2017 15:09:13 +0000 (UTC)
Received: by mail-qt0-f180.google.com with SMTP id v29so21193256qtv.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Aug 2017 08:09:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87mv7aol41.fsf@concordia.ellerman.id.au>
References: <20170725214427.25768-1-robh@kernel.org>
 <CAL_Jsq+tarBMM-frN+V9GYa-ZAzfJO4sv2owdOS3Ks+urned1g@mail.gmail.com>
 <87mv7aol41.fsf@concordia.ellerman.id.au>
From: Rob Herring <robh@kernel.org>
Date: Tue, 8 Aug 2017 10:08:52 -0500
Message-ID: <CAL_Jsq+-GuQKgM5uWpBDW8cwcT6_3x5ksYY1qMY1MLvSvP-vPg@mail.gmail.com>
Subject: Re: [PATCH 0/4] Removing full paths from DT full_name
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Frank Rowand <frowand.list@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 7, 2017 at 9:21 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> Rob Herring <robh@kernel.org> writes:
>
>> On Tue, Jul 25, 2017 at 4:44 PM, Rob Herring <robh@kernel.org> wrote:
>>> This series is the last steps to remove storing the full path for every
>>> DT node. Instead, we can create full path strings dynamically as needed
>>> with printf %pOF specifiers (commit ce4fecf1fe15). There are a number of
>>> remaining direct users of full_name after this series. I don't believe
>>> there should be any functional impact for those users with the change to
>>> only the node name (+unit-address). The majority are for struct
>>> resource.name. This should only affect /proc/iomem display.
>>>
>>> Patches 1 and 2 can be applied now for 4.14. For patches 3 and 4, my
>>> target is 4.15 after all the dependencies have been merged.
>>>
>>> PPC folks, Please test! The PPC parts are untested. A git branch with
>>> all the dependencies is here[1].
>>
>> PPC folks, any chance to test this?
>
> I got stuck on your %pOF conversion, which broke the vio.c code, because of:
>
> -               if (!strcmp(parent_node->full_name, "/ibm,platform-facilities"))
> +               if (!strcmp(parent_node->full_name, "ibm,platform-facilities"))
>
> But full_name hasn't been changed yet.

Ah, those lines need to be dropped from the %pOF conversion. I'll send
a new version.

What I was originally considering here was just:

strcmp(kbasename(parent_node->full_name), "ibm,platform-facilities")

That would work for "/foo/ibm,platform-facilities" too, but IMO
validation of the DT is not the kernel's job (if it is, we're doing a
horrible job). But in the end here, I decided to keep the existing
full path matching as patch 1 does.

> But patch 1 here should fix that, so I'll pull it all together and try
> and get it tested.

Thanks.

Rob

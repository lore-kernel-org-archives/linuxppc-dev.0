Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xRJ6k3SSSzDqkp
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Aug 2017 12:21:18 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Rob Herring <robh@kernel.org>,
 "devicetree\@vger.kernel.org" <devicetree@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Frank Rowand <frowand.list@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 0/4] Removing full paths from DT full_name
In-Reply-To: <CAL_Jsq+tarBMM-frN+V9GYa-ZAzfJO4sv2owdOS3Ks+urned1g@mail.gmail.com>
References: <20170725214427.25768-1-robh@kernel.org>
 <CAL_Jsq+tarBMM-frN+V9GYa-ZAzfJO4sv2owdOS3Ks+urned1g@mail.gmail.com>
Date: Tue, 08 Aug 2017 12:21:18 +1000
Message-ID: <87mv7aol41.fsf@concordia.ellerman.id.au>
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

Rob Herring <robh@kernel.org> writes:

> On Tue, Jul 25, 2017 at 4:44 PM, Rob Herring <robh@kernel.org> wrote:
>> This series is the last steps to remove storing the full path for every
>> DT node. Instead, we can create full path strings dynamically as needed
>> with printf %pOF specifiers (commit ce4fecf1fe15). There are a number of
>> remaining direct users of full_name after this series. I don't believe
>> there should be any functional impact for those users with the change to
>> only the node name (+unit-address). The majority are for struct
>> resource.name. This should only affect /proc/iomem display.
>>
>> Patches 1 and 2 can be applied now for 4.14. For patches 3 and 4, my
>> target is 4.15 after all the dependencies have been merged.
>>
>> PPC folks, Please test! The PPC parts are untested. A git branch with
>> all the dependencies is here[1].
>
> PPC folks, any chance to test this?

I got stuck on your %pOF conversion, which broke the vio.c code, because of:

-		if (!strcmp(parent_node->full_name, "/ibm,platform-facilities"))
+		if (!strcmp(parent_node->full_name, "ibm,platform-facilities"))

But full_name hasn't been changed yet.

But patch 1 here should fix that, so I'll pull it all together and try
and get it tested.

cheers

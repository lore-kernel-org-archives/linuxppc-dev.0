Return-Path: <robh@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xHcy81d3rzDqnD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jul 2017 00:32:16 +1000 (AEST)
Received: from mail-yw0-f173.google.com (mail-yw0-f173.google.com
 [209.85.161.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4485822CB3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jul 2017 14:32:14 +0000 (UTC)
Received: by mail-yw0-f173.google.com with SMTP id u207so27244834ywc.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jul 2017 07:32:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5978A534.5030008@gmail.com>
References: <20170725214427.25768-1-robh@kernel.org>
 <5978A534.5030008@gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 26 Jul 2017 09:31:52 -0500
Message-ID: <CAL_JsqLOT3U2jFAyyJ0H0H0dOEpfdQLi_z+CLXnUkEGvUer8ew@mail.gmail.com>
Subject: Re: [PATCH 0/4] Removing full paths from DT full_name
To: Frank Rowand <frowand.list@gmail.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 26, 2017 at 9:20 AM, Frank Rowand <frowand.list@gmail.com> wrote:
> Hi Rob,
>
> On 07/25/17 14:44, Rob Herring wrote:
>> This series is the last steps to remove storing the full path for every
>> DT node. Instead, we can create full path strings dynamically as needed
>> with printf %pOF specifiers (commit ce4fecf1fe15). There are a number of
>> remaining direct users of full_name after this series. I don't believe
>> there should be any functional impact for those users with the change to
>> only the node name (+unit-address). The majority are for struct
>> resource.name. This should only affect /proc/iomem display.
>
> I added a new dependency on full_name in:
>
>   [PATCH v4 3/3] of: overlay: add overlay symbols to live device tree
>
> You don't need to fix that -- I knew the removal of full_name was coming
> and expected to adapt to that change when it came, so I'll take care of
> it.  It will probably take me two or three weeks to get to it, but that
> shouldn't be a big deal since the affected code is a new feature that
> is not yet used.

Indeed, I had fixed up the print statements, but missed that. Thanks
for the heads up.

Rob

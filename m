Return-Path: <robh@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xHd0x264pzDqnD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jul 2017 00:34:41 +1000 (AEST)
Received: from mail-yw0-f169.google.com (mail-yw0-f169.google.com
 [209.85.161.169])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4B08C22BD1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jul 2017 14:34:39 +0000 (UTC)
Received: by mail-yw0-f169.google.com with SMTP id x125so88709740ywa.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jul 2017 07:34:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DD00419B2@AcuExch.aculab.com>
References: <20170725214427.25768-1-robh@kernel.org>
 <20170725214427.25768-4-robh@kernel.org>
 <063D6719AE5E284EB5DD2968C1650D6DD00419B2@AcuExch.aculab.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 26 Jul 2017 09:34:17 -0500
Message-ID: <CAL_JsqK6ioLTv+hgb7kZS2ySnDuM_FuOCUGBhtCG8hT607Js_Q@mail.gmail.com>
Subject: Re: [PATCH 3/4] powerpc: pseries: only store the device node basename
 in full_name
To: David Laight <David.Laight@aculab.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Frank Rowand <frowand.list@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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

On Wed, Jul 26, 2017 at 5:07 AM, David Laight <David.Laight@aculab.com> wrote:
> From: Rob Herring
>> Sent: 25 July 2017 22:44
>> With dependencies on full_name containing the entire device node path
>> removed, stop storing the full_name in nodes created by
>> dlpar_configure_connector() and pSeries_reconfig_add_node().
> ...
>>       dn = kzalloc(sizeof(*dn), GFP_KERNEL);
>>       if (!dn)
>>               return NULL;
>>
>>       name = (char *)ccwa + be32_to_cpu(ccwa->name_offset);
>> -     dn->full_name = kasprintf(GFP_KERNEL, "%s/%s", path, name);
>> +     dn->full_name = kasprintf(GFP_KERNEL, "%s", name);
>
> Isn't this just strdup()?

Yes, it can be simplified to that now.

> Perhaps you should rename full_name to name - since it is no longer 'full'?

Ideally, yes. However, we still have users in other places tree wide
(which should still work with the change) and I don't think it is
worth the additional churn. Also, we already have "name" as that is
the node name without the unit-address. I'd like to get rid of that,
but name is special in that it is exposed as a property too. Finally,
full_name is still the full path on Sparc.

> Maybe you could do a single malloc() for both 'dn' and the name?

Sure.

Rob

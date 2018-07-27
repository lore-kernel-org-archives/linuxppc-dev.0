Return-Path: <srs0=naab=kl=kernel.org=robh+dt@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41cbBn1TsPzF0h9
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Jul 2018 03:13:05 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 41cbBm73btz8sww
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Jul 2018 03:13:04 +1000 (AEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 41cbBm42Nvz9s0w
 for <linuxppc-dev@ozlabs.org>; Sat, 28 Jul 2018 03:13:04 +1000 (AEST)
Received: from mail-qt0-f170.google.com (mail-qt0-f170.google.com
 [209.85.216.170])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id F0C03208B6
 for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2018 17:13:01 +0000 (UTC)
Received: by mail-qt0-f170.google.com with SMTP id m13-v6so5778879qth.1
 for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2018 10:13:01 -0700 (PDT)
MIME-Version: 1.0
References: <20180727053555.26596-1-mpe@ellerman.id.au>
In-Reply-To: <20180727053555.26596-1-mpe@ellerman.id.au>
From: Rob Herring <robh+dt@kernel.org>
Date: Fri, 27 Jul 2018 11:12:50 -0600
Message-ID: <CAL_JsqK4GEPJSPg+sStvFyO=sQ0Fp49FKKTz0S9OGc1COOnp-g@mail.gmail.com>
Subject: Re: [PATCH] of/fdt: Remove PPC32 longtrail hack in memory scan
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev <linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 26, 2018 at 11:36 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> When the OF code was originally made common by Grant in commit
> 51975db0b733 ("of/flattree: merge early_init_dt_scan_memory() common
> code") (Feb 2010), the common code inherited a hack to handle
> PPC "longtrail" machines, which had a "memory@0" node with no
> device_type.
>
> That check was then made to only apply to PPC32 in b44aa25d20e2 ("of:
> Handle memory@0 node on PPC32 only") (May 2014).
>
> But according to Paul Mackerras the "longtrail" machines are long
> dead, if they were ever seen in the wild at all. If someone does still
> have one, we can handle this firmware wart in powerpc platform code.
>
> So remove the hack once and for all.

Yay. I guess Power Macs and other quirks will never die...

I'll queue this up.

Rob

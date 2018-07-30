Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41fGTy4YmLzF0gv
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jul 2018 20:47:02 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] of/fdt: Remove PPC32 longtrail hack in memory scan
In-Reply-To: <CAL_JsqK4GEPJSPg+sStvFyO=sQ0Fp49FKKTz0S9OGc1COOnp-g@mail.gmail.com>
References: <20180727053555.26596-1-mpe@ellerman.id.au>
 <CAL_JsqK4GEPJSPg+sStvFyO=sQ0Fp49FKKTz0S9OGc1COOnp-g@mail.gmail.com>
Date: Mon, 30 Jul 2018 20:47:01 +1000
Message-ID: <87in4xhufu.fsf@concordia.ellerman.id.au>
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

Rob Herring <robh+dt@kernel.org> writes:
> On Thu, Jul 26, 2018 at 11:36 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>> When the OF code was originally made common by Grant in commit
>> 51975db0b733 ("of/flattree: merge early_init_dt_scan_memory() common
>> code") (Feb 2010), the common code inherited a hack to handle
>> PPC "longtrail" machines, which had a "memory@0" node with no
>> device_type.
>>
>> That check was then made to only apply to PPC32 in b44aa25d20e2 ("of:
>> Handle memory@0 node on PPC32 only") (May 2014).
>>
>> But according to Paul Mackerras the "longtrail" machines are long
>> dead, if they were ever seen in the wild at all. If someone does still
>> have one, we can handle this firmware wart in powerpc platform code.
>>
>> So remove the hack once and for all.
>
> Yay. I guess Power Macs and other quirks will never die...

Not soon.

In base.c I see:
 - the hack in arch_find_n_match_cpu_physical_id()
   - we should just move that into arch code, it's a __weak arch hook
     after all.
 - a PPC hack in of_alias_scan(), I guess we need to retain that
   behaviour, but it's pretty minor anyway.

In address.c there's the powermac empty ranges hack. Seems like we could
fix that just by creating empty `ranges` properties in fixup_device_tree().
I don't think we support booting powermacs other than via prom_init(). (Ben?)

> I'll queue this up.

cheers

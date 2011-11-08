Return-Path: <r58472@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 3D5F61007D5
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Nov 2011 21:56:32 +1100 (EST)
Received: from mail20-ch1 (localhost.localdomain [127.0.0.1])	by
 mail20-ch1-R.bigfish.com (Postfix) with ESMTP id 3929B17782AF	for
 <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Nov 2011 10:56:10 +0000 (UTC)
Received: from CH1EHSMHS017.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.253])	by mail20-ch1.bigfish.com (Postfix) with ESMTP id
 F3E72C10055
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Nov 2011 10:56:09 +0000 (UTC)
From: Li Yang-R58472 <r58472@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>, Zhao Chenhui-B35336
 <B35336@freescale.com>
Subject: RE: [PATCH 5/7] fsl_pmc: update device bindings
Date: Tue, 8 Nov 2011 10:56:18 +0000
Message-ID: <3F607A5180246847A760FD34122A1E052BC964@039-SN1MPN1-004.039d.mgd.msft.net>
References: <1320410207-14537-1-git-send-email-chenhui.zhao@freescale.com>
 <4EB4456F.9020005@freescale.com>
In-Reply-To: <4EB4456F.9020005@freescale.com>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



>-----Original Message-----
>From: linuxppc-dev-bounces+leoli=3Dfreescale.com@lists.ozlabs.org
>[mailto:linuxppc-dev-bounces+leoli=3Dfreescale.com@lists.ozlabs.org] On
>Behalf Of Scott Wood
>Sent: Saturday, November 05, 2011 4:05 AM
>To: Zhao Chenhui-B35336
>Cc: linuxppc-dev@lists.ozlabs.org
>Subject: Re: [PATCH 5/7] fsl_pmc: update device bindings
>
>On 11/04/2011 07:36 AM, Zhao Chenhui wrote:
>> From: Li Yang <leoli@freescale.com>
>>
>> Signed-off-by: Li Yang <leoli@freescale.com>
>> ---
>>  .../devicetree/bindings/powerpc/fsl/pmc.txt        |   63 +++++++++++--
>------
>>  1 files changed, 36 insertions(+), 27 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/powerpc/fsl/pmc.txt
>b/Documentation/devicetree/bindings/powerpc/fsl/pmc.txt
>> index 07256b7..d84b4f8 100644
>> --- a/Documentation/devicetree/bindings/powerpc/fsl/pmc.txt
>> +++ b/Documentation/devicetree/bindings/powerpc/fsl/pmc.txt
>> @@ -9,22 +9,27 @@ Properties:
>>
>>    "fsl,mpc8548-pmc" should be listed for any chip whose PMC is
>>    compatible.  "fsl,mpc8536-pmc" should also be listed for any chip
>> -  whose PMC is compatible, and implies deep-sleep capability.
>> +  whose PMC is compatible, and implies deep-sleep capability and
>> +  wake on user defined packet(wakeup on ARP).
>
>Why does the PMC care?  This is an ethernet controller feature, the PMC
>is just keeping the wakeup-relevant parts of the ethernet controller
>alive (whatever they happen to be).
>
>Do we have any chips that have ethernet controller support for wake on
>user-defined packet, but a sleep mode that doesn't let it be used?

I think it is more a PMC feature cause Ethernet controller on many SoCs hav=
e the filer feature, but only very limited SoCs can support using it as a w=
ake-up source.  The differences should be mostly in the PM controller block=
.

Also the wake on user-defined packet feature was never mentioned in the Eth=
ernet controller part of UM.

>
>BTW, please remove fsl,mpc8536-pmc from the p1023rds device tree -- it
>was wrong before (no deep sleep, though it does appear to have jog
>mode...), and is even more wrong with this provision (it has a different
>ethernet controller).
>
>> +  "fsl,p1022-pmc" should be listed for any chip whose PMC is
>> +  compatible, and implies lossless Ethernet capability during sleep.
>>
>>    "fsl,mpc8641d-pmc" should be listed for any chip whose PMC is
>>    compatible; all statements below that apply to "fsl,mpc8548-pmc" also
>>    apply to "fsl,mpc8641d-pmc".
>>
>>    Compatibility does not include bit assignments in SCCR/PMCDR/DEVDISR;
>these
>> -  bit assignments are indicated via the sleep specifier in each
>device's
>> -  sleep property.
>> +  bit assignments are indicated via the clock nodes.  Device which has
>a
>> +  controllable clock source should have a "clk-handle" property
>pointing
>> +  to the clock node.
>
>Do we have any code to use this?

Yes, in another patch in the series.

>
>Normally that shouldn't matter, but we already an unused binding for
>this. :-)
>
>Please provide rationale for doing it this way.  Ideally it should
>probably use whatever http://devicetree.org/ClockBindings ends up being.

I have looked into that binding.  The binding was primarily defined for the=
 Linux clock API which is not same as what we are doing here(set wakeup sou=
rce).  If in the future the clock API also covers wakeup related features, =
we can change to use it.

- Leo

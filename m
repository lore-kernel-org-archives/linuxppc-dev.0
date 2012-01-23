Return-Path: <B07421@freescale.com>
Received: from AM1EHSOBE002.bigfish.com (am1ehsobe002.messaging.microsoft.com
 [213.199.154.205])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3F588B6FAB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jan 2012 06:31:44 +1100 (EST)
Message-ID: <4F1DB597.7030506@freescale.com>
Date: Mon, 23 Jan 2012 13:31:35 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/booke64: Configurable lazy interrupt disabling
References: <1326897306-3924-1-git-send-email-Laurentiu.Tudor@freescale.com>
 <1326921026.26116.34.camel@pasglop>
 <CALRxmdC_E4Z==4R_2MGHAi3T7mdF9oHx3rBE6Meb+3R1gWF5VQ@mail.gmail.com>
 <1327100531.2923.3.camel@pasglop>
In-Reply-To: <1327100531.2923.3.camel@pasglop>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Laurentiu Tudor <Laurentiu.Tudor@freescale.com>,
 linuxppc-dev@lists.ozlabs.org, Stuart Yoder <b08248@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/20/2012 05:02 PM, Benjamin Herrenschmidt wrote:
> 
>> With Topaz, interrupts go directly to guests and we don't want to require a
>> trap/hcall to do an IACK, as that adds potentially thousands of cycles of
>> latency to every interrupt.
>>
>> As you know, with external proxy interrupts are acknowledged by the
>> hardware and it becomes problematic to replay the interrupt in
>> the context of lazy EE when interrupts are re-enabled.   The interrupt
>> will not fire again when you enable EE.
> 
> So you have a broken HW and broken HV design to start with ... :-)

That "breakage" significantly reduces the overhead of handling
interrupts in a guest, since we don't need to involve the hypervisor (at
least on the entry side -- there's a hack to avoid it on EOI as well,
though that involves exposing some MPIC registers directly; users can
decide whether it's worth enabling for their use case).

-Scott

Return-Path: <b08248@gmail.com>
Received: from mail-qw0-f51.google.com (mail-qw0-f51.google.com
 [209.85.216.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BEB6F1007D3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jan 2012 06:22:00 +1100 (EST)
Received: by qadz32 with SMTP id z32so278737qad.17
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jan 2012 11:21:57 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1326921026.26116.34.camel@pasglop>
References: <1326897306-3924-1-git-send-email-Laurentiu.Tudor@freescale.com>
 <1326921026.26116.34.camel@pasglop>
Date: Thu, 19 Jan 2012 13:21:57 -0600
Message-ID: <CALRxmdC_E4Z==4R_2MGHAi3T7mdF9oHx3rBE6Meb+3R1gWF5VQ@mail.gmail.com>
Subject: Re: [PATCH] powerpc/booke64: Configurable lazy interrupt disabling
From: Stuart Yoder <b08248@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Laurentiu Tudor <Laurentiu.Tudor@freescale.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jan 18, 2012 at 3:10 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Wed, 2012-01-18 at 16:35 +0200, Laurentiu Tudor wrote:
>> This patch adds a menuconfig option that allows controlling
>> the lazy interrupt disabling feature implemented by this
>> commit:
>>
>> commit d04c56f73c30a5e593202ecfcf25ed43d42363a2
>> Author: Paul Mackerras
>> Date: =A0 Wed Oct 4 16:47:49 2006 +1000
>>
>> =A0 =A0 [POWERPC] Lazy interrupt disabling for 64-bit machines
>>
>> The code in 'powerpc/include/asm/hw_irq.h' was rearranged and
>> cleaned-up a bit in order to reduce the number of needed #ifdef's.
>
> It's still nasty. Do you have numbers showing that it's worth disabling
> on BookE ?

It's not just about bare metal performance-- some platforms such as
the Freescale
Topaz hypervisor don't provide legacy IACK type interrupt
acknowledgment, and expect
the guest to support the external proxy mechanism.

With Topaz, interrupts go directly to guests and we don't want to require a
trap/hcall to do an IACK, as that adds potentially thousands of cycles of
latency to every interrupt.

As you know, with external proxy interrupts are acknowledged by the
hardware and it becomes problematic to replay the interrupt in
the context of lazy EE when interrupts are re-enabled.   The interrupt
will not fire again when you enable EE.

That is currently the issue, as we can't run the 64-bit kernel on Topaz.
Our option are:
  1) to provide an option to disable lazy EE
  2) do some kind of hack to replay interrupts with lazy EE
  3) change Topaz to support legacy IACK, but this gets ugly for
      various reasons.

Providing a config option to disable lazy EE seemed to be a good
approach.

Stuart

Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id CE8B11007D3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Jan 2012 10:02:40 +1100 (EST)
Message-ID: <1327100531.2923.3.camel@pasglop>
Subject: Re: [PATCH] powerpc/booke64: Configurable lazy interrupt disabling
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stuart Yoder <b08248@gmail.com>
Date: Sat, 21 Jan 2012 10:02:11 +1100
In-Reply-To: <CALRxmdC_E4Z==4R_2MGHAi3T7mdF9oHx3rBE6Meb+3R1gWF5VQ@mail.gmail.com>
References: <1326897306-3924-1-git-send-email-Laurentiu.Tudor@freescale.com>
 <1326921026.26116.34.camel@pasglop>
 <CALRxmdC_E4Z==4R_2MGHAi3T7mdF9oHx3rBE6Meb+3R1gWF5VQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
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


> With Topaz, interrupts go directly to guests and we don't want to require a
> trap/hcall to do an IACK, as that adds potentially thousands of cycles of
> latency to every interrupt.
> 
> As you know, with external proxy interrupts are acknowledged by the
> hardware and it becomes problematic to replay the interrupt in
> the context of lazy EE when interrupts are re-enabled.   The interrupt
> will not fire again when you enable EE.

So you have a broken HW and broken HV design to start with ... :-)

> That is currently the issue, as we can't run the 64-bit kernel on Topaz.
> Our option are:
>   1) to provide an option to disable lazy EE
>   2) do some kind of hack to replay interrupts with lazy EE
>   3) change Topaz to support legacy IACK, but this gets ugly for
>       various reasons.
> 
> Providing a config option to disable lazy EE seemed to be a good
> approach.

A config option is bad because it gets us yet another step toward
non-generic kernels.

Why don't you look into what would be needed to do a replay ? There are
many ways to achieve this, using the DEC is one that wouldn't involve
the hypervisor for example. But the case of an interrupt occurring while
masked is actually pretty low key so the overhead of an hcall at that
point wouldn't be too bad I beleive, so you could also implement some
kind of retry hcall which can internally be implemented using a guest
doorbell or something similar.

Cheers,
Ben.

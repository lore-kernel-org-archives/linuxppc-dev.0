Return-Path: <B07421@freescale.com>
Received: from VA3EHSOBE002.bigfish.com (va3ehsobe002.messaging.microsoft.com
 [216.32.180.12]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id AA6961007DF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2011 07:32:38 +1100 (EST)
Message-ID: <4ED3EFD9.9010200@freescale.com>
Date: Mon, 28 Nov 2011 14:32:25 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@gmail.com>
Subject: Re: [PATCH] powerpc: Decode correct MSR bits in oops output
References: <20111125163557.5a464006@kryten>
 <F744714B-0527-415C-92BE-A5CB678F1C29@kernel.crashing.org>
 <CA+5PVA4kkeuWqdKWAJOJSUue=XsEC=27T2zptb-1P_H+HwNymg@mail.gmail.com>
 <4ED3E168.5000002@freescale.com>
 <CA+5PVA4gxb-oHwFhZ_GrTjhD2URvjS3R7Sk-xZcCwKg77Meo_g@mail.gmail.com>
 <4ED3E951.8000005@freescale.com>
 <CA+5PVA75TKyScsPfHXXPaHC3mobPRJ0_w48HGRJ1j_-7ktP3iA@mail.gmail.com>
In-Reply-To: <CA+5PVA75TKyScsPfHXXPaHC3mobPRJ0_w48HGRJ1j_-7ktP3iA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/28/2011 02:12 PM, Josh Boyer wrote:
> On Mon, Nov 28, 2011 at 3:04 PM, Scott Wood <scottwood@freescale.com> wrote:
>> On 11/28/2011 01:46 PM, Josh Boyer wrote:
>>> Could introduce BOOK3E_32 to cover cases like this.
>>
>> Why _32?  These bits apply to 64-bit as well.  MSR_CM is only for 64-bit.
> 
> Because CONFIG_BOOK3E depeonds on PPC_BOOK3E_64.  So either that
> dependency needs to go so it's selectable elsewhere, or a similarly
> intended PPC_BOOK3E_32 needs to get created.  Or something.

I think that dependency should go, in any case.  We already have
PPC_BOOK3E_64 for places that need to depend on that, and we don't want
to end up having this all over the place:

#if defined(CONFIG_PPC_BOOK3E_32) || defined(CONFIG_PPC_BOOK3E_64)

>> UCLE and PMM are present on pre-2.06 e500 cores as well.
> 
> Sigh.  Maybe there is no way to get un-ugly.

If we drop the 64-bit dependency, we could do this for UCLE if it really
needs to be omitted from a 4xx kernel:

#if defined(CONFIG_PPC_BOOK3E) || defined(CONFIG_E500)

PMM is not just a BookE thing, so if 4xx really needs to exclude it,
#ifndef CONFIG_4xx is the way to go.

I wouldn't bother unless 4xx is known to set these bits, though.

For GS and CM CONFIG_PPC_BOOK3E is OK, once 32-bit e500mc/e5500 kernels
start selecting it.

-Scott

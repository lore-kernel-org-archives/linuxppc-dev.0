Return-Path: <B07421@freescale.com>
Received: from DB3EHSOBE003.bigfish.com (db3ehsobe003.messaging.microsoft.com
 [213.199.154.141])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 7DC891007D1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2011 07:04:46 +1100 (EST)
Message-ID: <4ED3E951.8000005@freescale.com>
Date: Mon, 28 Nov 2011 14:04:33 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@gmail.com>
Subject: Re: [PATCH] powerpc: Decode correct MSR bits in oops output
References: <20111125163557.5a464006@kryten>
 <F744714B-0527-415C-92BE-A5CB678F1C29@kernel.crashing.org>
 <CA+5PVA4kkeuWqdKWAJOJSUue=XsEC=27T2zptb-1P_H+HwNymg@mail.gmail.com>
 <4ED3E168.5000002@freescale.com>
 <CA+5PVA4gxb-oHwFhZ_GrTjhD2URvjS3R7Sk-xZcCwKg77Meo_g@mail.gmail.com>
In-Reply-To: <CA+5PVA4gxb-oHwFhZ_GrTjhD2URvjS3R7Sk-xZcCwKg77Meo_g@mail.gmail.com>
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

On 11/28/2011 01:46 PM, Josh Boyer wrote:
> On Mon, Nov 28, 2011 at 2:30 PM, Scott Wood <scottwood@freescale.com> wrote:
>> On 11/28/2011 10:23 AM, Josh Boyer wrote:
>>> On Mon, Nov 28, 2011 at 11:04 AM, Kumar Gala <galak@kernel.crashing.org> wrote:
>>>>
>>>> Since you're fixing this can you add the following for CONFIG_BOOKE:
>>>>
>>>> MSR_GS, MSR_UCLE, MSR_PMM, MSR_CM

PMM is not just BookE, and is already present in the patch.

RI is present on e500mc (despite being reserved in book3e), so might not
want to stick that inside #ifndef CONFIG_BOOKE.

>> Not all bits are going to exist on all CPUs -- does 4xx use these bits
>> to mean something different?
> 
> No, marked as reserved.  However, given the patch shows up in human
> readable output, I don't think we want reserved bits being decoded and
> showing up inadvertently.

Do the bits ever actually get set on 4xx (documented or otherwise), or
is this a theoretical concern?

If 4xx must be excluded, use something like:
#if defined(CONFIG_BOOKE) && !defined(CONFIG_4xx)

Do we also need to patch out things like MSR_VEC at runtime, in case it
randomly shows up on a pre-Altivec CPU?

> Could introduce BOOK3E_32 to cover cases like this.

Why _32?  These bits apply to 64-bit as well.  MSR_CM is only for 64-bit.

UCLE and PMM are present on pre-2.06 e500 cores as well.

-Scott

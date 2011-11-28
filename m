Return-Path: <jwboyer@gmail.com>
Received: from mail-vx0-f179.google.com (mail-vx0-f179.google.com
 [209.85.220.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 2BEECB6F70
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2011 06:47:01 +1100 (EST)
Received: by vcbfl15 with SMTP id fl15so5445539vcb.38
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2011 11:46:58 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4ED3E168.5000002@freescale.com>
References: <20111125163557.5a464006@kryten>
 <F744714B-0527-415C-92BE-A5CB678F1C29@kernel.crashing.org>
 <CA+5PVA4kkeuWqdKWAJOJSUue=XsEC=27T2zptb-1P_H+HwNymg@mail.gmail.com>
 <4ED3E168.5000002@freescale.com>
Date: Mon, 28 Nov 2011 14:46:58 -0500
Message-ID: <CA+5PVA4gxb-oHwFhZ_GrTjhD2URvjS3R7Sk-xZcCwKg77Meo_g@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Decode correct MSR bits in oops output
From: Josh Boyer <jwboyer@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 28, 2011 at 2:30 PM, Scott Wood <scottwood@freescale.com> wrote:
> On 11/28/2011 10:23 AM, Josh Boyer wrote:
>> On Mon, Nov 28, 2011 at 11:04 AM, Kumar Gala <galak@kernel.crashing.org> wrote:
>>>
>>> Since you're fixing this can you add the following for CONFIG_BOOKE:
>>>
>>> MSR_GS, MSR_UCLE, MSR_PMM, MSR_CM
>>
>> Those don't exist on 4xx, so CONFIG_BOOKE doesn't seem appropriate.
>
> They're defined by book3e of ISA 2.06.

4xx existed before that, sadly (as did CONFIG_BOOKE).

> Not all bits are going to exist on all CPUs -- does 4xx use these bits
> to mean something different?

No, marked as reserved.  However, given the patch shows up in human
readable output, I don't think we want reserved bits being decoded and
showing up inadvertently.

Could introduce BOOK3E_32 to cover cases like this.

josh

Return-Path: <B29882@freescale.com>
Received: from TX2EHSOBE006.bigfish.com (tx2ehsobe003.messaging.microsoft.com
 [65.55.88.13]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id D011F1007D6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Dec 2011 14:29:56 +1100 (EST)
From: McClintock Matthew-B29882 <B29882@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v2] powerpc/setup_{32, 64}.c: remove unneeded
 boot_cpuid{, _phys}
Date: Fri, 16 Dec 2011 03:29:43 +0000
Message-ID: <CAEsOVNcZPH_MJUdy0q7AjwomHTZhg2DoHSV+y9xatq-2SohC2A@mail.gmail.com>
References: <1322192477.32635.15.camel@pasglop>
 <1322540669-6834-1-git-send-email-msm@freescale.com>
 <1324005174.4875.0.camel@pasglop>
In-Reply-To: <1324005174.4875.0.camel@pasglop>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: Gala Kumar-B11780 <B11780@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Reply-To: McClintock Matthew-B29882 <B29882@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Dec 15, 2011 at 9:12 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Mon, 2011-11-28 at 22:24 -0600, Matthew McClintock wrote:
>> boot_cpuid and init_thread_info.cpu are redundant, just use the
>> var that stays around longer and add a define to make boot_cpuid
>> point at the correct value
>>
>> boot_cpudid_phys is not needed and can completly go away from the
>> SMP case, we leave it there for the non-SMP case since the paca
>> struct is not around to store this info
>>
>> This patch also has the effect of having the logical cpu number
>> of the boot cpu be updated correctly independently of the ordering
>> of the cpu nodes in the device tree.
>
> So what about head_fsl_booke.S comparing boot_cpuid to -1 ? That seems
> to be broken now in at least 2 ways, boot_cpuid doesn't exist anymore
> and you don't initialize it to -1 either...

This is 4/5 which is also waiting for your review.

http://lists.ozlabs.org/pipermail/linuxppc-dev/2011-October/093474.html

-M=

Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe006.messaging.microsoft.com [216.32.180.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8C1EC2C007E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Aug 2012 02:26:27 +1000 (EST)
Message-ID: <50180729.4070109@freescale.com>
Date: Tue, 31 Jul 2012 11:26:17 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/fsl: mpic timer driver
References: <1343370058-2983-1-git-send-email-Dongsheng.wang@freescale.com>
 <2F4F76E5-1ACD-4F30-A997-9811DCE82202@kernel.crashing.org>
 <ABB05CD9C9F68C46A5CEDC7F15439259DA4580@039-SN2MPN1-021.039d.mgd.msft.net>
 <267909D0-5FDC-4864-AA4B-189A651889A6@kernel.crashing.org>
In-Reply-To: <267909D0-5FDC-4864-AA4B-189A651889A6@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Cc: Wang Dongsheng-B40534 <B40534@freescale.com>,
 "paulus@samba.org" <paulus@samba.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Wood Scott-B07421 <B07421@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/31/2012 09:31 AM, Kumar Gala wrote:
> 
> On Jul 31, 2012, at 2:58 AM, Wang Dongsheng-B40534 wrote:
> 
>>
>>
>>> -----Original Message-----
>>> From: Kumar Gala [mailto:galak@kernel.crashing.org]
>>> Sent: Friday, July 27, 2012 9:14 PM
>>> To: Wang Dongsheng-B40534
>>> Cc: benh@kernel.crashing.org; paulus@samba.org; Wood Scott-B07421;
>>> linuxppc-dev@lists.ozlabs.org
>>> Subject: Re: [PATCH] powerpc/fsl: mpic timer driver
>>>
>>>
>>> On Jul 27, 2012, at 1:20 AM, <Dongsheng.wang@freescale.com>
>>> <Dongsheng.wang@freescale.com> wrote:
>>>
>>>> From: Wang Dongsheng <Dongsheng.Wang@freescale.com>
>>>>
>>>> Global timers A and B internal to the PIC. The two independent groups
>>>> of global timer, group A and group B, are identical in their
>>> functionality.
>>>> The hardware timer generates an interrupt on every timer cycle.
>>>> e.g
>>>> Power management can use the hardware timer to wake up the machine.
>>>>
>>>> Signed-off-by: Wang Dongsheng <Dongsheng.Wang@freescale.com>
>>>> Signed-off-by: Li Yang <leoli@freescale.com>
>>>
>>> How much of this is FSL specific vs openpic?  OpenPIC spec's timer
>>> support (only a single group).
>>>
>> [Wang Dongsheng] Yes, OpenPIC only a single group timer.
>> FSL: add more register, features and group.
>> This patch only to support FSL chip.
>> "mpic_timer.c" -> "fsl_mpic_timer.c"
>> I will modify the description of the patch. how about?
> 
> I'd rather we support both, can we not use the MPIC_FSL flag to deal with FSL specific behavior?

The device this driver binds against is "fsl,mpic-global-timer".  We
don't have a binding for ordinary OpenPIC timers, and inferring them
from the basic OpenPIC node will cause AMP headaches.

Let someone who cares about ordinary OpenPIC drivers add support. :-)

-Scott

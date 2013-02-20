Return-Path: <STFD002@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe001.messaging.microsoft.com [213.199.154.204])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 606852C007A
 for <linuxppc-dev@ozlabs.org>; Thu, 21 Feb 2013 01:31:35 +1100 (EST)
Message-ID: <5124DE3A.8040309@freescale.com>
Date: Wed, 20 Feb 2013 16:31:22 +0200
From: Diana Craciun <diana.craciun@freescale.com>
MIME-Version: 1.0
To: Stuart Yoder <b08248@gmail.com>
Subject: Re: [PATCH][RFC] Replaced tlbilx with tlbwe in the initialization code
References: <1360846595-3397-1-git-send-email-diana.craciun@freescale.com>
 <1360887119.22260.10.camel@pasglop> <511E513F.7090103@freescale.com>
 <1361303278.29654.7@snotra>
 <CALRxmdCpS6cJ6kJ=cg4Mre6YA572fxyk+596E1k1MX+iRL7s9Q@mail.gmail.com>
In-Reply-To: <CALRxmdCpS6cJ6kJ=cg4Mre6YA572fxyk+596E1k1MX+iRL7s9Q@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/20/2013 04:22 PM, Stuart Yoder wrote:
> On Tue, Feb 19, 2013 at 1:47 PM, Scott Wood <scottwood@freescale.com> wrote:
>> This patch addresses boot-time invalidations only.  How will you handle
>> hugetlb invalidations (or indirect entry invalidations, once that becomes
>> supported)?
> We do envision that "direct guest TLB management" is an opt-in option
> that a guest can enable.
>
> If LRAT is on, with TLB management directly handled by guests, the only
> mechanism we have to do TLB1 invalidates is tlbwe.   That is our only option
> as far as I know.   So, hugetlb and indirect entries will each need to be
> addressed separately.    The kernel code that handles these either needs
> to be A) modified to unconditionally do all invalidates by tlbwe or B)
> conditionally
> use tlbwe depending on whether this is a guest that has enabled direct
> TLB management.
>
> Stuart
>

In case of indirect entries I think we can configure tlbwe and tlbilx to 
go to the hypervisor. The guest should not mix tlbwe (for TLB0) and 
hardware page table walk, so we can support this scenario without 
modifying the guest.

Diana

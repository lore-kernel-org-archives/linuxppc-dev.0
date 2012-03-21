Return-Path: <B07421@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe004.messaging.microsoft.com [213.199.154.207])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B59CFB6FA8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2012 05:19:21 +1100 (EST)
Message-ID: <4F6A1B99.9030105@freescale.com>
Date: Wed, 21 Mar 2012 13:19:05 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 12/38] powerpc/booke: Provide exception macros with
 interrupt name
References: <1330474206-14794-1-git-send-email-agraf@suse.de>
 <1330474206-14794-13-git-send-email-agraf@suse.de>
 <29EC69C4-816F-4B9E-9834-71176D2DECB9@kernel.crashing.org>
In-Reply-To: <29EC69C4-816F-4B9E-9834-71176D2DECB9@kernel.crashing.org>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@lists.ozlabs.org, Alexander Graf <agraf@suse.de>,
 kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/21/2012 01:04 PM, Kumar Gala wrote:
> 
> On Feb 28, 2012, at 6:09 PM, Alexander Graf wrote:
> 
>> From: Scott Wood <scottwood@freescale.com>
>>
>> DO_KVM will need to identify the particular exception type.
>>
>> There is an existing set of arbitrary numbers that Linux passes,
>> but it's an undocumented mess that sort of corresponds to server/classic
>> exception vectors but not really.
> 
> So what do the new names correspond to?

The names are Linux-defined.  The values are IVOR numbers.

> What header is defining MACHINE_CHECK, BOOKE_INTERRUPT_EXTERNAL, etc
> (asm/kvm_asm.h)?

Yes, it's asm/kvm_asm.h at the moment.

It's actually BOOKE_INTERRUPT_MACHINE_CHECK, etc.  The exception macros
paste on BOOKE_INTERRUPT_ when they use it, to keep the macro users from
having to wrap lines even more often.

> If so we really should move these out of
> asm/kvm_asm.h and into something a bit more appropriate.

Yes, that was one of the things I had been planning to fix post-RFC.
Any preference what header it should be in?  asm/reg_booke.h seems to be
the least bad option of the existing headers -- or perhaps move
head_booke.h to arch/powerpc/include/asm.

Long-term it would also be nice for this to replace, rather than
supplement, the current numbers, though as Ben pointed out there are a
number of places throughout the code that will have to be fixed for that
to happen.

-Scott

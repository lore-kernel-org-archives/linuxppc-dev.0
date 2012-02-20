Return-Path: <B07421@freescale.com>
Received: from AM1EHSOBE004.bigfish.com (am1ehsobe001.messaging.microsoft.com
 [213.199.154.204])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 71166B6F9D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2012 04:19:11 +1100 (EST)
Message-ID: <4F428071.6000304@freescale.com>
Date: Mon, 20 Feb 2012 11:18:41 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 24/30] KVM: PPC: booke: call resched after every exit
References: <1329498837-11717-1-git-send-email-agraf@suse.de>
 <1329498837-11717-25-git-send-email-agraf@suse.de>
 <4F3EDC01.5000400@freescale.com>
 <4B831F36-4BEB-4BDF-869D-117617B4EE44@suse.de>
In-Reply-To: <4B831F36-4BEB-4BDF-869D-117617B4EE44@suse.de>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/20/2012 07:17 AM, Alexander Graf wrote:
> 
> On 18.02.2012, at 00:00, Scott Wood wrote:
> 
>> It would be simpler (both here and in the idle hcall) if we could just
>> drop support for CONFIG_PREEMPT=n. :-P
> 
> When running with CONFIG_PREEMPT=n we don't have to worry about interrupts being enabled though,

That's exactly when we *do* need to worry.  Interrupts can cause the
"need resched" condition to become true.

> since we only preempt on known good checkpoints, right?

Yes, and "entering the guest" is supposed to be one of those known good
checkpoints, similar to returning to userspace.  If we miss a reschedule
here, we're may not have another chance until the next timer interrupt.
 The code for returning to userspace is similarly structured.

-Scott

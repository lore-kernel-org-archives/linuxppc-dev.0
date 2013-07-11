Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1BB3E2C02CC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jul 2013 12:59:50 +1000 (EST)
Message-ID: <51DE1FD1.90609@windriver.com>
Date: Thu, 11 Jul 2013 11:00:33 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [v1][PATCH 1/1] KVM: PPC: disable preemption when using
 hard_irq_disable()
References: <1373436139-27998-1-git-send-email-tiejun.chen@windriver.com>
 <1373483740.8183.223@snotra>
In-Reply-To: <1373483740.8183.223@snotra>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, agraf@suse.de, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/11/2013 03:15 AM, Scott Wood wrote:
> On 07/10/2013 01:02:19 AM, Tiejun Chen wrote:
>> We should ensure the preemption cannot occur while calling get_paca()
>> insdide hard_irq_disable(), otherwise the paca_struct may be the
>> wrong one just after. And btw, we may update timing stats in this case.
>
> The soft-ee mechanism depends on accessing the PACA directly via r13 to avoid
> this.  We probably should be using inline asm to read was_enabled rather than

Yes.

> hoping the compiler doesn't do anything silly.

Do you recommend I should directly replace get_paca() with local_paca inside 
hard_irq_disable()?

#define hard_irq_disable()      do {                    \
         u8 _was_enabled = get_paca()->soft_enabled;     \

->	u8 _was_enabled = local_paca->soft_enabled;

But is this safe for all scenarios?

Tiejun

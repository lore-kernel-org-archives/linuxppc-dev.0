Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id 63D422C00CF
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 May 2013 04:18:43 +1000 (EST)
Subject: Re: [v2][KVM][PATCH 1/1] kvm:ppc: enable doorbell exception with
 CONFIG_PPC_DOORBELL
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1368209828.19683.5@snotra>
Date: Fri, 10 May 2013 20:18:41 +0200
Message-Id: <DAF71702-55A8-4932-8FB5-BAF720CFA6D5@suse.de>
References: <1367922232-22455-1-git-send-email-tiejun.chen@windriver.com>
 <39FBAAD3-4B13-4CA3-9E80-B73A266C1D3A@suse.de> <1368209828.19683.5@snotra>
To: Scott Wood <scottwood@freescale.com>
Cc: Tiejun Chen <tiejun.chen@windriver.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 10.05.2013, at 20:17, Scott Wood wrote:

> On 05/10/2013 01:14:27 PM, Alexander Graf wrote:
>> On 07.05.2013, at 12:23, Tiejun Chen wrote:
>> > CONFIG_PPC_DOORBELL is enough to cover all variants.
>> >
>> > Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
>> > ---
>> > arch/powerpc/kvm/booke.c |    2 +-
>> > 1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
>> > index 1020119..62d4ece 100644
>> > --- a/arch/powerpc/kvm/booke.c
>> > +++ b/arch/powerpc/kvm/booke.c
>> > @@ -795,7 +795,7 @@ static void kvmppc_restart_interrupt(struct =
kvm_vcpu *vcpu,
>> > 		kvmppc_fill_pt_regs(&regs);
>> > 		timer_interrupt(&regs);
>> > 		break;
>> > -#if defined(CONFIG_PPC_FSL_BOOK3E) || =
defined(CONFIG_PPC_BOOK3E_64)
>> > +#if defined(CONFIG_PPC_DOORBELL)
>> The same question still holds. How is this an improvement over the =
previous code? Does this fix any issues for you? Is this just a coding =
style cleanup?
>=20
> This is an improvement because CONFIG_PPC_DOORBELL is what controls =
whether the function that is called inside the ifdef exists.

Aha! Now that's a good reason. Tiejun, please adjust your patch =
description accordingly.


Alex

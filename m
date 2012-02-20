Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CE64CB6FA2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2012 02:42:51 +1100 (EST)
Subject: Re: [PATCH 16/30] KVM: PPC: e500mc: Add doorbell emulation support
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <20120220153910.GA19844@schlenkerla.am.freescale.net>
Date: Mon, 20 Feb 2012 16:42:46 +0100
Message-Id: <D7A1C620-32FA-4BB1-9383-89436D12827E@suse.de>
References: <1329498837-11717-1-git-send-email-agraf@suse.de>
 <1329498837-11717-17-git-send-email-agraf@suse.de>
 <4F3ECCE6.2010503@freescale.com>
 <6925C0C5-A8BD-4252-9B92-0612D52BBDDA@suse.de>
 <20120220153910.GA19844@schlenkerla.am.freescale.net>
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 20.02.2012, at 16:39, Scott Wood wrote:

> On Mon, Feb 20, 2012 at 12:49:46PM +0100, Alexander Graf wrote:
>>=20
>> On 17.02.2012, at 22:55, Scott Wood wrote:
>>=20
>>> On 02/17/2012 11:13 AM, Alexander Graf wrote:
>>>> 	case BOOKE_IRQPRIO_EXTERNAL:
>>>> +#ifdef CONFIG_KVM_E500MC
>>>> +	case BOOKE_IRQPRIO_DBELL:
>>>> +#endif
>>>=20
>>> This isn't e500mc specific -- it's in the ISA as "Embedded.Processor
>>> Control".
>>>=20
>>> Any harm in just removing the ifdef (similar to tlbilx)?
>>=20
>> Well, to me this is more of an indication "this should become a =
runtime
>> check one day" in case we want to combine the two targets.  On =
e500v2,
>> we don't know what a doorbell interrupt is, so we really shouldn't be
>> delivering one either.
>=20
> Should at least have a comment saying that eventually the decision =
should
> be based on ISA category support rather than e500mc.

Hrm. How about a new #define that is a bit more verbose?

#ifdef CONFIG_KVM_E500MC
#define KVM_CAT_DOORBELL
#endif

>=20
>>> Should this be a kvm_make_request instead (with a separate
>>> pending_doorbell bool in vcpu that msgclr can act on), considering
>>> earlier discussion of phasing out atomics on pending_exceptions, in
>>> favor of requests?
>>=20
>> Yeah, I was thinking about that too, but right now we already have =
some
>> direct use of pending_exceptions in different places around the code.=20=

>> So today, that is our public interface.
>>=20
>> I'd rather go in and clean up the whole thing to make
>> pending_exceptions private in a separate cleanup round, rather than
>> having it part of e500mc support.
>=20
> We already use requests for timers, and it seems simple enough to add =
one
> for doorbells now rather than come back and clean it up later (it's =
not
> tied to what we'd have to do for external IRQs), but if you'd rather =
do
> it later that's fine with me.

Yeah, because I want the external interface to include the kick, which =
we don't model today. So instead of touching basically every line of =
code again, I'd rather do it in one roll.


Alex

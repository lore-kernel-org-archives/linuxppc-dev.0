Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4BBE8B6FC3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Feb 2012 22:58:07 +1100 (EST)
Subject: Re: [PATCH 35/37] KVM: PPC: booke: Support perfmon interrupts
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <4F481E66.8010408@freescale.com>
Date: Sun, 26 Feb 2012 12:58:00 +0100
Message-Id: <9E400F41-5FF6-4F2F-826D-5290034629D8@suse.de>
References: <1330093591-19523-1-git-send-email-agraf@suse.de>
 <1330093591-19523-36-git-send-email-agraf@suse.de>
 <4F481E66.8010408@freescale.com>
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


On 25.02.2012, at 00:33, Scott Wood wrote:

> On 02/24/2012 08:26 AM, Alexander Graf wrote:
>> When during guest context we get a performance monitor interrupt, we
>> currently bail out and oops. Let's route it to its correct handler
>> instead.
>>=20
>> Signed-off-by: Alexander Graf <agraf@suse.de>
>> ---
>> arch/powerpc/kvm/booke.c |    4 ++++
>> 1 files changed, 4 insertions(+), 0 deletions(-)
>>=20
>> diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
>> index 7adef28..423701b 100644
>> --- a/arch/powerpc/kvm/booke.c
>> +++ b/arch/powerpc/kvm/booke.c
>> @@ -677,6 +677,10 @@ int kvmppc_handle_exit(struct kvm_run *run, =
struct kvm_vcpu *vcpu,
>> 		r =3D RESUME_GUEST;
>> 		break;
>>=20
>> +	case BOOKE_INTERRUPT_PERFORMANCE_MONITOR:
>> +		r =3D RESUME_GUEST;
>> +		break;
>> +
>> 	case BOOKE_INTERRUPT_HV_PRIV:
>> 		r =3D emulation_exit(run, vcpu);
>> 		break;
>=20
> Why do we need to call timer_interrupt() explicitly, but can rely on
> automatic retriggering for perfmon?

We don't rely on automatic retriggering for perfmon. There are 2 =
different places where we need to handle an incoming exit code - the =
"reinject" code path and the "big switch over all exits" code path. This =
one deals with the latter.


Alex

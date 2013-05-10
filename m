Return-Path: <B07421@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe004.messaging.microsoft.com [213.199.154.207])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 840DE2C00E1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 May 2013 08:47:33 +1000 (EST)
Date: Fri, 10 May 2013 17:47:00 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2 3/4] kvm/ppc: Call trace_hardirqs_on before entry
To: tiejun.chen <tiejun.chen@windriver.com>
References: <1368155384-11035-1-git-send-email-scottwood@freescale.com>
 <1368155384-11035-4-git-send-email-scottwood@freescale.com>
 <6A3DF150A5B70D4F9B66A25E3F7C888D0700F4FF@039-SN2MPN1-011.039d.mgd.msft.net>
 <518C7A28.4000903@windriver.com>
In-Reply-To: <518C7A28.4000903@windriver.com> (from
 tiejun.chen@windriver.com on Thu May  9 23:40:08 2013)
Message-ID: <1368226020.19683.14@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Alexander Graf <agraf@suse.de>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 Bhushan Bharat-R65777 <R65777@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/09/2013 11:40:08 PM, tiejun.chen wrote:
> On 05/10/2013 11:34 AM, Bhushan Bharat-R65777 wrote:
>>> diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
>>> index 705fc5c..eb89b83 100644
>>> --- a/arch/powerpc/kvm/booke.c
>>> +++ b/arch/powerpc/kvm/booke.c
>>> @@ -673,7 +673,7 @@ int kvmppc_vcpu_run(struct kvm_run *kvm_run, =20
>>> struct kvm_vcpu
>>> *vcpu)
>>>   		ret =3D s;
>>>   		goto out;
>>>   	}
>>> -	kvmppc_lazy_ee_enable();
>>> +	kvmppc_fix_ee_before_entry();
>>=20
>> local_irq_disable() is called before kvmppc_prepare_to_enter().
>=20
> In patch 4, we call hard_irq_disable() once enter =20
> kvmppc_prepare_to_enter().

And before patch 4, we have the code near the end of =20
kvmppc_prepare_to_enter() that checks lazy_irq_pending() and aborts =20
guest entry if there was a race.  If I'd known about that bit of code =20
beforehand, I probably wouldn't have bothered with most of patch 4/4, =20
but now that it's been done it seems cleaner.

-Scott=

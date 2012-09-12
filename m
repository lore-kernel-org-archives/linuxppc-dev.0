Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 90C752C0080
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Sep 2012 07:45:15 +1000 (EST)
References: <1347455894-30044-1-git-send-email-mihai.caraman@freescale.com>
 <F4E2A678-6697-4207-8CEE-2CFB3629F554@suse.de>
 <505100BD.6020304@freescale.com>
In-Reply-To: <505100BD.6020304@freescale.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Message-Id: <B9A48F7E-664A-4E8A-883F-CEB01068CC2A@suse.de>
From: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH] KVM: PPC: bookehv: Allow duplicate calls of DO_KVM macro
Date: Wed, 12 Sep 2012 23:45:12 +0200
To: Scott Wood <scottwood@freescale.com>
Cc: Mihai Caraman <mihai.caraman@freescale.com>,
 "<linuxppc-dev@lists.ozlabs.org>" <linuxppc-dev@lists.ozlabs.org>,
 "<kvm@vger.kernel.org>" <kvm@vger.kernel.org>,
 "<kvm-ppc@vger.kernel.org>" <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 12.09.2012, at 23:38, Scott Wood <scottwood@freescale.com> wrote:

> On 09/12/2012 01:56 PM, Alexander Graf wrote:
>>=20
>>=20
>> On 12.09.2012, at 15:18, Mihai Caraman <mihai.caraman@freescale.com> wrot=
e:
>>=20
>>> The current form of DO_KVM macro restricts its use to one call per input=

>>> parameter set. This is caused by kvmppc_resume_\intno\()_\srr1 symbol
>>> definition.
>>> Duplicate calls of DO_KVM are required by distinct implementations of
>>> exeption handlers which are delegated at runtime.
>>=20
>> Not sure I understand what you're trying to achieve here. Please elaborat=
e ;)
>=20
> On 64-bit book3e we compile multiple versions of the TLB miss handlers,
> and choose from them at runtime. =20

Why?

> Without this patch, we get duplicate
> label errors if more than one variant of the same exception uses DO_KVM.

Makes sense. The proposed solution also looks good. Just quickly walk me thr=
ough the reasoning for the runtime check again please.


Alex

>=20
> -Scott
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe kvm-ppc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1DCF32C007B
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Dec 2012 04:39:01 +1100 (EST)
Subject: Re: [PATCH] KVM: PPC: Make EPCR a valid field for booke64 and bookehv
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1354553228.2960.4@snotra>
Date: Mon, 3 Dec 2012 18:38:52 +0100
Message-Id: <BBC7E487-E59E-46D9-808A-2BBE3DD48B98@suse.de>
References: <1354370305-12344-1-git-send-email-agraf@suse.de>
 <1354553228.2960.4@snotra>
To: Scott Wood <scottwood@freescale.com>
Cc: Mihai Caraman <mihai.caraman@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 "kvm@vger.kernel.org list" <kvm@vger.kernel.org>, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 03.12.2012, at 17:47, Scott Wood wrote:

> On 12/01/2012 07:58:25 AM, Alexander Graf wrote:
>> In BookE, EPCR is defined and valid when either the HV or the 64bit
>> category are implemented. Reflect this in the field definition.
>> Today the only KVM target on 64bit is HV enabled, so there is no
>> change in actual source code, but this keeps the code closer to the
>> spec and doesn't build up artificial road blocks for a PR KVM
>> on 64bit.
> [snip]
>> Signed-off-by: Alexander Graf <agraf@suse.de>
>> ---
>> arch/powerpc/include/asm/kvm_host.h |    9 +++++++--
>> 1 files changed, 7 insertions(+), 2 deletions(-)
>> diff --git a/arch/powerpc/include/asm/kvm_host.h =
b/arch/powerpc/include/asm/kvm_host.h
>> index 62fbd38..3480526 100644
>> --- a/arch/powerpc/include/asm/kvm_host.h
>> +++ b/arch/powerpc/include/asm/kvm_host.h
>> @@ -405,14 +405,19 @@ struct kvm_vcpu_arch {
>> #ifdef CONFIG_KVM_BOOKE_HV
>> 	u32 host_mas4;
>> 	u32 host_mas6;
>> -	u32 shadow_epcr;
>> -	u32 epcr;
>> 	u32 shadow_msrp;
>> 	u32 eplc;
>> 	u32 epsc;
>> 	u32 oldpir;
>> #endif
>> +#if defined(CONFIG_BOOKE)
>> +#if defined(CONFIG_KVM_BOOKE_HV) || defined(CONFIG_64BIT)
>> +	u32 shadow_epcr;
>> +	u32 epcr;
>> +#endif
>> +#endif
>=20
> On a PR-mode implementation, why would we be have a shadow_epcr?  It =
would always be set based on the host kernel, just like when running any =
other userspace process.

Right - we could simply set MSR_CM. I'll move shadow_epcr back into the =
HV only bit above.


Alex

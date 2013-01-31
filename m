Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7633F2C02E8
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Feb 2013 00:32:35 +1100 (EST)
Subject: Re: [PATCH 2/5] KVM: PPC: e500: Emulate TLBnPS registers
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <F796A11A-01C0-4B4E-B4FE-8E88E40DB2CF@suse.de>
Date: Thu, 31 Jan 2013 14:32:30 +0100
Message-Id: <F440909A-3940-4795-9D68-99D984EA659B@suse.de>
References: <1359552584-17861-1-git-send-email-mihai.caraman@freescale.com>
 <1359552584-17861-3-git-send-email-mihai.caraman@freescale.com>
 <F796A11A-01C0-4B4E-B4FE-8E88E40DB2CF@suse.de>
To: Mihai Caraman <mihai.caraman@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 31.01.2013, at 14:24, Alexander Graf wrote:

>=20
> On 30.01.2013, at 14:29, Mihai Caraman wrote:
>=20
>> Emulate TLBnPS registers which are available in MMU Architecture =
Version
>> (MAV) 2.0.
>>=20
>> Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
>> ---
>> arch/powerpc/include/asm/kvm_host.h |    1 +
>> arch/powerpc/kvm/e500.h             |    5 +++++
>> arch/powerpc/kvm/e500_emulate.c     |   10 ++++++++++
>> arch/powerpc/kvm/e500_mmu.c         |    5 +++++
>> 4 files changed, 21 insertions(+), 0 deletions(-)
>>=20
>> diff --git a/arch/powerpc/include/asm/kvm_host.h =
b/arch/powerpc/include/asm/kvm_host.h
>> index 8a72d59..88fcfe6 100644
>> --- a/arch/powerpc/include/asm/kvm_host.h
>> +++ b/arch/powerpc/include/asm/kvm_host.h
>> @@ -501,6 +501,7 @@ struct kvm_vcpu_arch {
>> 	spinlock_t wdt_lock;
>> 	struct timer_list wdt_timer;
>> 	u32 tlbcfg[4];
>> +	u32 tlbps[4];
>> 	u32 mmucfg;
>> 	u32 epr;
>> 	struct kvmppc_booke_debug_reg dbg_reg;
>> diff --git a/arch/powerpc/kvm/e500.h b/arch/powerpc/kvm/e500.h
>> index 41cefd4..b9f76d8 100644
>> --- a/arch/powerpc/kvm/e500.h
>> +++ b/arch/powerpc/kvm/e500.h
>> @@ -303,4 +303,9 @@ static inline unsigned int get_tlbmiss_tid(struct =
kvm_vcpu *vcpu)
>> #define get_tlb_sts(gtlbe)              (MAS1_TS)
>> #endif /* !BOOKE_HV */
>>=20
>> +static inline unsigned int has_mmu_v2(const struct kvm_vcpu *vcpu)
>=20
> bool. Also rename it to "is_..." then.

In light of the comment I did in a later patch, this too could be =
convert to feature flags.


Alex

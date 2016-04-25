Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qtfDn23y6zDq62
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Apr 2016 18:15:53 +1000 (AEST)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] powerpc: Fix definition of SIAR register
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <571DD072.6040305@linux.vnet.ibm.com>
Date: Mon, 25 Apr 2016 10:15:47 +0200
Cc: Thomas Huth <thuth@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org
Message-Id: <182287E9-40B9-4774-A932-08A0AA499AE3@suse.de>
References: <1460130851-29021-1-git-send-email-thuth@redhat.com>
 <571DD072.6040305@linux.vnet.ibm.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> Am 25.04.2016 um 10:08 schrieb Madhavan Srinivasan <maddy@linux.vnet.ibm.c=
om>:
>=20
>=20
>=20
>> On Friday 08 April 2016 09:24 PM, Thomas Huth wrote:
>> The SIAR register is available twice, one time as SPR 780 (unprivileged,
>> but read-only), and one time as SPR 796 (privileged, but read and write).=

>> The Linux kernel code currently uses SPR 780 - and while this is OK for
>> reading, writing to that register of course does not work.
>> Since the KVM code tries to write to this register, too (see the mtspr
>> in book3s_hv_rmhandlers.S), the contents of this register sometimes get
>> lost for the guests, e.g. during migration of a VM.
>> To fix this issue, simply switch to the other SPR numer 796 instead.
>=20
> IIUC, SIAR and SDAR are updated by hardware when we take
> a pmu exception with sampling mode enabled (based on instr).
> And these register contents are mainly for OS consumption.
> So, we dont need to restore these register values at all,
> kindly correct me if I missing something here.

What if you migrate between a pmu event firing and the os reading siar? Or w=
hat if the host gets pmu events? Or we migrate the guest to a different pcpu=
? In all those cases we need to ensure the register contents are consistent.=


>=20
> Maddy
>=20
>>=20
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>> Note: The perf code in core-book3s.c also seems to write to the SIAR
>>       SPR, so that might be affected by this issue, too - but I did
>>       not test the perf code, so I'm not sure about that part.

Please write a small unit test that fires off pmu events constantly and chec=
ks whtether they arrive correctly. Run perf in parallel on the host to incre=
ase the chance for breakage.

>>=20
>> arch/powerpc/include/asm/reg.h | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/re=
g.h
>> index f5f4c66..6630420 100644
>> --- a/arch/powerpc/include/asm/reg.h
>> +++ b/arch/powerpc/include/asm/reg.h
>> @@ -752,13 +752,13 @@
>> #define SPRN_PMC6    792
>> #define SPRN_PMC7    793
>> #define SPRN_PMC8    794
>> -#define SPRN_SIAR    780
>> #define SPRN_SDAR    781
>> #define SPRN_SIER    784
>> #define   SIER_SIPR        0x2000000    /* Sampled MSR_PR */
>> #define   SIER_SIHV        0x1000000    /* Sampled MSR_HV */
>> #define   SIER_SIAR_VALID    0x0400000    /* SIAR contents valid */
>> #define   SIER_SDAR_VALID    0x0200000    /* SDAR contents valid */
>> +#define SPRN_SIAR    796

I'm sure there's a reason (iSeries?) we used the r/o version before. Better i=
ntroduce a new constant that gives us rw access and use that in the kvm entr=
y/exit code.

Alex

>> #define SPRN_TACR    888
>> #define SPRN_TCSCR    889
>> #define SPRN_CSIGR    890
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe kvm-ppc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Return-Path: <avi@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 83A71B6EF3
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  4 Jul 2010 19:42:46 +1000 (EST)
Message-ID: <4C305793.2050206@redhat.com>
Date: Sun, 04 Jul 2010 12:42:43 +0300
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 13/27] KVM: PPC: Magic Page Book3s support
References: <1277980982-12433-1-git-send-email-agraf@suse.de>
	<1277980982-12433-14-git-send-email-agraf@suse.de>
	<4C2E07AC.4010801@suse.de>
In-Reply-To: <4C2E07AC.4010801@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	KVM list <kvm@vger.kernel.org>, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/02/2010 06:37 PM, Alexander Graf wrote:
> Alexander Graf wrote:
>    
>> We need to override EA as well as PA lookups for the magic page. When the guest
>> tells us to project it, the magic page overrides any guest mappings.
>>
>> In order to reflect that, we need to hook into all the MMU layers of KVM to
>> force map the magic page if necessary.
>>
>> Signed-off-by: Alexander Graf<agraf@suse.de>
>>
>> v1 ->  v2:
>>
>>    - RMO ->  PAM
>> ---
>>   arch/powerpc/kvm/book3s.c             |    7 +++++++
>>   arch/powerpc/kvm/book3s_32_mmu.c      |   16 ++++++++++++++++
>>   arch/powerpc/kvm/book3s_32_mmu_host.c |   12 ++++++++++++
>>   arch/powerpc/kvm/book3s_64_mmu.c      |   30 +++++++++++++++++++++++++++++-
>>   arch/powerpc/kvm/book3s_64_mmu_host.c |   12 ++++++++++++
>>   5 files changed, 76 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
>> index 14db032..b22e608 100644
>> --- a/arch/powerpc/kvm/book3s.c
>> +++ b/arch/powerpc/kvm/book3s.c
>> @@ -554,6 +554,13 @@ mmio:
>>
>>   static int kvmppc_visible_gfn(struct kvm_vcpu *vcpu, gfn_t gfn)
>>   {
>> +	ulong mp_pa = vcpu->arch.magic_page_pa;
>> +
>> +	if (unlikely(mp_pa)&&
>> +	    unlikely((mp_pa&  KVM_RMO)>>  PAGE_SHIFT == gfn)) {
>>
>>      
> This should be KVM_PAM :(. Should I respin the whole thing or could
> whoever commits this just make that trivial change?
>
>    

A respin followed by a bisectability test (compile each revision as it 
is applied), please.  Of course we need to resolve the detection issue 
first.

-- 
error compiling committee.c: too many arguments to function

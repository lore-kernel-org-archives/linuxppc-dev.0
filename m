Return-Path: <aik@ozlabs.ru>
Received: from mail-pd0-f182.google.com (mail-pd0-f182.google.com
 [209.85.192.182])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 447032C0097
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Feb 2014 19:03:25 +1100 (EST)
Received: by mail-pd0-f182.google.com with SMTP id v10so7963493pde.27
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Feb 2014 00:03:21 -0800 (PST)
Message-ID: <52F09EC0.60201@ozlabs.ru>
Date: Tue, 04 Feb 2014 19:03:12 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH] PPC: KVM: fix VCPU run for HV KVM
References: <1389338467-26303-1-git-send-email-aik@ozlabs.ru>
 <AF6669B4-EF1A-44BD-9034-8824EFD94B5B@suse.de>
In-Reply-To: <AF6669B4-EF1A-44BD-9034-8824EFD94B5B@suse.de>
Content-Type: text/plain; charset=KOI8-R
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 "kvm@vger.kernel.org mailing list" <kvm@vger.kernel.org>,
 kvm-ppc@vger.kernel.org,
 "linux-kernel@vger.kernel.org list" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/13/2014 02:44 AM, Alexander Graf wrote:
> 
> On 10.01.2014, at 08:21, Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> 
>> When write to MMIO happens and there is an ioeventfd for that and
>> is handled successfully, ioeventfd_write() returns 0 (success) and
>> kvmppc_handle_store() returns EMULATE_DONE. Then kvmppc_emulate_mmio()
>> converts EMULATE_DONE to RESUME_GUEST_NV and this broke from the loop.
>>
>> This adds handling of RESUME_GUEST_NV in kvmppc_vcpu_run_hv().
>>
>> Cc: Michael S. Tsirkin <mst@redhat.com>
>> Suggested-by: Paul Mackerras <paulus@samba.org>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>>
>> This definitely needs a better commit message. Please, help.
>> ps. it seems like ioeventfd never worked on ppc64. hm.
>>
>> ---
>> arch/powerpc/kvm/book3s_hv.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
>> index 072287f..24f363f 100644
>> --- a/arch/powerpc/kvm/book3s_hv.c
>> +++ b/arch/powerpc/kvm/book3s_hv.c
>> @@ -1569,7 +1569,7 @@ static int kvmppc_vcpu_run_hv(struct kvm_run *run, struct kvm_vcpu *vcpu)
>> 				vcpu->arch.fault_dar, vcpu->arch.fault_dsisr);
>> 			srcu_read_unlock(&vcpu->kvm->srcu, srcu_idx);
>> 		}
>> -	} while (r == RESUME_GUEST);
>> +	} while ((r == RESUME_GUEST_NV) || (r == RESUME_GUEST));
> 
> How about
> 
>   while(!(r & RESUME_FLAG_HOST));


Rather "while(!(r & RESUME_FLAG_HOST) && (r > 0));" and still not obvious
that this is really better.

Paul agrees with the original patch (and made a better commit message for
our internal tree) but I just cannot make him reply in this thread, keep
constantly asking him but to no avail :)


> That should cover all RESUME_GUEST_XXX cases just fine. Apart from that
> I agree that we should check for ! FLAG_HOST bit rather than the actual
> RESUME_GUEST value in all case where we check for it (read: please
> update all places).

There are 3 places remotely similar to this and none of them requires a fix
like above.



-- 
Alexey

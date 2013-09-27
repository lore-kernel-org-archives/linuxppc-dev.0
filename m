Return-Path: <paolo.bonzini@gmail.com>
Received: from mail-qa0-x236.google.com (mail-qa0-x236.google.com
 [IPv6:2607:f8b0:400d:c00::236])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 557D02C0341
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Sep 2013 01:14:27 +1000 (EST)
Received: by mail-qa0-f54.google.com with SMTP id bv4so561365qab.13
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 08:14:23 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
Message-ID: <5245A0DD.9070205@redhat.com>
Date: Fri, 27 Sep 2013 17:14:37 +0200
From: Paolo Bonzini <pbonzini@redhat.com>
MIME-Version: 1.0
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 09/11] kvm: simplify processor compat check
References: <1380276233-17095-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1380276233-17095-10-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <E5A81672-864D-4E33-B15A-5F6927CC7C13@suse.de>
 <87r4ca9zmi.fsf@linux.vnet.ibm.com>
In-Reply-To: <87r4ca9zmi.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Gleb Natapov <gleb@redhat.com>,
 "<kvm@vger.kernel.org> list" <kvm@vger.kernel.org>,
 Alexander Graf <agraf@suse.de>, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Il 27/09/2013 15:13, Aneesh Kumar K.V ha scritto:
> Alexander Graf <agraf@suse.de> writes:
> 
>> On 27.09.2013, at 12:03, Aneesh Kumar K.V wrote:
>>
>>> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>>
>> Missing patch description.
>>
>>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>>
>> I fail to see how this really simplifies things, but at the end of the
>> day it's Gleb's and Paolo's call.
> 
> will do. It avoid calling 
> 
> 	for_each_online_cpu(cpu) {
> 		smp_call_function_single() 
> 
> on multiple architecture.

I agree with Alex.

The current code is not specially awesome; having
kvm_arch_check_processor_compat take an int* disguised as a void* is a
bit ugly indeed.

However, the API makes sense and tells you that it is being passed as a
callback (to smp_call_function_single in this case).

You are making the API more complicated to use on the arch layer
(because arch maintainers now have to think "do I need to check this on
all online CPUs?") and making the "leaf" POWER code less legible because
it still has the weird void()(void *) calling convention.

If anything, you could change kvm_arch_check_processor_compat to return
an int and accept no argument, and introduce a wrapper that kvm_init
passes to smp_call_function_single.

Paolo

> We also want to make the smp call function a callback of opaque. Hence
> this should be made arch specific. 
> 
> int kvm_arch_check_processor_compat(void *opaque)
> {
> 	int r,cpu;
> 	struct kvmppc_ops *kvm_ops = (struct kvmppc_ops *)opaque;
> 	for_each_online_cpu(cpu) {
> 		smp_call_function_single(cpu,
> 					 kvm_ops->check_processor_compat,
> 					 &r, 1);
> 		if (r < 0)
> 			break;
> 	}
> 	return r;
> }
> 
> against
> 
> -	for_each_online_cpu(cpu) {
> -		smp_call_function_single(cpu,
> -				kvm_arch_check_processor_compat,
> -				&r, 1);
> -		if (r < 0)
> -			goto out_free_1;
> -	}
> +
> +	r = kvm_arch_check_processor_compat(opaque);
> +	if (r < 0)
> +		goto out_free_1;
> 
> 
> 
>>
>> Which brings me to the next issue: You forgot to CC kvm@vger on your
>> patch set. Gleb and Paolo don't read kvm-ppc@vger. And they shouldn't
>> have to. Every kvm patch that you want review on or that should get
>> applied needs to be sent to kvm@vger. If you want to tag it as PPC
>> specific patch, do so by CC'ing kvm-ppc@vger.
> 
> Will do in the next update
> 
> -aneesh
> 

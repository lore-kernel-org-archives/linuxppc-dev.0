Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp04.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DB7792C00E0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Sep 2013 01:05:26 +1000 (EST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sun, 29 Sep 2013 20:35:21 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 300661258051
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Sep 2013 20:35:34 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r8TF7hm926738896
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Sep 2013 20:37:43 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r8TF5HkF028974
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Sep 2013 20:35:17 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Gleb Natapov <gleb@redhat.com>
Subject: Re: [RFC PATCH 09/11] kvm: simplify processor compat check
In-Reply-To: <20130929085800.GO17294@redhat.com>
References: <1380276233-17095-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1380276233-17095-10-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <E5A81672-864D-4E33-B15A-5F6927CC7C13@suse.de>
 <87r4ca9zmi.fsf@linux.vnet.ibm.com> <5245A0DD.9070205@redhat.com>
 <87mwmx9cvk.fsf@linux.vnet.ibm.com> <20130929085800.GO17294@redhat.com>
Date: Sun, 29 Sep 2013 20:35:16 +0530
Message-ID: <87siwnbrdf.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: "<kvm@vger.kernel.org> list" <kvm@vger.kernel.org>,
 Alexander Graf <agraf@suse.de>, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Paolo Bonzini <pbonzini@redhat.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Gleb Natapov <gleb@redhat.com> writes:

> On Sat, Sep 28, 2013 at 09:06:47PM +0530, Aneesh Kumar K.V wrote:
>> Paolo Bonzini <pbonzini@redhat.com> writes:
>> 
>> > Il 27/09/2013 15:13, Aneesh Kumar K.V ha scritto:
>> >> Alexander Graf <agraf@suse.de> writes:
>> >> 
>> >>> On 27.09.2013, at 12:03, Aneesh Kumar K.V wrote:
>> >>>
>> >>>> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>> >>>
>> >>> Missing patch description.
>> >>>
>> >>>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> >>>
>> >>> I fail to see how this really simplifies things, but at the end of the
>> >>> day it's Gleb's and Paolo's call.
>> >> 
>> >> will do. It avoid calling 
>> >> 
>> >> 	for_each_online_cpu(cpu) {
>> >> 		smp_call_function_single() 
>> >> 
>> >> on multiple architecture.
>> >
>> > I agree with Alex.
>> >
>> > The current code is not specially awesome; having
>> > kvm_arch_check_processor_compat take an int* disguised as a void* is a
>> > bit ugly indeed.
>> >
>> > However, the API makes sense and tells you that it is being passed as a
>> > callback (to smp_call_function_single in this case).
>> 
>> But whether to check on all cpus or not is arch dependent right?.
>> IIUC only x86 and ppc64 need to do that. Also on ppc64 it really
>> depends on whether HV or PR. We need to check on all cpus only if it is
>> HV. 
>> 
>> >
>> > You are making the API more complicated to use on the arch layer
>> > (because arch maintainers now have to think "do I need to check this on
>> > all online CPUs?") and making the "leaf" POWER code less legible because
>> > it still has the weird void()(void *) calling convention.
>> >
>> 
>> IIUC what we wanted to check is to find out whether kvm can run on this
>> system. That is really an arch specific check. So for core kvm the call
>> should be a simple 
>> 
>> if (kvm_arch_check_process_compat() < 0)
>>         error;
> We have that already, just return error from kvm_arch_hardware_setup. This
> is specific processor compatibility check and you are arguing that the
> processor check should be part of kvm_arch_hardware_setup().


What about the success case ?. ie, on arch like arm we do

void kvm_arch_check_processor_compat(void *rtn)
{
	*(int *)rtn = 0;
}

for_each_online_cpu(cpu) {
	smp_call_function_single(cpu,
			kvm_arch_check_processor_compat,
			&r, 1);
	if (r < 0)
		goto out_free_1;
}

There is no need to do that for loop for arm. 

The only reason I wanted this patch in the series is to make
kvm_arch_check_processor_compat take additional argument opaque. 
I am dropping that requirement in the last patch. Considering
that we have objection to this one, I will drop this patch in
the next posting by rearranging the patches.

-aneesh

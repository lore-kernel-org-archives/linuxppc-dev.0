Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp03.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E96692C010C
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Sep 2013 01:37:07 +1000 (EST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sat, 28 Sep 2013 21:06:53 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 4CF94E0053
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Sep 2013 21:07:58 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r8SFdDjw41943188
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Sep 2013 21:09:14 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r8SFamHV010232
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Sep 2013 21:06:48 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH 09/11] kvm: simplify processor compat check
In-Reply-To: <5245A0DD.9070205@redhat.com>
References: <1380276233-17095-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1380276233-17095-10-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <E5A81672-864D-4E33-B15A-5F6927CC7C13@suse.de>
 <87r4ca9zmi.fsf@linux.vnet.ibm.com> <5245A0DD.9070205@redhat.com>
Date: Sat, 28 Sep 2013 21:06:47 +0530
Message-ID: <87mwmx9cvk.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> Il 27/09/2013 15:13, Aneesh Kumar K.V ha scritto:
>> Alexander Graf <agraf@suse.de> writes:
>> 
>>> On 27.09.2013, at 12:03, Aneesh Kumar K.V wrote:
>>>
>>>> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>>>
>>> Missing patch description.
>>>
>>>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>>>
>>> I fail to see how this really simplifies things, but at the end of the
>>> day it's Gleb's and Paolo's call.
>> 
>> will do. It avoid calling 
>> 
>> 	for_each_online_cpu(cpu) {
>> 		smp_call_function_single() 
>> 
>> on multiple architecture.
>
> I agree with Alex.
>
> The current code is not specially awesome; having
> kvm_arch_check_processor_compat take an int* disguised as a void* is a
> bit ugly indeed.
>
> However, the API makes sense and tells you that it is being passed as a
> callback (to smp_call_function_single in this case).

But whether to check on all cpus or not is arch dependent right?.
IIUC only x86 and ppc64 need to do that. Also on ppc64 it really
depends on whether HV or PR. We need to check on all cpus only if it is
HV. 

>
> You are making the API more complicated to use on the arch layer
> (because arch maintainers now have to think "do I need to check this on
> all online CPUs?") and making the "leaf" POWER code less legible because
> it still has the weird void()(void *) calling convention.
>

IIUC what we wanted to check is to find out whether kvm can run on this
system. That is really an arch specific check. So for core kvm the call
should be a simple 

if (kvm_arch_check_process_compat() < 0)
        error;

Now how each arch figure out whether kvm can run on this system should
be arch specific. For x86 we do need to check all the cpus. On ppc64 for
HV we need to. For other archs we always allow kvm. 


> If anything, you could change kvm_arch_check_processor_compat to return
> an int and accept no argument, and introduce a wrapper that kvm_init
> passes to smp_call_function_single.

What i am suggesting in the patch is to avoid calling
smp_call_function_single from kvm_init and let arch decide whether to
check on all cpus or not.

-aneesh

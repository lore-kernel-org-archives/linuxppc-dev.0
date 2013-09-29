Return-Path: <gleb@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 4FF862C00F8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Sep 2013 01:11:21 +1000 (EST)
Date: Sun, 29 Sep 2013 18:11:15 +0300
From: Gleb Natapov <gleb@redhat.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 09/11] kvm: simplify processor compat check
Message-ID: <20130929151115.GA4964@redhat.com>
References: <1380276233-17095-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1380276233-17095-10-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <E5A81672-864D-4E33-B15A-5F6927CC7C13@suse.de>
 <87r4ca9zmi.fsf@linux.vnet.ibm.com> <5245A0DD.9070205@redhat.com>
 <87mwmx9cvk.fsf@linux.vnet.ibm.com>
 <20130929085800.GO17294@redhat.com>
 <87siwnbrdf.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87siwnbrdf.fsf@linux.vnet.ibm.com>
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

On Sun, Sep 29, 2013 at 08:35:16PM +0530, Aneesh Kumar K.V wrote:
> Gleb Natapov <gleb@redhat.com> writes:
> 
> > On Sat, Sep 28, 2013 at 09:06:47PM +0530, Aneesh Kumar K.V wrote:
> >> Paolo Bonzini <pbonzini@redhat.com> writes:
> >> 
> >> > Il 27/09/2013 15:13, Aneesh Kumar K.V ha scritto:
> >> >> Alexander Graf <agraf@suse.de> writes:
> >> >> 
> >> >>> On 27.09.2013, at 12:03, Aneesh Kumar K.V wrote:
> >> >>>
> >> >>>> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> >> >>>
> >> >>> Missing patch description.
> >> >>>
> >> >>>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> >> >>>
> >> >>> I fail to see how this really simplifies things, but at the end of the
> >> >>> day it's Gleb's and Paolo's call.
> >> >> 
> >> >> will do. It avoid calling 
> >> >> 
> >> >> 	for_each_online_cpu(cpu) {
> >> >> 		smp_call_function_single() 
> >> >> 
> >> >> on multiple architecture.
> >> >
> >> > I agree with Alex.
> >> >
> >> > The current code is not specially awesome; having
> >> > kvm_arch_check_processor_compat take an int* disguised as a void* is a
> >> > bit ugly indeed.
> >> >
> >> > However, the API makes sense and tells you that it is being passed as a
> >> > callback (to smp_call_function_single in this case).
> >> 
> >> But whether to check on all cpus or not is arch dependent right?.
> >> IIUC only x86 and ppc64 need to do that. Also on ppc64 it really
> >> depends on whether HV or PR. We need to check on all cpus only if it is
> >> HV. 
> >> 
> >> >
> >> > You are making the API more complicated to use on the arch layer
> >> > (because arch maintainers now have to think "do I need to check this on
> >> > all online CPUs?") and making the "leaf" POWER code less legible because
> >> > it still has the weird void()(void *) calling convention.
> >> >
> >> 
> >> IIUC what we wanted to check is to find out whether kvm can run on this
> >> system. That is really an arch specific check. So for core kvm the call
> >> should be a simple 
> >> 
> >> if (kvm_arch_check_process_compat() < 0)
> >>         error;
> > We have that already, just return error from kvm_arch_hardware_setup. This
> > is specific processor compatibility check and you are arguing that the
> > processor check should be part of kvm_arch_hardware_setup().
> 
> 
> What about the success case ?. ie, on arch like arm we do
> 
> void kvm_arch_check_processor_compat(void *rtn)
> {
> 	*(int *)rtn = 0;
> }
> 
> for_each_online_cpu(cpu) {
As I said they opted out from doing the check. They may reconsider after
first bad HW will be discovered.

> 	smp_call_function_single(cpu,
> 			kvm_arch_check_processor_compat,
> 			&r, 1);
> 	if (r < 0)
> 		goto out_free_1;
> }
> 
> There is no need to do that for loop for arm. 
It's done once during module initialisation. Why is this a big deal?

--
			Gleb.

Return-Path: <gleb@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 4D2942C00E4
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Sep 2013 18:58:08 +1000 (EST)
Date: Sun, 29 Sep 2013 11:58:00 +0300
From: Gleb Natapov <gleb@redhat.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 09/11] kvm: simplify processor compat check
Message-ID: <20130929085800.GO17294@redhat.com>
References: <1380276233-17095-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1380276233-17095-10-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <E5A81672-864D-4E33-B15A-5F6927CC7C13@suse.de>
 <87r4ca9zmi.fsf@linux.vnet.ibm.com> <5245A0DD.9070205@redhat.com>
 <87mwmx9cvk.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87mwmx9cvk.fsf@linux.vnet.ibm.com>
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

On Sat, Sep 28, 2013 at 09:06:47PM +0530, Aneesh Kumar K.V wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
> 
> > Il 27/09/2013 15:13, Aneesh Kumar K.V ha scritto:
> >> Alexander Graf <agraf@suse.de> writes:
> >> 
> >>> On 27.09.2013, at 12:03, Aneesh Kumar K.V wrote:
> >>>
> >>>> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> >>>
> >>> Missing patch description.
> >>>
> >>>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> >>>
> >>> I fail to see how this really simplifies things, but at the end of the
> >>> day it's Gleb's and Paolo's call.
> >> 
> >> will do. It avoid calling 
> >> 
> >> 	for_each_online_cpu(cpu) {
> >> 		smp_call_function_single() 
> >> 
> >> on multiple architecture.
> >
> > I agree with Alex.
> >
> > The current code is not specially awesome; having
> > kvm_arch_check_processor_compat take an int* disguised as a void* is a
> > bit ugly indeed.
> >
> > However, the API makes sense and tells you that it is being passed as a
> > callback (to smp_call_function_single in this case).
> 
> But whether to check on all cpus or not is arch dependent right?.
> IIUC only x86 and ppc64 need to do that. Also on ppc64 it really
> depends on whether HV or PR. We need to check on all cpus only if it is
> HV. 
> 
> >
> > You are making the API more complicated to use on the arch layer
> > (because arch maintainers now have to think "do I need to check this on
> > all online CPUs?") and making the "leaf" POWER code less legible because
> > it still has the weird void()(void *) calling convention.
> >
> 
> IIUC what we wanted to check is to find out whether kvm can run on this
> system. That is really an arch specific check. So for core kvm the call
> should be a simple 
> 
> if (kvm_arch_check_process_compat() < 0)
>         error;
We have that already, just return error from kvm_arch_hardware_setup. This
is specific processor compatibility check and you are arguing that the
processor check should be part of kvm_arch_hardware_setup().

> 
> Now how each arch figure out whether kvm can run on this system should
> be arch specific. For x86 we do need to check all the cpus. On ppc64 for
> HV we need to. For other archs we always allow kvm. 
> 
This is really a sanity check. Theoretically on x86 we also should
not need to check all cpus since SMP configuration with different cpu
models is not supported by the architecture (AFAIK), but bugs happen
(BIOS bugs may cause difference in capabilities for instance). So some
arches opted out from this sanity check for now and this is their choice,
but the code makes it explicit what are we checking here.

> 
> > If anything, you could change kvm_arch_check_processor_compat to return
> > an int and accept no argument, and introduce a wrapper that kvm_init
> > passes to smp_call_function_single.
> 
> What i am suggesting in the patch is to avoid calling
> smp_call_function_single from kvm_init and let arch decide whether to
> check on all cpus or not.
> 
> -aneesh

--
			Gleb.

Return-Path: <sjitindarsingh@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3swBTH1tPRzDt2L
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Oct 2016 13:32:35 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id 128so6193088pfz.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Oct 2016 19:32:35 -0700 (PDT)
Message-ID: <1476412344.10795.1.camel@gmail.com>
Subject: Re: [PATCH 6/6] doc/kvm: Add halt polling documentation
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: Wanpeng Li <kernellwp@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Radim Krcmar <rkrcmar@redhat.com>,
 agraf@suse.com, Jonathan Corbet <corbet@lwn.net>, Paul Mackerras
 <paulus@samba.org>,  mpe@ellerman.id.au, sam.bobroff@au1.ibm.com, kvm
 <kvm@vger.kernel.org>,  kvm-ppc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org,
 linux-doc@vger.kernel.org
Date: Fri, 14 Oct 2016 13:32:24 +1100
In-Reply-To: <CANRm+CxnmZ1HzBiRTL7T+fYUMMMSZvAqq1LLj2NgRnUAnNSb=Q@mail.gmail.com>
References: <1476406404-32752-1-git-send-email-sjitindarsingh@gmail.com>
 <1476406404-32752-7-git-send-email-sjitindarsingh@gmail.com>
 <CANRm+CxnmZ1HzBiRTL7T+fYUMMMSZvAqq1LLj2NgRnUAnNSb=Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-10-14 at 09:16 +0800, Wanpeng Li wrote:
> 2016-10-14 8:53 GMT+08:00 Suraj Jitindar Singh <sjitindarsingh@gmail.
> com>:
> > 
> > There is currently no documentation about the halt polling
> > capabilities
> > of the kvm module. Add some documentation describing the mechanism
> > as well
> > as the module parameters to all better understanding of how halt
> > polling
> > should be used and the effect of tuning the module parameters.
> How about replace "halt-polling" by "Adaptive halt-polling"? Btw,
Yeah that's slightly more descriptive I guess
> thanks for your docs.
> 
> Regards,
> Wanpeng Li
> 
> > 
> > 
> > Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> > ---
> >  Documentation/virtual/kvm/00-INDEX         |   2 +
> >  Documentation/virtual/kvm/halt-polling.txt | 127
> > +++++++++++++++++++++++++++++
> >  2 files changed, 129 insertions(+)
> >  create mode 100644 Documentation/virtual/kvm/halt-polling.txt
> > 
> > diff --git a/Documentation/virtual/kvm/00-INDEX
> > b/Documentation/virtual/kvm/00-INDEX
> > index fee9f2b..69fe1a8 100644
> > --- a/Documentation/virtual/kvm/00-INDEX
> > +++ b/Documentation/virtual/kvm/00-INDEX
> > @@ -6,6 +6,8 @@ cpuid.txt
> >         - KVM-specific cpuid leaves (x86).
> >  devices/
> >         - KVM_CAP_DEVICE_CTRL userspace API.
> > +halt-polling.txt
> > +       - notes on halt-polling
> >  hypercalls.txt
> >         - KVM hypercalls.
> >  locking.txt
> > diff --git a/Documentation/virtual/kvm/halt-polling.txt
> > b/Documentation/virtual/kvm/halt-polling.txt
> > new file mode 100644
> > index 0000000..4a84183
> > --- /dev/null
> > +++ b/Documentation/virtual/kvm/halt-polling.txt
> > @@ -0,0 +1,127 @@
> > +The KVM halt polling system
> > +===========================
> > +
> > +The KVM halt polling system provides a feature within KVM whereby
> > the latency
> > +of a guest can, under some circumstances, be reduced by polling in
> > the host
> > +for some time period after the guest has elected to no longer run
> > by cedeing.
> > +That is, when a guest vcpu has ceded, or in the case of powerpc
> > when all of the
> > +vcpus of a single vcore have ceded, the host kernel polls for
> > wakeup conditions
> > +before giving up the cpu to the scheduler in order to let
> > something else run.
> > +
> > +Polling provides a latency advantage in cases where the guest can
> > be run again
> > +very quickly by at least saving us a trip through the scheduler,
> > normally on
> > +the order of a few micro-seconds, although performance benefits
> > are workload
> > +dependant. In the event that no wakeup source arrives during the
> > polling
> > +interval or some other task on the runqueue is runnable the
> > scheduler is
> > +invoked. Thus halt polling is especially useful on workloads with
> > very short
> > +wakeup periods where the time spent halt polling is minimised and
> > the time
> > +savings of not invoking the scheduler are distinguishable.
> > +
> > +The generic halt polling code is implemented in:
> > +
> > +       virt/kvm/kvm_main.c: kvm_vcpu_block()
> > +
> > +The powerpc kvm-hv specific case is implemented in:
> > +
> > +       arch/powerpc/kvm/book3s_hv.c: kvmppc_vcore_blocked()
> > +
> > +Halt Polling Interval
> > +=====================
> > +
> > +The maximum time for which to poll before invoking the scheduler,
> > referred to
> > +as the halt polling interval, is increased and decreased based on
> > the perceived
> > +effectiveness of the polling in an attempt to limit pointless
> > polling.
> > +This value is stored in either the vcpu struct:
> > +
> > +       kvm_vcpu->halt_poll_ns
> > +
> > +or in the case of powerpc kvm-hv, in the vcore struct:
> > +
> > +       kvmppc_vcore->halt_poll_ns
> > +
> > +Thus this is a per vcpu (or vcore) value.
> > +
> > +During polling if a wakeup source is received within the halt
> > polling interval,
> > +the interval is left unchanged. In the event that a wakeup source
> > isn't
> > +received during the polling interval (and thus schedule is
> > invoked) there are
> > +two options, either the polling interval and total block time[0]
> > were less than
> > +the global max polling interval (see module params below), or the
> > total block
> > +time was greater than the global max polling interval.
> > +
> > +In the event that both the polling interval and total block time
> > were less than
> > +the global max polling interval then the polling interval can be
> > increased in
> > +the hope that next time during the longer polling interval the
> > wake up source
> > +will be received while the host is polling and the latency
> > benefits will be
> > +received. The polling interval is grown in the function
> > grow_halt_poll_ns() and
> > +is multiplied by the module parameter halt_poll_ns_grow.
> > +
> > +In the event that the total block time was greater than the global
> > max polling
> > +interval then the host will never poll for long enough (limited by
> > the global
> > +max) to wakeup during the polling interval so it may as well be
> > shrunk in order
> > +to avoid pointless polling. The polling interval is shrunk in the
> > function
> > +shrink_halt_poll_ns() and is divided by the module parameter
> > +halt_poll_ns_shrink, or set to 0 iff halt_poll_ns_shrink == 0.
> > +
> > +It is worth noting that this adjustment process attempts to hone
> > in on some
> > +steady state polling interval but will only really do a good job
> > for wakeups
> > +which come at an approximately constant rate, otherwise there will
> > be constant
> > +adjustment of the polling interval.
> > +
> > +[0] total block time: the time between when the halt polling
> > function is
> > +                     invoked and a wakeup source received
> > (irrespective of
> > +                     whether the scheduler is invoked within that
> > function).
> > +
> > +Module Parameters
> > +=================
> > +
> > +The kvm module has 3 tuneable module parameters to adjust the
> > global max
> > +polling interval as well as the rate at which the polling interval
> > is grown and
> > +shrunk. These variables are defined in include/linux/kvm_host.h
> > and as module
> > +parameters in virt/kvm/kvm_main.c, or arch/powerpc/kvm/book3s_hv.c
> > in the
> > +powerpc kvm-hv case.
> > +
> > +Module
> > Parameter    |       Description              |      Default Value
> > +----------------------------------------------------------------
> > ----------------
> > +halt_poll_ns       | The global max polling interval |
> > KVM_HALT_POLL_NS_DEFAULT
> > +                   | which defines the ceiling value |
> > +                   | of the polling interval for     | (per arch
> > value)
> > +                   | each vcpu.                      |
> > +----------------------------------------------------------------
> > ----------------
> > +halt_poll_ns_grow   | The value by which the halt     |        2
> > +                   | polling interval is multiplied  |
> > +                   | in the grow_halt_poll_ns()      |
> > +                   | function.                       |
> > +----------------------------------------------------------------
> > ----------------
> > +halt_poll_ns_shrink | The value by which the halt     |        0
> > +                   | polling interval is divided in  |
> > +                   | the shrink_halt_poll_ns()       |
> > +                   | function.                       |
> > +----------------------------------------------------------------
> > ----------------
> > +
> > +These module parameters can be set from the debugfs files in:
> > +
> > +       /sys/module/kvm/parameters/
> > +
> > +Note: that these module parameters are system wide values and are
> > not able to
> > +      be tuned on a per vm basis.
> > +
> > +Further Notes
> > +=============
> > +
> > +- Care should be taken when setting the halt_poll_ns module
> > parameter as a
> > +large value has the potential to drive the cpu usage to 100% on a
> > machine which
> > +would be almost entirely idle otherwise. This is because even if a
> > guest has
> > +wakeups during which very little work is done and which are quite
> > far apart, if
> > +the period is shorter than the global max polling interval
> > (halt_poll_ns) then
> > +the host will always poll for the entire block time and thus cpu
> > utilisation
> > +will go to 100%.
> > +
> > +- Halt polling essentially presents a trade off between power
> > usage and latency
> > +and the module parameters should be used to tune the affinity for
> > this. Idle
> > +cpu time is essentially converted to host kernel time with the aim
> > of decreasing
> > +latency when entering the guest.
> > +
> > +- Halt polling will only be conducted by the host when no other
> > tasks are
> > +runnable on that cpu, otherwise the polling will cease immediately
> > and
> > +schedule will be invoked to allow that other task to run. Thus
> > this doesn't
> > +allow a guest to denial of service the cpu.
> > --
> > 2.5.5
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe kvm" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html

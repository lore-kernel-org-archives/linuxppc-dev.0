Return-Path: <dja@axtens.net>
Received: from mail-pl0-x22e.google.com (mail-pl0-x22e.google.com
 [IPv6:2607:f8b0:400e:c01::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40mvvl3rrJzF26F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 May 2018 01:13:38 +1000 (AEST)
Received: by mail-pl0-x22e.google.com with SMTP id c11-v6so2733890plr.5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 May 2018 08:13:38 -0700 (PDT)
Received: from localhost (124-171-193-185.dyn.iinet.net.au. [124.171.193.185])
 by smtp.gmail.com with ESMTPSA id
 a7-v6sm8519173pgc.68.2018.05.17.08.13.34
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 17 May 2018 08:13:35 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@lists.ozlabs.org
Subject: Failure to allocate HTAB for guest - CMA allocation failures?
Date: Fri, 18 May 2018 01:13:31 +1000
Message-ID: <87zi0ye2n8.fsf@linkitivity.dja.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I have reports from a user who is experiencing intermittent issues
with qemu being unable to allocate memory for the guest HPT. We see:

libvirtError: internal error: process exited while connecting to monitor: Unexpected error in spapr_alloc_htab() at /build/qemu-UwnbKa/qemu-2.5+dfsg/hw/ppc/spapr.c:1030:
qemu-system-ppc64le: Failed to allocate HTAB of requested size, try with smaller maxmem

and in the kernel logs:

[10103945.040498] alloc_contig_range: 19127 callbacks suppressed
[10103945.040502] alloc_contig_range: [7a5d00, 7a6500) PFNs busy
[10103945.040526] alloc_contig_range: [7a5d00, 7a6504) PFNs busy
[10103945.040548] alloc_contig_range: [7a5d00, 7a6508) PFNs busy
[10103945.040569] alloc_contig_range: [7a5d00, 7a650c) PFNs busy
[10103945.040591] alloc_contig_range: [7a5d00, 7a6510) PFNs busy
[10103945.040612] alloc_contig_range: [7a5d00, 7a6514) PFNs busy
[10103945.040634] alloc_contig_range: [7a5d00, 7a6518) PFNs busy
[10103945.040655] alloc_contig_range: [7a5d00, 7a651c) PFNs busy
[10103945.040676] alloc_contig_range: [7a5d00, 7a6520) PFNs busy
[10103945.040698] alloc_contig_range: [7a5d00, 7a6524) PFNs busy

I understand that this is caused when the request for an appropriately
sized and aligned piece of contiguous host memory for the guest hash
page table cannot be satisfied from the CMA. The user was attempting
to start a 16GB guest, so if I can read qemu code correctly, it would
be asking for 128MB of contiguous memory.

The CMA is pretty large - this is taken from /proc/meminfo some time
after the allocation failure:

CmaTotal: 26853376 kB
CmaFree: 4024448 kB

(The CMA is ~25GB, the host has 512GB of RAM.)

My guess is that the CMA has become fragmented (the machine had 112
days of uptime) and that was interfering with the ability of the
kernel to service the request?

Some googling suggests that these sorts of failures have been seen
before:

 * [1] is a Launchpad bug mirrored from the IBM Bugzilla that talks
   about this issue especially in the context of PCI passthrough
   leading to more memory being pinned. No PCI passthrough is
   occurring in this case.

 * [2] is from Red Hat - it seems to be especially focussed on
   particularly huge guests and memory hotplug. I don't think either
   of those apply here either.

I noticed from [1] that there is a patch from Balbir that apparently
helps when VFIO is used - 2e5bbb5461f1 ("KVM: PPC: Book3S HV: Migrate
pinned pages out of CMA"). The user is running a 4.4 kernel with this
backported. There's also reference to some work Alexey was doing to
unpin pages in a more timely fashion. It looks like that stalled, and
I can't see anything else particularly relevant in the kernel tree
between then and now - although I may well be missing stuff.

So:

 - have I missed anything obvious here/have I gone completely wrong in
   my analysis somewhere?

 - have I missed any great changes since 4.4 that would fix this?

 - is there any ongoing work in increasing CMA availability?

 - I noticed in arch/powerpc/kvm/book3s_hv_builtin.c,
   kvm_cma_resv_ratio is defined as a boot parameter. By default 5% of
   host memory is reserved for CMA. Presumably increasing this will
   increase the likelihood that the kernel can service a request for
   contiguous memory. Are there any recommended tunings here?

 - is there anything else the user could try?

Thanks!

Regards,
Daniel

[1] https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1632045
[2] https://bugzilla.redhat.com/show_bug.cgi?id=1304300

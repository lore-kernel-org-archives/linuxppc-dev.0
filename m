Return-Path: <SRS0=ImKy=S4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27AAEC43218
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 14:26:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9291D206C1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 14:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNKjPJXY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9291D206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44rGZF4zgFzDqht
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Apr 2019 00:26:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com;
 envelope-from=changbin.du@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="bNKjPJXY"; 
 dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44rGWq26PXzDqPR
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Apr 2019 00:24:07 +1000 (AEST)
Received: by mail-pf1-x441.google.com with SMTP id 10so1815156pfo.5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2019 07:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=8AQ2GkngH1De/6XzGohWoAVpJB2lelkaRG8sTS9mhMQ=;
 b=bNKjPJXYCcnMRb4CgyavROJDvz580E5qQgxUpn/9Mj6rjtE0rYaq0SxQoBgfO48vmk
 /VfzrOZ8ZN8qUeLoAGxLZORUANQ3JCesRjEORUbuogBqZk+YHD0xGKrJT/GoGnaToe4r
 kwbSTcZgXfi2jii8y2pKTvsBggAdJjkCsr0MaQw6K6c35I+nGHQzH3by0XgR8LUZxl36
 SEQDlRGZmg0vt2B8cihXYdTPvB+3iwfaOgZ6NnBjiv/E5HnhtZrNsUFX8CT4A3b4ZKgZ
 d3fhwF+uOta6W9nuvJxkbiNrEqTHqb6Z5QV0VzcQqypw2PTKlQwfL6YSN9c46hWTSdCy
 B88A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=8AQ2GkngH1De/6XzGohWoAVpJB2lelkaRG8sTS9mhMQ=;
 b=PCRv2BpTrQKPsDrh85A5wMnXW2hTTdnldJBUkGbgKk0IKCgvZdIu1xd0zGa+UY/4KY
 /KviCAMqtCMhrud0bDnUvadVUilBTD0/m9E6HbMMN1qcZUhBuH8aeZasyO08f5Ljdkc5
 FYMpWeMyP3iODXUqVKydtluqWnZBoGXqUBHNHRAVPfoOGAJUgXkNKNDgVOQgld0qgg4u
 faMKBQ2N+rZbNbDQ88XIxFXPY5U8KdFYK7XQjCMhWlkztkMNjNIK938BpxyJRNjLYdUi
 wR4oZj8YubJNs8lTDvlPpefrPcUd1PEXLcEYExKEbpqAc3VnAUaCBTDKh+R1yHe3ZLcg
 Ewug==
X-Gm-Message-State: APjAAAWmG1i89lUF6dc04/SEPdpBmvIqnFHiZIVbAx4rymLEmCjN8Uvs
 kFQhY3YB9A8afYNwcsLP5WA=
X-Google-Smtp-Source: APXvYqzOhSS96XBS6//FlzBxLAJB7NizGmVPmh3diujylNVWoJ/k4w9X4288juAjaooqChU9jWEdcQ==
X-Received: by 2002:a65:4489:: with SMTP id l9mr42554893pgq.1.1556288643966;
 Fri, 26 Apr 2019 07:24:03 -0700 (PDT)
Received: from mail.google.com ([104.238.181.70])
 by smtp.gmail.com with ESMTPSA id e23sm35659131pfd.11.2019.04.26.07.23.57
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 26 Apr 2019 07:24:03 -0700 (PDT)
Date: Fri, 26 Apr 2019 22:23:54 +0800
From: Changbin Du <changbin.du@gmail.com>
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: [PATCH v4 39/63] Documentation: x86: convert topology.txt to reST
Message-ID: <20190426142352.dyrxkzrw6h7hgyv4@mail.google.com>
References: <20190423162932.21428-1-changbin.du@gmail.com>
 <20190423162932.21428-40-changbin.du@gmail.com>
 <20190424144407.0df2c2f5@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424144407.0df2c2f5@coco.lan>
User-Agent: NeoMutt/20180716
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: fenghua.yu@intel.com, x86@kernel.org, Jonathan Corbet <corbet@lwn.net>,
 linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-doc@vger.kernel.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, mingo@redhat.com,
 Bjorn Helgaas <bhelgaas@google.com>, tglx@linutronix.de,
 linuxppc-dev@lists.ozlabs.org, Changbin Du <changbin.du@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Apr 24, 2019 at 02:44:07PM -0300, Mauro Carvalho Chehab wrote:
> Em Wed, 24 Apr 2019 00:29:08 +0800
> Changbin Du <changbin.du@gmail.com> escreveu:
> 
> > This converts the plain text documentation to reStructuredText format and
> > add it to Sphinx TOC tree. No essential content change.
> > 
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > ---
> >  Documentation/x86/index.rst    |   1 +
> >  Documentation/x86/topology.rst | 228 +++++++++++++++++++++++++++++++++
> >  Documentation/x86/topology.txt | 217 -------------------------------
> >  3 files changed, 229 insertions(+), 217 deletions(-)
> >  create mode 100644 Documentation/x86/topology.rst
> >  delete mode 100644 Documentation/x86/topology.txt
> 
> Why? Please preserve as much as possible from the original file...
> it is really hard to see what you're doing. Most of those x86
> files are already almost at ReST format (like this one). There's
> absolutely **no reason** why you would do so much radical changes
> that would below the 50% similarity threshold that would make git
> to recognize as a change on the same file!
>
My editor changed the indent. I need to redo this conversion. Thanks.

> I'll give a quick review on this one, but it is really hard to be
> sure that something is missing, when the similarity is too low.
> 
> > 
> > diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
> > index 8f08caf4fbbb..2033791e53bc 100644
> > --- a/Documentation/x86/index.rst
> > +++ b/Documentation/x86/index.rst
> > @@ -9,3 +9,4 @@ Linux x86 Support
> >     :numbered:
> >  
> >     boot
> > +   topology
> > diff --git a/Documentation/x86/topology.rst b/Documentation/x86/topology.rst
> > new file mode 100644
> > index 000000000000..1df5f56f4882
> > --- /dev/null
> > +++ b/Documentation/x86/topology.rst
> > @@ -0,0 +1,228 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +============
> > +x86 Topology
> > +============
> > +
> > +This documents and clarifies the main aspects of x86 topology modelling and
> > +representation in the kernel. Update/change when doing changes to the
> > +respective code.
> > +
> > +The architecture-agnostic topology definitions are in
> > +Documentation/cputopology.txt. This file holds x86-specific
> > +differences/specialities which must not necessarily apply to the generic
> > +definitions. Thus, the way to read up on Linux topology on x86 is to start
> > +with the generic one and look at this one in parallel for the x86 specifics.
> > +
> > +Needless to say, code should use the generic functions - this file is *only*
> > +here to *document* the inner workings of x86 topology.
> > +
> > +Started by Thomas Gleixner <tglx@linutronix.de> and Borislav Petkov <bp@alien8.de>.
> > +
> > +The main aim of the topology facilities is to present adequate interfaces to
> > +code which needs to know/query/use the structure of the running system wrt
> > +threads, cores, packages, etc.
> > +
> > +The kernel does not care about the concept of physical sockets because a
> > +socket has no relevance to software. It's an electromechanical component. In
> > +the past a socket always contained a single package (see below), but with the
> > +advent of Multi Chip Modules (MCM) a socket can hold more than one package. So
> > +there might be still references to sockets in the code, but they are of
> > +historical nature and should be cleaned up.
> > +
> > +The topology of a system is described in the units of:
> > +
> > +    - packages
> > +    - cores
> > +    - threads 
> > +
> > +Package
> > +=======
> > +
> > +Packages contain a number of cores plus shared resources, e.g. DRAM
> > +controller, shared caches etc.
> > +
> > +AMD nomenclature for package is 'Node'.
> > +
> > +Package-related topology information in the kernel:
> > +
> > +  - cpuinfo_x86.x86_max_cores:
> > +
> > +    The number of cores in a package. This information is retrieved via CPUID.
> > +
> > +  - cpuinfo_x86.phys_proc_id:
> > +
> > +    The physical ID of the package. This information is retrieved via CPUID
> > +    and deduced from the APIC IDs of the cores in the package.
> > +
> > +  - cpuinfo_x86.logical_id:
> > +
> > +    The logical ID of the package. As we do not trust BIOSes to enumerate the
> > +    packages in a consistent way, we introduced the concept of logical package
> > +    ID so we can sanely calculate the number of maximum possible packages in
> > +    the system and have the packages enumerated linearly.
> > +
> > +  - topology_max_packages():
> > +
> > +    The maximum possible number of packages in the system. Helpful for per
> > +    package facilities to preallocate per package information.
> > +
> > +  - cpu_llc_id:
> > +
> > +    A per-CPU variable containing:
> > +
> > +    - On Intel, the first APIC ID of the list of CPUs sharing the Last Level
> > +      Cache.
> > +
> > +    - On AMD, the Node ID or Core Complex ID containing the Last Level
> > +      Cache. In general, it is a number identifying an LLC uniquely on the
> > +      system.
> > +
> > +Cores
> > +=====
> > +
> > +A core consists of 1 or more threads. It does not matter whether the threads
> > +are SMT- or CMT-type threads.
> > +
> > +AMDs nomenclature for a CMT core is "Compute Unit". The kernel always uses
> > +"core".
> > +
> > +Core-related topology information in the kernel:
> > +
> > +  - smp_num_siblings:
> > +
> > +    The number of threads in a core. The number of threads in a package can be
> > +    calculated by::
> > +
> > +      threads_per_package = cpuinfo_x86.x86_max_cores * smp_num_siblings
> > +
> > +
> > +Threads
> > +=======
> > +
> > +A thread is a single scheduling unit. It's the equivalent to a logical Linux
> > +CPU.
> > +
> > +AMDs nomenclature for CMT threads is "Compute Unit Core". The kernel always
> > +uses "thread".
> > +
> > +Thread-related topology information in the kernel:
> > +
> > +  - topology_core_cpumask():
> > +
> > +    The cpumask contains all online threads in the package to which a thread
> > +    belongs.
> > +
> > +    The number of online threads is also printed in /proc/cpuinfo "siblings."
> > +
> > +  - topology_sibling_cpumask():
> > +
> > +    The cpumask contains all online threads in the core to which a thread
> > +    belongs.
> > +
> > +  - topology_logical_package_id():
> > +
> > +    The logical package ID to which a thread belongs.
> > +
> > +  - topology_physical_package_id():
> > +
> > +    The physical package ID to which a thread belongs.
> > +
> > +  - topology_core_id();
> > +
> > +    The ID of the core to which a thread belongs. It is also printed in /proc/cpuinfo
> > +    "core_id."
> > +
> > +
> > +
> > +System topology examples
> > +========================
> > +
> > +.. note:: The alternative Linux CPU enumeration depends on how the BIOS
> > +  enumerates the threads. Many BIOSes enumerate all threads 0 first and
> > +  then all threads 1. That has the "advantage" that the logical Linux CPU
> > +  numbers of threads 0 stay the same whether threads are enabled or not.
> > +  That's merely an implementation detail and has no practical impact.
> > +
> > +1) Single Package, Single Core
> > +::
> 
> I would just place the :: on the above line. Same applies to similar
> cases on this file.
> 
Sure.

> > +
> > +   [package 0] -> [core 0] -> [thread 0] -> Linux CPU 0
> > +
> > +2) Single Package, Dual Core
> > +
> > +  a) One thread per core
> > +  ::
> > +
> > +    [package 0] -> [core 0] -> [thread 0] -> Linux CPU 0
> > +          -> [core 1] -> [thread 0] -> Linux CPU 1
> 
> Something got broken here.
> 
> > +
> > +  b) Two threads per core
> > +  ::
> > +
> > +    [package 0] -> [core 0] -> [thread 0] -> Linux CPU 0
> > +          -> [thread 1] -> Linux CPU 1
> > +          -> [core 1] -> [thread 0] -> Linux CPU 2
> > +          -> [thread 1] -> Linux CPU 3
> 
> And here... This one, for example, should be, instead:
> 
>         [package 0] -> [core 0] -> [thread 0] -> Linux CPU 0
>                                 -> [thread 1] -> Linux CPU 1
>                     -> [core 1] -> [thread 0] -> Linux CPU 2
>                                 -> [thread 1] -> Linux CPU 3
> 
> Clearly there's something that it is messing with tabs on your
> x86 conversion.
>
Sorry for such mistake. I will check them one by one.

> I'll stop my review here, as it sounds pointless to review it,
> as there are too many broken whitespace stuff on your
> conversion.
> 
> Thanks,
> Mauro

-- 
Cheers,
Changbin Du

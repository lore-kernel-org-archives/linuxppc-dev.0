Return-Path: <duwe@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5EEF71A03A7
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Sep 2015 00:39:29 +1000 (AEST)
Date: Sat, 26 Sep 2015 16:30:08 +0200
From: Torsten Duwe <duwe@lst.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: live-patching@vger.kernel.org
Subject: -mprofile-kernel vs. notrace in ppc64(le) Linux kernels
Message-ID: <20150926143008.GA14606@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As I mentioned earlier this year, it's a bad idea to call _mcount from
MMU helper functions (e.g. hash_page...), when the profiling/tracing/
live-patching/whatever framewok might in turn cause another such fault.
Jikos suggested to use fine-grained control of these functions with the
"notrace" keyword in the Linux kernel. It is mapped to GCC's (4.8, FWIW)
__attribute__((no_instrument_function)), which, to my surprise, works
for -p and -pg nicely, but does not affect -mprofile-kernel at all!

Should we consider this a bug? IMHO it is. I can see in the GCC sources
that -mprofile-kernel is more like a low-level hack in rs6000.c,
quite far below the RTL code generator, so the no_instrument_function
attribute is probably hard to check for.

What is -mprofile-kernel good for, if it bears such a risk of crashing
the kernel? Is it the right hook for ppc64 live patching? How to protect
those critical functions? Filter -mprofile-kernel for those object files?
Ask the GCC experts to fix this?

Any ideas welcome!

	Torsten

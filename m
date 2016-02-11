Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4028E1A0038
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Feb 2016 19:40:36 +1100 (AEDT)
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <kamalesh@linux.vnet.ibm.com>;
 Thu, 11 Feb 2016 18:40:35 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id D43633578052
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Feb 2016 19:40:32 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1B8eOGh36765922
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Feb 2016 19:40:32 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1B8dxEK012203
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Feb 2016 19:40:00 +1100
Date: Thu, 11 Feb 2016 14:09:33 +0530
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: Torsten Duwe <duwe@lst.de>, Michael Ellerman <mpe@ellerman.id.au>,
 Jiri Kosina <jkosina@suse.cz>, Miroslav Benes <mbenes@suse.cz>,
 Petr Mladek <pmladek@suse.com>, Jessica Yu <jeyu@redhat.com>,
 Steven Rostedt <rostedt@goodmis.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Subject: Re: [PATCH v8 4/8] ppc64 ftrace_with_regs configuration variables
Message-ID: <20160211083932.GA23103@linux.vnet.ibm.com>
Reply-To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
References: <20160210174221.EBBEC692C8@newverein.lst.de>
 <20160210174450.9C065692C8@newverein.lst.de>
 <1455176897.2885.12.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1455176897.2885.12.camel@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Balbir Singh <bsingharora@gmail.com> [2016-02-11 18:48:17]:

> On Wed, 2016-02-10 at 17:25 +0100, Torsten Duwe wrote:
> 
> snip
> 
> > diff --git a/arch/powerpc/gcc-mprofile-kernel-notrace.sh b/arch/powerpc/gcc-mprofile-kernel-notrace.sh
> > new file mode 100755
> > index 0000000..68d6482
> > --- /dev/null
> > +++ b/arch/powerpc/gcc-mprofile-kernel-notrace.sh
> > @@ -0,0 +1,33 @@
> > +#!/bin/sh
> > +# Test whether the compile option -mprofile-kernel
> > +# generates profiling code ( = a call to mcount), and
> > +# whether a function without any global references sets
> > +# the TOC pointer properly at the beginning, and
> > +# whether the "notrace" function attribute successfully
> > +# suppresses the _mcount call.
> > +
> > +echo "int func() { return 0; }" | \
> > +    $* -S -x c -O2 -p -mprofile-kernel - -o - 2> /dev/null | \
> > +    grep -q "mcount"
> > +
> > +trace_result=$?
> > +
> > +echo "int func() { return 0; }" | \
> > +    $* -S -x c -O2 -p -mprofile-kernel - -o - 2> /dev/null | \
> > +    sed -n -e '/func:/,/bl _mcount/p' | grep -q TOC
> > +
> > +leaf_toc_result=$?
> > +
> 
> leaf_toc_result failed for me with gcc 5. I'll try and grab gcc-6
> and give the patches a spin
> 

It fails for me to on ppc64le but pass over ppc64

# gcc -v
Using built-in specs.
COLLECT_GCC=gcc
COLLECT_LTO_WRAPPER=/usr/libexec/gcc/ppc64-redhat-linux/5.1.1/lto-wrapper
Target: ppc64-redhat-linux
[...]
gcc version 5.1.1 20150422 (Red Hat 5.1.1-1) (GCC)

# echo "int func() { return 0;  }" |     gcc -S -x c -O2 -p -mprofile-kernel - -o - 2> /dev/null |     sed -n -e '/func:/,/bl _mcount/p'
func:
        .quad   .L.func,.TOC.@tocbase
        .previous
        .type   func, @function
.L.func:
        mflr 0
        std 0,16(1)
        bl _mcount

# gcc -v
Using built-in specs.
COLLECT_GCC=gcc
COLLECT_LTO_WRAPPER=/usr/lib/gcc/powerpc64le-linux-gnu/5/lto-wrapper
Target: powerpc64le-linux-gnu
[...]
gcc version 5.3.1 20160205 (Ubuntu/IBM 5.3.1-8ubuntu2)

# echo "int func() { return 0;  }" |     gcc -S -x c -O2 -p -mprofile-kernel - -o - 2> /dev/null |     sed -n -e '/func:/,/bl _mcount/p'
func:
        mflr 0
        std 0,16(1)
        bl _mcount


I will try it over gcc-6.

Thanks,
Kamalesh

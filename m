Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com
 [IPv6:2607:f8b0:400e:c03::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 10FB31A00FB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Feb 2016 20:35:39 +1100 (AEDT)
Received: by mail-pa0-x244.google.com with SMTP id fl4so2190034pad.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Feb 2016 01:35:38 -0800 (PST)
Message-ID: <1455183328.2885.18.camel@gmail.com>
Subject: Re: [PATCH v8 4/8] ppc64 ftrace_with_regs configuration variables
From: Balbir Singh <bsingharora@gmail.com>
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Cc: Torsten Duwe <duwe@lst.de>, Michael Ellerman <mpe@ellerman.id.au>, Jiri
 Kosina <jkosina@suse.cz>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek
 <pmladek@suse.com>,  Jessica Yu <jeyu@redhat.com>, Steven Rostedt
 <rostedt@goodmis.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Date: Thu, 11 Feb 2016 20:35:28 +1100
In-Reply-To: <20160211083932.GA23103@linux.vnet.ibm.com>
References: <20160210174221.EBBEC692C8@newverein.lst.de>
 <20160210174450.9C065692C8@newverein.lst.de>
 <1455176897.2885.12.camel@gmail.com>
 <20160211083932.GA23103@linux.vnet.ibm.com>
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

On Thu, 2016-02-11 at 14:09 +0530, Kamalesh Babulal wrote:
> * Balbir Singh <bsingharora@gmail.com> [2016-02-11 18:48:17]:
> 
> > On Wed, 2016-02-10 at 17:25 +0100, Torsten Duwe wrote:
> > 
> > snip
> > 
> > > diff --git a/arch/powerpc/gcc-mprofile-kernel-notrace.sh
> > > b/arch/powerpc/gcc-mprofile-kernel-notrace.sh
> > > new file mode 100755
> > > index 0000000..68d6482
> > > --- /dev/null
> > > +++ b/arch/powerpc/gcc-mprofile-kernel-notrace.sh
> > > @@ -0,0 +1,33 @@
> > > +#!/bin/sh
> > > +# Test whether the compile option -mprofile-kernel
> > > +# generates profiling code ( = a call to mcount), and
> > > +# whether a function without any global references sets
> > > +# the TOC pointer properly at the beginning, and
> > > +# whether the "notrace" function attribute successfully
> > > +# suppresses the _mcount call.
> > > +
> > > +echo "int func() { return 0; }" | \
> > > +    $* -S -x c -O2 -p -mprofile-kernel - -o - 2> /dev/null | \
> > > +    grep -q "mcount"
> > > +
> > > +trace_result=$?
> > > +
> > > +echo "int func() { return 0; }" | \
> > > +    $* -S -x c -O2 -p -mprofile-kernel - -o - 2> /dev/null | \
> > > +    sed -n -e '/func:/,/bl _mcount/p' | grep -q TOC
> > > +
> > > +leaf_toc_result=$?
> > > +
> > 
> > leaf_toc_result failed for me with gcc 5. I'll try and grab gcc-6
> > and give the patches a spin
> > 
> 
> It fails for me to on ppc64le but pass over ppc64
> 

This series is for ppc64le only, so we can safely ignore ppc64 for now

Regards,
Balbir Singh.

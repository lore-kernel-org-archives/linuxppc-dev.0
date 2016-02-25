Return-Path: <duwe@lst.de>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 81FB71A0341
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Feb 2016 01:34:09 +1100 (AEDT)
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 187E814031F
 for <linuxppc-dev@ozlabs.org>; Fri, 26 Feb 2016 01:34:09 +1100 (AEDT)
Date: Thu, 25 Feb 2016 15:34:06 +0100
From: Torsten Duwe <duwe@lst.de>
To: Balbir Singh <bsingharora@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 kamalesh@linux.vnet.ibm.com, pmladek@suse.com, jeyu@redhat.com,
 jkosina@suse.cz, live-patching@vger.kernel.org, mbenes@suse.cz
Subject: Re: [PATCH 10/12] powerpc/ftrace: FTRACE_WITH_REGS configuration
 variables
Message-ID: <20160225143406.GJ21932@lst.de>
References: <1456324115-21144-1-git-send-email-mpe@ellerman.id.au>
 <1456324115-21144-10-git-send-email-mpe@ellerman.id.au>
 <56CE54C5.1060204@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56CE54C5.1060204@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Feb 25, 2016 at 12:11:33PM +1100, Balbir Singh wrote:
> On 25/02/16 01:28, Michael Ellerman wrote:
> >
> > diff --git a/arch/powerpc/gcc-mprofile-kernel-notrace.sh b/arch/powerpc/gcc-mprofile-kernel-notrace.sh
> > new file mode 100755
> > index 000000000000..68d6482d56ab
> > --- /dev/null
> > +++ b/arch/powerpc/gcc-mprofile-kernel-notrace.sh
> > @@ -0,0 +1,33 @@
> > +#!/bin/sh
> > +# Test whether the compile option -mprofile-kernel
> > +# generates profiling code ( = a call to mcount), and
> > +# whether a function without any global references sets
> > +# the TOC pointer properly at the beginning, and

Remove the above two lines, for completeness,

> > +# whether the "notrace" function attribute successfully
> > +# suppresses the _mcount call.
> > +
> > +echo "int func() { return 0; }" | \
> > +    $* -S -x c -O2 -p -mprofile-kernel - -o - 2> /dev/null | \
> > +    grep -q "mcount"
> > +
> > +trace_result=$?
> > +
> > +echo "int func() { return 0; }" | \
> > +    $* -S -x c -O2 -p -mprofile-kernel - -o - 2> /dev/null | \
> > +    sed -n -e '/func:/,/bl _mcount/p' | grep -q TOC
> > +
> > +leaf_toc_result=$?
> > +
> We should remove this bit, we don't need a TOC for leaf procedures anymore

Exactly. I thought it was a bug when I wrote this test, Michael insisted
it was a feature :-)

> > +/bin/echo -e "#include <linux/compiler.h>\nnotrace int func() { return 0; }" | \
> > +    $* -S -x c -O2 -p -mprofile-kernel - -o - 2> /dev/null | \
> > +    grep -q "mcount"
> > +
> > +notrace_result=$?
> > +
> > +if [ "$trace_result" -eq "0" -a \
> > +	"$leaf_toc_result" -eq "0" -a \

In particular, remove this ^ line.

> > +	"$notrace_result" -eq "1" ]; then
> > +	echo y
> > +else
> > +	echo n
> > +fi

That version would have made it into my v9.

Signed-off-by: Torsten Duwe <duwe@suse.de>

	Torsten

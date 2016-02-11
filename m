Return-Path: <msampath@alphion.com>
Received: from mx1.alphion.com (mx1.alphion.com [71.168.162.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E92661A003D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Feb 2016 00:07:04 +1100 (AEDT)
From: Murali Sampath <MSampath@alphion.com>
To: Balbir Singh <bsingharora@gmail.com>, Kamalesh Babulal
 <kamalesh@linux.vnet.ibm.com>
CC: Petr Mladek <pmladek@suse.com>, Jessica Yu <jeyu@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>, Torsten Duwe <duwe@lst.de>, Jiri Kosina
 <jkosina@suse.cz>, "live-patching@vger.kernel.org"
 <live-patching@vger.kernel.org>, Miroslav Benes <mbenes@suse.cz>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v8 4/8] ppc64 ftrace_with_regs configuration variables
Date: Thu, 11 Feb 2016 13:00:15 +0000
Message-ID: <20160211130014.5955729.76685.27387@alphion.com>
References: <20160210174221.EBBEC692C8@newverein.lst.de>
 <20160210174450.9C065692C8@newverein.lst.de>
 <1455176897.2885.12.camel@gmail.com>
 <20160211083932.GA23103@linux.vnet.ibm.com>,
 <1455183328.2885.18.camel@gmail.com>
In-Reply-To: <1455183328.2885.18.camel@gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



  Original Message
From: Balbir Singh
Sent: Thursday, February 11, 2016 4:37 AM
To: Kamalesh Babulal
Cc: Petr Mladek; Jessica Yu; linux-kernel@vger.kernel.org; Steven Rostedt; =
Torsten Duwe; Jiri Kosina; live-patching@vger.kernel.org; Miroslav Benes; l=
inuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v8 4/8] ppc64 ftrace_with_regs configuration variables


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
> > > +# generates profiling code ( =3D a call to mcount), and
> > > +# whether a function without any global references sets
> > > +# the TOC pointer properly at the beginning, and
> > > +# whether the "notrace" function attribute successfully
> > > +# suppresses the _mcount call.
> > > +
> > > +echo "int func() { return 0; }" | \
> > > +    $* -S -x c -O2 -p -mprofile-kernel - -o - 2> /dev/null | \
> > > +    grep -q "mcount"
> > > +
> > > +trace_result=3D$?
> > > +
> > > +echo "int func() { return 0; }" | \
> > > +    $* -S -x c -O2 -p -mprofile-kernel - -o - 2> /dev/null | \
> > > +    sed -n -e '/func:/,/bl _mcount/p' | grep -q TOC
> > > +
> > > +leaf_toc_result=3D$?
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
_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@lists.ozlabs.org
https://lists.ozlabs.org/listinfo/linuxppc-dev

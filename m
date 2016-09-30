Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3slZp334VCzDvJv
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Sep 2016 12:17:15 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id 21so4298415pfy.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Sep 2016 19:17:15 -0700 (PDT)
Date: Fri, 30 Sep 2016 10:17:09 +0800
From: Simon Guo <wei.guo.simon@gmail.com>
To: Cyril Bur <cyrilbur@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Shuah Khan <shuah@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Chris Smart <chris@distroguy.com>,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
 Michael Neuling <mikey@neuling.org>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Jack Miller <jack@codezen.org>, Rashmica Gupta <rashmicy@gmail.com>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v14 13/15] selftests/powerpc: Add ptrace tests for TM SPR
 registers
Message-ID: <20160930021709.GA23717@simonLocalRHEL7.x64>
References: <1473665605-11890-1-git-send-email-wei.guo.simon@gmail.com>
 <1473665605-11890-14-git-send-email-wei.guo.simon@gmail.com>
 <1473829452.2554.19.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1473829452.2554.19.camel@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Cyril,
On Wed, Sep 14, 2016 at 03:04:12PM +1000, Cyril Bur wrote:
> On Mon, 2016-09-12 at 15:33 +0800, wei.guo.simon@gmail.com wrote:
> > From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> > 
> > This patch adds ptrace interface test for TM SPR registers. This
> > also adds ptrace interface based helper functions related to TM
> > SPR registers access.
> > 
> 
> I'm seeing this one fail a lot, it does occasionally succeed but fails
> a lot on my test setup.
> 
> I use qemu on a power8 for most of my testing:
> qemu-system-ppc64 --enable-kvm -machine pseries,accel=kvm,usb=off -m
> 4096 -realtime mlock=off -smp 4,sockets=1,cores=2,threads=2 -nographic
> -vga none
> 
> 
> > Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> > Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
> > ---
> >  tools/testing/selftests/powerpc/ptrace/Makefile    |   3 +-
> >  .../selftests/powerpc/ptrace/ptrace-tm-spr.c       | 186
> > +++++++++++++++++++++
> >  tools/testing/selftests/powerpc/ptrace/ptrace.h    |  35 ++++
> >  3 files changed, 223 insertions(+), 1 deletion(-)
> >  create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace-tm-
> > spr.c
> > 
> > diff --git a/tools/testing/selftests/powerpc/ptrace/Makefile
> > b/tools/testing/selftests/powerpc/ptrace/Makefile
> > index 797840a..f34670e 100644
> > --- a/tools/testing/selftests/powerpc/ptrace/Makefile
> > +++ b/tools/testing/selftests/powerpc/ptrace/Makefile
> > @@ -1,7 +1,8 @@
> >  TEST_PROGS := ptrace-ebb ptrace-gpr ptrace-tm-gpr ptrace-tm-spd-gpr
> > \
> >  ptrace-tar ptrace-tm-tar ptrace-tm-spd-tar ptrace-vsx ptrace-tm-vsx
> > \
> > -ptrace-tm-spd-vsx
> > +ptrace-tm-spd-vsx ptrace-tm-spr
> >  
> > +include ../../lib.mk
> >  
> >  all: $(TEST_PROGS)
> >  CFLAGS += -m64
> > diff --git a/tools/testing/selftests/powerpc/ptrace/ptrace-tm-spr.c
> > b/tools/testing/selftests/powerpc/ptrace/ptrace-tm-spr.c
> > new file mode 100644
> > index 0000000..2863070
> > --- /dev/null
> > +++ b/tools/testing/selftests/powerpc/ptrace/ptrace-tm-spr.c
> > @@ -0,0 +1,186 @@
> > +/*
> > + * Ptrace test TM SPR registers
> > + *
> > + * Copyright (C) 2015 Anshuman Khandual, IBM Corporation.
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public License
> > + * as published by the Free Software Foundation; either version
> > + * 2 of the License, or (at your option) any later version.
> > + */
> > +#include "ptrace.h"
> > +
> > +/* Tracee and tracer shared data */
> > +struct shared {
> > +	int flag;
> > +	struct tm_spr_regs regs;
> > +};
> > +unsigned long tfhar;
> > +
> > +int shm_id;
> > +volatile struct shared *cptr, *pptr;
> > +
> > +int shm_id1;
> > +volatile int *cptr1, *pptr1;
> > +
> > +#define TM_SCHED	0xde0000018c000001
> > +#define TM_KVM_SCHED	0xe0000001ac000001
> > +
> > +int validate_tm_spr(struct tm_spr_regs *regs)
> > +{
> > +	if (regs->tm_tfhar != tfhar)
> > +		return TEST_FAIL;
> > +
> > +	if ((regs->tm_texasr != TM_SCHED) && (regs->tm_texasr !=
> > TM_KVM_SCHED))
> > +		return TEST_FAIL;
> 
> The above condition fails, should this test try again if this condition
> is true, rather than fail?
> 

I reproduced the failure with your configuration. Besides treclaim, there are 
many other reasons that may lead to the transaction failure according to ISA.  
At least I observed following Texasr values:
      1000018000001
      1000088000001
      10000a8000001


I noticed some FIAR locates at IPI handling related code.  My previous configuration 
is 4 sockets/each with only 1 core/1 thread. That is probably the reason I always 
passed the test in the old configuration.(per my understanding, IPI is limited within 
threads).  So I removed the checking regarding specfied TEXASR value.

And I think I have reworked all your other comments.

I will send out v15 soon. Again thanks for your code inspection.

BR,
- Simon

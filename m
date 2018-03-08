Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zxxGZ444jzF09v
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Mar 2018 03:45:58 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w28GjVZY036905
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 8 Mar 2018 11:45:56 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gk847jpgq-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Mar 2018 11:45:55 -0500
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Thu, 8 Mar 2018 16:45:53 -0000
Date: Thu, 8 Mar 2018 08:45:45 -0800
From: Ram Pai <linuxram@us.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Li Wang <liwang@redhat.com>, Jan Stancek <jstancek@redhat.com>,
 ltp@lists.linux.it, linux-mm@kvack.org,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [bug?] Access was denied by memory protection keys in
 execute-only address
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <CAEemH2f0LDqyR5AmUYv17OuBc5-UycckDPWgk46XU_ghQo4diw@mail.gmail.com>
 <871sguep4v.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <871sguep4v.fsf@concordia.ellerman.id.au>
Message-Id: <20180308164545.GM1060@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 08, 2018 at 11:19:12PM +1100, Michael Ellerman wrote:
> Li Wang <liwang@redhat.com> writes:
> > Hi,
> >
> > ltp/mprotect04[1] crashed by SEGV_PKUERR on ppc64(LPAR on P730, Power 8
> > 8247-22L) with kernel-v4.16.0-rc4.
> >
> > 10000000-10020000 r-xp 00000000 fd:00 167223           mprotect04
> > 10020000-10030000 r--p 00010000 fd:00 167223           mprotect04
> > 10030000-10040000 rw-p 00020000 fd:00 167223           mprotect04
> > 1001a380000-1001a3b0000 rw-p 00000000 00:00 0          [heap]
> > 7fffa6c60000-7fffa6c80000 --xp 00000000 00:00 0 ​
> >
> > ​&exec_func = 0x10030170​
> >
> > ​&func = 0x7fffa6c60170​
> >
> > ​While perform ​
> > "(*func)();" we get the
> > ​segmentation fault.
> > ​
> >
> > ​strace log:​
> >
> > -------------------
> > ​mprotect(0x7fffaed00000, 131072, PROT_EXEC) = 0
> > rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
> > --- SIGSEGV {si_signo=SIGSEGV, si_code=SEGV_PKUERR, si_addr=0x7fffaed00170}
> > ---​
> 
> Looks like a bug to me.
> 
> Please Cc linuxppc-dev on powerpc bugs.
> 
> I also can't reproduce this failure on my machine.
> Not sure what's going on?

I could reproduce it on a power7 lpar.  But not on a power8 lpar.

The problem seems to be that the cpu generates a key exception if
the page with Read/Write-disable-but-execute-enable key is executed
on power7. If I enable read on that key, the exception disappears.

BTW: the testcase executes mprotect(..,PROT_EXEC).
The mprotect(, PROT_EXEC) system call internally generates a
execute-only key and associates it with the pages in the address-range.

Now since Li Wang claims that he can reproduce it on power8 as well, i
am wondering if the slightly different cpu behavior is dependent on the
version of the firmware/microcode?


RP

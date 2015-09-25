Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B2C1D1A01EE
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2015 10:05:18 +1000 (AEST)
Message-ID: <1443139518.2157.0.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc/vdso: Avoid link stack corruption in
 __get_datapage()
From: Michael Ellerman <mpe@ellerman.id.au>
To: Denis Kirjanov <kda@linux-powerpc.org>
Cc: Michael Neuling <mikey@neuling.org>, Steve Munroe <sjmunroe@us.ibm.com>,
 Anton Blanchard <anton@samba.org>, Aaron Sawdey <sawdey@us.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Fri, 25 Sep 2015 10:05:18 +1000
In-Reply-To: <CAOJe8K20scaHxV50KmzsFGA7uTGZdq7MTkeDCdraG0350gvLeQ@mail.gmail.com>
References: <1442988302.31273.81.camel@neuling.org>
 <8B86AA57-EFAD-4D4E-860A-8F8251DF10AD@ellerman.id.au>
 <CAOJe8K20scaHxV50KmzsFGA7uTGZdq7MTkeDCdraG0350gvLeQ@mail.gmail.com>
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

On Thu, 2015-09-24 at 13:10 +0300, Denis Kirjanov wrote:
> On 9/24/15, Michael Ellerman <michael@ellerman.id.au> wrote:
> > On 23 September 2015 16:05:02 GMT+10:00, Michael Neuling <mikey@neuling.org>
> > wrote:
> >>
> >>Testcase tb.c (stolen from Anton)
> >>  /* gcc -O2 tb.c -o tb */
> >>  #include <sys/time.h>
> >>  #include <stdio.h>
> >>
> >>  int main()
> >>  {
> >>	  int i;
> >>
> >>	  struct timeval tv_start, tv_end;
> >>
> >>	  gettimeofday(&tv_start, NULL);
> >>
> >>	  for(i = 0; i < 10000000; i++) {
> >>		  gettimeofday(&tv_end, NULL);
> >>	  }
> >>
> >>	  printf("time = %.6f\n", tv_end.tv_sec - tv_start.tv_sec +
> >>(tv_end.tv_usec - tv_start.tv_usec) * 1e-6);
> >>
> >>	  return 0;
> >>  }
> >
> > You know where test cases are supposed to go.
> >
> > I know it's not a pass/fail test, but it's still useful. If it's in the tree
> > it will get run as part of automated test runs and we will have a record of
> > the result over time.
> 
> I can send a patch for it.

Mikey was working on it I think.

cheers

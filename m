Return-Path: <abdhalee@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 401S0L28YCzF10S
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 21:00:49 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2EA0dwi057493
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 06:00:47 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gq0dmtvxs-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 06:00:41 -0400
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <abdhalee@linux.vnet.ibm.com>;
 Wed, 14 Mar 2018 05:59:13 -0400
Subject: Re: [linux-next][bisected c7c133f3][gcc 4.8.5] build fail with
 error: first argument to
 =?UTF-8?Q?=E2=80=98=5F=5Fbuiltin=5Fchoose=5Fexpr=E2=80=99?= not a constant
From: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-next
 <linux-next@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 Kees Cook <keescook@chromium.org>, mpe <mpe@ellerman.id.au>, sachinp
 <sachinp@linux.vnet.ibm.com>
Date: Wed, 14 Mar 2018 15:29:06 +0530
In-Reply-To: <20180314193957.5f835d33@canb.auug.org.au>
References: <1521016194.31953.9.camel@abdul.in.ibm.com>
 <20180314193957.5f835d33@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1521021546.31953.12.camel@abdul.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-03-14 at 19:39 +1100, Stephen Rothwell wrote:
> Hi Abdul,
> 
> On Wed, 14 Mar 2018 13:59:54 +0530 Abdul Haleem <abdhalee@linux.vnet.ibm.com> wrote:
> >
> > Today's next kernel fails to build with gcc 4.8.5 on powerpc machine.
> 
> Thanks for the report.  Just for the future, please include  the
> next-XXXXXXXX tag when making reports about linux-next.

Sure, I will. next-20180313 is the bad tag
> 
> > ./include/linux/jiffies.h: In function ‘jiffies_delta_to_clock_t’:
> > ./include/linux/kernel.h:855:2: error: first argument to ‘__builtin_choose_expr’ not a constant
> >   __builtin_choose_expr(__builtin_constant_p(x) &&  \
> >   ^
> > ./include/linux/kernel.h:867:19: note: in expansion of macro ‘__max’
> >  #define max(x, y) __max(typeof(x), typeof(y), x, y)
> > 
> > Machine Type: Power8 Baremetal
> > gcc: 4.8.5
> > 
> > 
> > Builds fine when below patch is reverted
> > c7c133f3 kernel.h: skip single-eval logic on literals in min()/max()
> 
> Those patches have been removed from today's linux-next (next-20180314).

-- 
Regard's

Abdul Haleem
IBM Linux Technology Centre

Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41wjZV5WDRzDqC8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Aug 2018 08:56:02 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w7MMrdxe105914
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Aug 2018 18:56:00 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2m1cuuh1g5-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Aug 2018 18:55:59 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Wed, 22 Aug 2018 23:55:57 +0100
Date: Wed, 22 Aug 2018 15:55:47 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Christophe LEROY <christophe.leroy@c-s.fr>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 linux-mm <linux-mm@kvack.org>
Subject: Re: Odd SIGSEGV issue introduced by commit 6b31d5955cb29 ("mm, oom:
 fix potential data corruption when oom_reaper races with writer")
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <7767bdf4-a034-ecb9-1ac8-4fa87f335818@c-s.fr>
 <871sasmddc.fsf@concordia.ellerman.id.au>
 <20180821175049.GA5905@ram.oc3035372033.ibm.com>
 <633145ae-162c-9e03-6e8d-7442cbc8356c@c-s.fr>
MIME-Version: 1.0
In-Reply-To: <633145ae-162c-9e03-6e8d-7442cbc8356c@c-s.fr>
Message-Id: <20180822225547.GJ5905@ram.oc3035372033.ibm.com>
Content-Type: text/plain; charset=iso-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 22, 2018 at 10:19:02AM +0200, Christophe LEROY wrote:
> 
> 
> Le 21/08/2018 à 19:50, Ram Pai a écrit :
> >On Tue, Aug 21, 2018 at 04:40:15PM +1000, Michael Ellerman wrote:
> >>Christophe LEROY <christophe.leroy@c-s.fr> writes:
> >>...
> >>>
> >>>And I bisected its disappearance with commit 99cd1302327a2 ("powerpc:
> >>>Deliver SEGV signal on pkey violation")
> >>
> >>Whoa that's weird.
> >>
> >>>Looking at those two commits, especially the one which makes it
> >>>dissapear, I'm quite sceptic. Any idea on what could be the cause and/or
> >>>how to investigate further ?
> >>
> >>Are you sure it's not some corruption that just happens to be masked by
> >>that commit? I can't see anything in that commit that could explain that
> >>change in behaviour.
> >>
> >>The only real change is if you're hitting DSISR_KEYFAULT isn't it?
> >
> >even with the 'commit 99cd1302327a2', a SEGV signal should get generated;
> >which should kill the process. Unless the process handles SEGV signals
> >with SEGV_PKUERR differently.
> 
> No, the sigsegv are not handled differently. And the trace shown it
> is SEGV_MAPERR which is generated.
> 
> >
> >The other surprising thing is, why is DSISR_KEYFAULT getting generated
> >in the first place?  Are keys somehow getting programmed into the HPTE?
> 
> Can't be that, because DSISR_KEYFAULT is filtered out when applying
> DSISR_SRR1_MATCH_32S mask.

Ah.. in that case, 99cd1302327a2 does nothing to fix the problem.

Are you sure it is this patch that fixes the problem?


RP

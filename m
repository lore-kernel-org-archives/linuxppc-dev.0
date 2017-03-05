Return-Path: <benh@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vbzCk3TKWzDqBV
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Mar 2017 10:10:10 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v25N8WNA011942
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 5 Mar 2017 18:10:08 -0500
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28ytm409cg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Mar 2017 18:10:08 -0500
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Mon, 6 Mar 2017 09:10:05 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 8E4153578053
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Mar 2017 10:10:03 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v25N9tNJ48234748
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Mar 2017 10:10:03 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v25N9Uea025493
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Mar 2017 10:09:30 +1100
Subject: Re: [PATCH] powerpc: Avoid panic during boot due to divide by zero
 in init_cache_info()
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: Segher Boessenkool <segher@kernel.crashing.org>, Gabriel Paubert
 <paubert@iram.es>
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Date: Mon, 06 Mar 2017 10:09:01 +1100
In-Reply-To: <20170305172456.GN31469@gate.crashing.org>
References: <1488671674-20833-1-git-send-email-anton@ozlabs.org>
 <87pohw3tp4.fsf@concordia.ellerman.id.au>
 <20170305123737.GM31469@gate.crashing.org>
 <20170305165837.GA2019@visitor2.iram.es>
 <20170305172456.GN31469@gate.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1488755341.2870.117.camel@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2017-03-05 at 11:24 -0600, Segher Boessenkool wrote:
> On Sun, Mar 05, 2017 at 05:58:37PM +0100, Gabriel Paubert wrote:
> > > > Erk sorry. One of the static checkers spotted it, but I hadn't got
> > > > around to fixing it because it seemed to not actually blow up, guess
> > > > not.
> > > 
> > > The PowerPC divw etc. instructions do not trap by themselves, but recent
> > > GCC inserts trap instructions on code paths that are always undefined
> > > behaviour (like, dividing by zero).
> > 
> > Is it systematic or does it depend from, e.g., optimization levels?
> 
> In this case it needs -fisolate-erroneous-paths-dereference which is
> default at -O2 and higher.
> 
> > Is there anything in the standards about this feature?
> 
> The compiler can do whatever it likes with code that has undefined
> behaviour.  With this optimisation it a) can compile the conforming
> code to something better; and b) undefined behaviour will trap instead
> of doing something random (which often is exploitable).

I actually like that feature, except it did bite me once or twice in the past
adding traps to intentional NULL dereferences ;-) Ah the joys of writing
a firmware where you poke at stuff at fixed addresses in low memory :-)

Cheers,
Ben.

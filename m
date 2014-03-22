Return-Path: <srikar@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 92A2C2C00A0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Mar 2014 13:28:05 +1100 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srikar@linux.vnet.ibm.com>;
 Sat, 22 Mar 2014 07:57:59 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id CC220394003E
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Mar 2014 07:57:56 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2M2RlkK48890022
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Mar 2014 07:57:47 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2M2RttW018431
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Mar 2014 07:57:56 +0530
Date: Sat, 22 Mar 2014 07:57:54 +0530
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Tasks stuck in futex code (in 3.14-rc6)
Message-ID: <20140322022754.GA21677@linux.vnet.ibm.com>
References: <20140320053350.GB30295@linux.vnet.ibm.com>
 <1395295019.2612.11.camel@buesod1.americas.hpqcorp.net>
 <CA+55aFzP60Ucn0snFchHNw2tOnS6HYp-6n+f+9nxrbTPw8fTfQ@mail.gmail.com>
 <1395335909.14694.15.camel@buesod1.americas.hpqcorp.net>
 <CA+55aFwH2sJKCH6hUf8H-7nMPo8YwFCR6oP8McZ5VpMcGDrYSw@mail.gmail.com>
 <1395342510.14694.43.camel@buesod1.americas.hpqcorp.net>
 <CA+55aFw8wSe-DUtZ8=rjFJzXYmOSsZ0JzS-_jsZKrDai8LZMXw@mail.gmail.com>
 <1395346808.14694.62.camel@buesod1.americas.hpqcorp.net>
 <20140321045501.GD30295@linux.vnet.ibm.com>
 <CA+55aFyX0sj_MjTas3RYWWOa1W-xc3t0Af_0vdmsmgui8Apqpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CA+55aFyX0sj_MjTas3RYWWOa1W-xc3t0Af_0vdmsmgui8Apqpw@mail.gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
 Davidlohr Bueso <davidlohr@hp.com>, Paul Mackerras <paulus@samba.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Paul McKenney <paulmck@linux.vnet.ibm.com>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>, Ingo Molnar <mingo@kernel.org>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> > So reverting and applying v3 3/4 and 4/4 patches works for me.
> 
> Ok, I verified that the above endds up resulting in the same tree as
> the minimal patch I sent out, modulo (a) some comments and (b) an
> #ifdef CONFIG_SMP in futex_get_mm() that doesn't really matter.
> 
> So I committed the minimal patch with your tested-by.
> 

Just to be sure, I have verified with latest mainline with HEAD having
commit 08edb33c4 (Merge branch 'drm-fixes' of
git://people.freedesktop.org/~airlied/linux) which also has the commit
11d4616bd0 futex:( revert back to the explicit waiter counting code).

-- 
Thanks and Regards
Srikar Dronamraju

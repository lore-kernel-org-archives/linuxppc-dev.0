Return-Path: <michaele@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w8K9B0b4qzDqJv
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Apr 2017 12:16:13 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3L2FrNa087766
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 22:16:03 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29y0hdusmu-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 22:15:57 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <michaele@au1.ibm.com>;
 Fri, 21 Apr 2017 12:14:49 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3L2Ed4T51052564
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Apr 2017 12:14:47 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3L2EEnO006938
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Apr 2017 12:14:15 +1000
From: Michael Ellerman <michaele@au1.ibm.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, "paulus\@samba.org" <paulus@samba.org>,
 kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 "linuxppc-dev\@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Cc: tglx@linutronix.de, bobby.prani@gmail.com, peterz@infradead.org,
 fweisbec@gmail.com, jiangshanlai@gmail.com, josh@joshtriplett.org,
 rostedt@goodmis.org, oleg@redhat.com, dhowells@redhat.com,
 edumazet@google.com, mathieu.desnoyers@efficios.com,
 dipankar@in.ibm.com, akpm@linux-foundation.org, mingo@kernel.org
Subject: Re: powerpc KVM build break in linux-next (was Re: [PATCH
 tip/core/rcu 40/40] srcu: Parallelize callback handling)
In-Reply-To: <24c85d26-bb4b-892d-5837-6d02af570e0e@redhat.com>
References: <20170412174003.GA23207@linux.vnet.ibm.com>
 <1492018825-25634-40-git-send-email-paulmck@linux.vnet.ibm.com>
 <871ssn692a.fsf@concordia.ellerman.id.au>
 <24c85d26-bb4b-892d-5837-6d02af570e0e@redhat.com>
Date: Fri, 21 Apr 2017 12:13:49 +1000
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87tw5itsma.fsf@concordia.ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Paolo Bonzini <pbonzini@redhat.com> writes:
> Michael, if you want to move the two srcu structs at the end of struct
> kvm, that would be fine by me.  Please send a patch yourself so you can
> test it on PPC.  Thanks,

Paul beat me to it :)

I've confirmed it fixes the build break and the resulting kernel can
boot a KVM guest happily.

cheers

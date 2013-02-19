Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id 9003B2C0077
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Feb 2013 21:44:01 +1100 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 09560-04 for <linuxppc-dev@lists.ozlabs.org>;
 Tue, 19 Feb 2013 10:43:55 +0000 (GMT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Subject: RE: [PATCH v6 08/46] CPU hotplug: Provide APIs to prevent CPU offline
 from atomic context
Date: Tue, 19 Feb 2013 10:42:53 -0000
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6026B7154@saturn3.aculab.com>
In-Reply-To: <51234C23.2030909@linux.vnet.ibm.com>
References: <20130218123714.26245.61816.stgit@srivatsabhat.in.ibm.com>
 <20130218123920.26245.56709.stgit@srivatsabhat.in.ibm.com>
 <CANN689HhVxDv+3Bn9UAxOMzj0egTvVp_c7oAmQ2nnQ8Xjn_aMA@mail.gmail.com>
 <51225A36.40600@linux.vnet.ibm.com>
 <CANN689FJPLfz06MFRJ9T+BuToejAzjYP_yrw_H4iGi1Kb3p2-g@mail.gmail.com>
 <51227810.6090009@linux.vnet.ibm.com>
 <CANN689E-98zK69pGeojbm30n3sswQYVBvhk3i3OzqvbeqSrSrg@mail.gmail.com>
 <51234C23.2030909@linux.vnet.ibm.com>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>,
 "Michel Lespinasse" <walken@google.com>
Cc: linux-doc@vger.kernel.org, peterz@infradead.org, fweisbec@gmail.com,
 linux-kernel@vger.kernel.org, mingo@kernel.org, linux-arch@vger.kernel.org,
 linux@arm.linux.org.uk, xiaoguangrong@linux.vnet.ibm.com,
 wangyun@linux.vnet.ibm.com, paulmck@linux.vnet.ibm.com,
 nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org, rusty@rustcorp.com.au,
 rostedt@goodmis.org, rjw@sisk.pl, namhyung@kernel.org, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, oleg@redhat.com,
 vincent.guittot@linaro.org, sbw@mit.edu, tj@kernel.org,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> I wouldn't go that far... ;-) Unfairness is not a show-stopper right?
> IMHO, the warning/documentation should suffice for anybody wanting to
> try out this locking scheme for other use-cases.

I presume that by 'fairness' you mean 'write preference'?

I'd not sure how difficult it would be, but maybe have two functions
for acquiring the lock for read, one blocks if there is a writer
waiting, the other doesn't.

That way you can change the individual call sites separately.

The other place I can imagine a per-cpu rwlock being used
is to allow a driver to disable 'sleep' or software controlled
hardware removal while it performs a sequence of operations.

	David

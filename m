Return-Path: <rdreier@cisco.com>
Received: from sj-iport-3.cisco.com (sj-iport-3-in.cisco.com [171.71.176.72])
	by ozlabs.org (Postfix) with ESMTP id 37E2DDDF3F
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2007 05:27:13 +1100 (EST)
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] IB/ehca: Serialize HCA-related hCalls on POWER5
References: <200712061607.20004.fenkes@de.ibm.com>
	<200712061648.24806.arnd@arndb.de>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 06 Dec 2007 10:27:09 -0800
In-Reply-To: <200712061648.24806.arnd@arndb.de> (Arnd Bergmann's message of
	"Thu, 6 Dec 2007 16:48:23 +0100")
Message-ID: <ada7ijrd6gy.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Joachim Fenkes <fenkes@de.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
	OF-EWG <ewg@lists.openfabrics.org>, linuxppc-dev@ozlabs.org,
	Christoph Raisch <raisch@de.ibm.com>, Marcus Eder <meder@de.ibm.com>,
	OF-General <general@lists.openfabrics.org>,
	Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 > > +               ehca_lock_hcalls = !(cur_cpu_spec->cpu_user_features
 > > +                                    & PPC_FEATURE_ARCH_2_05);

 > We already talked about this yesterday, but I still feel that checking the
 > instruction set of the CPU should not be used to determine whether a
 > specific device driver implementation is used int hypervisor.

I had the same reaction... is testing cpu_user_features really the
best way to detect this issue?

I'll hold off applying this for a few days so you guys can decide the
best thing to do.  We'll definitely get some fix into 2.6.24 but we
have time to make a good decision.

 > Regarding the performance problem, have you checked whether converting all
 > your spin_lock_irqsave to spin_lock/spin_lock_irq improves your performance
 > on the older machines? Maybe it's already fast enough that way.

It does seem that the only places that the hcall_lock is taken also
use msleep, so they must always be in process context.  So you can
safely just use spin_lock(), right?

 - R.

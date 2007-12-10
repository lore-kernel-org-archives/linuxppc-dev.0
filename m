Return-Path: <rdreier@cisco.com>
Received: from sj-iport-3.cisco.com (sj-iport-3-in.cisco.com [171.71.176.72])
	by ozlabs.org (Postfix) with ESMTP id 011AEDDE39
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Dec 2007 08:47:40 +1100 (EST)
To: Joachim Fenkes <fenkes@de.ibm.com>
Subject: Re: [PATCH] IB/ehca: Serialize HCA-related hCalls on POWER5
References: <200712061607.20004.fenkes@de.ibm.com>
	<200712071058.38416.arnd@arndb.de> <adaodcza1xc.fsf@cisco.com>
	<200712101841.30010.fenkes@de.ibm.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 10 Dec 2007 13:47:37 -0800
In-Reply-To: <200712101841.30010.fenkes@de.ibm.com> (Joachim Fenkes's message
	of "Mon, 10 Dec 2007 18:41:29 +0100")
Message-ID: <adahciq9q86.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Arnd Bergmann <arnd@arndb.de>, LKML <linux-kernel@vger.kernel.org>,
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

 > >     map_phys_fmr
 > 
 > In fact, we do use hCalls there. Our hardware doesn't actually support FMRs,
 > so we translate a "map FMR" into a "reallocate PMR", which doesn't work
 > without hCalls. What's more, the hCalls involved (e.g. H_FREE_RESOURCE)
 > might well return H_LONG_BUSY, so the whole operation might sleep; no way
 > around it.

It's a big problem.  If you cannot implement FMRs in such a way that
you can handling having map_phys_fmr being called in a context that
can't sleep, then I think the only option is to remove your FMR
support.  It's an optional device feature, so this should be OK
(although the iSER driver currently seems to depend on a device
supporting FMRs, which is probably going to be a problem with iWARP
support in the future anyway).

The fact that consumers can map FMRs from interrupt context, while
holding locks, etc, is pretty fundamental to the use of FMRs so I
don't see any way around the requirement that map_phys_fmr never
sleep.

 - R.

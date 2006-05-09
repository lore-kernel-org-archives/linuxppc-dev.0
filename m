Return-Path: <rdreier@cisco.com>
Received: from test-iport-2.cisco.com (test-iport-2.cisco.com [171.71.176.105])
	by ozlabs.org (Postfix) with ESMTP id BA4AA679E2
	for <linuxppc-dev@ozlabs.org>; Wed, 10 May 2006 02:23:57 +1000 (EST)
To: Heiko J Schick <schihei@de.ibm.com>
Subject: Re: [openib-general] [PATCH 07/16] ehca: interrupt handling routines
References: <4450A196.2050901@de.ibm.com> <adaejz9o4vh.fsf@cisco.com>
	<445B4DA9.9040601@de.ibm.com> <adafyjomsrd.fsf@cisco.com>
	<44608C90.30909@de.ibm.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 09 May 2006 09:23:38 -0700
In-Reply-To: <44608C90.30909@de.ibm.com> (Heiko J. Schick's message of "Tue,
	09 May 2006 14:35:28 +0200")
Message-ID: <adalktbcgl1.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org,
	linuxppc-dev@ozlabs.org, Christoph Raisch <RAISCH@de.ibm.com>,
	Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, Marcus Eder <MEDER@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

    Heiko> Yes, I agree. It would not be an optimal solution, because
    Heiko> other upper level protocols (e.g. SDP, SRP, etc.) or
    Heiko> userspace verbs would not be affected by this
    Heiko> changes. Nevertheless, how can an improved "scaling" or
    Heiko> "SMP" version of IPoIB look like. How could it be
    Heiko> implemented?

The trivial way to do it would be to use the same idea as the current
ehca driver: just create a thread for receive CQ events and a thread
for send CQ events, and defer CQ polling into those two threads.

Something even better may be possible by specializing to IPoIB of course.

 - R.

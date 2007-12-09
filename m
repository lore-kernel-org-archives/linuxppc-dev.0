Return-Path: <rdreier@cisco.com>
Received: from sj-iport-6.cisco.com (sj-iport-6.cisco.com [171.71.176.117])
	by ozlabs.org (Postfix) with ESMTP id 1075DDDDFE
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Dec 2007 10:22:44 +1100 (EST)
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] IB/ehca: Serialize HCA-related hCalls on POWER5
References: <200712061607.20004.fenkes@de.ibm.com>
	<200712061648.24806.arnd@arndb.de> <ada7ijrd6gy.fsf@cisco.com>
	<200712071058.38416.arnd@arndb.de>
From: Roland Dreier <rdreier@cisco.com>
Date: Sun, 09 Dec 2007 15:22:39 -0800
In-Reply-To: <200712071058.38416.arnd@arndb.de> (Arnd Bergmann's message of
	"Fri, 7 Dec 2007 10:58:37 +0100")
Message-ID: <adaodcza1xc.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

 > I think it needs some more inspection. The msleep in there is only called
 > for hcalls that return H_IS_LONG_BUSY(). In theory, you can call
 > ehca_plpar_hcall_norets() from inside an interrupt handler if the
 > hcall in question never returns long busy.

Fair enough... according to Documentation/infiniband/core_locking.txt,
the only driver methods that cannot sleep are:

    create_ah
    modify_ah
    query_ah
    destroy_ah
    bind_mw
    post_send
    post_recv
    poll_cq
    req_notify_cq
    map_phys_fmr

and I don't think ehca does an hcall from any of those.  Of course
there might be other driver-internal code paths that I don't know
about.  Maybe do a quick audit and then stick might_sleep() in the
hcall functions to catch any mistakes?

 - R.

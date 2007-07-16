Return-Path: <rdreier@cisco.com>
Received: from sj-iport-5.cisco.com (sj-iport-5.cisco.com [171.68.10.87])
	by ozlabs.org (Postfix) with ESMTP id 9CAB7DE1A6
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 02:04:29 +1000 (EST)
To: Joachim Fenkes <fenkes@de.ibm.com>
Subject: Re: [PATCH 01/10] IB/ehca: Support for multiple event queues
References: <200707121745.27592.fenkes@de.ibm.com>
	<200707121746.36763.fenkes@de.ibm.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 16 Jul 2007 09:04:26 -0700
In-Reply-To: <200707121746.36763.fenkes@de.ibm.com> (Joachim Fenkes's message
	of "Thu, 12 Jul 2007 17:46:35 +0200")
Message-ID: <adalkdgz65x.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: LKML <linux-kernel@vger.kernel.org>, LinuxPPC-Dev <linuxppc-dev@ozlabs.org>,
	Christoph Raisch <raisch@de.ibm.com>,
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

 > The eHCA driver can now handle multiple event queues (read: interrupt
 > sources) instead of one. The number of available EQs is selected via the
 > nr_eqs module parameter.

 > CQs are either assigned to the EQs based on the comp_vector index or, if the
 > dist_eqs module parameter is supplied, using a round-robin scheme.

Do you have any data on how well this round-robin assignment works?
It seems not quite right to me for the driver to advertise nr_eqs
completion vectors, but then if round-robin is turned on to ignore the
consumer's decision about which vector to use.

Maybe if round-robin is turned on you should report 0 as the number of
completion vectors?  Or maybe we should allow well-known values for
the completion vector passed to ib_create_cq to allow consumers to
specify a policy (like round robin) instead of a particular vector?
Maybe the whole interface is broken and we should only be exposing
policies to consumers instead of the specific vector?

I think I would rather hold off on multiple EQs for this merge window
and plan on having something really solid and thought-out for 2.6.24.

 - R.

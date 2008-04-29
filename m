Return-Path: <rdreier@cisco.com>
Received: from sj-iport-6.cisco.com (sj-iport-6.cisco.com [171.71.176.117])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "sj-iport-6.cisco.com", Issuer "Cisco SSCA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 44815DE322
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2008 02:43:45 +1000 (EST)
From: Roland Dreier <rdreier@cisco.com>
To: Stefan Roscher <ossrosch@linux.vnet.ibm.com>
Subject: Re: [PATCH] IB/ehca: Allocate event queue size depending on max
	number of CQs and QPs
References: <200804291744.17235.ossrosch@linux.vnet.ibm.com>
Date: Tue, 29 Apr 2008 09:43:42 -0700
In-Reply-To: <200804291744.17235.ossrosch@linux.vnet.ibm.com> (Stefan
	Roscher's message of "Tue, 29 Apr 2008 17:44:15 +0200")
Message-ID: <adafxt4y5kx.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: fenkes@de.ibm.com, LKML <linux-kernel@vger.kernel.org>,
	OF-EWG <ewg@lists.openfabrics.org>,
	LinuxPPC-Dev <linuxppc-dev@ozlabs.org>, raisch@de.ibm.com,
	OF-General <general@lists.openfabrics.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 > 
 > Signed-off-by: Stefan Roscher <stefan.roscher at de.ibm.com>

Kind of an inadequate changelog ;)

Is this a fix or an enhancement or what?

 > +	if (atomic_read(&shca->num_cqs) >= ehca_max_cq) {

 > +	if (atomic_read(&shca->num_qps) >= ehca_max_qp) {

These are racy in the sense that multiple simultaneous calls to
create_cq/create_qp might end up exceeding the ehca_max_cq limit.  Is
that an issue?

You could close the race by using atomic_add_unless() and testing the
return value (and being careful to do atomic_dec() on error paths after
you bump num_cqs/num_qps).

 - R.

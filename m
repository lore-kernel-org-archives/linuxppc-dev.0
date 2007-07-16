Return-Path: <HNGUYEN@de.ibm.com>
Received: from mtagate3.de.ibm.com (mtagate3.de.ibm.com [195.212.29.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate3.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8F34EDDE25
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 06:38:01 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate3.de.ibm.com (8.13.8/8.13.8) with ESMTP id l6GKbvlk033750
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Jul 2007 20:37:57 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.4) with
	ESMTP id l6GKbvlr1892492
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Jul 2007 22:37:57 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l6GKboF4010578
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Jul 2007 22:37:51 +0200
In-Reply-To: <adalkdgz65x.fsf@cisco.com>
Subject: Re: [PATCH 01/10] IB/ehca: Support for multiple event queues
To: Roland Dreier <rdreier@cisco.com>
Message-ID: <OF2377E85C.B05BDE94-ONC125731A.006E64A7-C125731A.00714F9E@de.ibm.com>
From: Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>
Date: Mon, 16 Jul 2007 22:37:44 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Joachim Fenkes <fenkes@de.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
	LinuxPPC-Dev <linuxppc-dev@ozlabs.org>,
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

Roland Dreier <rdreier@cisco.com> wrote on 16.07.2007 18:04:26:
> Do you have any data on how well this round-robin assignment works?
> It seems not quite right to me for the driver to advertise nr_eqs
> completion vectors, but then if round-robin is turned on to ignore the
> consumer's decision about which vector to use.
No, I've no figures to provide here. The background of this dist_eqs
option is actually to allow us testing across all event queues
without to change the testcases resp consumers to use certain
event queue number. Thus, I should comment it as EXPERIMENTAL?
> Maybe if round-robin is turned on you should report 0 as the number of
> completion vectors?  Or maybe we should allow well-known values for
> the completion vector passed to ib_create_cq to allow consumers to
> specify a policy (like round robin) instead of a particular vector?
> Maybe the whole interface is broken and we should only be exposing
> policies to consumers instead of the specific vector?
Agree in that device driver should not overwrite consumer's policy
of event queue assigment. Since dist_eqs is disabled as default,
there's no issue, isn't it?
Regarding ib_verbs: perhaps we should provide create/destroy_eq()
and let upper level protocols or consumers dictate the assignment
to cq by passing an event queue pointer to create_cq()...
> I think I would rather hold off on multiple EQs for this merge window
> and plan on having something really solid and thought-out for 2.6.24.
Fair enough. However why don't let us gather experience with this
feature now? Should we remove dist_eqs option for more consistency?
Thanks
Nam

Return-Path: <FENKES@de.ibm.com>
Received: from mtagate3.de.ibm.com (mtagate3.de.ibm.com [195.212.29.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate3.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2AC9FDDE00
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 06:34:56 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate3.de.ibm.com (8.13.8/8.13.8) with ESMTP id l6GKYp5C193898
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Jul 2007 20:34:51 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.4) with
	ESMTP id l6GKYhsH1921212
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Jul 2007 22:34:51 +0200
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l6GKYRKq019621
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Jul 2007 22:34:27 +0200
In-Reply-To: <adalkdgz65x.fsf@cisco.com>
To: Roland Dreier <rdreier@cisco.com>
MIME-Version: 1.0
Subject: Re: [PATCH 01/10] IB/ehca: Support for multiple event queues
From: Joachim Fenkes <FENKES@de.ibm.com>
Message-ID: <OF82B8C559.721FE4D8-ONC125731A.00700205-C125731A.00711653@de.ibm.com>
Date: Mon, 16 Jul 2007 22:34:19 +0200
Content-Type: text/plain; charset="US-ASCII"
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

Roland Dreier <rdreier@cisco.com> wrote on 16.07.2007 18:04:26:

> It seems not quite right to me for the driver to advertise nr_eqs
> completion vectors, but then if round-robin is turned on to ignore the
> consumer's decision about which vector to use.

The round-robin feature was primarily meant as a debug/evaluation feature; 
it is not supposed to be active by default. ULP programmers can, for 
example, quickly evaluate the performance increase that comp_vectors could 
give them, without changing their code. Without this debug option, the 
comp_vector policy is still up to the ULPs.
 
> Maybe if round-robin is turned on you should report 0 as the number of
> completion vectors?

That sounds like a reasonable idea -- I'll change that right away.

> Maybe the whole interface is broken and we should only be exposing
> policies to consumers instead of the specific vector?

If so, I think the policies should be handled by the IB core code instead 
of being re-invented by each driver. The IB core would then again pass 
actual comp_vector values to the driver.
 
> I think I would rather hold off on multiple EQs for this merge window
> and plan on having something really solid and thought-out for 2.6.24.

It's your call, but the code is there and I don't expect it to change a 
lot later, so it could be used by others to get a first impression of 
what's possible using comp_vectors and to gather some experience with 
them.

Regards,
  Joachim

Return-Path: <FENKES@de.ibm.com>
Received: from mtagate5.de.ibm.com (mtagate5.de.ibm.com [195.212.29.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate5.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 51165DDE42
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Dec 2007 19:37:35 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate5.de.ibm.com (8.13.8/8.13.8) with ESMTP id lBB8bT0S356014
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Dec 2007 08:37:29 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.7) with
	ESMTP id lBB8bTpL2814080
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Dec 2007 09:37:29 +0100
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id lBB8bSvo009220
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Dec 2007 09:37:29 +0100
In-Reply-To: <adahciq9q86.fsf@cisco.com>
To: Roland Dreier <rdreier@cisco.com>
MIME-Version: 1.0
Subject: Re: [PATCH] IB/ehca: Serialize HCA-related hCalls on POWER5
From: Joachim Fenkes <FENKES@de.ibm.com>
Message-ID: <OFD9564F75.44193623-ONC12573AE.002EA542-C12573AE.002F5FBC@de.ibm.com>
Date: Tue, 11 Dec 2007 09:38:58 +0100
Content-Type: text/plain; charset="US-ASCII"
Cc: Arnd Bergmann <arnd@arndb.de>, OF-EWG <ewg@lists.openfabrics.org>,
	LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org,
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

Roland Dreier <rdreier@cisco.com> wrote on 10.12.2007 22:47:37:

> It's a big problem.  If you cannot implement FMRs in such a way that
> you can handling having map_phys_fmr being called in a context that
> can't sleep, then I think the only option is to remove your FMR
> support.

That's kind of what I feared you would say =)

> It's an optional device feature, so this should be OK
> (although the iSER driver currently seems to depend on a device
> supporting FMRs, which is probably going to be a problem with iWARP
> support in the future anyway).

I don't feel very well with removing code from the driver that iSER seems 
to depend on. Are there plans to fix this in iSER?

In reality, PHYP rarely ever returns H_LONG_BUSY, and we haven't had any 
problems with iSER in the field yet. I admit that our FMR code is 
dangerous, but I prefer "dangerous but working for the customer" over "not 
working for the customer at all".
 
Maybe we can agree on keeping the status quo until no more ULPs depend on 
FMR, then remove FMR from ehca? If so, we'd also let the _irqsave 
spinlocks around hCalls stay in place.

Regards,
  Joachim

Return-Path: <fenkes@de.ibm.com>
Received: from mtagate3.uk.ibm.com (mtagate3.uk.ibm.com [195.212.29.136])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate3.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 24301DDE3D
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Dec 2007 04:42:08 +1100 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate3.uk.ibm.com (8.13.8/8.13.8) with ESMTP id lBAHg3Hp130976
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Dec 2007 17:42:03 GMT
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
	[9.149.37.216])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.7) with
	ESMTP id lBAHg3Bb4948178
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Dec 2007 17:42:03 GMT
Received: from d06av04.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av04.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id lBAHfkfd007042
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Dec 2007 17:41:47 GMT
From: Joachim Fenkes <fenkes@de.ibm.com>
To: Roland Dreier <rdreier@cisco.com>
Subject: Re: [PATCH] IB/ehca: Serialize HCA-related hCalls on POWER5
Date: Mon, 10 Dec 2007 18:41:29 +0100
References: <200712061607.20004.fenkes@de.ibm.com>
	<200712071058.38416.arnd@arndb.de> <adaodcza1xc.fsf@cisco.com>
In-Reply-To: <adaodcza1xc.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200712101841.30010.fenkes@de.ibm.com>
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

On Monday 10 December 2007 00:22, Roland Dreier wrote:
> Fair enough... according to Documentation/infiniband/core_locking.txt,
> the only driver methods that cannot sleep are:
> 
>     [...]
>     map_phys_fmr

In fact, we do use hCalls there. Our hardware doesn't actually support FMRs,
so we translate a "map FMR" into a "reallocate PMR", which doesn't work
without hCalls. What's more, the hCalls involved (e.g. H_FREE_RESOURCE)
might well return H_LONG_BUSY, so the whole operation might sleep; no way
around it.

How should we deal with this?

Thanks,
  Joachim

Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id C465EDDDE7
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2007 20:58:54 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] IB/ehca: Serialize HCA-related hCalls on POWER5
Date: Fri, 7 Dec 2007 10:58:37 +0100
References: <200712061607.20004.fenkes@de.ibm.com>
	<200712061648.24806.arnd@arndb.de> <ada7ijrd6gy.fsf@cisco.com>
In-Reply-To: <ada7ijrd6gy.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200712071058.38416.arnd@arndb.de>
Cc: Roland Dreier <rdreier@cisco.com>, Joachim Fenkes <fenkes@de.ibm.com>,
	LKML <linux-kernel@vger.kernel.org>, OF-EWG <ewg@lists.openfabrics.org>,
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

On Thursday 06 December 2007, Roland Dreier wrote:
> =A0> Regarding the performance problem, have you checked whether converti=
ng all
> =A0> your spin_lock_irqsave to spin_lock/spin_lock_irq improves your perf=
ormance
> =A0> on the older machines? Maybe it's already fast enough that way.
>=20
> It does seem that the only places that the hcall_lock is taken also
> use msleep, so they must always be in process context. =A0So you can
> safely just use spin_lock(), right?

I think it needs some more inspection. The msleep in there is only called
for hcalls that return H_IS_LONG_BUSY(). In theory, you can call
ehca_plpar_hcall_norets() from inside an interrupt handler if the
hcall in question never returns long busy.

	Arnd <><

Return-Path: <FENKES@de.ibm.com>
Received: from mtagate2.de.ibm.com (mtagate2.de.ibm.com [195.212.29.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate2.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 71762DE08F
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Dec 2007 07:59:56 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate2.de.ibm.com (8.13.8/8.13.8) with ESMTP id lBDKxrc5149286
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Dec 2007 20:59:53 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.7) with
	ESMTP id lBDKxqdL2748580
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Dec 2007 21:59:52 +0100
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id lBDKxquY005346
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Dec 2007 21:59:52 +0100
In-Reply-To: <469958e00712131122s661dd970ud359389e1c6637d4@mail.gmail.com>
To: "Caitlin Bestler" <caitlin.bestler@neterion.com>
MIME-Version: 1.0
Subject: Re: [ofa-general] Re: [ewg] Re: [PATCH] IB/ehca: Serialize HCA-related
	hCalls on POWER5
From: Joachim Fenkes <FENKES@de.ibm.com>
Message-ID: <OFD5B7D5E6.3538DC2A-ONC12573B0.0072D42A-C12573B0.00735730@de.ibm.com>
Date: Thu, 13 Dec 2007 21:59:50 +0100
Content-Type: text/plain; charset="US-ASCII"
Cc: Arnd Bergmann <arnd@arndb.de>, Roland Dreier <rdreier@cisco.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Or Gerlitz <ogerlitz@voltaire.com>, linuxppc-dev@ozlabs.org,
	caitlin.bestler@gmail.com, OF-General <general@lists.openfabrics.org>,
	Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

caitlin.bestler@gmail.com wrote on 13.12.2007 20:22:49:

> On Dec 13, 2007 12:30 AM, Or Gerlitz <ogerlitz@voltaire.com> wrote:
> > The current implementation of the open iscsi initiator makes sure to
> > issue commands in thread (sleepable) context, see iscsi_xmitworker and
> > references to it in drivers/scsi/libiscsi.c , so this keeps ehca users
> > safe for the time being.

> I agree, *some* form of FMR support is important for iSER (and probably
> for NFS over RDMA as well). Rather than adding a crippled NO FMR
> mode it would make more sense to add support for FMR Work Requests.
> I'm not certain what, if any, impact that would have on the Power5 
problem,
> but that's certainly a cleaner path for iWARP.

Well, FMR WRs wouldn't change the eHCA issue -- the driver would have to 
make an hCall in any case, and the architecture says that the hCalls used 
in this scenario might return H_LONG_BUSY, causing the driver to sleep. No 
way around that. Because of this, eHCA's FMRs are actually standard MRs 
with a different API.

If, as Or said, the iSCSI initiator issues commands in sleepable context 
anyway, nothing would be lost by using standard MRs as a fallback solution 
if FMRs aren't available, would it?

J.

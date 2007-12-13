Return-Path: <Caitlin.Bestler@neterion.com>
Received: from owa.neterion.com (mx.neterion.com [72.1.205.142])
	by ozlabs.org (Postfix) with ESMTP id 41763DE07D
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Dec 2007 08:21:17 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [ofa-general] Re: [ewg] Re: [PATCH] IB/ehca: Serialize
	HCA-related hCalls on POWER5
Date: Thu, 13 Dec 2007 16:08:34 -0500
Message-ID: <78C9135A3D2ECE4B8162EBDCE82CAD7702B14004@nekter>
In-Reply-To: <OFD5B7D5E6.3538DC2A-ONC12573B0.0072D42A-C12573B0.00735730@de.ibm.com>
References: <469958e00712131122s661dd970ud359389e1c6637d4@mail.gmail.com>
	<OFD5B7D5E6.3538DC2A-ONC12573B0.0072D42A-C12573B0.00735730@de.ibm.com>
From: "Caitlin Bestler" <Caitlin.Bestler@neterion.com>
To: "Joachim Fenkes" <FENKES@de.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Roland Dreier <rdreier@cisco.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Or Gerlitz <ogerlitz@voltaire.com>, linuxppc-dev@ozlabs.org,
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



> -----Original Message-----
> From: Joachim Fenkes [mailto:FENKES@de.ibm.com]
> Sent: Thursday, December 13, 2007 1:00 PM
> To: Caitlin Bestler
> Cc: Arnd Bergmann; caitlin.bestler@gmail.com; OF-General; LKML;
> linuxppc-dev@ozlabs.org; Or Gerlitz; Roland Dreier; Stefan Roscher
> Subject: Re: [ofa-general] Re: [ewg] Re: [PATCH] IB/ehca: Serialize
> HCA-related hCalls on POWER5
>=20
> caitlin.bestler@gmail.com wrote on 13.12.2007 20:22:49:
>=20
> > On Dec 13, 2007 12:30 AM, Or Gerlitz <ogerlitz@voltaire.com> wrote:
> > > The current implementation of the open iscsi initiator makes sure
> to
> > > issue commands in thread (sleepable) context, see iscsi_xmitworker
> and
> > > references to it in drivers/scsi/libiscsi.c , so this keeps ehca
> users
> > > safe for the time being.
>=20
> > I agree, *some* form of FMR support is important for iSER (and
> probably
> > for NFS over RDMA as well). Rather than adding a crippled NO FMR
> > mode it would make more sense to add support for FMR Work Requests.
> > I'm not certain what, if any, impact that would have on the Power5
> problem,
> > but that's certainly a cleaner path for iWARP.
>=20
> Well, FMR WRs wouldn't change the eHCA issue -- the driver would have
> to
> make an hCall in any case, and the architecture says that the hCalls
> used
> in this scenario might return H_LONG_BUSY, causing the driver to
sleep.
> No
> way around that. Because of this, eHCA's FMRs are actually standard
MRs
> with a different API.
>=20
> If, as Or said, the iSCSI initiator issues commands in sleepable
> context
> anyway, nothing would be lost by using standard MRs as a fallback
> solution
> if FMRs aren't available, would it?
>=20

To clarify, an FMR Work Request is simply posted to the SendQ like
any other Work Request (of course the QP has to be privileged, or
it will complete in error). An SQ Post should never block.

But yes, if the current iSCSI initiator always does all call-based
FMRs in a sleepable context then I would agree then any changes can
wait for the first vendor that wants to support FMR Work Requests.

FMR Work Requests can be pipelined, so anyone with hardware that
supported them would have strong motivation to enable the open
iSCSI initiator to take advantage of this.

Return-Path: <caitlin.bestler@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.181])
	by ozlabs.org (Postfix) with ESMTP id 4B2F7DE474
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Dec 2007 06:22:51 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so1289729wag.13
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Dec 2007 11:22:50 -0800 (PST)
Message-ID: <469958e00712131122s661dd970ud359389e1c6637d4@mail.gmail.com>
Date: Thu, 13 Dec 2007 11:22:49 -0800
From: "Caitlin Bestler" <caitlin.bestler@neterion.com>
Sender: caitlin.bestler@gmail.com
To: "Or Gerlitz" <ogerlitz@voltaire.com>
Subject: Re: [ofa-general] Re: [ewg] Re: [PATCH] IB/ehca: Serialize
	HCA-related hCalls on POWER5
In-Reply-To: <4760EDC0.5020703@voltaire.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
References: <OFD9564F75.44193623-ONC12573AE.002EA542-C12573AE.002F5FBC@de.ibm.com>
	<475FD0A1.3090304@voltaire.com> <adabq8v91co.fsf@cisco.com>
	<4760EDC0.5020703@voltaire.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Roland Dreier <rdreier@cisco.com>,
	Joachim Fenkes <FENKES@de.ibm.com>,
	LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org,
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

On Dec 13, 2007 12:30 AM, Or Gerlitz <ogerlitz@voltaire.com> wrote:
> Roland Dreier wrote:
> > I think the right fix for iSER would be to make iSER work even for
> > devices that don't support FMRs.  For example cxgb3 doesn't implement
> > FMRs so if anyone ever updates iSER to work on iWARP and not just IB,
> > then this is something that has to be tackled anyway.  Then ehca could
> > just get rid of the FMR support it has.
>
> OK, The iSER design took into account the case of many initiators
> running on strong/modern machines talking to possibly lightweight
> embedded target for which the processing cost per I/O at the target side
> should be minimized, that is at most --one-- RDMA operation should be
> issued by the target to serve an I/O request.
>
> For that end, iSER works with one descriptor (called stag in iWARP and
> rkey in IB) per I/O direction sent from the initiator to the target and
> hence can't work without some sort of FMR implementation.
>
> The current implementation of the open iscsi initiator makes sure to
> issue commands in thread (sleepable) context, see iscsi_xmitworker and
> references to it in drivers/scsi/libiscsi.c , so this keeps ehca users
> safe for the time being.
>
> Or.
>

I agree, *some* form of FMR support is important for iSER (and probably
for NFS over RDMA as well). Rather than adding a crippled NO FMR
mode it would make more sense to add support for FMR Work Requests.
I'm not certain what, if any, impact that would have on the Power5 problem,
but that's certainly a cleaner path for iWARP.

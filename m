Return-Path: <ogerlitz@voltaire.com>
Received: from exil.voltaire.com (fwil.voltaire.com [193.47.165.2])
	by ozlabs.org (Postfix) with ESMTP id 89B47DDFD9
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Dec 2007 19:31:00 +1100 (EST)
Message-ID: <4760EDC0.5020703@voltaire.com>
Date: Thu, 13 Dec 2007 10:30:56 +0200
From: Or Gerlitz <ogerlitz@voltaire.com>
MIME-Version: 1.0
To: Roland Dreier <rdreier@cisco.com>
Subject: Re: [ewg] Re: [PATCH] IB/ehca: Serialize HCA-related hCalls on POWER5
References: <OFD9564F75.44193623-ONC12573AE.002EA542-C12573AE.002F5FBC@de.ibm.com><475FD0A1.3090304@voltaire.com>
	<adabq8v91co.fsf@cisco.com>
In-Reply-To: <adabq8v91co.fsf@cisco.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Arnd Bergmann <arnd@arndb.de>, Joachim Fenkes <FENKES@de.ibm.com>,
	LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org,
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

Roland Dreier wrote:
> I think the right fix for iSER would be to make iSER work even for
> devices that don't support FMRs.  For example cxgb3 doesn't implement
> FMRs so if anyone ever updates iSER to work on iWARP and not just IB,
> then this is something that has to be tackled anyway.  Then ehca could
> just get rid of the FMR support it has.

OK, The iSER design took into account the case of many initiators 
running on strong/modern machines talking to possibly lightweight 
embedded target for which the processing cost per I/O at the target side 
should be minimized, that is at most --one-- RDMA operation should be 
issued by the target to serve an I/O request.

For that end, iSER works with one descriptor (called stag in iWARP and 
rkey in IB) per I/O direction sent from the initiator to the target and 
hence can't work without some sort of FMR implementation.

The current implementation of the open iscsi initiator makes sure to 
issue commands in thread (sleepable) context, see iscsi_xmitworker and 
references to it in drivers/scsi/libiscsi.c , so this keeps ehca users 
safe for the time being.

Or.

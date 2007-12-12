Return-Path: <rdreier@cisco.com>
Received: from sj-iport-5.cisco.com (sj-iport-5.cisco.com [171.68.10.87])
	by ozlabs.org (Postfix) with ESMTP id 791F4DDE03
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Dec 2007 06:19:38 +1100 (EST)
To: Or Gerlitz <ogerlitz@voltaire.com>
Subject: Re: [ewg] Re: [PATCH] IB/ehca: Serialize HCA-related hCalls on POWER5
References: <OFD9564F75.44193623-ONC12573AE.002EA542-C12573AE.002F5FBC@de.ibm.com>
	<475FD0A1.3090304@voltaire.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Wed, 12 Dec 2007 11:09:27 -0800
In-Reply-To: <475FD0A1.3090304@voltaire.com> (Or Gerlitz's message of "Wed,
	12 Dec 2007 14:14:25 +0200")
Message-ID: <adabq8v91co.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

 > What is the fix you suggest, to add a device query that tells you for 
 > which verbs the documentation does not apply? or enhance the code of the 
 >   map_phys_fmr verb within the ehca driver to return error if called 
 > from non-sleepable context?

I think the right fix for iSER would be to make iSER work even for
devices that don't support FMRs.  For example cxgb3 doesn't implement
FMRs so if anyone ever updates iSER to work on iWARP and not just IB,
then this is something that has to be tackled anyway.  Then ehca could
just get rid of the FMR support it has.

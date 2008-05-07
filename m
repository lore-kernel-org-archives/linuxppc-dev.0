Return-Path: <rdreier@cisco.com>
Received: from sj-iport-1.cisco.com (sj-iport-1.cisco.com [171.71.176.70])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "sj-iport-1.cisco.com", Issuer "Cisco SSCA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 522C1DE107
	for <linuxppc-dev@ozlabs.org>; Thu,  8 May 2008 01:32:07 +1000 (EST)
From: Roland Dreier <rdreier@cisco.com>
To: Stefan Roscher <ossrosch@linux.vnet.ibm.com>
Subject: Re: [ewg] [PATCH] IB/ehca: Protect QP against destroying until all
	async events for it are handled.
References: <200805071319.37164.ossrosch@linux.vnet.ibm.com>
Date: Wed, 07 May 2008 08:32:03 -0700
In-Reply-To: <200805071319.37164.ossrosch@linux.vnet.ibm.com> (Stefan
	Roscher's message of "Wed, 7 May 2008 13:19:35 +0200")
Message-ID: <adahcdaw2oc.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: LinuxPPC-Dev <linuxppc-dev@ozlabs.org>, fenkes@de.ibm.com,
	LKML <linux-kernel@vger.kernel.org>, raisch@de.ibm.com,
	OF-EWG <ewg@lists.openfabrics.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 > We are not sure if this should be fixed in the driver or in uverbs itself.
 > Roland, what's your opinion about this?

Would be nice to be able to fix it in uverbs but I don't see how.  In
particular a kernel consumer has to have the same guarantee that no
async events will come in after destroy QP returns.  And I don't see any
way generic code can provide a guarantee about what low-level driver
code may do internally.

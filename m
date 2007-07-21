Return-Path: <rdreier@cisco.com>
Received: from sj-iport-6.cisco.com (sj-iport-6.cisco.com [171.71.176.117])
	by ozlabs.org (Postfix) with ESMTP id A6E06DDE3B
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Jul 2007 14:12:59 +1000 (EST)
To: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/5] ehca: Generate event when SRQ limit reached
References: <200707201602.19142.hnguyen@linux.vnet.ibm.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Fri, 20 Jul 2007 21:12:52 -0700
In-Reply-To: <200707201602.19142.hnguyen@linux.vnet.ibm.com> (Hoang-Nam
	Nguyen's message of "Fri, 20 Jul 2007 16:02:18 +0200")
Message-ID: <ada7iou75tn.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: fenkes@de.ibm.com, linux-kernel@vger.kernel.org, openib-general@openib.org,
	linuxppc-dev@ozlabs.org, raisch@de.ibm.com, stefan.roscher@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

thanks, applied.

BTW, does your SRQ-capable hardware support generating the "last WQE
reached" event?  There's not any reliable way to avoid problems when
destroying QPs attached to an SRQ without it, and the IB spec requires
CAs that support SRQs to generate it (o11-5.2.5 in chapter 11 of vol 1).

I don't see any code in ehca to generate the event, and IPoIB CM at
least will be very unhappy when using SRQs if the event is not
generated.

 - R.

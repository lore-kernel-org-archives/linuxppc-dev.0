Return-Path: <fenkes@de.ibm.com>
Received: from mtagate6.de.ibm.com (mtagate6.de.ibm.com [195.212.29.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate6.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BB7F0DDE00
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Sep 2007 00:42:57 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate6.de.ibm.com (8.13.8/8.13.8) with ESMTP id l8CEgqFF1360934
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 14:42:52 GMT
Received: from d12av01.megacenter.de.ibm.com (d12av01.megacenter.de.ibm.com
	[9.149.165.212])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.5) with
	ESMTP id l8CEgqQV2080800
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 16:42:52 +0200
Received: from d12av01.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av01.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l8CEgpFr022454
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 16:42:52 +0200
From: Joachim Fenkes <fenkes@de.ibm.com>
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: [PATCH 08/12] IB/ehca: Replace get_paca()->paca_index by the more
	portable smp_processor_id()
Date: Wed, 12 Sep 2007 16:42:50 +0200
References: <200709111518.26276.fenkes@de.ibm.com>
	<200709111533.14333.fenkes@de.ibm.com>
	<20070911145131.GN32388@localdomain>
In-Reply-To: <20070911145131.GN32388@localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709121642.51198.fenkes@de.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, OF-EWG <ewg@lists.openfabrics.org>,
	LinuxPPC-Dev <linuxppc-dev@ozlabs.org>,
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

On Tuesday 11 September 2007 16:51, Nathan Lynch wrote:

> > -				   get_paca()->paca_index, __FUNCTION__, \
> > +				   smp_processor_id(), __FUNCTION__, \
> 
> I think I see these macros used in preemptible code (e.g. ehca_probe),
> where smp_processor_id() will print a warning when
> CONFIG_DEBUG_PREEMPT=y.  Probably better to use raw_smp_processor_id.

You're right, man. The processor id doesn't need to be preemption-safe in this
context, so that would be a bogus warning. Thanks for pointing this out. I'll
post a new version of this patch.

Joachim

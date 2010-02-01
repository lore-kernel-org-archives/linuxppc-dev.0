Return-Path: <jschopp@austin.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9C155B7D4A
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Feb 2010 09:50:43 +1100 (EST)
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by e3.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o11MeHA7020443
	for <linuxppc-dev@ozlabs.org>; Mon, 1 Feb 2010 17:40:17 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o11Moe7b154558
	for <linuxppc-dev@ozlabs.org>; Mon, 1 Feb 2010 17:50:40 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o11ModO7031671
	for <linuxppc-dev@ozlabs.org>; Mon, 1 Feb 2010 17:50:40 -0500
Received: from [9.53.41.167] (jschopp-laptop-009053041167.austin.ibm.com
	[9.53.41.167])
	by d01av01.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVin) with ESMTP id
	o11ModbQ031650
	for <linuxppc-dev@ozlabs.org>; Mon, 1 Feb 2010 17:50:39 -0500
Subject: [PATCHv2 0/2] Add max CPU nodes field to ibm,client-architecture call
From: Joel Schopp <jschopp@austin.ibm.com>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <1263501508.4869.133.camel@jschopp-laptop>
References: <1263501508.4869.133.camel@jschopp-laptop>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 01 Feb 2010 16:50:39 -0600
Message-ID: <1265064639.5391.17.camel@jschopp-laptop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Large NUMA machines require Linux to indicate support for more than 64
cpu cores.  This is done through the ibm,client-architecture call, and
is documented in the PAPR.  There is also another new field added to
indicate that the OS is Linux as a hint for possible future performance
settings.

The first patch attempts to statically initialize the number of
supported cores with NR_CPUS, the maximum Linux could boot if the cpus
did not have multi-threading (SMT).  It can overestimate by the factor
of SMT.  For instance on Power6 with 2 way SMT it would overestimate by
a factor of 2.  The result of this overestimation is that Linux might
not be able boot all the cpus assigned to it, but would still boot
NR_CPUS worth of SMT threads.

The second patch adjusts for SMT by reading the device tree before
unflattening.  

I've updated patch 1 from previous comments. Patch 1 can be taken on its
own if Patch 2 seems like overkill.  

v2 - Updated patch 2 style and messages.  Basic functionality is the
same as v1.

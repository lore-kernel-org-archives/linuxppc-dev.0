Return-Path: <jschopp@austin.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 374FBB7CE9
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Jan 2010 07:38:44 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o0EKP4al020929
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Jan 2010 13:25:04 -0700
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	o0EKcTBv112242
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Jan 2010 13:38:35 -0700
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o0EKcT0O029613
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Jan 2010 13:38:29 -0700
Subject: [PATCH 0/2] Add max CPU nodes field to ibm,client-architecture call
From: Joel Schopp <jschopp@austin.ibm.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 14 Jan 2010 14:38:28 -0600
Message-ID: <1263501508.4869.133.camel@jschopp-laptop>
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

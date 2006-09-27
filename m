Return-Path: <johnrose@austin.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8892067BEB
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Sep 2006 02:50:39 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e32.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k8RGoabI025245
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Sep 2006 12:50:36 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k8RGoa4D252064
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Sep 2006 10:50:36 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k8RGoZww028245
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Sep 2006 10:50:35 -0600
Subject: iommu hypervisor hypothetical
From: John Rose <johnrose@austin.ibm.com>
To: Santiago Leon <saleon@us.ibm.com>, benh@kernel.crashing.org,
	External List <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1159375671.19103.3.camel@sinatra.austin.ibm.com>
Mime-Version: 1.0
Date: Wed, 27 Sep 2006 11:47:51 -0500
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Suppose the hypervisor added new failure codes for the hcall that does
tce_build().  Suppose that the device driver needed to expect such
failures when alloc_[coherent,consistent] is not successful, and handle
that case accordingly.

Is this something we can accommodate without rewriting the iommu stuff
for various platforms?  All these functions in machdep.h are defined to
return NULL.  Is this because we haven't had a reasonable expectation of
failure, or because device drivers _have_ to assume success for such
operations?

Thanks-
John

Return-Path: <johnrose@austin.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id AEE5A67C26
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Nov 2006 09:47:19 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id kASMlE4p030429
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Nov 2006 17:47:15 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kASMlEfD523650
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Nov 2006 15:47:14 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kASMlEqY017115
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Nov 2006 15:47:14 -0700
Subject: powerpc: xics_teardown_cpu()
From: John Rose <johnrose@austin.ibm.com>
To: External List <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1164754032.20203.4.camel@sinatra.austin.ibm.com>
Mime-Version: 1.0
Date: Tue, 28 Nov 2006 16:47:12 -0600
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This function currently makes an eoi call that unconditionally sets the
CPPR bits to 0xff.  For the case of CPU DLPAR remove, the firmware
require those bits to be 0x00.  We explicitly set the CPPR to 0xff
earlier in the function.

Any opinions on whether we should:
1) Reorder xics_teardown_cpu() to set the CPPR after the eoi call
2) Add another call to zero out the CPPR at the end of teardown_cpu()
3) Add a new hcall (H_IPOLL) wrapper to determine the current CPPR, and
use that in the eoi call.

Any thoughts would be greatly appreciated!

Thanks-
John

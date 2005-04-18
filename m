Return-Path: <pestes@us.ibm.com>
Received: from over.ny.us.ibm.com (over.ny.us.ibm.com [32.97.182.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3C81867A6C
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Apr 2005 07:15:11 +1000 (EST)
Received: from e4.ny.us.ibm.com ([192.168.1.104])
	by pokfb.esmtp.ibm.com (8.12.11/8.12.11) with ESMTP id j3IJgRk2020578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Apr 2005 15:42:27 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id j3IJgKIG032715
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Apr 2005 15:42:20 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id
	j3IJgKZd088042
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Apr 2005 15:42:20 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11/8.12.11) with ESMTP id j3IJgK86023472
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Apr 2005 15:42:20 -0400
Received: from unary.wma.ibm.com (unary.wma.ibm.com [9.54.149.20])
	by d01av01.pok.ibm.com (8.12.11/8.12.11) with ESMTP id j3IJgJiF023461
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Apr 2005 15:42:19 -0400
From: Phil Estes <pestes@us.ibm.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain
Date: Mon, 18 Apr 2005 15:42:07 -0400
Message-Id: <1113853327.3750.21.camel@unary.wma.ibm.com>
Mime-Version: 1.0
Subject: writev test failure related to arch/ppc/lib/string.S changes?
Reply-To: pestes@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,
Recently I applied some 2.6.7 ppc32 patches to a 2.6.5 kernel, which
included the 1.1612.2.78 changeset titled "[PATCH] PPC32: Fix copy
prefetch on non coherent PPCs".  The functionality I meant to get from
that backport is working fine, but a test team which is testing my
changes note that a standard LTP testcase in the writev family now
fails, which they tracked to the changes made in arch/ppc/lib/string.S
from the above changeset.

Their comments follow:
> I checked the string.S of 2.6.7. I think there is a bug in it. 
> At 114, we set ctr=r0-r7. If exception occurs, it then goes to 104,
> then 92 where r3 is set to LG_CACHELINE_BYTES. Then it goes to 99.
>
> But in the remarks before 99, the number of bytes not copied is 
> r5 + (ctr << r3). This is not as what has happen because 
> ctr = r0 - r7. The ctr should be adjusted before it goes to 99.

The failing test being noted is the LTP writev02 test, which is 
an "expected to FAIL" testcase, but passes in this case.  A bad 
address is passed to writev, but instead of EFAULT, a positive 
integer is returned.  Again, backing out the above changeset 
causes this test (among a few other writev variants which expect 
failure) to pass accordingly.

Thanks for your help,
Phil Estes
pestes@us.ibm.com

Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp07.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CBAABB6F0C
	for <linuxppc-dev@ozlabs.org>; Wed,  4 May 2011 14:28:53 +1000 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp07.au.ibm.com (8.14.4/8.13.1) with ESMTP id p444Sqnc006062
	for <linuxppc-dev@ozlabs.org>; Wed, 4 May 2011 14:28:52 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p444Sjuc913498
	for <linuxppc-dev@ozlabs.org>; Wed, 4 May 2011 14:28:47 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p444Sn23021184
	for <linuxppc-dev@ozlabs.org>; Wed, 4 May 2011 14:28:49 +1000
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org, tsenglin@us.ibm.com
Subject: [PATCH 0/2] powerpc/pseries: Reworked support for IO event interrupts
Date: Wed,  4 May 2011 14:28:42 +1000
Message-Id: <1304483324-11155-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Frank !

There were several issues with your patch. Some were nasty bugs such
as kmalloc(...GFP_KERNEL) at interrupt time, or taking the rtas buffer
lock from an interrupt, others simply the code being ugly.

I've removed the "generic" event log parsing as it's not useful at
this point and simplified the code significantly.

Please test and let me know if it works for you before I commit.

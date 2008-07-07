Return-Path: <munroesj@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 57313DED0B
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2008 01:10:54 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m67FAokL001114
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jul 2008 11:10:50 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m67FAj2m047964
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jul 2008 09:10:46 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m67FAjic008219
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jul 2008 09:10:45 -0600
Received: from spokane1.rchland.ibm.com (spokane1.rchland.ibm.com [9.10.86.94])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	m67FAiQe008174
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jul 2008 09:10:44 -0600
Subject: Re: [PATCH 1/2] elf loader support for auxvec base platform string
From: Steven Munroe <munroesj@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain
Date: Mon, 07 Jul 2008 10:14:13 -0500
Message-Id: <1215443653.4065.211.camel@spokane1.rchland.ibm.com>
Mime-Version: 1.0
Reply-To: munroesj@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Roland McGrath writes:

> I understand why you think so.  But let's not be too abstract.  The
> purpose of the addition is to drive ld.so's selection of libraries, yes?

The is one possible usage of this AT_BASE_PLATFORM. There is also a
requirement from performance tools and large applications to understand
their environment. As it needs to be a public and durable ABI.

Virtualization and multi-core are only going to make everyones life more
complicated. Applications and performance tools will require more info
about the system to do their jobs. This is the problem I am trying to
solve. And I thought this was the simplest way to solve several use
cases.

I proposes for this and the possible extension to library selection
because it would become part of the ABI and any application could
access it.

So if you want to propose another (Better) mechanism for ld.so library
search shaping I would be glad to discuss it.

But in my mind the requirement for AT_BASE_PLATFORM still stands.

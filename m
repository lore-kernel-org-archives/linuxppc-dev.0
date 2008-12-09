Return-Path: <dave@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e38.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 346F6DDF09
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2008 05:21:35 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e38.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id mB9IKPTC009585
	for <linuxppc-dev@ozlabs.org>; Tue, 9 Dec 2008 11:20:25 -0700
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mB9ILWnx197120
	for <linuxppc-dev@ozlabs.org>; Tue, 9 Dec 2008 11:21:32 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mB9ILVea011598
	for <linuxppc-dev@ozlabs.org>; Tue, 9 Dec 2008 11:21:32 -0700
Subject: [PATCH 0/8] Fix a bug and cleanup NUMA boot-time code
To: paulus@samba.org
From: Dave Hansen <dave@linux.vnet.ibm.com>
Date: Tue, 09 Dec 2008 10:21:30 -0800
Message-Id: <20081209182130.DB2150A2@kernel>
Cc: Jon Tollefson <kniht@linux.vnet.ibm.com>, Mel Gorman <mel@csn.ul.ie>,
	Dave Hansen <dave@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org,
	"Serge E. Hallyn" <serue@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The first patch in this series is a genuine bug fix.  The rest
are really just an RFC.

Jon introduced a bug a while ago.  I introduced another when
trying to fix Jon's bug.  I refuse to accept personal blame for
this and, instead, blame the code. :)

The reset of the series are "cleanups" that I think will help
clarify the code in numa.c and work to ensure that the next
bonehead like me is not as able to easily muck up the code. :)

The cleanups increase in impact and intrusiveness as the series
goes along, so please consider them an RFC.  But, what I really
want to figure out is a safer way to initialize NODE_DATA() and
start using it as we bring up bootmem on all the nodes.

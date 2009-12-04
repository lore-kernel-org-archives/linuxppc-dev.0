Return-Path: <ananth@in.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 00078B7BE0
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Dec 2009 15:21:52 +1100 (EST)
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e35.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id nB449SpK001895
	for <linuxppc-dev@ozlabs.org>; Thu, 3 Dec 2009 21:09:28 -0700
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nB44LjQe191218
	for <linuxppc-dev@ozlabs.org>; Thu, 3 Dec 2009 21:21:45 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id nB3LBecc021077
	for <linuxppc-dev@ozlabs.org>; Thu, 3 Dec 2009 14:11:40 -0700
Date: Fri, 4 Dec 2009 09:51:44 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 1/4] powerpc: Fix thinko in _stp_arg()
Message-ID: <20091204042144.GB22089@in.ibm.com>
References: <20091203233059.GA28186@oksana.dev.rtsoft.ru>
	<20091203233151.GA3416@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20091203233151.GA3416@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, Jim Keniston <jkenisto@us.ibm.com>,
	systemtap@sourceware.org
Reply-To: ananth@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Dec 04, 2009 at 02:31:51AM +0300, Anton Vorontsov wrote:
> _stp_arg() has an almost unnoticeable thinko in the argnum handling,
> which causes it to always return u_register("r10"):
> 
> 'else (argnum == 8)' should actually be 'else if (argnum == 8)'.
> 
> Though, since we check for 'if (argnum < 1 || argnum > 8)' at the
> beginning of _stp_arg(), let's make it just 'else'.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>

Ugh! What was I thinking?

Thanks for fixing this Anton.

Ananth

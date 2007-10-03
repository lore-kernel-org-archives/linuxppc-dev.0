Return-Path: <linas@austin.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4D7F1DDE1D
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Oct 2007 04:50:43 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	l93HgFPm022353
	for <linuxppc-dev@ozlabs.org>; Wed, 3 Oct 2007 13:42:15 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l93IoanN477128
	for <linuxppc-dev@ozlabs.org>; Wed, 3 Oct 2007 12:50:36 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l93IoZG6017824
	for <linuxppc-dev@ozlabs.org>; Wed, 3 Oct 2007 12:50:35 -0600
Date: Wed, 3 Oct 2007 13:50:35 -0500
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: 2.6.23-rc7-mm1 -- powerpc rtas panic
Message-ID: <20071003185035.GS4338@austin.ibm.com>
References: <20070924021716.9bfe7dfb.akpm@linux-foundation.org>
	<20070924123531.GC30855@shadowen.org>
	<20071002232819.GN4338@austin.ibm.com>
	<20071003002646.GD9814@bakeyournoodle.com>
	<1191371416.8073.1.camel@concordia>
	<20071003011909.GG9814@bakeyournoodle.com>
	<1191384586.8073.6.camel@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1191384586.8073.6.camel@concordia>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Oct 03, 2007 at 02:09:46PM +1000, Michael Ellerman wrote:
> 
> Until we initialise what exactly?

Until we allocate the error log buffer. The original crash was 
for a null-pointer deref of the unallocated buffer. I just sent 
out a patch to fix this; its a bit simpler than the below.

In that email, I remarked:

Andy Whitcroft's crash was appearently due to firmware complaining
about lost power, (actually, lost power supply redundancy!), which
occurred very early during boot.

    Type                00000040 (EPOW)
    Status:             bypassed new
    Residual error from previous boot.
    EPOW Sensor Value:  00000002
    EPOW warning due to loss of redundancy.
    EPOW general power fault.

I've no clue why firmware thought it was OK to report this
during one of the earliest calls to RTAS; I'm still investiigating
that.

--linas

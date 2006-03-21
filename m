Return-Path: <nathanl@austin.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8BA2367A5B
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Mar 2006 05:58:54 +1100 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e33.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id k2LIwoZZ029889
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Mar 2006 13:58:50 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k2LItnPM242664
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Mar 2006 11:55:49 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id
	k2LIwkHG029210
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Mar 2006 11:58:46 -0700
Subject: Re: [PATCH 2/7] powerpc numa: Minor debugging code changes
From: Nathan Lynch <nathanl@austin.ibm.com>
To: Dave Hansen <haveblue@us.ibm.com>
In-Reply-To: <1142965632.10906.163.camel@localhost.localdomain>
References: <11429012851755-git-send-email-nathanl@austin.ibm.com>
	<1142965632.10906.163.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 21 Mar 2006 12:54:42 -0600
Message-Id: <1142967282.27114.20.camel@pants.austin.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-03-21 at 10:27 -0800, Dave Hansen wrote:
> On Mon, 2006-03-20 at 18:34 -0600, Nathan Lynch wrote:
> > Don't print a meaningless associativity depth (-1) on non-numa systems.
> ...
> > -	dbg("NUMA associativity depth for CPU/Memory: %d\n", min_common_depth);
> >  	if (min_common_depth < 0)
> >  		return min_common_depth;
> >  
> > +	dbg("NUMA associativity depth for CPU/Memory: %d\n", min_common_depth);
> 
> This is debugging code anyway, right?
> 
> I thought this might be useful when you're booting on a machine which
> you _think_ should be NUMA, but doesn't come up that way.  Did you boot
> a non-NUMA kernel, or is something in the reporting wrong?  It makes it
> pretty obvious when you see this printout.

I think it's pretty obvious anyway -- we still print a message about not
finding the ibm,associativity-reference-points property, which is the
only reason min_common_depth would be -1.

This file isn't built when CONFIG_NUMA=n, so the placement of the dbg()
isn't going to shed any light on that particular operator error.

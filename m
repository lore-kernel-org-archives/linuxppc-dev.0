Return-Path: <cel@us.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D1D4ADE4AF
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jun 2008 01:38:35 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m5AFcWKd029233
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jun 2008 11:38:32 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m5AFcUti062140
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jun 2008 09:38:30 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m5AFcTpp007367
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jun 2008 09:38:29 -0600
Subject: Re: [patch 1/5] powerpc: fix for OProfile callgraph for Power 64
	bit user apps
From: Carl Love <cel@us.ibm.com>
To: michael@ellerman.id.au
In-Reply-To: <1213057802.25500.1.camel@localhost>
References: <200806092326.m59NQ7rM014218@imap1.linux-foundation.org>
	<1213054877.25745.11.camel@pasglop>
	<1213057802.25500.1.camel@localhost>
Content-Type: text/plain
Date: Tue, 10 Jun 2008 08:35:46 -0700
Message-Id: <1213112146.6763.177.camel@carll-linux-desktop>
Mime-Version: 1.0
Cc: akpm@linux-foundation.org, carll@us.ibm.com, paulus@samba.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Tue, 2008-06-10 at 10:30 +1000, Michael Ellerman wrote:
> On Tue, 2008-06-10 at 09:41 +1000, Benjamin Herrenschmidt wrote:
> > On Mon, 2008-06-09 at 16:26 -0700, akpm@linux-foundation.org wrote:
> > > From: Carl Love <cel@us.ibm.com>
> > > 
> > > Fix the 64 bit user code backtrace which currently may hang the system.
> > > 
> > > Signed-off-by: Carl Love <carll@us.ibm.com>
> > > Cc: Maynard Johnson <maynardj@us.ibm.com>
> > 
> > That looks weird. I doubt it's the right fix for the problem. Paul,
> > I remember this was discussed earlier, did we come up with a proper fix
> > already ?
> 
> We decided there probably wasn't a bug there at all:
> 
> http://ozlabs.org/pipermail/linuxppc-dev/2008-May/056449.html
> 
> Haven't heard from Carl if he reproduced the hang and traced it to
> something else.
> 
> cheers
> 

After a discussion of this patch, the general consensus was that the
issue is with the underlying copy from user call.  After developing and
posting the patch, I had tried to go back and reproduce it again and was
not able to. My system had changed slightly and I could get it to fail.
I still have this on my to do list to get back to working on the Powerpc
callgraph support as there are some other fundamental issues with the
code.  Specifically the call back traces are not always correct for leaf
nodes.  This was actually the issue I was working on when I found the
issue with the 64 bit applications hanging the system.  

The patch should be dropped.

                Carl Love

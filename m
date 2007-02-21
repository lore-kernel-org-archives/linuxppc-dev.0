Return-Path: <pjmaiya@signal-networks.com>
Received: from signal-networks.com (unknown [61.95.204.104])
	by ozlabs.org (Postfix) with ESMTP id 002F9DDD0C
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Feb 2007 22:45:43 +1100 (EST)
Received: from pjmaiya ([192.168.1.70])
	by signal-networks.com (mail.signal-networks.com [192.168.1.1])
	(MDaemon Standard v9.0.1) with ESMTP id md50000072889.msg
	for <linuxppc-embedded@ozlabs.org>; Wed, 21 Feb 2007 17:18:37 +0530
Message-ID: <000d01c755ae$364a7bf0$4601a8c0@signet>
From: "pjmaiya" <pjmaiya@signal-networks.com>
To: <bwarren@qstreams.com>
References: <29DC34A6B43468409F5A371CFE34E849091044@ex01.ads.ubidyne.de>
	<011b01c74b81$5604ad80$4601a8c0@signet>
	<1170949359.14627.66.camel@saruman.qstreams.net>
	<00c401c74c36$42aeded0$4601a8c0@signet>
	<01a901c750f5$ef392de0$4601a8c0@signet>
	<1171555658.7029.49.camel@saruman.qstreams.net>
Subject: Re: CLI for embedded system
Date: Wed, 21 Feb 2007 17:18:32 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear Ben,
     I have tried following option, with host as ppc_8xx, since we are using
mpc860 processor and  also we are using montavista provided compiler
(ppc_8xx).
Our embedded target runs on montavista linux with mpc860 processor and
compiler given by monta vista(hard hat linux).

host$ ./configure --host=ppc_8xx --build=i686 CC=ppc_8xx-gcc

We are getting error ppc_8xx unkown host at some stage. When we further
investigated "clish" code we found that we need to add our new architecture
in aux_scripts/configure.sub file. We have successfully built that part. But
for some libarary we are getting error in /usr/lib/libbstd++, but we need to
change this path..only option left for us to change in "configure" file
which requires autoconf tool..Also we need to change some thing in
"configure.in". We are little bit stuck in this part..Can U help in this
regard.. Writing our make for clish is massive work!!!

thanx for help.
-pjmaiya

----- Original Message ----- 
From: "Ben Warren" <bwarren@qstreams.com>
To: "pjmaiya" <pjmaiya@signal-networks.com>
Cc: <linuxppc-embedded@ozlabs.org>
Sent: Thursday, February 15, 2007 9:37 PM
Subject: Re: CLI for embedded system


> On Thu, 2007-02-15 at 17:09 +0530, pjmaiya wrote:
> > hi,
> >     I have successfully complied and used 'clish' in host system (i686
> > machine)
> > But I need to port the same for PPC platform. Can anyone suggest me how
to
> > do the same.
> >
> > thanx in advace,
> > pjmaiya
> >
>
> Like many other projects, I believe this one uses autoconf (I think
> that's the term).  As a starting point, try:
>
> host$ ./configure --host=ppc-linux-gnu --build=i686 CC=
> ${CROSS_COMPILE}gcc
>
> /* Monitor the output of configure to make sure that everything looks
> kosher.  You'll probably want to add a "--prefix=" option that tells it
> where to place the end result, and there may be other options you want
> too.  Read and understand the Makefile that configure creates.  Then:
>
> host$ make
>
> I reiterate - this is only a starting point.  This may not compile
> cleanly and you will need to experiment a bit, I'm sure.  Hopefully it's
> not too bad, but these projects can sometimes be a pain to get exactly
> as you want.
>
> regards,
> Ben
>
>

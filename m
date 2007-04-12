Return-Path: <will_schmidt@vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 500C1DDF9E
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Apr 2007 04:43:43 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l3CIiM8B018807
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Apr 2007 14:44:22 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l3CIheSP290592
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Apr 2007 14:43:40 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l3CIhdoa018970
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Apr 2007 14:43:39 -0400
Subject: Re: [PATCH] hvc_console polling mode timer backoff
From: Will Schmidt <will_schmidt@vnet.ibm.com>
To: Linas Vepstas <linas@austin.ibm.com>
In-Reply-To: <20070412173334.GP4747@austin.ibm.com>
References: <1176394477.28514.32.camel@farscape.rchland.ibm.com>
	<20070412173334.GP4747@austin.ibm.com>
Content-Type: text/plain
Date: Thu, 12 Apr 2007 13:43:30 -0500
Message-Id: <1176403411.28514.55.camel@farscape.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: will_schmidt@vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-12-04 at 12:33 -0500, Linas Vepstas wrote:
> On Thu, Apr 12, 2007 at 11:14:36AM -0500, Will Schmidt wrote:
> > +/*
> > + * timeout will vary between the MIN and MAX values defined here.  By default
> > + * and during console activity we will use a default MIN_TIMEOUT of 10.  When
> > + * the console is idle, we increase the timeout value on each pass through
> > + * msleep until we reach the max.  This may be noticeable as a brief (average
> > + * one second) delay on the console before the console responds to input when
> > + * there has been no input for some time.
> > + */
> > +#define MIN_TIMEOUT		(10)
> > +#define MAX_TIMEOUT		(2000)
> 
> [...]
> > +				msleep_interruptible(timeout);
> 
> 
> These values are milliseconds (that's what the m in msleep stands for
> or at least it did last time I looked). This 10 is 1/100 of a second,
> which makes a responsive keyboard for even a very very fast typist.
> That's fine.  But 2000 is two seconds, which is longer than the amount 
> of time that I wait before I start panicking that something is broken. 

Well, I usually give my systems at least ten seconds before I start to
worry. :-) 

I did ponder the max value to use.   Though when I sit down at &random&
console in the lab, It often takes a moment for the terminal to warm up,
or for the screen to unblank.   With that in mind, a couple seconds max
for the console does not seem unreasonable to me.

Will see if other folks have an opinion either way.. 

> 
> I'd suggest that maybe 1000 or 750 or 500 is more apropriate.
> 
> --linas

Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id BB6D2DDF7A
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Apr 2007 04:51:33 +1000 (EST)
Date: Thu, 12 Apr 2007 14:09:02 -0500
To: Will Schmidt <will_schmidt@vnet.ibm.com>
Subject: Re: [PATCH] hvc_console polling mode timer backoff
Message-ID: <20070412190902.GA8158@lixom.net>
References: <1176394477.28514.32.camel@farscape.rchland.ibm.com>
	<20070412173334.GP4747@austin.ibm.com>
	<1176403411.28514.55.camel@farscape.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1176403411.28514.55.camel@farscape.rchland.ibm.com>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 12, 2007 at 01:43:30PM -0500, Will Schmidt wrote:
> On Thu, 2007-12-04 at 12:33 -0500, Linas Vepstas wrote:
> > On Thu, Apr 12, 2007 at 11:14:36AM -0500, Will Schmidt wrote:
> > > +/*
> > > + * timeout will vary between the MIN and MAX values defined here.  By default
> > > + * and during console activity we will use a default MIN_TIMEOUT of 10.  When
> > > + * the console is idle, we increase the timeout value on each pass through
> > > + * msleep until we reach the max.  This may be noticeable as a brief (average
> > > + * one second) delay on the console before the console responds to input when
> > > + * there has been no input for some time.
> > > + */
> > > +#define MIN_TIMEOUT		(10)
> > > +#define MAX_TIMEOUT		(2000)
> > 
> > [...]
> > > +				msleep_interruptible(timeout);
> > 
> > 
> > These values are milliseconds (that's what the m in msleep stands for
> > or at least it did last time I looked). This 10 is 1/100 of a second,
> > which makes a responsive keyboard for even a very very fast typist.
> > That's fine.  But 2000 is two seconds, which is longer than the amount 
> > of time that I wait before I start panicking that something is broken. 
> 
> Well, I usually give my systems at least ten seconds before I start to
> worry. :-) 
> 
> I did ponder the max value to use.   Though when I sit down at &random&
> console in the lab, It often takes a moment for the terminal to warm up,
> or for the screen to unblank.   With that in mind, a couple seconds max
> for the console does not seem unreasonable to me.
> 
> Will see if other folks have an opinion either way.. 

I wasn't going to bring it up since I think it's a good approach as is,
but another thing that could be worth considering is to not just go
from whatever value to min on every actual input, instead go down in
delay a bit (say half the delay). Likewise you might be able to back off
more aggressively than just one millisecond per iteration.   Of course,
both of these should take min/max values into consideration.

It's the kind of change that's useful to get in early in the .22 cycle
no matter what, so if there are some interactivity hickups people have
a chance to tune it.

Besides that i think it's a great approach, there's no use in polling an
idle console often.


-Olof

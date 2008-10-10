Return-Path: <david-b@pacbell.net>
Received: from smtp119.sbc.mail.sp1.yahoo.com (smtp119.sbc.mail.sp1.yahoo.com
	[69.147.64.92]) by ozlabs.org (Postfix) with SMTP id 6466ADDED5
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Oct 2008 13:38:06 +1100 (EST)
From: David Brownell <david-b@pacbell.net>
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH v6] PPC440EPx gpio driver
Date: Thu, 9 Oct 2008 17:12:41 -0700
References: <48EE6408.3020006@harris.com>
	<20081009211852.GA23903@oksana.dev.rtsoft.ru>
In-Reply-To: <20081009211852.GA23903@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200810091712.42155.david-b@pacbell.net>
Cc: Stefan Roese <sr@denx.de>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 09 October 2008, Anton Vorontsov wrote:
> 
> > I've incorporated the other changes, with one exception.  I want
> > ppc4xx_gpio_get() to return 0 or 1 (rather than Anton's comment that any
> > non-zero value is ok), because when you use the new "export feature" in
> > sysfs, you see the raw value returned from ppc4xx_gpio_get().  So, without
> > the !!  in the return statement, you would see a strange value, like 32768
> > instead of 1:
> > 
> >       # cd gpio208
> >       # cat value
> >       32768
> > 
> > So, I think it is worth sanitizing the return value here.
> 
> I think that nonzero == high assumption is also ok for the userspace.

Actually, I was thinking that userspace might be happier
not having to deal with that ... so that's worth changing
in the sysfs glue.  I'd sign off on a patch fixing that.

I seem to recall seeing an explicit policy saying sysfs
exports booleans as 0/1, at some point, though I can't
find it just now.

- Dave

Return-Path: <rjw@sisk.pl>
Received: from ogre.sisk.pl (ogre.sisk.pl [217.79.144.158])
	by ozlabs.org (Postfix) with ESMTP id BE597B7CFA
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Apr 2010 15:14:24 +1000 (EST)
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: michael@ellerman.id.au
Subject: Re: [Bug #15589] 2.6.34-rc1: Badness at fs/proc/generic.c:316
Date: Wed, 21 Apr 2010 06:57:18 +0200
References: <deuQKFRcc0B.A.3EG.BRSzLB@tosh> <20100421155547.GA4222@x200>
	<1271809299.13262.6.camel@concordia>
In-Reply-To: <1271809299.13262.6.camel@concordia>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Message-Id: <201004210657.18864.rjw@sisk.pl>
Cc: Christian Kujau <lists@nerdbynature.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org, schwab@linux-m68k.org,
	Kernel Testers List <kernel-testers@vger.kernel.org>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Maciej Rutecki <maciej.rutecki@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wednesday 21 April 2010, Michael Ellerman wrote:
> On Wed, 2010-04-21 at 18:55 +0300, Alexey Dobriyan wrote:
> > On Tue, Apr 20, 2010 at 10:18:18PM +1000, Michael Ellerman wrote:
> > > On Mon, 2010-04-19 at 23:45 -0700, Christian Kujau wrote:
> > > --- a/fs/proc/proc_devtree.c
> > > +++ b/fs/proc/proc_devtree.c
> > > @@ -175,6 +175,24 @@ retry:
> > >         return fixed_name;
> > >  }
> > >  
> > > +static const char *unslash_name(const char *name)
> > > +{
> > > +       char *p, *fixed_name;
> > > +
> > > +       fixed_name = kstrdup(name);
> > > +       if (!fixed_name) {
> > > +               printk(KERN_ERR "device-tree: Out of memory trying to unslash "
> > > +                               "name \"%s\"\n", name);
> > > +               return name;
> > > +       }
> > > +
> > > +       p = fixed_name;
> > > +       while ((p = strstr(p, "/")))
> > > +               *p++ = '_';
> > 
> > This is wasteful. :-)
> 
> Whatever, patches welcome :)
> 
> > Also, I hope we won't spit message every time allocation fail.
> 
> We do. Your system is mostly hosed anyway, but feel free to rate limit
> it or something.

OK

Is anyone going to post a clean patch for that with a sign-off?

Rafael

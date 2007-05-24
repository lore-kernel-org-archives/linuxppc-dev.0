Return-Path: <mgreer@mvista.com>
Date: Thu, 24 May 2007 14:28:32 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: "Mark A. Greer" <mgreer@mvista.com>, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev <Linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH 1/13] powerpc: Add Makefile rules to wrap dts file in
	zImage
Message-ID: <20070524212832.GB32012@mag.az.mvista.com>
References: <20070512004605.GA2808@mag.az.mvista.com>
	<20070512005336.GA3365@mag.az.mvista.com>
	<20070514003332.GE6517@localhost.localdomain>
	<20070521181043.GB7120@mag.az.mvista.com>
	<20070522002349.GA25426@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070522002349.GA25426@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 22, 2007 at 10:23:49AM +1000, David Gibson wrote:
> On Mon, May 21, 2007 at 11:10:43AM -0700, Mark A. Greer wrote:
> > On Mon, May 14, 2007 at 10:33:32AM +1000, David Gibson wrote:
> > > On Fri, May 11, 2007 at 05:53:36PM -0700, Mark A. Greer wrote:
> > > > +$(obj)/zImage.dts:	$(addprefix $(obj)/, $(dts-y))
> > > > +	@rm -f $@; ln $< $@
> > > > +$(obj)/zImage.dts_initrd:	$(addprefix $(obj)/, $(dts_initrd-y))
> > > > +	@rm -f $@; ln $< $@
> > > > +
> > > 
> > > I thought you said you were going to drop this bit?
> > 
> > Hi David.
> > 
> > Would you elaborate on what your alternative is?  A lot of the Makefile
> > stuff is still black magic to me.
> 
> Just leave them out.  As long as you add the correct specific
> zImage.dts.% and zImage.dts_initrd.% targets to image-y and initrd-y,
> then a "make zImage" from the top-level Makefile will get them built.

That defeats the whole purpose of the patch--to allow the selection of
wrapping a dtb or not at build time.  Its just like initrd, you choose
whether to "do it" at build time.

Mark

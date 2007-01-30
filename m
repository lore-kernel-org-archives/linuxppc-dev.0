Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao02.cox.net (fed1rmmtao02.cox.net [68.230.241.37])
	by ozlabs.org (Postfix) with ESMTP id 7F7C8DDFCC
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Jan 2007 05:53:39 +1100 (EST)
Date: Tue, 30 Jan 2007 11:53:36 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] generic RTC support for PPC
Message-ID: <20070130185336.GA10776@smtp.west.cox.net>
References: <20070125073754.GA10004@lixom.net>
	<20070130051736.GH28746@smtp.west.cox.net>
	<0747B3CD-F875-4A28-8199-1A7FF3666301@kernel.crashing.org>
	<20070130160340.GA25443@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070130160340.GA25443@lixom.net>
Cc: kimphill@freescale.com, paulus@samba.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jan 30, 2007 at 10:03:40AM -0600, Olof Johansson wrote:
> On Tue, Jan 30, 2007 at 12:37:12AM -0600, Kumar Gala wrote:
> > 
> > On Jan 29, 2007, at 11:17 PM, Tom Rini wrote:
> > 
> > >On Thu, Jan 25, 2007 at 01:37:54AM -0600, Olof Johansson wrote:
> > >
> > >>Make the PPC RTC functions use the generic RTC infrastructure if they
> > >>are not already defined (and an RTC is registered in the system).
> > >>
> > >>This should make it possible to remove the hideous direct access used
> > >>in some of the 83xx platforms.
> > >
> > >Now, I know I'm a bit late, and I've been quiet of late, but, um,  
> > >why is
> > >there anything other than the RTC class stuff being used?  I know
> > >drivers/char/genrtc.c isn't gone yet, but really, it should be in the
> > >process of being phased out.  IMHO, it should depend on !POWERPC (or
> > >whatever the magic is to allow arch/ppc && !arch/powerpc).
> > 
> > I think the problem was calling the RTC class code from the place's  
> > we use rtc in ppc had locking issues or something like that.

Sounds like the RTC class code needs to be fixed up then.  There's
really no good reason for drivers/char/genrtc.c to live anymore, a
better 'generic rtc' driver set exists now.

> Yes, and it does a direct call into the driver instead of using the
> subsystem, exporting the symbol from the driver. Not a very pretty
> solution but it's possible that the genrtc stuff wasn't available when
> it was first implemented.

genrtc is quite old, really :)

-- 
Tom Rini

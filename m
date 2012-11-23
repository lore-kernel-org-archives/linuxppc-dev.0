Return-Path: <gregkh@linuxfoundation.org>
Received: from mail-da0-f51.google.com (mail-da0-f51.google.com
 [209.85.210.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4B30C2C007A
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Nov 2012 03:39:10 +1100 (EST)
Received: by mail-da0-f51.google.com with SMTP id i30so2165274dad.38
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Nov 2012 08:39:09 -0800 (PST)
Date: Fri, 23 Nov 2012 08:40:24 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 056/493] edac: remove use of __devexit_p
Message-ID: <20121123164024.GB5471@kroah.com>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-56-git-send-email-wfp5p@virginia.edu>
 <20121122134451.GG17147@x1.alien8.de>
 <20121122182222.GB25392@kroah.com>
 <20121123100635.GC18765@x1.alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20121123100635.GC18765@x1.alien8.de>
Cc: "Arvind R." <arvino55@gmail.com>, Mark Gross <mark.gross@intel.com>,
 Mauro Carvalho Chehab <mchehab@redhat.com>,
 Jason Uhlenkott <juhlenko@akamai.com>,
 Ranganathan Desikan <ravi@jetztechnologies.com>,
 Bill Pemberton <wfp5p@virginia.edu>, Egor Martovetsky <egor@pasemi.com>,
 Doug Thompson <dougthompson@xmission.com>, Olof Johansson <olof@lixom.net>,
 linux-edac@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Tim Small <tim@buttersideup.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Nov 23, 2012 at 11:06:35AM +0100, Borislav Petkov wrote:
> On Thu, Nov 22, 2012 at 10:22:22AM -0800, Greg KH wrote:
> > On Thu, Nov 22, 2012 at 02:44:51PM +0100, Borislav Petkov wrote:
> > > On Mon, Nov 19, 2012 at 01:20:05PM -0500, Bill Pemberton wrote:
> > > > CONFIG_HOTPLUG is going away as an option so __devexit_p is no longer
> > > > needed.
> > > 
> > > Erm, I don't understand. __devexit_p is defined also for modules not
> > > only for CONFIG_HOTPLUG:
> > > 
> > > #if defined(MODULE) || defined(CONFIG_HOTPLUG)
> > > #define __devexit_p(x) x
> > > #else
> > > #define __devexit_p(x) NULL
> > > #endif
> > > 
> > > AFAICT, we cannot remove it yet no?
> > 
> > If MODULE is defined, it defaults to nothing.  And now that
> > CONFIG_HOTPLUG is always set to Y, this always defaults to nothing.
> 
> Huh, if MODULE is defined, __devexit_p(x) evaluates to the function name
> 'x' itself, AFAICT.

Yes, sorry, that is what I was trying to say here, I meant "nothing" in
that the macro did not do anything, not that it was setting it to NULL.

> So, if MODULE is defined and we have a reference from retained sections
> to a discarded section (I'm rereading the comment over __devexit_p in
> <include/linux/init.h> btw) then we'll get linker errors so we'd still
> need the ifdef thing, no?

No, as there will not be any discarded sections anymore because
CONFIG_HOTPLUG is always enabled.  We will just delete this whole
#if/#endif section once all users of __devexit_p() are gone from the
tree.

Does that help out?

thanks,

greg k-h

Return-Path: <bp@alien8.de>
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:120:8448::d00d])
 by ozlabs.org (Postfix) with ESMTP id 212D62C008C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Nov 2012 21:07:11 +1100 (EST)
Date: Fri, 23 Nov 2012 11:06:35 +0100
From: Borislav Petkov <bp@alien8.de>
To: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 056/493] edac: remove use of __devexit_p
Message-ID: <20121123100635.GC18765@x1.alien8.de>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-56-git-send-email-wfp5p@virginia.edu>
 <20121122134451.GG17147@x1.alien8.de>
 <20121122182222.GB25392@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20121122182222.GB25392@kroah.com>
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

On Thu, Nov 22, 2012 at 10:22:22AM -0800, Greg KH wrote:
> On Thu, Nov 22, 2012 at 02:44:51PM +0100, Borislav Petkov wrote:
> > On Mon, Nov 19, 2012 at 01:20:05PM -0500, Bill Pemberton wrote:
> > > CONFIG_HOTPLUG is going away as an option so __devexit_p is no longer
> > > needed.
> > 
> > Erm, I don't understand. __devexit_p is defined also for modules not
> > only for CONFIG_HOTPLUG:
> > 
> > #if defined(MODULE) || defined(CONFIG_HOTPLUG)
> > #define __devexit_p(x) x
> > #else
> > #define __devexit_p(x) NULL
> > #endif
> > 
> > AFAICT, we cannot remove it yet no?
> 
> If MODULE is defined, it defaults to nothing.  And now that
> CONFIG_HOTPLUG is always set to Y, this always defaults to nothing.

Huh, if MODULE is defined, __devexit_p(x) evaluates to the function name
'x' itself, AFAICT.

So, if MODULE is defined and we have a reference from retained sections
to a discarded section (I'm rereading the comment over __devexit_p in
<include/linux/init.h> btw) then we'll get linker errors so we'd still
need the ifdef thing, no?

What am I missing?

Thanks.

-- 
Regards/Gruss,
Boris.

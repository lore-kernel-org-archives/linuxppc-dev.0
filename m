Return-Path: <bp@alien8.de>
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:120:8448::d00d])
 by ozlabs.org (Postfix) with ESMTP id 12E032C008A
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Nov 2012 20:14:57 +1100 (EST)
Date: Sat, 24 Nov 2012 10:14:53 +0100
From: Borislav Petkov <bp@alien8.de>
To: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 056/493] edac: remove use of __devexit_p
Message-ID: <20121124091453.GC25143@x1.alien8.de>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-56-git-send-email-wfp5p@virginia.edu>
 <20121122134451.GG17147@x1.alien8.de>
 <20121122182222.GB25392@kroah.com>
 <20121123100635.GC18765@x1.alien8.de>
 <20121123164024.GB5471@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20121123164024.GB5471@kroah.com>
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

On Fri, Nov 23, 2012 at 08:40:24AM -0800, Greg KH wrote:
> No, as there will not be any discarded sections anymore because
> CONFIG_HOTPLUG is always enabled. We will just delete this whole
> #if/#endif section once all users of __devexit_p() are gone from the
> tree.
>
> Does that help out?

Yes, I missed the fact that there won't be any discarded sections
anymore. Btw, in that case, you'd probably need to remove all those

#ifdef CONFIG_HOTPLUG

...

#endif

stanzas surrounding different places in the kernel (I see 40ish
currenty) now that HOTPLUG is def_bool y and if you haven't done so yet.

Thanks for explaining.

Btw, you can have my

Acked-by: Borislav Petkov <bp@alien8.de>

for the amd64_edac pieces.

-- 
Regards/Gruss,
Boris.

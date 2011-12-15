Return-Path: <jkosina@suse.cz>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 99B0C1007D7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Dec 2011 21:08:23 +1100 (EST)
Date: Thu, 15 Dec 2011 11:08:08 +0100 (CET)
From: Jiri Kosina <jkosina@suse.cz>
To: Tony Breeds <tony@bakeyournoodle.com>
Subject: Re: linux-next bad Kconfig for drivers/hid
In-Reply-To: <20111212003140.GA16353@thor.bakeyournoodle.com>
Message-ID: <alpine.LNX.2.00.1112151107020.21970@pobox.suse.cz>
References: <20111209012746.GC20353@thor.bakeyournoodle.com>
 <4EE19DA0.5010705@goop.org>
 <alpine.LNX.2.00.1112120020330.21970@pobox.suse.cz>
 <20111212003140.GA16353@thor.bakeyournoodle.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeremy Fitzhardinge <jeremy@goop.org>,
 LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel ML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 12 Dec 2011, Tony Breeds wrote:

> On Mon, Dec 12, 2011 at 12:21:16AM +0100, Jiri Kosina wrote:
> > On Thu, 8 Dec 2011, Jeremy Fitzhardinge wrote:
> > > 
> > > Hm.  How about making it "depends on HID && POWER_SUPPLY"?  I think that
> > > would needlessly disable it if HID is also modular, but I'm not sure how
> > > to fix that.  "depends on HID && POWER_SUPPLY && HID == POWER_SUPPLY"?
> 
> That would work, but I think technically I think you could end up with
> HID=m and POWER_SUPPLY=m which would still allow HID_BATTERY_STRENGTH=y
> which is the same problem.
> 
> I don't know what kind of .config contortions you'd need to do to get
> there.
>  
> > How about making it 'default POWER_SUPPLY' instead?
> 
> By itself that wont help as POWER_SUPPLY=m statisfies.
> 
> So it looks like we have Jeremy's:
> 	HID && POWER_SUPPLY && HID == POWER_SUPPLY

Tony,

have you actually tested this one to work in the configuration you have 
been seeing it to fail?

I don't seem to be able to find any use of '==' in other Kconfig files 
(and never used it myself), so I'd like to have confirmation that it 
actually works and fixes the problem before I apply it :)

Thanks,

-- 
Jiri Kosina
SUSE Labs

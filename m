Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao03.cox.net (fed1rmmtao03.cox.net [68.230.241.36])
	by ozlabs.org (Postfix) with ESMTP id 3DC6E2BF0E
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Jan 2005 01:19:04 +1100 (EST)
Date: Wed, 12 Jan 2005 07:19:02 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Dan Malek <dan@embeddededge.com>
Message-ID: <20050112141902.GQ3391@smtp.west.cox.net>
References: <1102585377.41b81e218d6df@webmail.televes.com:443>
	<20050105174838.GF4213@smtp.west.cox.net>
	<71A72D18-5F4C-11D9-A045-003065F9B7DC@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <71A72D18-5F4C-11D9-A045-003065F9B7DC@embeddededge.com>
Cc: alebas@televes.com, linuxppc-embedded@ozlabs.org
Subject: Re: Kernel 2.6.10 running on mpc8272ads
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Jan 05, 2005 at 02:03:11PM -0500, Dan Malek wrote:
> 
> On Jan 5, 2005, at 12:48 PM, Tom Rini wrote:
> 
> >Indeed.  While I had a PQ2FADS for a bit, I had to do that as well.
> >Kumar, what/why is that needed exactly?  Did I screw up in re-working
> >the 82xx init stuff and it needs to happen a bit later in boot?
> 
> I don't understand the what/why question, but that has never stopped
> me from providing answers in the past :-)

Ha!

> So, In 2.6, and I think in some of the 2.4 cpm2 stuff, we no longer
> automatically map any of the hardware IO resources for common
> access like I used to do in the past.  If you want to access the
> BCSR, you need to make sure it is ioremap()'ed in your driver before
> you make the access.  Was that the question, or was it that
> the BCSR should have been set someplace outside of the
> driver for the serial port to work?

Actually, I did break it.  When I re-worked the hooks around
platform_init/ppc_md.setup_arch, I added a call-out from platform_init()
but not from m82xx_setup_arch(), when I really needed one.  I'll follow
up with a patch momentarily.

-- 
Tom Rini
http://gate.crashing.org/~trini/

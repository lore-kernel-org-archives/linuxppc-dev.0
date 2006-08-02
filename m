Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao06.cox.net (fed1rmmtao06.cox.net [68.230.241.33])
	by ozlabs.org (Postfix) with ESMTP id 3B9CF67BA4
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Aug 2006 02:38:25 +1000 (EST)
Date: Wed, 2 Aug 2006 09:38:22 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: RFC: Location for Device Tree Sources?
Message-ID: <20060802163822.GK3075@smtp.west.cox.net>
References: <1154464346.19994.4.camel@cashmere.sps.mot.com>
	<Pine.LNX.4.60.0608012258040.4041@poirot.grange>
	<1154466094.11069.6.camel@localhost>
	<20060802003504.GA20439@mag.az.mvista.com>
	<1154481150.2676.3.camel@vader.jdub.homelinux.org>
	<528646bc0608012020l11690cf7wbb7d93e6ba6eae90@mail.gmail.com>
	<33AC4A3A-876A-4AF9-B851-928EE80A9D80@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <33AC4A3A-876A-4AF9-B851-928EE80A9D80@kernel.crashing.org>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 02, 2006 at 08:35:55AM -0500, Kumar Gala wrote:

> I like this location and agree that having them in tree makes sense.   
> And putting them under boot isolates them from the kernel proper.
> 
> The reason I see to having them in tree is to ensure proper version  
> compatibility.  This way there is no concern about which .dts version  
> will work with which kernel.  In the future we can always pull them  
> out when things are more stable.

I'd rephrase that as an arguement to keep them out of tree:

The reason I see to having them out of tree is to ensure we follow the
intent trees holding the information about where devices live and the
kernel being good and asking the trees.  This way there is no concern
about which (otherwise valid) .dts version will work with which kernel,
as breaking a valid .dts is either a bug (unintentional API change or a
'Oops, I forgot that the tree might not specify X' which potentially
preempts the custom board Y (that's like a sandpoint!) just doesn't have
X bugs) or a change that requires a dts version bump.

I'll throw in the caveat that I'm not 100% sure we're that stable yet,
but it certainly seems like it, at least for the overall portion where
you might really have incompatible trees.  More or less complete (now
every device is described!) dts should be interchangable to the kernel
for the custom board X is just a little different from ref board Y
issues (and now, in theory, the Just Like A Sandpoint board, with a
correct dts will boot the 'sandpoint' kernel).

-- 
Tom Rini

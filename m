Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao09.cox.net (fed1rmmtao09.cox.net [68.230.241.30])
	by ozlabs.org (Postfix) with ESMTP id 2F26C68926
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  2 Feb 2006 14:07:24 +1100 (EST)
Date: Wed, 1 Feb 2006 20:07:21 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Yosemite/440EP why are readl()/ioread32() setup to
	readlittle-endian?
Message-ID: <20060201200721.E16064@cox.net>
References: <87wtgeeq8o.fsf@48ers.dk>
	<Pine.LNX.4.44.0602011851490.22854-100000@gate.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.44.0602011851490.22854-100000@gate.crashing.org>;
	from galak@kernel.crashing.org on Wed, Feb 01, 2006 at 06:54:09PM
	-0600
Cc: linuxppc-embedded@ozlabs.org, "Jenkins, Clive" <Clive.Jenkins@xerox.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Feb 01, 2006 at 06:54:09PM -0600, Kumar Gala wrote:
> On Wed, 1 Feb 2006, Peter Korsgaard wrote:
> 
> > >>>>> "Matt" == Matt Porter <mporter@kernel.crashing.org> writes:
> > 
> >  Matt> read*/write* and ioread*/iowrite* generate outbound little
> >  Matt> endian cycles on ALL arches, period.  They are intended
> >  Matt> only for PCI use and have generic names only because of
> >  Matt> the assumption that "all the world is a PC".
> > 
> > What is the preferred way of accessing non-PCI devices then? Direct
> > pointer access?
> 
> No direct pointer access is bad. On PPC You can use
> in_be{8,16,32}/out_be{8,16,32}

Ack. Also, it should be pointed out that there are countless
examples of PPC drivers where this is done properly. 4xx, 83xx,
85xx, etc. on-chip peripherals all do this since they are
naturally BE registers.

-Matt

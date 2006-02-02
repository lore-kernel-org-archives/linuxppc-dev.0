Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao10.cox.net (fed1rmmtao10.cox.net [68.230.241.29])
	by ozlabs.org (Postfix) with ESMTP id 9374868A14
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  3 Feb 2006 01:22:04 +1100 (EST)
Date: Thu, 2 Feb 2006 07:21:58 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: Yosemite/440EP why are readl()/ioread32() setup to
	readlittle-endian?
Message-ID: <20060202072158.A27740@cox.net>
References: <87wtgeeq8o.fsf@48ers.dk>
	<Pine.LNX.4.44.0602011851490.22854-100000@gate.crashing.org>
	<9305ca410602020009r4946d874qc52c2b27f715370f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9305ca410602020009r4946d874qc52c2b27f715370f@mail.gmail.com>;
	from jacmet@sunsite.dk on Thu, Feb 02, 2006 at 09:09:17AM +0100
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

On Thu, Feb 02, 2006 at 09:09:17AM +0100, Peter Korsgaard wrote:
> On 2/2/06, Kumar Gala <galak@kernel.crashing.org> wrote:
> > > What is the preferred way of accessing non-PCI devices then? Direct
> > > pointer access?
> >
> > No direct pointer access is bad. On PPC You can use
> > in_be{8,16,32}/out_be{8,16,32}
> 
> What about arch independent drivers? Are there any generic approach
> for this or do you have to stick to ugly #ifdefs to decide between
> in_be32/inl ?

ioread*be()/iowrite*be() can be used for this. Since the generic
big endian accessors became a standard thing a little while back,
all the PPC on-chip drivers should move to that. It's just a matter
of time.

-Matt

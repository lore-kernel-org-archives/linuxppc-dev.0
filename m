Return-Path: <sven.luther@wanadoo.fr>
Received: from smtp7.wanadoo.fr (smtp7.wanadoo.fr [193.252.22.24])
	by ozlabs.org (Postfix) with ESMTP id EA26E67A79
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  7 Mar 2005 18:04:03 +1100 (EST)
Date: Mon, 7 Mar 2005 07:52:10 +0100
To: Dale Farnsworth <dale@farnsworth.org>
Message-ID: <20050307065210.GA21270@pegasos>
References: <421DF2B8.6040007@mvista.com> <20050224160411.GA11197@pegasos>
	<20050224172420.GA6932@xyzzy> <20050305192752.GA28491@pegasos>
	<20050305203254.GB30151@pegasos> <20050305225128.GC16904@xyzzy>
	<20050306070248.GA6673@pegasos> <20050306102924.GA32386@xyzzy>
	<20050306191034.GA10975@pegasos> <20050307010058.GB22642@xyzzy>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20050307010058.GB22642@xyzzy>
From: Sven Luther <sven.luther@wanadoo.fr>
Cc: Nicolas DET <det.nicolas@free.fr>, linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH][PPC32] mv64x60 updates
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sun, Mar 06, 2005 at 06:00:58PM -0700, Dale Farnsworth wrote:
> On Sun, Mar 06, 2005 at 08:10:34PM +0100, Sven Luther wrote:
> > On Sun, Mar 06, 2005 at 03:29:24AM -0700, Dale Farnsworth wrote:
> > > MV64360 is in arch/ppc/Kconfig, and is currently defined for KATANA and
> > > CHESTNUT.  If I understand correctly, it should be defined for any
> > > board using the MV64360.  I don't think we want the PPC_CHRP dependency.
> > 
> > Ah, i guess that was the missing bit. Basically i need to set MV64360 for my
> > board, but since it is a generic PPC_CHRP, how is that supposed to work ? 
> > 
> > Could you send me maybe a list of files which need merging yet, compared to
> > 2.6.11 ? I guess it just doesn't work because i am missing pieces.
> 
> I would be guessing, since I've focused on the ethernet driver.  Mark
> Greer <mgreer@mvista.com> has done the core mv64[34]60 core support.
> Nicholas is working with regarding Pegasos II support.

Nicolas even, and i work with him on this.

> > The pegasos has the mv64360 registers mapped at 0xf1000000, and the ports
> > (only port1 is wired though) mapped at interrupt 9, shared with other devices.
> > I guess that would be the only real difference with the other currently
> > supported hardware, right ? 
> 
> Nicholas implied that the PCI IRQs are different as well.

The real problem as far as i see it, is that the mv6[34]60 code does too much.
The pegasos OpenFirmware implementation initializes the chip, and we really
only need the ethernet part. It seems that the code from Mark Greer
initializes the whole stuff, since it has no usefull firmware under it anyway,
and thus mis-initializes some of it and thus fully break everything.

Mark, any comment on this ? 

But i hear Nicolas has done some useful work yesterday evening, i will review
it as soon as he is back from dreamland :)

Friendly,

Sven Luther

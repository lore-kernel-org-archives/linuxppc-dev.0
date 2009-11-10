Return-Path: <linnj@xilinx.com>
Received: from SG2EHSOBE002.bigfish.com (sg2ehsobe002.messaging.microsoft.com
	[207.46.51.76]) by ozlabs.org (Postfix) with ESMTP id BAD62B7C1F
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Nov 2009 09:38:41 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Subject: RE: [spi-devel-general] [PATCH v4] xilinx_spi: Splitted into generic,
	of and platform driver, added support for DS570
Date: Tue, 10 Nov 2009 10:23:02 -0700
In-Reply-To: <fa686aa40911100844q19789297h8e6713e915185a7@mail.gmail.com>
References: <4AC0C699.2070506@mocean-labs.com>
	<fa686aa40911091321w187fe85fl4e6d9f36f5966f34@mail.gmail.com>
	<4AF99298.9020207@mocean-labs.com>
	<fa686aa40911100844q19789297h8e6713e915185a7@mail.gmail.com>
From: John Linn <linnj@xilinx.com>
To: "Grant Likely" <grant.likely@secretlab.ca>,
	=?iso-8859-1?Q?Richard_R=F6jfors?= <richard.rojfors@mocean-labs.com>
Message-ID: <00fe7c25-4fd8-4df1-b712-ed31db58ba58@SG2EHSMHS010.ehs.local>
Cc: spi-devel-general@lists.sourceforge.net,
	Andrew Morton <akpm@linux-foundation.org>,
	dbrownell@users.sourceforge.net, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: glikely@secretlab.ca [mailto:glikely@secretlab.ca] On Behalf Of Gra=
nt Likely
> Sent: Tuesday, November 10, 2009 9:45 AM
> To: Richard R=F6jfors
> Cc: spi-devel-general@lists.sourceforge.net; linuxppc-dev@ozlabs.org; And=
rew Morton;
> dbrownell@users.sourceforge.net; John Linn
> Subject: Re: [spi-devel-general] [PATCH v4] xilinx_spi: Splitted into gen=
eric, of and platform
> driver, added support for DS570
> =

> On Tue, Nov 10, 2009 at 9:19 AM, Richard R=F6jfors
> <richard.rojfors@mocean-labs.com> wrote:
> > Grant Likely wrote:
> >> Oops, I replied to the original version, but missed the subsequent
> >> versions. =A0Looks like some of my comments still apply though.
> >> Overall, the patch changes too many things all at once. =A0You should
> >> look at splitting it up. =A0At the very least the io accessor changes
> >> should be done in a separate patch.
> =

> Hi Richard.  Please do another spin of this patch.  I don't have any
> particular problem with the changes, but it needs to be in a more
> granular form so I can review it properly.

I agree.  =


We have a functioning driver such that I need to make sure it doesn't regre=
ss. More granular changes will also allow us to better isolate any problems=
 if they occur.

Thanks,
John

> =

> >>> +struct xilinx_spi {
> >>> + =A0 =A0 =A0 /* bitbang has to be first */
> >>> + =A0 =A0 =A0 struct spi_bitbang bitbang;
> >>> + =A0 =A0 =A0 struct completion done;
> >>> + =A0 =A0 =A0 struct resource mem; /* phys mem */
> >>> + =A0 =A0 =A0 void __iomem =A0 =A0*regs; =A0/* virt. address of the c=
ontrol registers */
> >>> + =A0 =A0 =A0 u32 irq;
> >>> + =A0 =A0 =A0 u8 *rx_ptr; =A0 =A0 =A0 =A0 =A0 =A0 /* pointer in the T=
x buffer */
> >>> + =A0 =A0 =A0 const u8 *tx_ptr; =A0 =A0 =A0 /* pointer in the Rx buff=
er */
> >>> + =A0 =A0 =A0 int remaining_bytes; =A0 =A0/* the number of bytes left=
 to transfer */
> >>> + =A0 =A0 =A0 /* offset to the XSPI regs, these might vary... */
> >>> + =A0 =A0 =A0 u8 bits_per_word;
> >>> + =A0 =A0 =A0 bool big_endian; =A0 =A0 =A0 =A0/* The device could be =
accessed big or little
> >>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* en=
dian
> >>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> >>> +};
> >>> +
> >>
> >> Why is the definition of xilinx_spi moved?
> >
> > I liked the idea of heaving the struct defined in the top of the file.
> =

> ... which is completely unrelated to the patch purpose, and is not
> mentioned in the patch header.  If you really want to move it then put
> it in a completely separate patch and describe the change properly.
> As it is right now it is just noise that makes the stated purpose of
> the patch hard to review.
> =

> >> Ah, you changed these to functions instead of macros. =A0I like.
> >> However, as you suggested elsewhere in this thread, you could change
> >> these to callbacks and then eliminate the if/else statements. =A0I thi=
nk
> >> that is the approach you should use. =A0I don't think you need to worr=
y
> >> about it being slower. =A0Any extra cycles for jumping to a callback
> >> will be far dwarfed by the number of cycles it takes to complete an
> >> SPI transfer.
> >
> > Sure that can be updated. I prefer to do that in an incremental patch, =
would be great to get this
> > big one merged first.
> =

> As already commented on, this patch is too big and does too many
> unrelated things.  Please split into discrete changes so it can be
> reviewed properly.
> =

> Thanks,
> g.
> =

> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.


This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.

Return-Path: <scottwood@freescale.com>
Date: Mon, 3 Jan 2011 13:51:20 -0600
From: Scott Wood <scottwood@freescale.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC] MPIC Bindings and Bindings for AMP Systems
Message-ID: <20110103135120.32aeb60d@udp111988uds.am.freescale.net>
In-Reply-To: <20101223223325.GK20384@angua.secretlab.ca>
References: <4D12F171.7010103@mentor.com>
	<20101223185623.GA20384@angua.secretlab.ca>
	<4D13C402.2090209@mentor.com>
	<20101223223325.GK20384@angua.secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: Meador Inge <meador_inge@mentor.com>, "Blanchard,
	Hollis" <Hollis_Blanchard@mentor.com>, devicetree-discuss@lists.ozlabs.org,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 23 Dec 2010 15:33:25 -0700
Grant Likely <grant.likely@secretlab.ca> wrote:

> On Thu, Dec 23, 2010 at 03:49:54PM -0600, Meador Inge wrote:
> > How do you
> > see this working in terms of processing the data?  It seems like we
> > are going to have to be aware of N values instead of 1, which seems
> > worse.
> 
> This argument has been rehashed many times, but it basically comes
> down to compatible values should ideally be anchored to a real
> implemented device, not to a family of devices, or to an unversioned
> specification.

Freescale MPICs do have version numbers (version registers, even).  We
should put that version (possibly along with a compatible version) in
the compatible, though, for blocks such as this which don't include the
main MPIC registers and thus the version registers.

> In practise, the implementation doesn't actually look any different
> except that the 'reference' version specifies a specific
> implementation instead of a generic name.  To use a concrete example,
> if there are two parts using this MPIC, like the freescale p2040 and
> p4080, and say for argument that the p2040 was implemented first, then
> the compatible values would look like:
> 
> for the p2040:   compatible = "fsl,p2040-msgr";
> for the p4080:   compatible = "fsl,p4080-msgr", "fsl,p2040-msgr";

While I don't think it affected the message unit, p4080 rev 1 has a
different version of the MPIC from p4080 rev 2 (4.0 versus 4.1, IIRC).

I don't think "mpic-" should be dropped, whether a specific chip is
added or not.  "msgr" just seems too generic, and "mpic-" tells the
reader where in the chip manual they can find information about it.

> > >?  This needs some more explanation.  cell-index often gets abused as
> > >a way to enumerate devices.  Typically, the address of the device
> > >itself is sufficient to identify the device.
> > 
> > The message registers typically come in blocks of four memory mapped
> > registers and may not be in contiguous memory (example [3]).  The
> > intent of 'cell-index' is to put an ordering on the blocks (so, yes,
> > enumeration).  We could order them by address as well I suppose.
> > One less property to worry about :)

But why do we care about ordering them?  What's important is just that
you use the same one on both the sending partition and the receiving
partition.

-Scott

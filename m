Return-Path: <glikely@secretlab.ca>
Sender: Grant Likely <glikely@secretlab.ca>
Date: Fri, 7 Jan 2011 10:23:04 -0700
From: Grant Likely <grant.likely@secretlab.ca>
To: David Gibson <david@gibson.dropbear.id.au>,
	"Blanchard, Hollis" <Hollis_Blanchard@mentor.com>,
	devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, Scott Wood <scottwood@freescale.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	"Saxena, Deepak" <deepak_saxena@mentor.com>
Subject: Re: [PATCH] of/device: Don't register disabled devices
Message-ID: <20110107172304.GC25446@angua.secretlab.ca>
References: <20110103230122.25772.72990.stgit@localhost6.localdomain6>
	<DD7A9A95166BF4418C4C1EB2033B6EE2038FA8E5@na3-mail.mgc.mentorg.com>
	<20110105233535.GB8846@yookeroo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110105233535.GB8846@yookeroo>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jan 06, 2011 at 10:35:35AM +1100, David Gibson wrote:
> On Wed, Jan 05, 2011 at 02:53:27PM -0800, Blanchard, Hollis wrote:
> > On 01/03/2011 03:01 PM, Grant Likely wrote:
> > > Device nodes with the property status="disabled" are not usable and so
> > > don't register them when parsing the device tree for devices.
> > >
> > This is great and all, but a fair amount of driver code explicitly 
> > searches the tree, rather than registering a probe function. That's why 
> > our earlier patches in this area were more comprehensive.

As your patch set shows, the total set isn't unmanageable, and the
preference for new code is to use the device model infrastructure if
at all possible.

> > 
> > What are your thoughts on handling those cases?
> 
> One by one.  Trying to handle the explicit searches automagically is
> just asking for trouble.

Just as David says, the special cases are... well... special.
Anything making decisions about registering devices needs to follow
the status!="okay" rules.

g.

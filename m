Return-Path: <holt@sgi.com>
Received: from relay.sgi.com (relay1.sgi.com [192.48.179.29])
	by ozlabs.org (Postfix) with ESMTP id 975EBB6F76
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Aug 2011 04:35:28 +1000 (EST)
Date: Wed, 10 Aug 2011 13:35:26 -0500
From: Robin Holt <holt@sgi.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v10 5/5] [powerpc] Fix up fsl-flexcan device tree binding.
Message-ID: <20110810183526.GZ4926@sgi.com>
References: <1312945564-6626-1-git-send-email-holt@sgi.com>
	<1312945564-6626-6-git-send-email-holt@sgi.com>
	<4E428BFF.7060402@grandegger.com> <20110810141550.GQ4926@sgi.com>
	<9C64B7751C3BCA41B64A68E23005A7BE1C6A21@039-SN1MPN1-002.039d.mgd.msft.net>
	<20110810160054.GT4926@sgi.com> <4E42CCB0.8090803@grandegger.com>
	<4E42CDA8.5050902@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4E42CDA8.5050902@freescale.com>
Cc: Wood Scott-B07421 <B07421@freescale.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	U Bhaskar-B22300 <B22300@freescale.com>,
	"socketcan-core@lists.berlios.de" <socketcan-core@lists.berlios.de>,
	Robin Holt <holt@sgi.com>, PPC list <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 10, 2011 at 01:27:52PM -0500, Scott Wood wrote:
> On 08/10/2011 01:23 PM, Wolfgang Grandegger wrote:
> > On 08/10/2011 06:00 PM, Robin Holt wrote:
> >> On Wed, Aug 10, 2011 at 02:36:20PM +0000, U Bhaskar-B22300 wrote:
> > ...
> >> It looks like the way to do that is to assign a label to those devices
> >> and then associate the label with an alias.  I have no idea how that
> >> works under the hood, but it is the way other files are set up.  Take a
> >> look at arch/powerpc/boot/dts/bamboo.dts for how they define the serial
> >> interfaces.
> > 
> > With a label you mean "label:" at the beginning of a node. Such labels
> > are translated by the device tree compiler in node handles, which can be
> > referenced within nodes by using <&label>, e.g.:
> > 
> > UIC0: interrupt-controller0 {
> > 	...
> > };
> > UIC1: interrupt-controller1 {
> > 	...
> > 	interrupt-parent = <&UIC0>;
> > 	...
> > };
> > 
> > It has nothing to do with the name of the node.
> 
> "...and then associate the label with an alias."
> 
> The alias can then be used if you want "can0" versus "can1".

Does the alias get used by either the kernel or something else or is it
just extra detail with no purpose?

Robin

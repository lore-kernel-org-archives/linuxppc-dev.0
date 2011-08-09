Return-Path: <holt@sgi.com>
Received: from relay.sgi.com (relay3.sgi.com [192.48.152.1])
	by ozlabs.org (Postfix) with ESMTP id 16626B6F57
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 10 Aug 2011 04:45:25 +1000 (EST)
Date: Tue, 9 Aug 2011 13:45:24 -0500
From: Robin Holt <holt@sgi.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 5/5] [powerpc] Fix up fsl-flexcan device tree binding.
Message-ID: <20110809184524.GB4926@sgi.com>
References: <1312901031-29887-1-git-send-email-holt@sgi.com>
	<1312901031-29887-6-git-send-email-holt@sgi.com>
	<4E4179CB.6030101@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4E4179CB.6030101@freescale.com>
Cc: netdev@vger.kernel.org, U Bhaskar-B22300 <B22300@freescale.com>,
	socketcan-core@lists.berlios.de, Robin Holt <holt@sgi.com>,
	PPC list <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 09, 2011 at 01:17:47PM -0500, Scott Wood wrote:
> On 08/09/2011 09:43 AM, Robin Holt wrote:
> > In working with the socketcan developers, we have come to the conclusion
> > the fsl-flexcan device tree bindings need to be cleaned up. 
> > The driver does not depend upon any properties other than the required properties
> > so we are removing the file.
> 
> That is not the criterion for whether something should be expresed in
> the device tree.  It's a description of the hardware, not a Linux driver
> configuration file.  If there are integration parameters that can not be
> inferred from "this is FSL flexcan v1.0", they should be expressed in
> the node.

There are no properties other than the required properties.  The others
were wrongly introduced and are not needed by the driver.  When we
removed the other properties and the wrong documentation of the mscan
oscillator source in the fsl-flexcan.txt file, we were left with an
Example: section and a one-line statement "The only properties supported
are the required properties."  That seemed like the fsl-flexcan.txt
file was then pointless.

> Removing the binding altogether seems extreme as well -- we should have
> bindings for all devices, even if there are no special properties.

Ok.  I can do that too.  Who is the definitive source for that answer?
I assume we are talking about the fsl-flexcan.txt file when we say
binding.  Is that correct?

> > Additionally, the p1010*dts files are not
> > following the standard for node naming in that they have a trailing -v1.0.
> 
> What "standard for node naming"?  There's nothing wrong with putting a

For the answer to that, you will need to ask Wolfgang Grandegger.  I was
working from his feedback.  Looking at the plethora of other node names,
the vast majority do not have any -v#.#, and the ones that do also tend
to have multiple versions. Based upon that, I suspect he is correct,
but I do not know where the documentation is or if it even exists.

> block version number in the compatible string, and it looks like the
> p1010 dts files were following the binding document in this regard.  It
> is common practice when the block version is publicly documented but
> there's no register it can be read from at runtime.

Thanks,
Robin

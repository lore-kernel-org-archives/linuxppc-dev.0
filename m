Return-Path: <B07421@freescale.com>
Received: from VA3EHSOBE002.bigfish.com (va3ehsobe002.messaging.microsoft.com
	[216.32.180.12]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7111BB702E
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 10 Aug 2011 04:18:11 +1000 (EST)
Message-ID: <4E4179CB.6030101@freescale.com>
Date: Tue, 9 Aug 2011 13:17:47 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Robin Holt <holt@sgi.com>
Subject: Re: [PATCH 5/5] [powerpc] Fix up fsl-flexcan device tree binding.
References: <1312901031-29887-1-git-send-email-holt@sgi.com>
	<1312901031-29887-6-git-send-email-holt@sgi.com>
In-Reply-To: <1312901031-29887-6-git-send-email-holt@sgi.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: netdev@vger.kernel.org, U Bhaskar-B22300 <B22300@freescale.com>,
	socketcan-core@lists.berlios.de, PPC list <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/09/2011 09:43 AM, Robin Holt wrote:
> In working with the socketcan developers, we have come to the conclusion
> the fsl-flexcan device tree bindings need to be cleaned up. 
> The driver does not depend upon any properties other than the required properties
> so we are removing the file.

That is not the criterion for whether something should be expresed in
the device tree.  It's a description of the hardware, not a Linux driver
configuration file.  If there are integration parameters that can not be
inferred from "this is FSL flexcan v1.0", they should be expressed in
the node.

Removing the binding altogether seems extreme as well -- we should have
bindings for all devices, even if there are no special properties.

> Additionally, the p1010*dts files are not
> following the standard for node naming in that they have a trailing -v1.0.

What "standard for node naming"?  There's nothing wrong with putting a
block version number in the compatible string, and it looks like the
p1010 dts files were following the binding document in this regard.  It
is common practice when the block version is publicly documented but
there's no register it can be read from at runtime.

-Scott

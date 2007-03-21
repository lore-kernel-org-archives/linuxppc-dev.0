Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-08.arcor-online.net (mail-in-08.arcor-online.net
	[151.189.21.48])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 34E23DDEF1
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 05:57:45 +1100 (EST)
In-Reply-To: <9696D7A991D0824DBA8DFAC74A9C5FA302B97B1A@az33exm25.fsl.freescale.net>
References: <20070316172846.GF29784@ld0162-tx32.am.freescale.net>
	<36990c5c3b7de1ab2f65662547641b79@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302B97B1A@az33exm25.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <4b0f0296e3beb792337a868c3527c954@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 06/17] Document the linux,network-index property.
Date: Wed, 21 Mar 2007 19:57:33 +0100
To: "Yoder Stuart-B08248" <stuart.yoder@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Segher, what is the the 'other alias' mechanism you are referring
> to that should be dropped?  Is it this proposed linux,network-index
> property?  or something else?

Just the

	pic0: pic@700 {
		...
	}

labeling thing -- it becomes redundant when the flat tree
stuff would support OF-style aliases, so it can be phased
out then.

For who doesn't know the aliases thing, it looks like this:

/ {
	aliases {
		pic0 = "/some/path/to/pic@700";
		pic1 = "/some/path/to/pic@800";

		enet  = "/some/path/to/some/ethernet";
		enet0 = "/some/path/to/some/ethernet";
		enet1 = "/some/path/to/some/other/ethernet";
		enet2 = "/some/path/to/yet/another/ethernet";
	
etc.  Note you can have multiple aliases to the same
node, that comes in quite handy sometimes (like "disk"
is the default boot disk, ...)

Path name resolution looks at the aliases whenever
a path name doesn't start with a '/' character.


Segher

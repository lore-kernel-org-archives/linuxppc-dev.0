Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6A3DBDDE2A
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Jun 2007 10:16:33 +1000 (EST)
Subject: Re: [patch 29/30] PS3: Device tree source.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <480f44878c42c1dc6452233f9e21d663@kernel.crashing.org>
References: <20070612181825.730300780@am.sony.com> >
	<466EEC01.6080807@am.sony.com>
	<f7c4ca74d3e2031e01264f31f09e515a@kernel.crashing.org>
	<20070613084023.GA28629@aepfle.de><46702AFE.8080800@am.sony.com>
	<20070613181854.GA723@aepfle.de>
	<1181774801.14818.343.camel@localhost.localdomain>
	<590cd31b74053f7499c1f53a29639175@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302F33549@az33exm25.fsl.freescale.net>
	<480f44878c42c1dc6452233f9e21d663@kernel.crashing.org>
Content-Type: text/plain
Date: Fri, 15 Jun 2007 10:16:11 +1000
Message-Id: <1181866571.14818.416.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Olaf Hering <olaf@aepfle.de>, paulus@samba.org,
	Yoder Stuart-B08248 <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-06-14 at 17:36 +0200, Segher Boessenkool wrote:
> 
> "node name" in flat device trees doesn't allow a proper
> "name" property to exist for the root node.  This is a
> bug in the flat device tree tools, and either should be
> fixed, or this should be clearly documented as a divergence
> from "real" OF.
> 
> "name" of the root node is a bit special, since it is
> never displayed as part of a device path or used for
> device selection (instead, "/" at start of a path is
> handled specially, just like on unix filesystems).

This 'special' behaviour, the fact that it's definition is out of sync
with the generic name recommended practice, and finally, the fact that
quite a lot of real OFs out there don't even bother having one, makes me
think that it's a good idea to stick to what I did, which is to say the
root node has no name in a flat device-tree.

Now, what I -may- do to avoid information loss is tweak prom_init.c to
actually extract that name if it exist and stick a "name" property in
the root node in that case when flattening the tree.

But I still beleive as far as flat DTs for embedded are concerned, we
shouldn't use and rely on having a name at the root of the tree.

> Since anything that matches for "compatible" entries
> also first should check the "name" contents, it should
> be okay for flat device trees to have the information
> that could/should be in "name" in "compatible", instead.
>
> Does this answer all questions / clarify my position
> on all this?

Ben.

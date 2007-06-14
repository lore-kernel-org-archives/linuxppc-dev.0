Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-05.arcor-online.net (mail-in-05.arcor-online.net
	[151.189.21.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B9A4BDDF1F
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Jun 2007 01:36:13 +1000 (EST)
In-Reply-To: <9696D7A991D0824DBA8DFAC74A9C5FA302F33549@az33exm25.fsl.freescale.net>
References: <20070612181825.730300780@am.sony.com>
	><466EEC01.6080807@am.sony.com><f7c4ca74d3e2031e01264f31f09e515a@kernel.crashing.org><20070613084023.GA28629@aepfle.de><46702AFE.8080800@am.sony.com>
	<20070613181854.GA723@aepfle.de><1181774801.14818.343.camel@localhost.localdomain>
	<590cd31b74053f7499c1f53a29639175@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302F33549@az33exm25.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <480f44878c42c1dc6452233f9e21d663@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [patch 29/30] PS3: Device tree source.
Date: Thu, 14 Jun 2007 17:36:05 +0200
To: "Yoder Stuart-B08248" <stuart.yoder@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Olaf Hering <olaf@aepfle.de>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> "compatible" is only needed if your "name" is bogus, or your
>> machine _actually_ is 100% compatible to some other machine.
>
> Segher,
>
> I don't understand this if we are following the 'Generic Names'
> recommendation (which I thought we were).

Yes, we should follow that recommended practice.

> Guideline 1: "name" property values must be generic, reflecting
> the device's function, but not necessarily its precise programming
> model.

Yes -- a short clear name that makes device tree paths
easily readable (and easy to type ;-) ) for human beings.

> Guideline 2: The "compatible" property must be present.

...if "name" doesn't perform the same function yet, which
of course is almost always.

> Its first
> component should be an explicit, unique name that identifies the
> device precisely enough to be able to infer the detailed programming
> model from that name. The format of that explicit name is
> manufacturer,model,...

Yep.  You understand "generic names" just fine.

> I read that and my understand is that _compatible_ is required
> and specifies the precise programming model.  name is supposed
> to be generic-- currently booting-without-of.txt says the
> property is optional because the name can be inferred from
> the node name which should be generic.

"node name" in flat device trees doesn't allow a proper
"name" property to exist for the root node.  This is a
bug in the flat device tree tools, and either should be
fixed, or this should be clearly documented as a divergence
from "real" OF.

"name" of the root node is a bit special, since it is
never displayed as part of a device path or used for
device selection (instead, "/" at start of a path is
handled specially, just like on unix filesystems).

Since anything that matches for "compatible" entries
also first should check the "name" contents, it should
be okay for flat device trees to have the information
that could/should be in "name" in "compatible", instead.

Does this answer all questions / clarify my position
on all this?

Cheers,


Segher

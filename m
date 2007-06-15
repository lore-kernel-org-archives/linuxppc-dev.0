Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net
	[151.189.21.41])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 26F23DDF5C
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Jun 2007 18:37:11 +1000 (EST)
In-Reply-To: <1181866571.14818.416.camel@localhost.localdomain>
References: <20070612181825.730300780@am.sony.com> >
	<466EEC01.6080807@am.sony.com>
	<f7c4ca74d3e2031e01264f31f09e515a@kernel.crashing.org>
	<20070613084023.GA28629@aepfle.de><46702AFE.8080800@am.sony.com>
	<20070613181854.GA723@aepfle.de>
	<1181774801.14818.343.camel@localhost.localdomain>
	<590cd31b74053f7499c1f53a29639175@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302F33549@az33exm25.fsl.freescale.net>
	<480f44878c42c1dc6452233f9e21d663@kernel.crashing.org>
	<1181866571.14818.416.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <437e7506d33016c4fa3cf89ad3ded0ae@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [patch 29/30] PS3: Device tree source.
Date: Fri, 15 Jun 2007 10:37:03 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
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

>> "node name" in flat device trees doesn't allow a proper
>> "name" property to exist for the root node.  This is a
>> bug in the flat device tree tools, and either should be
>> fixed, or this should be clearly documented as a divergence
>> from "real" OF.
>>
>> "name" of the root node is a bit special, since it is
>> never displayed as part of a device path or used for
>> device selection (instead, "/" at start of a path is
>> handled specially, just like on unix filesystems).
>
> This 'special' behaviour, the fact that it's definition is out of sync
> with the generic name recommended practice, and finally, the fact that
> quite a lot of real OFs out there don't even bother having one, makes 
> me
> think that it's a good idea to stick to what I did, which is to say the
> root node has no name in a flat device-tree.

Putting that info in "compatible" instead should work
fine enough.

> Now, what I -may- do to avoid information loss is tweak prom_init.c to
> actually extract that name if it exist and stick a "name" property in
> the root node in that case when flattening the tree.

Nice, thanks!

> But I still beleive as far as flat DTs for embedded are concerned, we
> shouldn't use and rely on having a name at the root of the tree.

There _has_ to be a "name" property.  But you have one,
just not with interesting contents ;-)

>> Since anything that matches for "compatible" entries
>> also first should check the "name" contents, it should
>> be okay for flat device trees to have the information
>> that could/should be in "name" in "compatible", instead.


Segher

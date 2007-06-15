Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-05.arcor-online.net (mail-in-05.arcor-online.net
	[151.189.21.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D0664DDF5C
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Jun 2007 18:32:48 +1000 (EST)
In-Reply-To: <9696D7A991D0824DBA8DFAC74A9C5FA302F335E6@az33exm25.fsl.freescale.net>
References: <20070612181825.730300780@am.sony.com>><466EEC01.6080807@am.sony.com><f7c4ca74d3e2031e01264f31f09e515a@kernel.crashing.org><20070613084023.GA28629@aepfle.de><46702AFE.8080800@am.sony.com><20070613181854.GA723@aepfle.de><1181774801.14818.343.camel@localhost.localdomain><590cd31b74053f7499c1f53a29639175@kernel.crashing.org><9696D7A991D0824DBA8DFAC74A9C5FA302F33549@az33exm25.fsl.freescale.net>
	<480f44878c42c1dc6452233f9e21d663@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302F335E6@az33exm25.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <917111d857ede66a197faba3bf5c2202@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [patch 29/30] PS3: Device tree source.
Date: Fri, 15 Jun 2007 10:32:36 +0200
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

>>> Guideline 2: The "compatible" property must be present.
>>
>> ...if "name" doesn't perform the same function yet, which
>> of course is almost always.
>
> But the recommended practice doesn't have an "...if".  It says
> "compatible" must always be present.

If you read the r.p. more closely, you'll see this applies
to normal devices only.  Either way, the r.p. says very
clearly that the "old way" of doing things is still supported.

> The reason an OS would need to support "name" as well as
> "compatbile" for device driver matching would be
> for _legacy_ device trees that don't follow the recommended
> practice.

No, the OS has to do this since that is what the OF spec
says has to be done.  The generic names recommended practice
goes into this in some detail, too.

> For newly developed trees "compatible" should specify the programming
> model, if we are following that recommended practice.

Yes.

> So bottom line is that we shouldn't be moving toward using "name"
> to specify the programming model.

And no one suggested that.

>> Since anything that matches for "compatible" entries
>> also first should check the "name" contents, it should
>> be okay for flat device trees to have the information
>> that could/should be in "name" in "compatible", instead.
>
> As mentioned above, matching on "name" would seem to be
> needed to handle legacy device trees as I read some of
> the reasoning in the generic names recommended practice.
> Not sure if that applies to Linux or not...

Not all Linux systems use a flat device tree, some use a
"real" Open Firmware.  Not doing the matching the way it
is described but differently is asking for problems, needing
unnecessary workarounds.


Segher

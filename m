Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0CE5EDDE03
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Oct 2008 01:07:21 +1100 (EST)
Message-Id: <DC24FCF5-F410-47AB-8FC0-592EA0906568@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Matt Sealey <matt@genesi-usa.com>
In-Reply-To: <48FF2DDE.9060301@genesi-usa.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: Extended Addressing Mode
Date: Wed, 22 Oct 2008 09:06:51 -0500
References: <48FEEB88.6050505@kontron.com>	<83735324-C37B-4C57-A50F-FFF0D133E4E3@kernel.crashing.org>	<48FF23C4.5030408@kontron.com>
	<88C8EDEB-C9A5-4876-AF7D-55CBABBE111D@kernel.crashing.org>
	<48FF2DDE.9060301@genesi-usa.com>
Cc: linuxppc-dev@ozlabs.org,
	=?ISO-8859-1?Q?R=E9gis_Odey=E9?= <regis.odeye@kontron.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 22, 2008, at 8:42 AM, Matt Sealey wrote:

>
>
> Kumar Gala wrote:
>> On Oct 22, 2008, at 7:59 AM, R=E9gis Odey=E9 wrote:
>>> of ram. So I need 4GB+IOs (~1GB) of physical addressing space.
>>> My plan is to put a part of this ram above of 4GB to keep accesses =20=

>>> to the IOs below the 4GB limit. It means non-contiguous ram =20
>>> addressing and XAEN features to be working.
>> So we have XAEN support in the tree.. however non-contiguous is =20
>> something you'll have to work on yourself.  Patches are welcome for =20=

>> this
>
> So to confirm, XAEN support through Becky's patches does support the =20=

> MPC8641D/e600 cores?

Yes, its the only part that has XAEN.

>>> Where can I glance through Becky patches ?
>> This is the bulk:
>> =
http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dcom=
mitdiff;h=3D4ee7084eb11e00eb02dc8435fd18273a61ffa9bf
>
> I'd also be interested in any work done to enable non-contiguous =20
> memory areas. Reading the docs for the MPC8641D though I am not sure =20=

> you can set up LAWs for it?

You can if you can configure your DDR to support it.

> One thing I wanted to try was installing 4GB in a system and =20
> "overlapping" IO (since there is very little of it on a stock =20
> MPC8641DHPCN) in the top ~256MB-512MB, but I am fairly sure this is =20=

> NOT supported because of the way the LAWs work, and also the =20
> alignment of the LAWs means it is not fine enough granularity to map =20=

> between 2GB and 4GB into a window (you can have 2GB or 4GB but not =20
> some more arbitrary value?)

You can overlap LAWs because they have priority encoding.  The lower =20
the LAW # the higher the priority.

Your bigger issue is if you can setup the DDR controller for the hole =20=

you want.

- k=

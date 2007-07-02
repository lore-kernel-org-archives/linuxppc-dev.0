Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id ECAD3DDF1F
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Jul 2007 09:05:47 +1000 (EST)
Date: Mon, 2 Jul 2007 17:46:44 -0500
From: Scott Wood <scottwood@freescale.com>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH] powerpc: Add of_register_i2c_devices()
Message-ID: <20070702224643.GA21539@ld0162-tx32.am.freescale.net>
References: <Pine.LNX.4.60.0706292113240.4227@poirot.grange>
	<00a85f152aa3547f0f0b4acd7954468a@kernel.crashing.org>
	<Pine.LNX.4.60.0707022114020.3339@poirot.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.60.0707022114020.3339@poirot.grange>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jul 02, 2007 at 10:11:04PM +0200, Guennadi Liakhovetski wrote:
> AFAIK, i2c is not specified by OF standard. So, we are free to chose any 
> "compatible" fields for our dts. Which we then would need to match against 
> drivers. So, why not make this a 1-to-1 match? I.e.,
> [OF]			[I2C]
> compatible	<->	driver_name
> model		<->	type

If we do this, then the compatible field should probably be preceded with
"linux,", which would get stripped by of_register_i2c_devices().  This
would only be an interim measure until we can figure out some sort of
name registry via power.org.  Once that happens, non-"linux," compatible
fields could be looked up in an OF-to-linux table, or there could be a
way for i2c devices to specify OF matches in addition to driver name.

-Scott

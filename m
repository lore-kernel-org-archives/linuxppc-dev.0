Return-Path: <jochen@scram.de>
Received: from mail.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id EF590DE177
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 22:28:09 +1000 (EST)
Message-ID: <480893C8.6020300@scram.de>
Date: Fri, 18 Apr 2008 14:27:52 +0200
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: build breakage from of i2c helper patch
References: <CDDD8C0A-4B40-4CA7-BB84-50B2A93C7804@kernel.crashing.org>	<48071778.2000405@scram.de>
	<20080417113703.0f24c578@hyperion.delvare>
In-Reply-To: <20080417113703.0f24c578@hyperion.delvare>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>, Paul Mackerras <paulus@samba.org>,
	Linux I2C <i2c@lm-sensors.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Jean,

> (blind shot) Maybe this means that some code that is in i2c-core should
> be moved to i2c-boardinfo instead? i2c-boardinfo is always built into
> the kernel even when i2c-core is modular.

unfortunately, i2c_new_device() tries to attach the module, so this function
really needs full i2c-core functionality.

I think the best way to fix this is to make the OF helpers def_tristate I2C, so
it will be compiled as module if i2c-core is compiled as module, as well.

I'll send an updated patch in a minute.

Thanks,
Jochen

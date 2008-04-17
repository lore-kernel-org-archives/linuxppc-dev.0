Return-Path: <jochen@scram.de>
Received: from mail.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 2710FDE128
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Apr 2008 19:25:29 +1000 (EST)
Message-ID: <48071778.2000405@scram.de>
Date: Thu, 17 Apr 2008 11:25:12 +0200
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: build breakage from of i2c helper patch
References: <CDDD8C0A-4B40-4CA7-BB84-50B2A93C7804@kernel.crashing.org>
In-Reply-To: <CDDD8C0A-4B40-4CA7-BB84-50B2A93C7804@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Paul Mackerras <paulus@samba.org>,
	Linux I2C <i2c@lm-sensors.org>,
	"linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Kumar,

> I'm guessing the "[POWERPC] i2c: OF helpers for the i2c API"
> 
> http://git.kernel.org/?p=linux/kernel/git/paulus/powerpc.git;a=commitdiff;h=612212a3f2f053ea68ce9cd16d3deeca7754e8c9
> 
> is causing this build failure:
> 
> http://kisskb.ellerman.id.au/kisskb/buildresult/24375/

It looks like it. i2c-core needs to be compiled static for the OF bindings to work.
I guess in Kconfig "depends on OF && I2C" must be changed into "depends on OF && (I2C=y)"

On the other hand, i didn't test the patch without the dependent patches, so it might not work as expected:

http://patchwork.ozlabs.org/linuxppc/patch?id=17833
http://patchwork.ozlabs.org/linuxppc/patch?id=17834

or the original ones from Jean Delvare:

http://patchwork.ozlabs.org/linuxppc/patch?id=16282
http://patchwork.ozlabs.org/linuxppc/patch?id=16283
http://patchwork.ozlabs.org/linuxppc/patch?id=16284

Thanks,
Jochen

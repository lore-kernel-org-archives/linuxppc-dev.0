Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C77C367DA1
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 28 Oct 2006 08:39:30 +1000 (EST)
Subject: Re: status of mpc52xx with arch=powerpc?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sylvain Munaut <tnt@246tNt.com>
In-Reply-To: <45411F14.6020308@246tNt.com>
References: <20061018130628.GE6202@localhost.localdomain>
	<528646bc0610180652u2ee8e8b4xe25d555a59a27c85@mail.gmail.com>
	<1161740815.22582.1.camel@localhost.localdomain>
	<528646bc0610242325m45fa610egb47f118f5f4f6f5e@mail.gmail.com>
	<4b73d43f0610261307sd0668d1x6e535880a46e71d3@mail.gmail.com>
	<528646bc0610261336i61521af3y3a5f134bb8c2f8da@mail.gmail.com>
	<45411F14.6020308@246tNt.com>
Content-Type: text/plain
Date: Sat, 28 Oct 2006 08:39:25 +1000
Message-Id: <1161988765.25682.99.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


> We would use the API we worked earlier on (Dale, Andrey, John, ...).
> To add support of fw preloaded task :
>  - The bestcomm.ko module would be used when bestcomm is completely
> controlled by the kernel
> - A different module but with the same exported function would be used
> when the fw has a part to play in the init. That allows to customize a bunch
> of the sdma init / sram mapping ...
> - All the other code (task helpers / the .h / the driver api) would be
> exactly
> the same.

No. Two different modules is the wrong approach. I want to be able to
build everything in the kernel (no modules) and still boot machines with
both types.

There should be a single implementation. I know bestcomm is fucked by
design but still.

> So the bestcomm modules maintain a list with all task loaded with a name and
> a index attribute. (The index would be used when there is multiple
> device with
> the same name, like "psc". We could use names like "psc1", "psc2". But that
> would imply string manipulation to "create" the name string ;)
> 
> In the case of the "classic" (kernel handles it all), the table of task
> is just
> initially empty. But for the "custom" case, it's filled with whatever
> the fw has
> passed as infos.

A single module should handle all cases though. If, for some reasons, it
looks like that will cause a lot of additional code, them it can be
internally split and we can have config options to enable only one way,
but it should be possible to enable both.

Ben.

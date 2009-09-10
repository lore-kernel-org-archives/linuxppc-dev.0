Return-Path: <sebastian@breakpoint.cc>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 1C14DB707B
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Sep 2009 08:24:06 +1000 (EST)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc
	[85.10.199.196])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 86FBDDDD0B
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Sep 2009 08:24:05 +1000 (EST)
Date: Fri, 11 Sep 2009 00:24:00 +0200
From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: MPC85xx External/Internal Interrupts
Message-ID: <20090910222400.GB26587@Chamillionaire.breakpoint.cc>
References: <d970ff420909040604h1bb3874eg5c79f79f85e713a3@mail.gmail.com>
	<d970ff420909041228h3638e840r34c0c0e79f178e55@mail.gmail.com>
	<d970ff420909041229hb3aa96dya329e06ea56dd1ac@mail.gmail.com>
	<20090906110641.GA11350@Chamillionaire.breakpoint.cc>
	<20090909182857.GB8215@b07421-ec1.am.freescale.net>
	<20090910131544.GB23433@Chamillionaire.breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <20090910131544.GB23433@Chamillionaire.breakpoint.cc>
Cc: linuxppc-dev@ozlabs.org, Alemao <xcarandiru@gmail.com>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Sebastian Andrzej Siewior | 2009-09-10 15:15:44 [+0200]:

>* Scott Wood | 2009-09-09 13:28:57 [-0500]:
>
>>> That's why you always have an offset of 16 between every internal
>>> interupt source number in the MPC855ERM document and those weired
>>> numbers in the device tree :)
>>
>>something in the dts bindings that explains it.  Am I correct in assuming
>>that this particular internal/external split is Freescale-specific and
>>not a general OpenPIC thing?
>Yes it looks like this. 
>manual for both of them to check. I also don't have an OpenPIC spec to
>check there.
I had to say this. Now I got one. According to the OpenPIC there is no
such thing as an internal and external interrupt sources. Base + 0x10000
is the first interrupt source register and the number of interrupt
sources is specified in the feature register. 

So the split is a FSL thing.
What do you thing about making this clear? Adding into every .dts a
comment right on top or maybe in
Documentation/powerpc/dts-bindings/fsl/?

>>
>>-Scott

Sebastian

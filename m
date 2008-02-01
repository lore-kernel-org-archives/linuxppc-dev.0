Return-Path: <cbouatmailru@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.174])
	by ozlabs.org (Postfix) with ESMTP id AEEBFDDF2E
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Feb 2008 10:49:08 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id q7so810317uge.0
	for <linuxppc-dev@ozlabs.org>; Fri, 01 Feb 2008 15:49:06 -0800 (PST)
Date: Sat, 2 Feb 2008 02:30:43 +0300
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] [POWERPC] fsl_soc: add support for "fsl, immr"
	compatible matching
Message-ID: <20080201233043.GA20533@zarina>
References: <20080201150117.GA26545@localhost.localdomain>
	<47A38C49.7020606@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <47A38C49.7020606@freescale.com>
Cc: linuxppc-dev@ozlabs.org
Reply-To: cbouatmailru@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Feb 01, 2008 at 03:16:57PM -0600, Scott Wood wrote:
> Anton Vorontsov wrote:
> > -	soc8540@e0000000 {
> > +	soc@e0000000 {
> >  		#address-cells = <1>;
> >  		#size-cells = <1>;
> >  		#interrupt-cells = <2>;
> > -		device_type = "soc";
> > +		compatible = "fsl,mpc8540-immr", "fsl,immr", "simple-bus";
> >  		ranges = <00000000 e0000000 00100000>
> >  		reg = <e0000000 00003000>;
> >  		bus-frequency = <0>;
> 
> It's called "CCSR" rather than "IMMR" on 85xx.

^^ Theory.

$ grep ccsr -r arch/powerpc/boot/dts/
$

$ grep immr -r arch/powerpc/boot/dts/ | grep 85 | cut -d: -f1
arch/powerpc/boot/dts/tqm8540.dts
arch/powerpc/boot/dts/tqm8541.dts
arch/powerpc/boot/dts/mpc8572ds.dts
arch/powerpc/boot/dts/tqm8555.dts
arch/powerpc/boot/dts/stx_gp3_8560.dts
arch/powerpc/boot/dts/mpc885ads.dts
arch/powerpc/boot/dts/tqm8560.dts

^^ Practice. :-)


Maybe "fsl,soc", finally? :-) I think soc, ccsr or immr doesn't
really matter, what really matters is consistency. <cpu-specific>
part of the -ccsr/-immr should be sufficient to distinct whether
we're on 85xx or 83xx...

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2

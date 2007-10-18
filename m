Return-Path: <cbou@mail.ru>
Received: from mx28.mail.ru (mx28.mail.ru [194.67.23.67])
	by ozlabs.org (Postfix) with ESMTP id EC0CCDDEC5
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 10:17:12 +1000 (EST)
Received: from mx39.mail.ru (mx39.mail.ru [194.67.23.35])
	by mx28.mail.ru (mPOP.Fallback_MX) with ESMTP id 626E26CF823
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 02:29:47 +0400 (MSD)
Date: Fri, 19 Oct 2007 02:29:27 +0400
From: Anton Vorontsov <cbou@mail.ru>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v3 2/2] [POWERPC] MPC8568E-MDS: add support for flash
Message-ID: <20071018222927.GA1475@zarina>
References: <2eed9d85d53305b2b0d6e8f8287148f7a600ad19.1192730268.git.avorontsov@ru.mvista.com>
	<20071018180104.GB16748@localhost.localdomain>
	<C2A61B74-FDB4-4571-A2F4-F0B7317FD7C7@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <C2A61B74-FDB4-4571-A2F4-F0B7317FD7C7@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
Reply-To: cbou@mail.ru
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Oct 18, 2007 at 02:58:25PM -0500, Kumar Gala wrote:
[...]
> > +
> > +		flash@0,0 {
> > +			#address-cells = <1>;
> > +			#size-cells = <1>;
> > +			compatible = "Spansion,S29GL256N11TFIV2O", "cfi-flash";
> > +			reg = <0 0 2000000>;
> > +			bank-width = <2>;
> > +			device-width = <1>;
> > +
> 
> Are you basing the partition map on something or making it up?   
> Clearly hrcw & u-boot are at fixed offsets, wondering about kernel &  
> rootfs?

I'm making it up. From the brief look at the u-boot* git sources,
there is no `flashboot` yet, thus I'm free to make this up...

I've partitioned this flash based on these thoughts:

1. HRCW - whole sector, to not wear out it, plus it's impossible to
   create just 64 bytes partition;
2. Kernel - 2MB, should be enough for bootup kernels?
3. Rootfs - the rest up to...
4. U-Boot at the end.

I'm not saying that it's best map ever, I'm open to suggestions. ;-)

* Unfortunately I didn't look at the stock Freescale u-boot, maybe
  there was flashboot, most probably.. I'll find the CD to look this
  up.

Much thanks for noticing this,

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2

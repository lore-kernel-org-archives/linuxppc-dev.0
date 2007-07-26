Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 37EB4DDF13
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2007 01:48:10 +1000 (EST)
Date: Thu, 26 Jul 2007 19:47:47 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: [RFC][PATCH] MPC832x_RDB: update dts to use spi, register
	mmc_spi stub
Message-ID: <20070726154747.GA6930@localhost.localdomain>
References: <20070726135738.GB5643@localhost.localdomain>
	<02aa01c7cf9a$aebf3bf0$02ac10ac@Jocke>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <02aa01c7cf9a$aebf3bf0$02ac10ac@Jocke>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jul 26, 2007 at 05:36:06PM +0200, Joakim Tjernlund wrote:
[...]
> >  		spi@4c0 {
> >  			device_type = "spi";
> > +			device-id = <1>;
> >  			compatible = "fsl_spi";
> >  			reg = <4c0 40>;
> >  			interrupts = <2>;
> >  			interrupt-parent = <&qeic>;
> > -			mode = "cpu";
> > +			mode = "qe";
> 
> The driver is still using "cpu" mode. It just happens that the cpu mode for QE
> enabled CPUs isn't 100% compatible with the defacto cpu mode used by other CPU:s.

Yup, indeed.

> So mode should probably be "cpu_qe" or, even better, if the drver could

That's easy to change, thanks.

> autodetect that it is running on a QE enabled CPU and adjust accordinly.
> Maybe the Freescale guys have some ideas how to do that.

Ok. Well, for now could we use machine_is() for kind of autodetect?
Or it's better leave it as is, and just rename mode to cpu_qe?

>  Jocke
> 
> PS.
>    Will be on vacation for a week as of tmw, won't have access
>    during this time.

Thanks,

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2

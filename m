Return-Path: <SRS0=ZzN4=OP=denx.de=sr@srs.kundenserver.de>
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: Sequoia kernel crash workaround.
Date: Wed, 19 Sep 2007 21:19:47 +0200
References: <46F16CC9.3010003@ru.mvista.com>
In-Reply-To: <46F16CC9.3010003@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709192119.48259.sr@denx.de>
Cc: Josh Boyer <jwboyer@gmail.com>, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Valentine,

On Wednesday 19 September 2007, Valentine Barshak wrote:
> Disabling write pipelining really helps.
> Josh, David, what is the right place to put this workaround to?
>
> Is it OK to do mtdcr(PLB4A0_ACR, mfdcr(PLB4A0_ACR) & ~PLB4_WRP); in
> arch/powerpc/boot/cuboot-sequoia.c:sequoia_fixups()?
> or
> should this be done in
> arch/powerpc/platforms/44x/sequoia.c:sequoia_setup_arch()
> with dcr_map, dcr_read/write stuff?

I vote for putting it into sequoia.c, since it's very likely to happen that 
Sequoia will at one point be booted without the bootwrapper. Or perhaps it 
should go into some common code checking the PVR and disabling it when this 
440EPx/GRx is detected, since all those boards are affected.

Best regards,
Stefan

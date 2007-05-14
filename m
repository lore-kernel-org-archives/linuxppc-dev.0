Return-Path: <tnt@246tNt.com>
Received: from outmx004.isp.belgacom.be (outmx004.isp.belgacom.be
	[195.238.4.101])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BDC5BDDE1E
	for <linuxppc-dev@ozlabs.org>; Mon, 14 May 2007 15:30:50 +1000 (EST)
Received: from outmx004.isp.belgacom.be (localhost [127.0.0.1])
	by outmx004.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id l4E5UdiW017423
	for <linuxppc-dev@ozlabs.org>; Mon, 14 May 2007 07:30:40 +0200
	(envelope-from <tnt@246tNt.com>)
Message-ID: <4647F359.1060403@246tNt.com>
Date: Mon, 14 May 2007 07:27:53 +0200
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: [PATCH 3/9] powerpc/ppc32: Update mpc52xx_psc structure with
	B	revision changes
References: <11790019171838-git-send-email-tnt@246tNt.com>	<11790019223299-git-send-email-tnt@246tNt.com>	<11790019223880-git-send-email-tnt@246tNt.com>
	<11790019223925-git-send-email-tnt@246tNt.com>
	<4647A35B.40407@genesi-usa.com>
In-Reply-To: <4647A35B.40407@genesi-usa.com>
Content-Type: text/plain; charset=UTF-8
Cc: Linux PPC dev ML <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Matt Sealey wrote:
> Would a note next to these new fields be worth it? "5200B only" or
> "reserved on 5200" or even create a new PSC structure for the old
> processor and recast it in drivers that really want to support both
> revisions of the CPU?
>   
A comment next to them yes, that looks a good idea.
A new structure certainly not.
> Real nitpick:
>
> Setting the CCR on the MPC5200 (not B) now means you need to left
> shift your required CCR values by 16 bits before applying them into
> the field for the desired effect.
>
> If you were being lazy and just wanted to set some low-order bits
> in the CCR on the 5200, with the old structure that's fine. With
> the new structure, it will be writing into previously reserved
> space on the 5200. The 5200B might work fine, unless it's a driver
> someone missed, and is programming a value that should be in the
> upper 16 bits of the new CCR, in which case now you have to left
> shift by 16 bits.. :)
I know about the ccr that's annoying.
I guess I could make ccr a union and have it contains ccr16 and ccr32.

Note that old driver will still work ... then most likely do
out_be16(&psc->ccr, ...) and the &psc->ccr address didn't change. They
will just have a warning because ccr is a u32 so &psc->ccr is a u32* and
they give it to out_be16 ...


    Sylvain

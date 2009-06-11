Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id B73C4B71E6
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Jun 2009 13:32:46 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E2AAFDDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jun 2009 13:32:45 +1000 (EST)
Message-Id: <E3FB2692-D60E-4C06-BEDD-45441E67458E@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Peter Korsgaard <jacmet@sunsite.dk>
In-Reply-To: <1244547812-3811-1-git-send-email-jacmet@sunsite.dk>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: [PATCH] mpc83xx/usb.c: fix usb mux setup for mpc834x
Date: Wed, 10 Jun 2009 22:32:39 -0500
References: <1244547812-3811-1-git-send-email-jacmet@sunsite.dk>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jun 9, 2009, at 6:43 AM, Peter Korsgaard wrote:

> usb0 and usb1 mux settings in the sicrl register were swapped (twice!)
> in mpc834x_usb_cfg(), leading to various strange issues with fsl-ehci
> and full speed devices.
>
> The USB port config on mpc834x is done using 2 muxes: Port 0 is always
> used for MPH port 0, and port 1 can either be used for MPH port 1 or  
> DR
> (unless DR uses TMDI phy or OTG, then it uses both ports) - See 8349  
> RM
> figure 1-4..
>
> mpc8349_usb_cfg() had this inverted for the DR, and it also had the  
> bit
> positions of the usb0 / usb1 mux settings swapped. It would basically
> work if you specified port1 instead of port0 for the MPH controller  
> (and
> happened to use ULPI phys), which is what all the 834x dts have done,
> even though that configuration is physically invalid.
>
> Instead fix mpc8349_usb_cfg() and adjust the dts files to match  
> reality.
>
> Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
> ---
> arch/powerpc/boot/dts/asp834x-redboot.dts |    2 +-
> arch/powerpc/boot/dts/mpc8349emitx.dts    |    2 +-
> arch/powerpc/boot/dts/mpc834x_mds.dts     |    2 +-
> arch/powerpc/boot/dts/sbc8349.dts         |    2 +-
> arch/powerpc/platforms/83xx/mpc83xx.h     |    4 ++--
> arch/powerpc/platforms/83xx/usb.c         |   10 +++++-----
> 6 files changed, 11 insertions(+), 11 deletions(-)

applied.. Please remind me to send this linux-stable for .30 and .29

- k

Return-Path: <jwboyer@gmail.com>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.228])
	by ozlabs.org (Postfix) with ESMTP id 3853DDDE16
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 12:40:24 +1100 (EST)
Received: by wx-out-0506.google.com with SMTP id h27so1969842wxd
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Oct 2007 18:40:23 -0700 (PDT)
Date: Tue, 30 Oct 2007 20:40:15 -0500
From: Josh Boyer <jwboyer@gmail.com>
To: "Steven A. Falco" <sfalco@harris.com>
Subject: Re: PPC405GP Walnut irq patch
Message-ID: <20071030204015.06a699d7@vader.jdub.homelinux.org>
In-Reply-To: <4727A507.10309@harris.com>
References: <47279CF0.4050600@harris.com>
	<4727A507.10309@harris.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 30 Oct 2007 17:41:27 -0400
"Steven A. Falco" <sfalco@harris.com> wrote:

> From: "Steven A. Falco" <sfalco@harris.com>
> To: linuxppc-dev@ozlabs.org
> Subject: Re: PPC405GP Walnut irq patch
> Date: Tue, 30 Oct 2007 17:41:27 -0400
> Sender: linuxppc-dev-bounces+jwboyer=gmail.com@ozlabs.org
> User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
> 
> I realized that I should have done this from the root level.  So here is 
> the corrected patch.
> 
> Signed-off-by: Steve Falco <sfalco at harris.com>
> 
> 
> Steven A. Falco wrote:
> > Hi - I have found a bug in the ARCH=powerpc Walnut BSP.  The order of 
> > the ethernet interrupts in the walnut.dts file doesn't match the 
> > documentation.  I discovered this when porting the BSP to a custom 
> > board - the ethernet would not work.  The attached patch corrects that.
> >
> > This is the first patch I am submitting, so please advise me if there 
> > is anything I should do differently.
> >
> > Signed-off-by: Steve Falco <sfalco at harris.com>
> >
> >  
> 
> diff --git a/arch/powerpc/boot/dts/walnut.dts b/arch/powerpc/boot/dts/walnut.dts
> index 27bef06..dd65115 100644
> --- a/arch/powerpc/boot/dts/walnut.dts
> +++ b/arch/powerpc/boot/dts/walnut.dts
> @@ -67,7 +67,7 @@
>  			num-tx-chans = <2>;
>  			num-rx-chans = <1>;
>  			interrupt-parent = <&UIC0>;
> -			interrupts = <a 4 b 4 c 4 d 4 e 4>;
> +			interrupts = <b 4 c 4 a 4 d 4 e 4>;
>  		};

I fixed this part already.  Seems your tree is slightly old.

>  
>  		POB0: opb {
> @@ -117,7 +117,7 @@
>  				device_type = "network";
>  				compatible = "ibm,emac-405gp", "ibm,emac";
>  				interrupt-parent = <&UIC0>;
> -				interrupts = <9 4 f 4>;
> +				interrupts = <f 4 9 4>;

Could you redo the patch with just this bit and send it again?

josh

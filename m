Return-Path: <mathieu.deschamps@com2gether.net>
Received: from mail.libertysurf.net (mx-out.libertysurf.net [213.36.80.91])
	by ozlabs.org (Postfix) with ESMTP id 64A1767BA1
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Jul 2006 18:17:39 +1000 (EST)
From: Mathieu Deschamps <mathieu.deschamps@com2gether.net>
To: Laurent Pinchart <laurent.pinchart@tbox.biz>
Subject: Re: MPC8260 SCC UART hardware flow control
Date: Thu, 20 Jul 2006 10:18:35 +0200
References: <200607191718.00328.laurent.pinchart@tbox.biz>
In-Reply-To: <200607191718.00328.laurent.pinchart@tbox.biz>
MIME-Version: 1.0
Message-Id: <200607201018.13445.mathieu.deschamps@com2gether.net>
Content-Type: text/plain;
  charset="iso-8859-1"
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

Hi Laurent,

On Wednesday 19 July 2006 17:18, Laurent Pinchart wrote:
> Hi everybody,
>
> I was wondering if anyone had implemented hardware flow control support in
> the cpm_uart driver. If not, I would appreciate pointers regarding how to
> do so.
>
> Best regards,
>
> Laurent Pinchart
>

I had. PQ2 CPM is a dedicated part which handles this aspect for you via
its microcode. This also means you can't play with it the old way and making 
your own HHS with a CD/DSR :). Back to seriousness, rather this means you 
needn't adding modem signal handling in cpm_uart driver. So don't define 
modem_something that's an ancient reliq from the times, I guess, no CPM was 
put auxillary.

So how to tell CPM to cope with HHS ? Simple, you "just" have to put SCC's 
Dedicated pins the right way which depends on your board type. Remember you 
can't do any HHS with SMC. Refer to Dedicated Pins chapter in the litterature 
[41.4.2]. Also take a look at SCC GSMR register [20.8] and to SCC UART mode 
PSMR register [21-14] to maybe use protocol specificities. 

When you'll have your kernel ready, you would do probably something like :
	stty -F $port crtscts $SPEED

As Wolfgang said HHS works for DTE-DCE only (roughly but visually you must 
have plugs opposite gender on both ends), trying DTE-DTE HHS dialog is bound 
to failure despite time spend on it.

Cdy,
 
Mathieu Deschamps
Com2gether Design Center
Electronic and Embedded Engineering Services
www.com2gether.net 

Return-Path: <glikely@secretlab.ca>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.228])
	by ozlabs.org (Postfix) with ESMTP id 2AA22DE159
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jun 2008 02:45:18 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id 67so345342wri.3
	for <linuxppc-dev@ozlabs.org>; Thu, 05 Jun 2008 09:45:17 -0700 (PDT)
Message-ID: <fa686aa40806050945h5e61910flb63a8d00e1d2b0e8@mail.gmail.com>
Date: Thu, 5 Jun 2008 10:45:17 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Anton Vorontsov" <avorontsov@ru.mvista.com>
Subject: Re: [PATCH] [RFC v3] OF: OpenFirmware bindings for the mmc_spi driver
In-Reply-To: <20080605161624.GA517@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080605161624.GA517@polina.dev.rtsoft.ru>
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Gary Jennejohn <garyj@denx.de>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
	Pierre Ossman <drzeus-mmc@drzeus.cx>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jun 5, 2008 at 10:16 AM, Anton Vorontsov
<avorontsov@ru.mvista.com> wrote:
> Here is v3. I'm out of ideas if you won't like it. :-)
>
> v3:
> - Now these bindings are using bus notifiers chain, thus we adhere to the
>  spi bus.
>
>  By the way, this scheme (IMO) looks good for I2C devices which needs
>  platform_data extracted from the device tree too (Cc'ing Jochen).
>
> - Plus changed the OF bindings themselves, implemented voltage-range
>  property. (Pierre, please take a look at vddrange_to_ocrmask(). I
>  wonder if you would like this in the MMC core instead, with a kernel
>  doc, of course.)
>
> v2:
> - Bindings were adhered to the MMC_SPI driver. Withdrawn by Pierre Ossman.

Personally I think your v2 was better, and if I'm interpreting
Pierre's comments correctly I think his main point is that instead of
using the 'stock' probe/remove hooks for the spi mmc driver, the
driver should be mildly reworked to provide a common block of code
that can be used by both the OF and non-OF versions of the
probe/remove routines.  I also think that is the way to go.

Cheers,
g.


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

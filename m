Return-Path: <glikely@secretlab.ca>
Received: from hs-out-0708.google.com (hs-out-0708.google.com [64.233.178.248])
	by ozlabs.org (Postfix) with ESMTP id 44D5EDE5A4
	for <linuxppc-dev@ozlabs.org>; Thu, 22 May 2008 02:51:40 +1000 (EST)
Received: by hs-out-0708.google.com with SMTP id z77so2903805hsz.9
	for <linuxppc-dev@ozlabs.org>; Wed, 21 May 2008 09:51:38 -0700 (PDT)
Message-ID: <fa686aa40805210951l5b9af13cw46acba87926857c1@mail.gmail.com>
Date: Wed, 21 May 2008 10:51:37 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: avorontsov@ru.mvista.com
Subject: Re: [RFC/DRAFT] SPI OF bindings, MMC-over-SPI, chip-selects and so on
In-Reply-To: <20080521154103.GA32577@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080521154103.GA32577@polina.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, Gary Jennejohn <garyj@denx.de>,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 21, 2008 at 9:41 AM, Anton Vorontsov
<avorontsov@ru.mvista.com> wrote:
> Hi all,
>
> This is just a bait for further discussion of OF/SPI, chip-selects,
> e.t.c.
>
> I've converted the spi_mpc83xx to the OF driver (using Grant's
> SPI_MASTER_OF work + some additions), and implemented MMC-over-SPI
> bindings. This stuff extensively using GPIOs, and I think this will
> work for the "bridged SPI" too, since the SPI bridge could be
> represented as GPIO controller (inside the SPI controller node).

The GPIOs case doesn't bother me too much.  If the controller supports
GPIO chip selects (and pretty much all of them could I think) then the
SPI master driver just needs to specify that it supports N chip
selects and have a gpios property that lists all the relevant GPIOs
(just like you've done).  So I think this bit is looking good.

More complex cases would still probably need some form of spi-bridge
node (and most likely requiring changes to the SPI infrastructure to
make bridging easy; but that is just driver details).

The board info handling I think requires more thought... (details in
another email)

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

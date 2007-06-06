Return-Path: <glikely@secretlab.ca>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.236])
	by ozlabs.org (Postfix) with ESMTP id EE208DDED6
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  7 Jun 2007 05:00:40 +1000 (EST)
Received: by nz-out-0506.google.com with SMTP id v1so250300nzb
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 06 Jun 2007 12:00:39 -0700 (PDT)
Message-ID: <fa686aa40706061200u1141fcc9k73b7cc80c07240d1@mail.gmail.com>
Date: Wed, 6 Jun 2007 13:00:38 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
Subject: Re: [PATCH] Simple driver for Xilinx SPI controler.
In-Reply-To: <20070606180618.C4D861268059@mail88-blu.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <4666F598.2000004@ru.mvista.com>
	<20070606180618.C4D861268059@mail88-blu.bigfish.com>
Cc: spi-devel-general@lists.sourceforge.net,
	Andrei Konovalov <akonovalov@ru.mvista.com>,
	Wolfgang Reissnegger <wre@xilinx.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 6/6/07, Stephen Neuendorffer <stephen.neuendorffer@xilinx.com> wrote:
>
> Yes, except that microblazes systems run in non-virtex FPGAs...
>
> It may be that XILINX_EDK is not the right thing either, but it
> seemed like the easiest way to have a superset of powerpc and microblaze
> systems
>
> What I'm trying to do is (in concert with Grant's recent configuration
> changes)
> having an easy way for a new board configuration to select the Kconfig
> options for
> all of the Xilinx drivers.  Namely:
>
> config XILINX_ML300
>         bool "Xilinx-ML300"
>         select XILINX_VIRTEX_II_PRO
>         select EMBEDDEDBOOT
>         help
>           This option enables support for the Xilinx ML300 evaluation
> board.
>
> config XILINX_VIRTEX_II_PRO
>         bool
>         select XILINX_VIRTEX
>
> config XILINX_EDK
>         bool
>         depends on XILINX_VIRTEX || XILINX_MICROBLAZE
>         default y

I don't have any problem with adding XILINX_EDK (or whatever), but
think particular layout is back-assward.  Rather than XILINX_EDK
depending on XILINX_VIRTEX/MICROBLAZE, XILINX_VIRTEX/MICROBLAZE should
'select' XILINX_EDK and you need to drop the 'default y' line.
Otherwise the XILINX_EDK option shows up in non-edk config files.

>
> config XILINX_GPIO
>         tristate "Xilinx OPB GPIO Support"
>         depends on XILINX_EDK
>         help
>         This option enables support for Xilinx GPIO.
>
>
> It seems like I'm using XILINX_EDK to mean something different than you
> are.
> Perhaps it sould be instead:
>
> config XILINX_DRIVERS
>         bool
>         depends on XILINX_VIRTEX || XILINX_MICROBLAZE
>         default y

Hmmm, yes.  XILINX_DRIVERS is probably better.

>
> config XILINX_GPIO_EDK
>         tristate "Xilinx EDK-based OPB GPIO Support"
>         depends on XILINX_DRIVERS
>         select XILINX_EDK
>         help
>         This option enables support for Xilinx GPIO using EDK OS
> independent driver.

Why still have XILINX_EDK?  I thought you meant replace XILINX_EDK
with XILINX_DRIVERS.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195

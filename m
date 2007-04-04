Return-Path: <vitalywool@gmail.com>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.229])
	by ozlabs.org (Postfix) with ESMTP id A9B44DDDF9
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Apr 2007 21:51:06 +1000 (EST)
Received: by nz-out-0506.google.com with SMTP id l1so95731nzf
	for <linuxppc-dev@ozlabs.org>; Wed, 04 Apr 2007 04:51:03 -0700 (PDT)
Message-ID: <acd2a5930704040451u55ae7619wfa1aaa84aebdf72@mail.gmail.com>
Date: Wed, 4 Apr 2007 04:51:03 -0700
From: "Vitaly Wool" <vitalywool@gmail.com>
To: "Sascha Hauer" <s.hauer@pengutronix.de>
Subject: Re: SPI devices and OF
In-Reply-To: <20070404110916.GA9910@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <20070404110916.GA9910@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 4/4/07, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> Hi,
>
> I'm currently writing a driver for the mpc5200 spi controller (the
> dedicated one, not the PSC ones).
> The driver has the form of a of_platform_driver. My problem is that I
> don't know how to define the spi devices on the spi bus. My current
> approach is having something like this in the OF tree:
>
>
>         spi@f00 {
>                 device_type = "spi";
>                 compatible = "mpc5200b-spi\0mpc5200-spi";
>                 reg = <f00 20>;
>                 interrupts = <2 d 0 2 e 0>;
>                 interrupt-parent = <500>;
>                 mmc@0 {
>                         device_type = "mmc_spi";
>                         compatible = "mmc_spi";
>                 };
>         };
>
> I can then parse the children in my spi driver with
>
>         while( (child = of_get_next_child(odev->node, child))) {
>                 struct spi_board_info info;
>
>                 info.max_speed_hz =
>                 info.bus_num =
>                 info.chip_select =
>                 ...
>                 spi_register_board_info(&info, 1);
>         }
>
> I think it will work this way but I found no way getting the
> platform_data for the spi devices.

I think that it's worth extending the current SPI core with OF
support. Maybe I'll manage to get to it :)
If you have something ready, please email to
spi-devel-general@lists.sourceforge.net.

Thanks,
   Vitaly

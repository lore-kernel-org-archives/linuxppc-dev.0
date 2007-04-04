Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 36D49DDE9F
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Apr 2007 02:34:56 +1000 (EST)
In-Reply-To: <acd2a5930704040451u55ae7619wfa1aaa84aebdf72@mail.gmail.com>
References: <20070404110916.GA9910@localhost.localdomain>
	<acd2a5930704040451u55ae7619wfa1aaa84aebdf72@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <4850DC60-A560-4A38-8416-ADA776B69509@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: SPI devices and OF
Date: Wed, 4 Apr 2007 11:34:11 -0500
To: Vitaly Wool <vitalywool@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 4, 2007, at 6:51 AM, Vitaly Wool wrote:

> On 4/4/07, Sascha Hauer <s.hauer@pengutronix.de> wrote:
>> Hi,
>>
>> I'm currently writing a driver for the mpc5200 spi controller (the
>> dedicated one, not the PSC ones).
>> The driver has the form of a of_platform_driver. My problem is that I
>> don't know how to define the spi devices on the spi bus. My current
>> approach is having something like this in the OF tree:
>>
>>
>>         spi@f00 {
>>                 device_type = "spi";
>>                 compatible = "mpc5200b-spi\0mpc5200-spi";
>>                 reg = <f00 20>;
>>                 interrupts = <2 d 0 2 e 0>;
>>                 interrupt-parent = <500>;
>>                 mmc@0 {
>>                         device_type = "mmc_spi";
>>                         compatible = "mmc_spi";
>>                 };
>>         };
>>
>> I can then parse the children in my spi driver with
>>
>>         while( (child = of_get_next_child(odev->node, child))) {
>>                 struct spi_board_info info;
>>
>>                 info.max_speed_hz =
>>                 info.bus_num =
>>                 info.chip_select =
>>                 ...
>>                 spi_register_board_info(&info, 1);
>>         }
>>
>> I think it will work this way but I found no way getting the
>> platform_data for the spi devices.
>
> I think that it's worth extending the current SPI core with OF
> support. Maybe I'll manage to get to it :)
> If you have something ready, please email to
> spi-devel-general@lists.sourceforge.net.

I don't think this is a good idea for SPI devices.  The effort vs  
reward isn't worth it.  The simple fact that the 'chip select'  
mechanism ends up being board specific is too much of a pain to  
figure out how to deal with in the device tree.  I think its ok if we  
put information about the controller in the tree, but trying to do  
the devices as well at this point doesn't seem like its much of a win.

- k

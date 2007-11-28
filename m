Return-Path: <fabio7774@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.173])
	by ozlabs.org (Postfix) with ESMTP id B7C12DDE36
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 Nov 2007 02:42:10 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id q7so1772099uge
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Nov 2007 07:42:09 -0800 (PST)
Message-ID: <474D8C43.4030608@gmail.com>
Date: Wed, 28 Nov 2007 17:41:55 +0200
MIME-Version: 1.0
To: Ben Warren <bwarren@qstreams.com>
Subject: Re: SPI driver for spi_mpc83xx
References: <mailman.3149.1196114204.3099.linuxppc-embedded@ozlabs.org>
	<474C6920.3030109@gmail.com> <474C70EF.4040800@qstreams.com>
In-Reply-To: <474C70EF.4040800@qstreams.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
From: fabio777 <fabio7774@gmail.com>
Cc: linuxppc-embedded@ozlabs.org
Reply-To: fabio777@gmail.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Thanks Ben
works.

Ben Warren wrote:
> Fabio,
>
> Note: I've changed the e-mail subject back to the original. In the 
> future, please ensure that it remains intact.
>
> fabio777 wrote:
>> Thanks Ben,
>>
>> Here it is
>>
>> static struct fsl_spi_platform_data k_platform_data = {
>> .initial_spmode = 0,
>> .bus_num = 1,
> Probably should be bus_num = 0
>> .max_chipselect = 1,
>> /* board specific information */
>> .activate_cs = k_cs_activate,
>> .deactivate_cs = k_cs_deactivate,
>> .sysclk = 266,
>> };
>>
>> static struct spi_board_info spi_board_info[] __initdata = { {
>> .modalias = "kplus",
>> .platform_data = &k_platform_data,
>> .max_speed_hz = 120000,
>> .bus_num = 1,
> Again, bus_num probably should be 0
>> .chip_select = 0,
>> },
>> };
>>
>>
>> struct platform_device k_plus = {
>> .name = "kplus",
> name should be "mpc83xx_spi". At initialization, the SPI controller 
> driver searches the registered platform devices (models of board 
> hardware) for a match. Without a match, it gives up.
>
>> .id = 1,
>> .dev = {
>> .platform_data = &k_platform_data,
>> },
>> };
>>
>> platform_device_register(&k_plus);
>>
> Do you add the SPI controller's resources (base address and IRQ?) 
> You'll need to in order for this to work. On my board, I use 
> 'platform_device_register_simple()', passing the name and the two 
> resources, then call 'platform_add_data()', passing in the platform 
> data structure.
>> spi_register_board_info(spi_board_info, ARRAY_SIZE(spi_board_info))
>>
> Good
>> and then calls spi_register_driver(&k_driver);
> I don't think this last call is needed.
>>
>> I can't get the into the *probe functions.
>> Thanks
>>
> regards,
> Ben

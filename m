Return-Path: <fabio7774@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.171])
	by ozlabs.org (Postfix) with ESMTP id 42460DDE08
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Nov 2007 05:59:58 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id q7so1500740uge
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 27 Nov 2007 10:59:58 -0800 (PST)
Message-ID: <474C6920.3030109@gmail.com>
Date: Tue, 27 Nov 2007 20:59:44 +0200
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org,  bwarren@qstreams.com
Subject: Re: Linuxppc-embedded Digest, Vol 39, Issue 48
References: <mailman.3149.1196114204.3099.linuxppc-embedded@ozlabs.org>
In-Reply-To: <mailman.3149.1196114204.3099.linuxppc-embedded@ozlabs.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
From: fabio777 <fabio7774@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Thanks Ben,

Here it is

static struct fsl_spi_platform_data k_platform_data = {
    .initial_spmode = 0,
    .bus_num = 1,
    .max_chipselect = 1,
/* board specific information */
    .activate_cs = k_cs_activate,
    .deactivate_cs = k_cs_deactivate,
    .sysclk =    266,
};

static struct spi_board_info spi_board_info[] __initdata = { {
    .modalias    = "kplus",
    .platform_data    = &k_platform_data,
    .max_speed_hz    = 120000,
    .bus_num    = 1,
    .chip_select    = 0,
},
};


struct platform_device k_plus = {
    .name        = "kplus",
    .id        = 1,
    .dev        = {
        .platform_data = &k_platform_data,
    },
};

 platform_device_register(&k_plus);

 spi_register_board_info(spi_board_info, ARRAY_SIZE(spi_board_info))

and then calls  spi_register_driver(&k_driver);

I can't get the into the *probe functions. 

Thanks 





>
> fabio777 wrote:
>   
>> Has anyone been using this driver ?
>>   
>>     
> I use it, on ARCH=powerpc, though.
>   
>> For legacy reasons I need to keep the ppc=arch however I haven't found 
>> out how to get this driver probed at start-up even basing my init on 
>> Lublock.
>>
>>   
>>     
> The driver's expecting a platform device with name "mpc83xx_spi" to be 
> registered in board init code. If you post your init code I may be able 
> to help.
>
> regards,
> Ben
>
>   

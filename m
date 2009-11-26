Return-Path: <Kari.Davidsson@marel.com>
Received: from mail.marel.is (mail.marel.is [213.167.134.96])
	by ozlabs.org (Postfix) with ESMTP id 569B51007D1
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Nov 2009 01:48:43 +1100 (EST)
Message-ID: <4B0E9203.7040208@marel.com>
Date: Thu, 26 Nov 2009 14:34:43 +0000
From: =?ISO-8859-1?Q?K=E1ri_Dav=ED=F0sson?= <kari.davidsson@marel.com>
MIME-Version: 1.0
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: fsl diu, edid info and i2c platform data
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I am messing about with the fsl-diu-fb.c which handles the display on mpc512x platforms.
The display panels we are using provide EDID information and I would like to use that to setup
the display modes etc. The current fsl-diu-fb.c is hard coding display modes into the driver.

I have started this and it is working more or less but I appreciate all input from more knowledgeable people
about how to do this "correctly" with the aim that others could benefit.
I have the feeling I am not approaching this correctly.

One option I was looking into was to use platform data for the i2c edid driver, e.g. for the platform to provide
default fb_mode. But I have a big problem on how to attach the platform data to the i2cedid driver.
I tried few options and while I think using code like :

     np = of_find_compatible_node( NULL, NULL, "vesa,edid" );
     if( np )
     {
         struct i2c_client * tsc2007 = NULL;

         //        tsc2007 = of_find_i2c_device_by_node( np );
         if( tsc2007 )
         {
             tsc2007->dev.platform_data = &v39_edid_data;
             put_device( &tsc2007->dev );
         }
         of_node_put( np );
     }

is the correct way to do it. The function of_find_i2c_device_by_node() hangs the kernel.

Attached is the patch as I have it now. It compiles and works on our custom mpc5121 board for two different LCD panels.

rg
kd

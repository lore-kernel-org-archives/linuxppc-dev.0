Return-Path: <gjb@semihalf.com>
Received: from semihalf.com (semihalf.com [206.130.101.55])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F0030DDD0C
	for <linuxppc-dev@ozlabs.org>; Mon,  2 Feb 2009 23:50:28 +1100 (EST)
Message-ID: <4986EC33.9000600@semihalf.com>
Date: Mon, 02 Feb 2009 13:50:59 +0100
From: Grzegorz Bernacki <gjb@semihalf.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] Add support for the digsy MTC board.
References: <1233329630876-git-send-email-gjb@semihalf.com>
	<fa686aa40901300859t4da76ce3hf943adc48abb9b9c@mail.gmail.com>
In-Reply-To: <fa686aa40901300859t4da76ce3hf943adc48abb9b9c@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
>> +/dts-v1/;
>> +
>> +/ {
>> +       model = "mtc,digsy";
>> +       compatible = "mtc,digsy";
> 
> This should be something like:  "intercontrol,digsy-mtc".  Compatible
> values should be in the form "<vendor>,<model>".
> 

ok, I will change it

>> +               mpc5200_pic: interrupt-controller@500 {
>> +                       // 5200 interrupts are encoded into two levels;
>> +                       interrupt-controller;
>> +                       #interrupt-cells = <3>;
>> +                       device_type = "interrupt-controller";
> 
> Drop device_type here.

ok, I will drop it

>> +                       compatible = "fsl,mpc5200b-pic","fsl,mpc5200-pic";
>> +                       reg = <0x500 0x80>;
>> +               };
>> +
>> +               timer@600 {     // General Purpose Timer
>> +                       compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
>> +                       cell-index = <0>;
> 
> Drop cell-index on all the timer nodes.  If you compare this file with
> the current cm5200.dts in mainline then you'll see the properties that
> you can drop.
> 
> Otherwise the device tree looks pretty good.
> 
>> diff --git a/arch/powerpc/configs/52xx/digsy_mtc_defconfig b/arch/powerpc/configs/52xx/digsy_mtc_defconfig
>> new file mode 100644
>> index 0000000..ad70d5b
>> --- /dev/null
>> +++ b/arch/powerpc/configs/52xx/digsy_mtc_defconfig

I would like to have support for following devices in defconfig for digsy:
- LXT PHY
- RTC DS1337
- EEPROM AT24
- MTD partitioning based on OF description

If you dont mind I can add them to generic mpc5200 defconfig, otherwise
I think that separate defconfig is needed.

> 
> Do you *really* need your own defconfig for the digsy_mtc.  I've
> grudgingly accepted them for other boards under the argument that the
> defconfig reflects a specific application of the board.  However, I'd
> much rather see the digsy added to the multiplatform
> mpc5200_defconfig, especially considering that the MTC looks like it's
> supposed to be a general purpose platform.

> There is a lot of direct copy/paste from the lite5200.c board file,
> but the big scary warning comment about not duplicating this code was
> deleted in the copy (so I know you saw it).  Is Semihalf responsible
> for the U-Boot port to the digsy-mtc?  If so then please fix the
> port_config and clock settings in u-boot.
> 

I will update port config and clock settings in u-boot and use mpc5200_simple
instead of creating a new file for digsy.

BTW,
I noticed that there are some problems with mounting file system
over NFS on Linux-2.6.29-rc3, I see following messages:
...
[  339.813807] nfs: server 192.168.1.1 not responding, still trying
[  339.832144] nfs: server 192.168.1.1 OK
...

I haven't noticed in on Linux-2.6.29-rc2. Is there any known problem?

regards,
Grzesiek

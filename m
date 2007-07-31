Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 79689DDDF9
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 31 Jul 2007 14:22:56 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1IFjG0-0005RQ-6D
	for linuxppc-embedded@ozlabs.org; Mon, 30 Jul 2007 21:22:52 -0700
Message-ID: <11918008.post@talk.nabble.com>
Date: Mon, 30 Jul 2007 21:22:52 -0700 (PDT)
From: Qin Lin <linkinge@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: ml403 ac97 driver
In-Reply-To: <11859770.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <1185698888.6397.37.camel@localhost>
	<11858308.post@talk.nabble.com>
	<1185780815.5454.18.camel@localhost>
	<11859770.post@talk.nabble.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


HI ALL
I have compile the driver and test it with the help of Joachim.

1.add the lm4550 driver to kernel source
(someboby may can add them as a patch to kernel source)

#cp -r ml403_ac97cr $(KERNEL)/sound/drivers/
#vi $(KERNEL)/sound/drivers/Makefile
=add=
obj-$(CONFIG_SND_ML403_AC97)	+=ml403_ac97cr/
#vi $(KERNEL)/sound/drivers/
=add=
config SND_ML403_AC97
        tristate "ml403 ac97 codec(LM4550)"
        depends on SND
        select SND_AC97_CODEC
        help
          ml403 ac97 codec added by Joachim
          enjoy it !

#vi $(KERNEL)/sound/drivers/ml403_ac97cr/Makefile
obj-$(CONFIG_SND_ML403_AC97) += ml403_ac97cr.o

#make xconfig 
you can see the ml403_ac97cr in SOUND ALSA 

2.cross-compile alsa-lib
I use ELDK4.0 to install cross compile in XILINX ML403.
$echo $CROSS_COMPILE
 ppc_4xx-
$export CC=${CROSS_COMPILE}gcc
$export CPP=${CROSS_COMPILE}cpp
$export CXX=${CROSS_COMPILE}g++
$export LDD=${CROSS_COMPILE}ldd
$export AR=${CROSS_COMPILE}ar
$export LD=${CROSS_COMPILE}ld
$export RANLIB=${CROSS_COMPILE}ranlib
$export STRIP=${CROSS_COMPILE}strip
$cd ${ALSA-LIB-SOURCE}
$./configure --host=ppc-4xx-linux --target=ppc  --prefix=/usr
$make install  DESTDIR=${ALSA}

ps:ALSA lib will be install in path ${ALSA}/usr.Here use prefix=/usr is
important,do not change to another 
path. Otherwise in the target board alsa will not find the config file by
default.You can use DESTDIR to set the lib path .

3.cross-compile alsa-utils
$export CC=${CROSS_COMPILE}gcc
$export CPP=${CROSS_COMPILE}cpp
$export CXX=${CROSS_COMPILE}g++
$export LDD=${CROSS_COMPILE}ldd
$export AR=${CROSS_COMPILE}ar
$export LD=${CROSS_COMPILE}ld
$export RANLIB=${CROSS_COMPILE}ranlib
$export STRIP=${CROSS_COMPILE}strip
$export CFLAGS="-I${ALSA}/usr/include  -L${ALSA}/usr/lib"

$cd ${ALSA-UTILS-SOURCE}
$./configure --host=ppc-4xx-linux --target=ppc  --prefix=/usr --disable-nls 
$make install  DESTDIR=${ALSA}

ps:use --disable-nls,otherwise there is an error about LC_ALL not defined.

3.copy the ${ALSA}/usr/* to the target rootfile /usr/  ,so you can use the
alsa utils.

4.insmod the drive module and create device node ,use 
#aplay music.wav
to test the drive.
-- 
View this message in context: http://www.nabble.com/Re%3A-ml403-ac97-driver-tf4164866.html#a11918008
Sent from the linuxppc-embedded mailing list archive at Nabble.com.

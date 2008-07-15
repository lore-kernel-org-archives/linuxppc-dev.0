Return-Path: <khali@linux-fr.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A3EA5DE781
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jul 2008 00:05:32 +1000 (EST)
Date: Tue, 15 Jul 2008 16:05:10 +0200
From: Jean Delvare <khali@linux-fr.org>
To: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [PATCH] of: i2c: improve last resort compatible entry selection
Message-ID: <20080715160510.0f57dd0e@hyperion.delvare>
In-Reply-To: <9e4733910807150640x52cca982jf4f1ccfe7fd506cf@mail.gmail.com>
References: <20080714175437.GA5230@polina.dev.rtsoft.ru>
	<487C7F9A.7030201@scram.de>
	<9e4733910807150640x52cca982jf4f1ccfe7fd506cf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 15 Jul 2008 09:40:08 -0400, Jon Smirl wrote:
> On 7/15/08, Jochen Friedrich <jochen@scram.de> wrote:
> > Hi Anton,
> >
> >
> >  > Since no sane driver will ever match specific devices, what we want is
> >  > to select most generic option (last). Then driver may call
> >  > of_device_is_compatible() if it is really interested in details.
> >
> >
> > My original intention was to have alias entries for specific devices in the
> >  i2c device drivers. Later, Jean decided to only have the most generic names
> >  in there (like in http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blobdiff;f=drivers/media/video/tvaudio.c;h=c77914d99d15c5972c94e9763a08b5789098e90a;hp=6f9945b04e1f2bcd676f0ed8dc910994b29ed300;hb=ae429083efe996ca2c569c44fd6fea440676dc33;hpb=60b129d7bfa3e20450816983bd52c49bb0bc1c21)
> >  So your patch is correct.

Eeeek. The patch you mention here is only the conversion of ONE driver.
It is absolutely not relevant as to what the general rule is.

Background:
Some media drivers have been relying on autodetection for years. We
will convert them to the new model as much as possible, however the
knowledge of what chip is present on each board has sometimes been
lost, so switching to the new i2c model isn't that easy. So, as a
transition step, for a few media drivers, we decided to not enumerate
all the supported chips (nobody would be able to instantiate any of
them specifically anyway). This might change in the future, as
developers gain knowledge about the hardware again.

Jochen, I am very surprised that you dare drawing conclusions based on
one random patch of mine. And I am unhappy that you even claim that I
took some decision when I definitely did not.

> Why aren't we listing the chip names in the driver's id section? Large
> chip id tables are not unusual in the kernel, the e1000 driver has
> about 70 entries.
> 
> Taking the chip id table out of the driver just means we have to build
> it somewhere else. It doesn't save space, the tables just get moved.
> Device firmware has the chip names in it so there has to be code in
> the kernel somewhere to do the mapping from chip id to linux driver
> name.
> 
> Pushing the linux driver name down into the firmware is even crazier.
> +  /* 2. search for linux,<i2c-type> entry */
> Now if the linux driver gets renamed everyone on the planet needs a
> firmware update.

I can't comment on the specific issue at hand as I am not familiar with
it, but overall Jon appears to be right. Listing individual chips in
id_table is the standard way to go. That's even the very reason why we
decided to add this id_table to i2c_driver, instead of matching on the
driver name as we were doing before.

-- 
Jean Delvare

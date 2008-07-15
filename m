Return-Path: <jonsmirl@gmail.com>
Received: from ti-out-0910.google.com (ti-out-0910.google.com [209.85.142.186])
	by ozlabs.org (Postfix) with ESMTP id A4511DDF11
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jul 2008 23:40:11 +1000 (EST)
Received: by ti-out-0910.google.com with SMTP id w7so2662508tib.13
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jul 2008 06:40:09 -0700 (PDT)
Message-ID: <9e4733910807150640x52cca982jf4f1ccfe7fd506cf@mail.gmail.com>
Date: Tue, 15 Jul 2008 09:40:08 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Jean Delvare" <khali@linux-fr.org>
Subject: Re: [PATCH] of: i2c: improve last resort compatible entry selection
In-Reply-To: <487C7F9A.7030201@scram.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080714175437.GA5230@polina.dev.rtsoft.ru>
	<487C7F9A.7030201@scram.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 7/15/08, Jochen Friedrich <jochen@scram.de> wrote:
> Hi Anton,
>
>
>  > Since no sane driver will ever match specific devices, what we want is
>  > to select most generic option (last). Then driver may call
>  > of_device_is_compatible() if it is really interested in details.
>
>
> My original intention was to have alias entries for specific devices in the
>  i2c device drivers. Later, Jean decided to only have the most generic names
>  in there (like in http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blobdiff;f=drivers/media/video/tvaudio.c;h=c77914d99d15c5972c94e9763a08b5789098e90a;hp=6f9945b04e1f2bcd676f0ed8dc910994b29ed300;hb=ae429083efe996ca2c569c44fd6fea440676dc33;hpb=60b129d7bfa3e20450816983bd52c49bb0bc1c21)
>  So your patch is correct.

Why aren't we listing the chip names in the driver's id section? Large
chip id tables are not unusual in the kernel, the e1000 driver has
about 70 entries.

Taking the chip id table out of the driver just means we have to build
it somewhere else. It doesn't save space, the tables just get moved.
Device firmware has the chip names in it so there has to be code in
the kernel somewhere to do the mapping from chip id to linux driver
name.

Pushing the linux driver name down into the firmware is even crazier.
+  /* 2. search for linux,<i2c-type> entry */
Now if the linux driver gets renamed everyone on the planet needs a
firmware update.

-- 
Jon Smirl
jonsmirl@gmail.com

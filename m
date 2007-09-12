Return-Path: <hs@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 9C7B4DDECA
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 21:57:00 +1000 (EST)
Subject: Re: SYSFS: need a noncaching read
From: Heiko Schocher <hs@denx.de>
To: Greg KH <greg@kroah.com>
In-Reply-To: <20070912113907.GA24087@kroah.com>
References: <1189503798.6674.46.camel@Zeus.EmbLux>
	<20070912053207.GH23573@pengutronix.de>
	<20070912100123.GA23182@kroah.com>
	<1189595612.6659.23.camel@Zeus.EmbLux>
	<20070912113907.GA24087@kroah.com>
Content-Type: text/plain
Date: Wed, 12 Sep 2007 13:59:40 +0200
Message-Id: <1189598380.6659.28.camel@Zeus.EmbLux>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	Detlev Zundel <dzu@denx.de>
Reply-To: hs@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Greg,

Am Mittwoch, den 12.09.2007, 04:39 -0700 schrieb Greg KH:
> > > Do an lseek back to 0 and then re-read, you will get called in your
> > > driver again.
> > 
> > No thats not true. I thought this too, but if I make a:
> > 
> > seek (fd, 0L, SEEK_SET);
> > 
> > in Userspace, there is no retrigger in the sysFS, my driver is *not*
> > called again. So I made a own sysfs_seek function, which does retrigger
> > the driver ...
> 
> Hm, are you sure?  Otherwise the poll() stuff would not work at all.

Yes.
Sysfs uses generic_file_llseek (). And in sysfs_read_file ()
buffer->needs_read_fill must be 1, to reread from the driver.
generic_file_llseek () doesnt change this variable.

Best regards
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

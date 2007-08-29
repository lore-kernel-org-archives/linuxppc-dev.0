Return-Path: <mokuno@sm.sony.co.jp>
Received: from mgw2.sony.co.jp (MGW2.Sony.CO.JP [137.153.0.14])
	by ozlabs.org (Postfix) with ESMTP id 9A77DDDE1C
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Aug 2007 21:21:56 +1000 (EST)
Date: Wed, 29 Aug 2007 20:21:14 +0900
From: Masakazu Mokuno <mokuno@sm.sony.co.jp>
To: Andreas Schwab <schwab@suse.de>
Subject: Re: [PATCH] PS3: fix the bug the major version part is not compared
In-Reply-To: <jehcmj3i3p.fsf@sykes.suse.de>
References: <20070828211415.C2B5.MOKUNO@sm.sony.co.jp>
	<jehcmj3i3p.fsf@sykes.suse.de>
Message-Id: <20070829201929.C2E6.MOKUNO@sm.sony.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 28 Aug 2007 15:26:50 +0200
Andreas Schwab <schwab@suse.de> wrote:

> Masakazu Mokuno <mokuno@sm.sony.co.jp> writes:
> 
> > Fix the bug that the major version part of the firmware 
> > is not compared.
> >
> > Signed-off-by: Masakazu Mokuno <mokuno@sm.sony.co.jp>
> > CC: Geoff Levand <geoffrey.levand@am.sony.com>
> > ---
> >  arch/powerpc/platforms/ps3/setup.c |    2 +-
> >  include/asm-powerpc/ps3.h          |    2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > --- a/arch/powerpc/platforms/ps3/setup.c
> > +++ b/arch/powerpc/platforms/ps3/setup.c
> > @@ -54,7 +54,7 @@ void ps3_get_firmware_version(union ps3_
> >  }
> >  EXPORT_SYMBOL_GPL(ps3_get_firmware_version);
> >  
> > -int ps3_compare_firmware_version(u16 major, u16 minor, u16 rev)
> > +s64 ps3_compare_firmware_version(u16 major, u16 minor, u16 rev)
> >  {
> >  	union ps3_firmware_version x;
> >  
> 
> Better yet: normalize the return value.
> 
> 	return (ps3_firmware_version.raw > x.raw) -
>                (ps3_firmware_version.raw < x.raw);


Thank you!
I'll submit new patch.


--
Masakazu MOKUNO

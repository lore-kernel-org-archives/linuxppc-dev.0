Return-Path: <matthias.fuchs@esd-electronics.com>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 32150DE345
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Aug 2008 00:11:11 +1000 (EST)
From: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Fix Book-E watchdog timer interval setting
Date: Thu, 7 Aug 2008 16:04:07 +0200
References: <200808071448.06183.matthias.fuchs@esd-electronics.com>
	<A4CCB071-0FCE-490A-B563-399FCA74C71E@kernel.crashing.org>
In-Reply-To: <A4CCB071-0FCE-490A-B563-399FCA74C71E@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200808071604.07477.matthias.fuchs@esd-electronics.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sure,

the former line:

 mtspr(SPRN_TCR, (mfspr(SPRN_TCR)&~WDTP(0))|WDTP(booke_wdt_period));

tries to mask the wdt interval period bits by and'ing with ~WDTP(0) which
is 0xffffffff. So no bits are cleared and or'ing a new value does not change anything.
The default interval is '3' which is the maximum, so any attempt to set a new
interval keeps the former '3'.

The patch correctly masks the period bits in SPRN_TCR before writing the new value.

That's all.

Matthias

On Thursday 07 August 2008 15:19, Kumar Gala wrote:
> 
> On Aug 7, 2008, at 7:48 AM, Matthias Fuchs wrote:
> 
> > This patch fixes the setting of the Book-E watchdog timer interval  
> > setup
> > on initialization and by ioctl().
> >
> > Tested on PPC440EPx sequoia evaluation board.
> >
> > Signed-off-by: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
> > ---
> > drivers/watchdog/booke_wdt.c |    6 +++++-
> > 1 files changed, 5 insertions(+), 1 deletions(-)
> 
> can you be more explicit about what the bug was.
> 
> - k
> 
> 

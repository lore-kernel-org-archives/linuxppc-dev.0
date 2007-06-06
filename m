Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id B2FC6DDDFA
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Jun 2007 21:27:59 +1000 (EST)
Date: Wed, 6 Jun 2007 13:27:54 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [patch 07/18] PS3: Make ps3av.h usable from user space
In-Reply-To: <20070606074609.GA31975@lst.de>
Message-ID: <Pine.LNX.4.62.0706061325340.24545@pademelon.sonytel.be>
References: <20070606024407.786638029@am.sony.com>>
	<46662337.9060908@am.sony.com> <20070606074609.GA31975@lst.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Masashi Kimoto <Masashi_Kimoto@hq.scei.sony.co.jp>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 6 Jun 2007, Christoph Hellwig wrote:
> On Tue, Jun 05, 2007 at 08:00:07PM -0700, Geoff Levand wrote:
> > The user applications to manage the PS3 AV modes can use values
> > defined in this header.
> 
> NACK.  First please don't introduce new unifdef-y headers but always
> separated them.  Second I don't see any of the values actually used
> in a user<->kerne interface.  If the application only happens to use
> the same values it should ship a copy of the header intead.

ps3videomode (from ps3-utils,
git://git.kernel.org/pub/scm/linux/kernel/git/geoff/ps3-utils.git) uses the
PS3AV_MODE_* definitions for the PS3FB_IOCTL_[SG]ETMODE ioctls on /dev/fb0.

But it indeed just uses a few values, and ps3videomode.c already handles the
case were <asm/ps3av.h> is not available, so I guess we can drop the export.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium

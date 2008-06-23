Return-Path: <geert@linux-m68k.org>
Received: from yergi.telenet-ops.be (yergi.telenet-ops.be [195.130.132.36])
	by ozlabs.org (Postfix) with ESMTP id B9B77DE128
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jun 2008 04:15:10 +1000 (EST)
Received: from wilson.telenet-ops.be (unknown [195.130.132.42])
	by yergi.telenet-ops.be (Postfix) with ESMTP id DBBA5710531
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Jun 2008 20:15:18 +0200 (CEST)
Date: Mon, 23 Jun 2008 20:14:51 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Sender: geert@linux-m68k.org
To: Adrian Bunk <bunk@kernel.org>
Subject: Re: [2.6 patch] drivers/macintosh/: possible cleanups
In-Reply-To: <20080623174657.GC4756@cs181140183.pp.htv.fi>
Message-ID: <Pine.LNX.4.64.0806232014160.20175@anakin>
References: <20080609222312.GM1987@cs181133002.pp.htv.fi>
	<20080610102125.2816c9e3.sfr@canb.auug.org.au>
	<20080623174657.GC4756@cs181140183.pp.htv.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-m68k@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 23 Jun 2008, Adrian Bunk wrote:
> On Tue, Jun 10, 2008 at 10:21:25AM +1000, Stephen Rothwell wrote:
> > On Tue, 10 Jun 2008 01:23:12 +0300 Adrian Bunk <bunk@kernel.org> wrote:
> > >
> > > +++ b/drivers/macintosh/adbhid.c
> > > @@ -75,7 +75,7 @@ static struct notifier_block adbhid_adb_notifier = {
> > >  #define ADB_KEY_POWER_OLD	0x7e
> > >  #define ADB_KEY_POWER		0x7f
> > >  
> > > -u16 adb_to_linux_keycodes[128] = {
> > > +static u16 adb_to_linux_keycodes[128] = {
> > 
> > This could be const as well.
> 
> Updated patch below.
> 
> cu
> Adrian
> 
> <--  snip  -->
> 
> This patch contains the following possible cleanups:
> - make the following needlessly global code static:
>   - adb.c: adb_controller
>   - adb.c: adb_init()
>   - adbhid.c: adb_to_linux_keycodes[]  (also make it const)
>   - via-pmu68k.c: backlight_level
>   - via-pmu68k.c: backlight_enabled
> - remove the following unused code:
>   - via-pmu68k.c: sleep_notifier_list
> 
> Signed-off-by: Adrian Bunk <bunk@kernel.org>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

I assume Paulus will take it, as he controls more Macs?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

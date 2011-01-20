Return-Path: <akpm@linux-foundation.org>
Date: Thu, 20 Jan 2011 12:35:07 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: torbenh <torbenh@gmx.de>
Subject: Re: [PATCH] change acquire/release_console_sem() to
	console_lock/unlock()
Message-Id: <20110120123507.ac89c034.akpm@linux-foundation.org>
In-Reply-To: <20110120165502.GA10832@siel.b>
References: <1295539104-13210-1-git-send-email-torbenh@gmx.de>
	<20110120163448.GA30588@suse.de> <20110120165502.GA10832@siel.b>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: xen-devel@lists.xensource.com, Kees Cook <kees.cook@canonical.com>,
	linux-fbdev@vger.kernel.org,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	James Hogan <james@albanarts.com>, David Airlie <airlied@linux.ie>,
	Jesse Barnes <jbarnes@virtuousgeek.org>, James Morris <jmorris@namei.org>,
	Paul Mackerras <paulus@samba.org>, linux-parisc@vger.kernel.org,
	Magnus Damm <damm@opensource.se>, Jiri Slaby <jslaby@suse.cz>,
	Dan Williams <dan.j.williams@intel.com>,
	devel@driverdev.osuosl.org, Guy Martin <gmsoft@tuxicoman.be>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>,
	Russell King <linux@arm.linux.org.uk>, Thomas Gleixner <tglx@tglx.de>,
	Wu Zhangjin <wuzhangjin@gmail.com>,
	Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
	Lionel Debroux <lionel_debroux@yahoo.fr>,
	Helge Deller <deller@gmx.de>, Kay Sievers <kay.sievers@vrfy.org>,
	"James E.J. Bottomley" <jejb@parisc-linux.org>,
	Kevin Hilman <khilman@deeprootsystems.com>,
	Tony Lindgren <tony@atomide.com>, cbe-oss-dev@lists.ozlabs.org,
	Ben Skeggs <bskeggs@redhat.com>, Ingo Molnar <mingo@elte.hu>,
	Daniel Vetter <daniel.vetter@ffwll.ch>, Dave Airlie <airlied@redhat.com>,
	David Brown <davidb@codeaurora.org>,
	Francisco Jerez <currojerez@riseup.net>,
	virtualization@lists.linux-foundation.org,
	Namhyung Kim <namhyung@gmail.com>,
	Marcin Slusarz <marcin.slusarz@gmail.com>,
	Alberto Panizzo <maramaopercheseimorto@gmail.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Ondrej Zary <linux@rainbow-software.org>,
	Denys Vlasenko <vda.linux@googlemail.com>,
	Antonino Daplas <adaplas@gmail.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Abhijeet Dharmapurikar <adharmap@codeaurora.org>,
	Andres Salomon <dilinger@queued.net>, Werner Fink <werner@suse.de>,
	Phil Edworthy <phil.edworthy@renesas.com>, linux-geode@lists.infradead.org,
	Alex Deucher <alexdeucher@gmail.com>, Jerome Glisse <jglisse@redhat.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Alexey Dobriyan <adobriyan@gmail.com>, Daniel Mack <daniel@caiaq.de>,
	Nicolas Pitre <nicolas.pitre@canonical.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-omap@vger.kernel.org,
	Ondrej Zajicek <santiago@crfreenet.org>,
	linux-arm-kernel@lists.infradead.org, Liam Girdwood <lrg@slimlogic.co.uk>,
	Daniel Walker <dwalker@codeaurora.org>,
	Linus Walleij <linus.walleij@stericsson.com>,
	Caglar Akyuz <caglar@bilkon-kontrol.com.tr>,
	Geoff Levand <geoff@infradead.org>,
	Jiri Kosina <jkosina@suse.cz>, dri-devel@lists.freedesktop.org,
	Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org,
	Ralf Baechle <ralf@linux-mips.org>,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
	Kyle McMartin <kyle@mcmartin.ca>, Jean Delvare <khali@linux-fr.org>,
	Paul Mundt <lethal@linux-sh.org>, Arnd Bergmann <arnd@arndb.de>,
	Takashi Iwai <tiwai@suse.de>, Jason Wessel <jason.wessel@windriver.com>,
	Tejun Heo <tj@kernel.org>, Julia Lawall <julia@diku.dk>,
	linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>,
	Marcin =?UTF-8?Q?Ko=C5=9Bcielnicki?= <koriakin@0x04.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 20 Jan 2011 17:55:02 +0100
torbenh <torbenh@gmx.de> wrote:

> On Thu, Jan 20, 2011 at 08:34:48AM -0800, Greg KH wrote:
> > On Thu, Jan 20, 2011 at 04:58:13PM +0100, Torben Hohn wrote:
> > > the -rt patches change the console_semaphore to console_mutex.
> > > so a quite large chunk of the patches changes all
> > > acquire/release_console_sem() to acquire/release_console_mutex()
> > 
> > Why not just change the functionality of the existing function to be a
> > mutex in the rt patches, instead of having to rename it everywhere?
> 
> i hope that Thomas already did this in his upcoming -rt series.
> 
> > 
> > > this commit makes things use more neutral function names
> > > which dont make implications about the underlying lock.
> > > 
> > > the only real change is the return value of console_trylock
> > > which is inverted from try_acquire_console_sem()
> > > 
> > > Signed-off-by: Torben Hohn <torbenh@gmx.de>
> > > CC: Thomas Gleixner <tglx@tglx.de>
> > 
> > I don't mind this rename, but is it really going to help anything out?
> > What's the odds of the -rt portion of this patch ever making it to
> > mainline?
> 
> the -rt portion only changes the semaphore to a mutex.
> since the console_sem is used with mutex semantics, i dont see any
> reason, not to merge that portion too. 
> 
> i am just trying to shrink the -rt patch to make it more maintanable :)
> 

Yeah, I think it's a better name and if we can indeed switch that
semaphore to a mutex then that's a good thing to do.

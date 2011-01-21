Return-Path: <geert.uytterhoeven@gmail.com>
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20110120123507.ac89c034.akpm@linux-foundation.org>
References: <1295539104-13210-1-git-send-email-torbenh@gmx.de>
	<20110120163448.GA30588@suse.de> <20110120165502.GA10832@siel.b>
	<20110120123507.ac89c034.akpm@linux-foundation.org>
Date: Fri, 21 Jan 2011 09:10:06 +0100
Message-ID: <AANLkTinN2+pNGk1hwrcMhH5qDNZK=Egrw7P6c-cdJTmH@mail.gmail.com>
Subject: Re: [PATCH] change acquire/release_console_sem() to
	console_lock/unlock()
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Cc: linux-fbdev@vger.kernel.org, Greg KH <gregkh@suse.de>,
	Lars-Peter Clausen <lars@metafoo.de>, James Hogan <james@albanarts.com>,
	David Airlie <airlied@linux.ie>, Daniel Vetter <daniel.vetter@ffwll.ch>,
	linux-omap@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>,
	"James E.J. Bottomley" <jejb@parisc-linux.org>,
	"David S. Miller" <davem@davemloft.net>, Paul Mackerras <paulus@samba.org>,
	Liam Girdwood <lrg@slimlogic.co.uk>,
	Kyle McMartin <kyle@mcmartin.ca>, Jiri Slaby <jslaby@suse.cz>,
	Thomas Gleixner <tglx@linutronix.de>,
	Caglar Akyuz <caglar@bilkon-kontrol.com.tr>, devel@driverdev.osuosl.org,
	Alberto Panizzo <maramaopercheseimorto@gmail.com>,
	Phil Edworthy <phil.edworthy@renesas.com>, xen-devel@lists.xensource.com,
	Russell King <linux@arm.linux.org.uk>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Wu Zhangjin <wuzhangjin@gmail.com>,
	Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
	Lionel Debroux <lionel_debroux@yahoo.fr>,
	Helge Deller <deller@gmx.de>, Kay Sievers <kay.sievers@vrfy.org>,
	James Morris <jmorris@namei.org>,
	Kevin Hilman <khilman@deeprootsystems.com>,
	Tony Lindgren <tony@atomide.com>, Ben Skeggs <bskeggs@redhat.com>,
	Andres Salomon <dilinger@queued.net>,
	Julia Lawall <julia@diku.dk>, Dave Airlie <airlied@redhat.com>,
	Kees Cook <kees.cook@canonical.com>,
	Francisco Jerez <currojerez@riseup.net>,
	Abhijeet Dharmapurikar <adharmap@codeaurora.org>,
	Marcin Slusarz <marcin.slusarz@gmail.com>,
	cbe-oss-dev@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org,
	Ondrej Zary <linux@rainbow-software.org>,
	Denys Vlasenko <vda.linux@googlemail.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	linux-kernel@vger.kernel.org, Namhyung Kim <namhyung@gmail.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Werner Fink <werner@suse.de>, linux-geode@lists.infradead.org,
	torbenh <torbenh@gmx.de>, Jean Delvare <khali@linux-fr.org>,
	Magnus Damm <damm@opensource.se>,
	Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>,
	dri-devel@lists.freedesktop.org, Daniel Mack <daniel@caiaq.de>,
	Nicolas Pitre <nicolas.pitre@canonical.com>,
	Dan Williams <dan.j.williams@intel.com>,
	virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@elte.hu>,
	linux-arm-kernel@lists.infradead.org, Thomas Gleixner <tglx@tglx.de>,
	Daniel Walker <dwalker@codeaurora.org>,
	Linus Walleij <linus.walleij@stericsson.com>,
	linux-parisc@vger.kernel.org, Geoff Levand <geoff@infradead.org>,
	Jiri Kosina <jkosina@suse.cz>,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	Jerome Glisse <jglisse@redhat.com>, Ralf Baechle <ralf@linux-mips.org>,
	Alexey Dobriyan <adobriyan@gmail.com>, Guy Martin <gmsoft@tuxicoman.be>,
	Ondrej Zajicek <santiago@crfreenet.org>,
	Paul Mundt <lethal@linux-sh.org>, Arnd Bergmann <arnd@arndb.de>,
	Takashi Iwai <tiwai@suse.de>, Jason Wessel <jason.wessel@windriver.com>,
	Alex Deucher <alexdeucher@gmail.com>, Tejun Heo <tj@kernel.org>,
	Antonino Daplas <adaplas@gmail.com>,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
	=?UTF-8?Q?Marcin_Ko=C5=9Bcielnicki?= <koriakin@0x04.net>,
	David Brown <davidb@codeaurora.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jan 20, 2011 at 21:35, Andrew Morton <akpm@linux-foundation.org> wr=
ote:
> On Thu, 20 Jan 2011 17:55:02 +0100
> torbenh <torbenh@gmx.de> wrote:
>
>> On Thu, Jan 20, 2011 at 08:34:48AM -0800, Greg KH wrote:
>> > On Thu, Jan 20, 2011 at 04:58:13PM +0100, Torben Hohn wrote:
>> > > the -rt patches change the console_semaphore to console_mutex.
>> > > so a quite large chunk of the patches changes all
>> > > acquire/release_console_sem() to acquire/release_console_mutex()
>> >
>> > Why not just change the functionality of the existing function to be a
>> > mutex in the rt patches, instead of having to rename it everywhere?
>>
>> i hope that Thomas already did this in his upcoming -rt series.
>>
>> >
>> > > this commit makes things use more neutral function names
>> > > which dont make implications about the underlying lock.
>> > >
>> > > the only real change is the return value of console_trylock
>> > > which is inverted from try_acquire_console_sem()
>> > >
>> > > Signed-off-by: Torben Hohn <torbenh@gmx.de>
>> > > CC: Thomas Gleixner <tglx@tglx.de>
>> >
>> > I don't mind this rename, but is it really going to help anything out?
>> > What's the odds of the -rt portion of this patch ever making it to
>> > mainline?
>>
>> the -rt portion only changes the semaphore to a mutex.
>> since the console_sem is used with mutex semantics, i dont see any
>> reason, not to merge that portion too.
>>
>> i am just trying to shrink the -rt patch to make it more maintanable :)
>>
>
> Yeah, I think it's a better name and if we can indeed switch that
> semaphore to a mutex then that's a good thing to do.

include/linux/mutex.h:

/*
 * NOTE: mutex_trylock() follows the spin_trylock() convention,
 *       not the down_trylock() convention!
 *
 * Returns 1 if the mutex has been acquired successfully, and 0 on contenti=
on.
 */
extern int mutex_trylock(struct mutex *lock);

So that's why the return value was inverted (when treating it as a boolean)=
.
I can understand that.

However:

+/**
+ * console_trylock - try to lock the console system for exclusive use.
+ *
+ * Tried to acquire a lock which guarantees that the caller has
+ * exclusive access to the console system and the console_drivers list.
+ *
+ * returns -1 on success, and 0 on failure to acquire the lock.
+ */
+int console_trylock(void)

So this one returns -1 on success, not 1? Why?

Gr{oetje,eeting}s,

=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0=C2=A0 -- Linus Torvalds

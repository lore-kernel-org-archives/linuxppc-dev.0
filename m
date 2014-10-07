Return-Path: <geert.uytterhoeven@gmail.com>
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1412659726-29957-9-git-send-email-linux@roeck-us.net>
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
 <1412659726-29957-9-git-send-email-linux@roeck-us.net>
Date: Tue, 7 Oct 2014 10:32:44 +0200
Message-ID: <CAMuHMdXQfYqhHnVKLHZvTyqE8Ke7jWEu7LKLR9ZfVQaO8mNtBw@mail.gmail.com>
Subject: Re: [PATCH 08/44] kernel: Move pm_power_off to common code
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Cc: linux-m32r-ja@ml.linux-m32r.org,
 Linux MIPS Mailing List <linux-mips@linux-mips.org>, linux-efi@vger.kernel.org,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 Steven Miao <realmz6@gmail.com>,
 "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 David Howells <dhowells@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Paul Mackerras <paulus@samba.org>, Ralf Baechle <ralf@linux-mips.org>,
 Pavel Machek <pavel@ucw.cz>, "H. Peter Anvin" <hpa@zytor.com>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, Thomas Gleixner <tglx@linutronix.de>,
 Lennox Wu <lennox.wu@gmail.com>, Hans-Christian Egtvedt <egtvedt@samfundet.no>,
 driverdevel <devel@driverdev.osuosl.org>,
 linux-s390 <linux-s390@vger.kernel.org>,
 Jesper Nilsson <jesper.nilsson@axis.com>, lguest@lists.ozlabs.org,
 Russell King <linux@arm.linux.org.uk>, linux-c6x-dev@linux-c6x.org,
 Len Brown <len.brown@intel.com>, "David S. Miller" <davem@davemloft.net>,
 "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
 Hirokazu Takata <takata@linux-m32r.org>,
 Linux-sh list <linux-sh@vger.kernel.org>,
 "James E.J. Bottomley" <jejb@parisc-linux.org>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Mark Salter <msalter@redhat.com>,
 xen-devel@lists.xenproject.org, Matt Turner <mattst88@gmail.com>,
 Chen Liqin <liqin.linux@gmail.com>, Jonas Bonn <jonas@southpole.se>,
 Haavard Skinnemoen <hskinnemoen@gmail.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 James Hogan <james.hogan@imgtec.com>,
 uml-devel <user-mode-linux-devel@lists.sourceforge.net>,
 Linux PM list <linux-pm@vger.kernel.org>,
 Aurelien Jacquiot <a-jacquiot@ti.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, Jeff Dike <jdike@addtoit.com>,
 "adi-buildroot-devel@lists.sourceforge.net"
 <adi-buildroot-devel@lists.sourceforge.net>,
 Chris Metcalf <cmetcalf@tilera.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Mikael Starvik <starvik@axis.com>, Richard Weinberger <richard@nod.at>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 "moderated list:PANASONIC MN10300..." <linux-am33-list@redhat.com>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux-tegra@vger.kernel.org,
 openipmi-developer@lists.sourceforge.net,
 "open list:METAG ARCHITECTURE" <linux-metag@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Richard Henderson <rth@twiddle.net>, Chris Zankel <chris@zankel.net>,
 Michal Simek <monstr@monstr.eu>, Tony Luck <tony.luck@intel.com>,
 Parisc List <linux-parisc@vger.kernel.org>, Cris <linux-cris-kernel@axis.com>,
 Vineet Gupta <vgupta@synopsys.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Fenghua Yu <fenghua.yu@intel.com>, Richard Kuo <rkuo@codeaurora.org>,
 David Vrabel <david.vrabel@citrix.com>, alpha <linux-alpha@vger.kernel.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Koichi Yasutake <yasutake.koichi@jp.panasonic.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Helge Deller <deller@gmx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 7, 2014 at 7:28 AM, Guenter Roeck <linux@roeck-us.net> wrote:
> pm_power_off is defined for all architectures. Move it to common code.
>
> Have all architectures call do_kernel_poweroff instead of pm_power_off.
> Some architectures point pm_power_off to machine_power_off. For those,
> call do_kernel_poweroff from machine_power_off instead.

>  arch/m68k/kernel/process.c         |  6 +-----

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

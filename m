Return-Path: <geert.uytterhoeven@gmail.com>
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1412659726-29957-2-git-send-email-linux@roeck-us.net>
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
 <1412659726-29957-2-git-send-email-linux@roeck-us.net>
Date: Thu, 9 Oct 2014 13:31:40 +0200
Message-ID: <CAMuHMdVOBnZ=pyVeGSxbOT9MtRR2iNY4V-PUm0NU=UFQ2pxE_g@mail.gmail.com>
Subject: Re: [PATCH 01/44] kernel: Add support for poweroff handler call chain
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Cc: linux-m32r-ja@ml.linux-m32r.org,
 Linux MIPS Mailing List <linux-mips@linux-mips.org>, linux-efi@vger.kernel.org,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, Len Brown <len.brown@intel.com>,
 "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
 Pavel Machek <pavel@ucw.cz>, driverdevel <devel@driverdev.osuosl.org>,
 linux-s390 <linux-s390@vger.kernel.org>, lguest@lists.ozlabs.org,
 linux-c6x-dev@linux-c6x.org,
 "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
 Linux-sh list <linux-sh@vger.kernel.org>, Alexander Graf <agraf@suse.de>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 xen-devel@lists.xenproject.org,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 uml-devel <user-mode-linux-devel@lists.sourceforge.net>,
 Linux PM list <linux-pm@vger.kernel.org>,
 "adi-buildroot-devel@lists.sourceforge.net"
 <adi-buildroot-devel@lists.sourceforge.net>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 "moderated list:PANASONIC MN10300..." <linux-am33-list@redhat.com>,
 linux-tegra@vger.kernel.org, openipmi-developer@lists.sourceforge.net,
 "open list:METAG ARCHITECTURE" <linux-metag@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Parisc List <linux-parisc@vger.kernel.org>, Cris <linux-cris-kernel@axis.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 alpha <linux-alpha@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Romain Perier <romain.perier@gmail.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 7, 2014 at 7:28 AM, Guenter Roeck <linux@roeck-us.net> wrote:
> +int register_poweroff_handler_simple(void (*handler)(void), int priority)
> +{
> +       char symname[KSYM_NAME_LEN];
> +
> +       if (poweroff_handler_data.handler) {
> +               lookup_symbol_name((unsigned long)poweroff_handler_data.handler,
> +                                  symname);
> +               pr_warn("Poweroff function already registered (%s)", symname);
> +               lookup_symbol_name((unsigned long)handler, symname);
> +               pr_cont(", cannot register %s\n", symname);

Doesn't %ps work to look up symbols?

pr_warn("Poweroff function already registered (%ps), cannot register
%ps\n", poweroff_handler_data.handler, handler);

> +               return -EBUSY;
> +       }

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

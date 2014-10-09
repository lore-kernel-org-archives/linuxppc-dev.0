Return-Path: <catalin.marinas@arm.com>
Date: Thu, 9 Oct 2014 11:28:55 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 08/44] kernel: Move pm_power_off to common code
Message-ID: <20141009102855.GE17836@e104818-lin.cambridge.arm.com>
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
 <1412659726-29957-9-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1412659726-29957-9-git-send-email-linux@roeck-us.net>
Cc: "linux-m32r-ja@ml.linux-m32r.org" <linux-m32r-ja@ml.linux-m32r.org>,
 "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
 "linux-m68k@vger.kernel.org" <linux-m68k@vger.kernel.org>,
 "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 Steven Miao <realmz6@gmail.com>,
 "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Will Deacon <Will.Deacon@arm.com>, David Howells <dhowells@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Paul Mackerras <paulus@samba.org>,
 Ralf Baechle <ralf@linux-mips.org>, Pavel Machek <pavel@ucw.cz>,
 "H. Peter Anvin" <hpa@zytor.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>,
 Thomas Gleixner <tglx@linutronix.de>, Lennox Wu <lennox.wu@gmail.com>,
 Hans-Christian Egtvedt <egtvedt@samfundet.no>,
 "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 Jesper Nilsson <jesper.nilsson@axis.com>,
 "lguest@lists.ozlabs.org" <lguest@lists.ozlabs.org>,
 Russell King <linux@arm.linux.org.uk>,
 "linux-c6x-dev@linux-c6x.org" <linux-c6x-dev@linux-c6x.org>,
 Len Brown <len.brown@intel.com>, "David S. Miller" <davem@davemloft.net>,
 "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
 Hirokazu Takata <takata@linux-m32r.org>,
 "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
 "James E.J. Bottomley" <jejb@parisc-linux.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 "msalter@redhat.com" <msalter@redhat.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 Matt Turner <mattst88@gmail.com>, Chen Liqin <liqin.linux@gmail.com>,
 Jonas Bonn <jonas@southpole.se>, Haavard Skinnemoen <hskinnemoen@gmail.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 James Hogan <james.hogan@imgtec.com>,
 "user-mode-linux-devel@lists.sourceforge.net"
 <user-mode-linux-devel@lists.sourceforge.net>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 Aurelien Jacquiot <a-jacquiot@ti.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, Jeff Dike <jdike@addtoit.com>,
 "adi-buildroot-devel@lists.sourceforge.net"
 <adi-buildroot-devel@lists.sourceforge.net>,
 Chris Metcalf <cmetcalf@tilera.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Mikael Starvik <starvik@axis.com>, Richard Weinberger <richard@nod.at>,
 "linux-am33-list@redhat.com" <linux-am33-list@redhat.com>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 "openipmi-developer@lists.sourceforge.net"
 <openipmi-developer@lists.sourceforge.net>,
 "linux-metag@vger.kernel.org" <linux-metag@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Richard Henderson <rth@twiddle.net>, Chris Zankel <chris@zankel.net>,
 Michal Simek <monstr@monstr.eu>, Tony Luck <tony.luck@intel.com>,
 "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
 "linux-cris-kernel@axis.com" <linux-cris-kernel@axis.com>,
 Vineet Gupta <vgupta@synopsys.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Fenghua Yu <fenghua.yu@intel.com>, Richard Kuo <rkuo@codeaurora.org>,
 David Vrabel <david.vrabel@citrix.com>,
 "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 "yasutake.koichi@jp.panasonic.com" <yasutake.koichi@jp.panasonic.com>,
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

On Tue, Oct 07, 2014 at 06:28:10AM +0100, Guenter Roeck wrote:
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index e0ef8ba..db396bb 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -94,8 +94,6 @@ void soft_restart(unsigned long addr)
>  /*
>   * Function pointers to optional machine specific functions
>   */
> -void (*pm_power_off)(void);
> -EXPORT_SYMBOL_GPL(pm_power_off);
> 
>  void (*arm_pm_restart)(enum reboot_mode reboot_mode, const char *cmd);
> 
> @@ -155,8 +153,7 @@ void machine_power_off(void)
>  {
>         local_irq_disable();
>         smp_send_stop();
> -       if (pm_power_off)
> -               pm_power_off();
> +       do_kernel_poweroff();
>  }

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

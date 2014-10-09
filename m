Return-Path: <pavel@ucw.cz>
Received: from atrey.karlin.mff.cuni.cz (atrey.karlin.mff.cuni.cz
 [195.113.26.193])
 by lists.ozlabs.org (Postfix) with ESMTP id CB9E01A0728
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Oct 2014 21:32:56 +1100 (EST)
Date: Thu, 9 Oct 2014 12:32:54 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 03/44] hibernate: Call have_kernel_poweroff instead of
 checking pm_power_off
Message-ID: <20141009103254.GB6787@amd>
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
 <1412659726-29957-4-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1412659726-29957-4-git-send-email-linux@roeck-us.net>
Cc: linux-m32r-ja@ml.linux-m32r.org, linux-mips@linux-mips.org,
 linux-efi@vger.kernel.org, linux-ia64@vger.kernel.org,
 Len Brown <len.brown@intel.com>, linux-xtensa@linux-xtensa.org,
 devel@driverdev.osuosl.org, linux-s390@vger.kernel.org,
 lguest@lists.ozlabs.org, linux-c6x-dev@linux-c6x.org,
 linux-hexagon@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-acpi@vger.kernel.org, xen-devel@lists.xenproject.org,
 devicetree@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
 linux-pm@vger.kernel.org, adi-buildroot-devel@lists.sourceforge.net,
 linux-m68k@lists.linux-m68k.org, linux-am33-list@redhat.com,
 linux-tegra@vger.kernel.org, openipmi-developer@lists.sourceforge.net,
 linux-metag@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-parisc@vger.kernel.org, linux-cris-kernel@axis.com,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
 linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon 2014-10-06 22:28:05, Guenter Roeck wrote:
> Poweroff handlers may now be installed with register_poweroff_handler.
> Use the new API function have_kernel_poweroff to determine if a poweroff
> handler has been installed.
> 
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Len Brown <len.brown@intel.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  kernel/power/hibernate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index a9dfa79..20353c5 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -602,7 +602,7 @@ static void power_down(void)
>  	case HIBERNATION_PLATFORM:
>  		hibernation_platform_enter();
>  	case HIBERNATION_SHUTDOWN:
> -		if (pm_power_off)
> +		if (have_kernel_poweroff())
>  			kernel_power_off();
>  		break;

poweroff -> power_off.

But if you are playing with this, anyway... does it make sense to
introduce kernel_power_off() that just works, no need to check
have_..?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

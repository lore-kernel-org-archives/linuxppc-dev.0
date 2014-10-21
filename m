Return-Path: <dvhart@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6563C1A0054
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Oct 2014 07:49:57 +1100 (AEDT)
Date: Tue, 21 Oct 2014 13:50:07 -0700
From: Darren Hart <dvhart@infradead.org>
To: Jani Nikula <jani.nikula@intel.com>
Subject: Re: [PATCH] drivers: depend on instead of select
 BACKLIGHT_CLASS_DEVICE and ACPI_VIDEO
Message-ID: <20141021205006.GC20951@vmdeb7>
References: <1413580403-16225-1-git-send-email-jani.nikula@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1413580403-16225-1-git-send-email-jani.nikula@intel.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
 linux-fbdev@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
 Daniel Drake <dsd@laptop.org>, Jens Frederich <jfrederich@gmail.com>,
 David Airlie <airlied@linux.ie>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jon Nettleton <jon.nettleton@gmail.com>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 platform-driver-x86@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Daniel Vetter <daniel.vetter@intel.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Oct 18, 2014 at 12:13:23AM +0300, Jani Nikula wrote:
> Documentation/kbuild/kconfig-language.txt warns to use select with care,
> and in general use select only for non-visible symbols and for symbols
> with no dependencies, because select will force a symbol to a value
> without visiting the dependencies.
> 
> Select has become particularly problematic, interdependently, with the
> BACKLIGHT_CLASS_DEVICE and ACPI_VIDEO configs. For example:
> 
> scripts/kconfig/conf --randconfig Kconfig
> KCONFIG_SEED=0x48312B00
> warning: (DRM_RADEON && DRM_NOUVEAU && DRM_I915 && DRM_GMA500 &&
> DRM_SHMOBILE && DRM_TILCDC && FB_BACKLIGHT && FB_MX3 && USB_APPLEDISPLAY
> && FB_OLPC_DCON && ASUS_LAPTOP && SONY_LAPTOP && THINKPAD_ACPI &&
> EEEPC_LAPTOP && ACPI_CMPC && SAMSUNG_Q10) selects BACKLIGHT_CLASS_DEVICE
> which has unmet direct dependencies (HAS_IOMEM && BACKLIGHT_LCD_SUPPORT)
> warning: (DRM_RADEON && DRM_NOUVEAU && DRM_I915 && DRM_GMA500 &&
> DRM_SHMOBILE && DRM_TILCDC && FB_BACKLIGHT && FB_MX3 && USB_APPLEDISPLAY
> && FB_OLPC_DCON && ASUS_LAPTOP && SONY_LAPTOP && THINKPAD_ACPI &&
> EEEPC_LAPTOP && ACPI_CMPC && SAMSUNG_Q10) selects BACKLIGHT_CLASS_DEVICE
> which has unmet direct dependencies (HAS_IOMEM && BACKLIGHT_LCD_SUPPORT)
> 
> With tristates it's possible to end up selecting FOO=y depending on
> BAR=m in the config, which gets discovered at build time, not config
> time, like reported in the thread referenced below.
> 
> Do the following to fix the dependencies:
> 
> * Depend on instead of select BACKLIGHT_CLASS_DEVICE everywhere. Drop
>   select BACKLIGHT_LCD_SUPPORT in such cases, as it's a dependency of
>   BACKLIGHT_CLASS_DEVICE.
> 
> * Remove config FB_BACKLIGHT altogether, and replace it with a
>   dependency on BACKLIGHT_CLASS_DEVICE. All configs selecting
>   FB_BACKLIGHT select or depend on FB anyway, so we can simplify.
> 
> * Depend on (ACPI && ACPI_VIDEO) || ACPI=n in several places instead of
>   selecting ACPI_VIDEO and a number of its dependencies if ACPI is
>   enabled. This is tied to backlight, as ACPI_VIDEO depends on
>   BACKLIGHT_CLASS_DEVICE.
> 
> * Replace a couple of select INPUT/VT with depends as it seemed to be
>   necessary.
> 
> Reference: http://lkml.kernel.org/r/CA+r1ZhhmT4DrWtf6MbRQo5EqXwx+LxCqh15Vsu_d9WpftLhnxw@mail.gmail.com
> Reported-by: Jim Davis <jim.epost@gmail.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Darren Hart <dvhart@infradead.org>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Jens Frederich <jfrederich@gmail.com>
> Cc: Daniel Drake <dsd@laptop.org>
> Cc: Jon Nettleton <jon.nettleton@gmail.com>
> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>

As for the drivers/platform/x86/Kconfig:

Acked-by: Darren Hart <dvhart@linux.intel.com>

Thanks,

-- 
Darren Hart
Intel Open Source Technology Center

Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 009031A0103
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2015 18:38:13 +1000 (AEST)
In-Reply-To: <1440002994-25662-4-git-send-email-hegdevasant@linux.vnet.ibm.com>
To: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>, linux-leds@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: stewart@linux.vnet.ibm.com, j.anaszewski81@gmail.com, arnd@arndb.de,
 cooloney@gmail.com, Vasant Hegde <hegdevasant@linux.vnet.ibm.com>,
 rpurdie@rpsys.net, j.anaszewski@samsung.com, khandual@linux.vnet.ibm.com
Subject: Re: [v10,3/3] leds/powernv: Add driver for PowerNV platform
Message-Id: <20150820083812.88640140297@ozlabs.org>
Date: Thu, 20 Aug 2015 18:38:12 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-19-08 at 16:49:54 UTC, Vasant Hegde wrote:
> This patch implements LED driver for PowerNV platform using the existing
> generic LED class framework.
> 
> PowerNV platform has below type of LEDs:
>   - System attention
>       Indicates there is a problem with the system that needs attention.
>   - Identify
>       Helps the user locate/identify a particular FRU or resource in the
>       system.
>   - Fault
>       Indicates there is a problem with the FRU or resource at the
>       location with which the indicator is associated.
> 
> We register classdev structures for all individual LEDs detected on the
> system through LED specific device tree nodes. Device tree nodes specify
> what all kind of LEDs present on the same location code. It registers
> LED classdev structure for each of them.
> 
> All the system LEDs can be found in the same regular path /sys/class/leds/.
> We don't use LED colors. We use LED node and led-types property to form
> LED classdev. Our LEDs have names in this format.
> 
>         <location_code>:<attention|identify|fault>
> 
> Any positive brightness value would turn on the LED and a zero value would
> turn off the LED. The driver will return LED_FULL (255) for any turned on
> LED and LED_OFF (0) for any turned off LED.
> 
> The platform level implementation of LED get and set state has been
> achieved through OPAL calls. These calls are made available for the
> driver by exporting from architecture specific codes.
> 
> Signed-off-by: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> Acked-by: Stewart Smith <stewart@linux.vnet.ibm.com>
> Tested-by: Stewart Smith <stewart@linux.vnet.ibm.com>
> Acked-by: Jacek Anaszewski <j.anaszewski@samsung.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/84ad6e5cd3e8b365c893

cheers

Return-Path: <egtvedt@samfundet.no>
Date: Sat, 1 Nov 2014 11:16:37 +0100
From: Hans-Christian Egtvedt <egtvedt@samfundet.no>
To: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 33/44] avr32: atngw100: Register with kernel poweroff
 handler
Message-ID: <20141101101637.GA5765@samfundet.no>
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
 <1412659726-29957-34-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1412659726-29957-34-git-send-email-linux@roeck-us.net>
Cc: linux-m32r-ja@ml.linux-m32r.org, linux-mips@linux-mips.org,
 linux-efi@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-xtensa@linux-xtensa.org, devel@driverdev.osuosl.org,
 linux-s390@vger.kernel.org, lguest@lists.ozlabs.org,
 linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-acpi@vger.kernel.org,
 xen-devel@lists.xenproject.org, Haavard Skinnemoen <hskinnemoen@gmail.com>,
 devicetree@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
 linux-pm@vger.kernel.org, adi-buildroot-devel@lists.sourceforge.net,
 linux-m68k@lists.linux-m68k.org, linux-am33-list@redhat.com,
 linux-tegra@vger.kernel.org, openipmi-developer@lists.sourceforge.net,
 linux-metag@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-parisc@vger.kernel.org, linux-cris-kernel@axis.com,
 linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Around Mon 06 Oct 2014 22:28:35 -0700 or thereabout, Guenter Roeck wrote:
> Register with kernel poweroff handler instead of setting pm_power_off
> directly.
> 
> Cc: Haavard Skinnemoen <hskinnemoen@gmail.com>
> Cc: Hans-Christian Egtvedt <egtvedt@samfundet.no>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Acked-by: Hans-Christian Egtvedt <egtvedt@samfundet.no>

> ---
>  arch/avr32/boards/atngw100/mrmt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/avr32/boards/atngw100/mrmt.c b/arch/avr32/boards/atngw100/mrmt.c
> index 91146b4..54d0c27 100644
> --- a/arch/avr32/boards/atngw100/mrmt.c
> +++ b/arch/avr32/boards/atngw100/mrmt.c
> @@ -274,7 +274,7 @@ static int __init mrmt1_init(void)
>  {
>  	gpio_set_value( PIN_PWR_ON, 1 );	/* Ensure PWR_ON is enabled */
>  
> -	pm_power_off = mrmt_power_off;
> +	register_poweroff_handler_simple(mrmt_power_off, 128);
>  
>  	/* Setup USARTS (other than console) */
>  	at32_map_usart(2, 1, 0);	/* USART 2: /dev/ttyS1, RMT1:DB9M */
-- 
mvh
Hans-Christian Egtvedt

Return-Path: <catalin.marinas@arm.com>
Date: Thu, 9 Oct 2014 11:41:04 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 32/44] arm64: psci: Register with kernel poweroff handler
Message-ID: <20141009104104.GG17836@e104818-lin.cambridge.arm.com>
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
 <1412659726-29957-33-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1412659726-29957-33-git-send-email-linux@roeck-us.net>
Cc: "linux-m32r-ja@ml.linux-m32r.org" <linux-m32r-ja@ml.linux-m32r.org>,
 "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
 "linux-m68k@vger.kernel.org" <linux-m68k@vger.kernel.org>,
 "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
 Will Deacon <Will.Deacon@arm.com>,
 "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "lguest@lists.ozlabs.org" <lguest@lists.ozlabs.org>,
 "linux-c6x-dev@linux-c6x.org" <linux-c6x-dev@linux-c6x.org>,
 "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
 "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "user-mode-linux-devel@lists.sourceforge.net"
 <user-mode-linux-devel@lists.sourceforge.net>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "adi-buildroot-devel@lists.sourceforge.net"
 <adi-buildroot-devel@lists.sourceforge.net>,
 "linux-am33-list@redhat.com" <linux-am33-list@redhat.com>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 "openipmi-developer@lists.sourceforge.net"
 <openipmi-developer@lists.sourceforge.net>,
 "linux-metag@vger.kernel.org" <linux-metag@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
 "linux-cris-kernel@axis.com" <linux-cris-kernel@axis.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 07, 2014 at 06:28:34AM +0100, Guenter Roeck wrote:
> Register with kernel poweroff handler instead of setting pm_power_off
> directly.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  arch/arm64/kernel/psci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
> index 5539547..c1f3d09 100644
> --- a/arch/arm64/kernel/psci.c
> +++ b/arch/arm64/kernel/psci.c
> @@ -286,7 +286,7 @@ static int __init psci_0_2_init(struct device_node *np)
>  
>  	arm_pm_restart = psci_sys_reset;
>  
> -	pm_power_off = psci_sys_poweroff;
> +	register_poweroff_handler_simple(psci_sys_poweroff, 128);
>  
>  out_put_node:
>  	of_node_put(np);

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

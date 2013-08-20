Return-Path: <rjw@sisk.pl>
Received: from hydra.sisk.pl (hydra.sisk.pl [212.160.235.94])
 by ozlabs.org (Postfix) with ESMTP id A776B2C0129
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Aug 2013 22:18:20 +1000 (EST)
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 06/19] driver/core: cpu: initialize of_node in cpu's
 device struture
Date: Tue, 20 Aug 2013 14:28:54 +0200
Message-ID: <2130896.Ecsj2pZtBK@vostro.rjw.lan>
In-Reply-To: <1376991021-12160-7-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1374492747-13879-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376991021-12160-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376991021-12160-7-git-send-email-Sudeep.KarkadaNagesha@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Jonas Bonn <jonas@southpole.se>, devicetree@vger.kernel.org,
 Michal Simek <monstr@monstr.eu>, linux-pm@vger.kernel.org,
 Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>,
 Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org,
 Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@linaro.org>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday, August 20, 2013 10:30:08 AM Sudeep KarkadaNagesha wrote:
> From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
> 
> CPUs are also registered as devices but the of_node in these cpu
> devices are not initialized. Currently different drivers requiring
> to access cpu device node are parsing the nodes themselves and
> initialising the of_node in cpu device.
> 
> The of_node in all the cpu devices needs to be initialized properly
> and at one place. The best place to update this is CPU subsystem
> driver when registering the cpu devices.
> 
> The OF/DT core library now provides of_get_cpu_node to retrieve a cpu
> device node for a given logical index by abstracting the architecture
> specific details.
> 
> This patch uses of_get_cpu_node to assign of_node when registering the
> cpu devices.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Acked-by: Rob Herring <rob.herring@calxeda.com>
> Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>

Hi Greg,

I this one fine with you?

Rafael


> ---
>  drivers/base/cpu.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> index 4c358bc..4cf0717 100644
> --- a/drivers/base/cpu.c
> +++ b/drivers/base/cpu.c
> @@ -14,6 +14,7 @@
>  #include <linux/slab.h>
>  #include <linux/percpu.h>
>  #include <linux/acpi.h>
> +#include <linux/of.h>
>  
>  #include "base.h"
>  
> @@ -289,6 +290,7 @@ int register_cpu(struct cpu *cpu, int num)
>  	cpu->dev.release = cpu_device_release;
>  	cpu->dev.offline_disabled = !cpu->hotpluggable;
>  	cpu->dev.offline = !cpu_online(num);
> +	cpu->dev.of_node = of_get_cpu_node(num, NULL);
>  #ifdef CONFIG_ARCH_HAS_CPU_AUTOPROBE
>  	cpu->dev.bus->uevent = arch_cpu_uevent;
>  #endif
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.

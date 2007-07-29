Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id A93D5DDDD8
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 30 Jul 2007 03:08:02 +1000 (EST)
Message-ID: <46ACC42E.8040907@ru.mvista.com>
Date: Sun, 29 Jul 2007 20:45:34 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: niklaus.giger@member.fsf.org
Subject: Re: [PATCH] Fix compilation for non CONFIG_HOTPLUG case
References: <200707291807.52042.niklaus.giger@member.fsf.org>
In-Reply-To: <200707291807.52042.niklaus.giger@member.fsf.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linux-kernel@vger.kernel.org, kristen.c.accardi@intel.com,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello.

Niklaus Giger wrote:

> Fixes compilation issues for embedded boards which do not support HOTPLUG

> Signed-off-by: Niklaus Giger <niklaus.giger@member.fsf.org>

> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 3599ab2..a09bfc8 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -24,7 +24,9 @@
>  #include "base.h"
>  #include "power/power.h"
> 
> +#ifdef CONFIG_HOTPLUG
>  extern const char *kobject_actions[];
> +#endif

    No need for #ifdef around extern declarations.

>  int (*platform_notify)(struct device * dev) = NULL;
>  int (*platform_notify_remove)(struct device * dev) = NULL;
> @@ -306,11 +308,13 @@ static ssize_t store_uevent(struct device *dev, struct 
> device_attribute *attr,
>  			    const char *buf, size_t count)
>  {
>  	size_t len = count;
> +#ifdef CONFIG_HOTPLUG
>  	enum kobject_action action;
> -
> +#endif

    Please don't remove newline between the declaration block and the code.

>  	if (len && buf[len-1] == '\n')
>  		len--;
> 
> +#ifdef CONFIG_HOTPLUG
>  	for (action = 0; action < KOBJ_MAX; action++) {
>  		if (strncmp(kobject_actions[action], buf, len) != 0)
>  			continue;
> @@ -319,11 +323,14 @@ static ssize_t store_uevent(struct device *dev, struct 
> device_attribute *attr,
>  		kobject_uevent(&dev->kobj, action);
>  		goto out;

    Grr... cleanup style abuse -- ISO a mere return they used goto. :-/

>  	}
> +#endif
> 
>  	dev_err(dev, "uevent: unsupported action-string; this will "
>  		     "be ignored in a future kernel version\n");
>  	kobject_uevent(&dev->kobj, KOBJ_ADD);
> +#ifdef CONFIG_HOTPLUG
>  out:
> +#endif

    Well, #ifdef'ing out label seems too much.

>  	return count;
>  }

WBR, Sergei

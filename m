Return-Path: <joel.stan@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 102641A003C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Feb 2016 18:15:16 +1100 (AEDT)
Received: from mail-ob0-x243.google.com (mail-ob0-x243.google.com
 [IPv6:2607:f8b0:4003:c01::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 50CB0140134
 for <linuxppc-dev@ozlabs.org>; Thu, 11 Feb 2016 18:15:15 +1100 (AEDT)
Received: by mail-ob0-x243.google.com with SMTP id x5so4618093obg.1
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Feb 2016 23:15:15 -0800 (PST)
MIME-Version: 1.0
Sender: joel.stan@gmail.com
In-Reply-To: <1455002269-26543-1-git-send-email-andrew.donnellan@au1.ibm.com>
References: <1455002269-26543-1-git-send-email-andrew.donnellan@au1.ibm.com>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 11 Feb 2016 17:44:54 +1030
Message-ID: <CACPK8Xcfi+8XAR3WxvP6qJ7YjSBprZNcMzKrtiaABgoGw015gw@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] powerpc/powernv: new function to access OPAL msglog
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Stewart Smith <stewart@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 9, 2016 at 5:47 PM, Andrew Donnellan
<andrew.donnellan@au1.ibm.com> wrote:
> Currently, the OPAL msglog/console buffer is exposed as a sysfs file, with
> the sysfs read handler responsible for retrieving the log from the OPAL
> buffer. We'd like to be able to use it in xmon as well.
>
> Refactor the OPAL msglog code to create a new function, opal_msglog_copy(),
> that copies to an arbitrary buffer. Separate the initialisation code into
> generic memcons init and sysfs file creation.
>
> Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

Looks like you didn't break it much. Congratulations on being the new
memcons maintainer!

There's one issue with your error handling.

> diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
> index 4e0da5a..0256d07 100644
> --- a/arch/powerpc/platforms/powernv/opal.c
> +++ b/arch/powerpc/platforms/powernv/opal.c
> @@ -724,6 +724,9 @@ static int __init opal_init(void)
>                 of_node_put(leds);
>         }
>
> +       /* Initialise OPAL message log interface */
> +       opal_msglog_init();

If this fails due to eg. the magic number being wrong.

> +
>         /* Create "opal" kobject under /sys/firmware */
>         rc = opal_sysfs_init();
>         if (rc == 0) {
> @@ -739,8 +742,8 @@ static int __init opal_init(void)
>                 opal_platform_dump_init();
>                 /* Setup system parameters interface */
>                 opal_sys_param_init();
> -               /* Setup message log interface. */
> -               opal_msglog_init();
> +               /* Setup message log sysfs interface. */
> +               opal_msglog_sysfs_init();

This will succeed, leaving you with a sysfs file attached to a broken driver.

>         }
>
>         /* Initialize platform devices: IPMI backend, PRD & flash interface */

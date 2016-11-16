Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tJrKd51c3zDvRM
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 04:07:32 +1100 (AEDT)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, Scott Wood <oss@buserror.net>,
 Yangbo Lu <yangbo.lu@nxp.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] soc: fsl: fix section mismatch build warnings
Date: Wed, 16 Nov 2016 18:07:13 +0100
Message-ID: <48395491.F1myL99mt3@wuerfel>
In-Reply-To: <1479314367-9169-2-git-send-email-sudeep.holla@arm.com>
References: <1479314367-9169-1-git-send-email-sudeep.holla@arm.com>
 <1479314367-9169-2-git-send-email-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wednesday, November 16, 2016 4:39:27 PM CET Sudeep Holla wrote:
> @@ -223,6 +222,7 @@ static struct platform_driver fsl_guts_driver = {
>  
>  static int __init fsl_guts_init(void)
>  {
> +       machine = of_flat_dt_get_machine_name();
>         return platform_driver_register(&fsl_guts_driver);
>  }
>  core_initcall(fsl_guts_init);

I think we simply need to use the normal DT API rather than the of_flat_* one.

	Arnd

Return-Path: <groeck7@gmail.com>
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 420xxn69W4zF342
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Aug 2018 06:27:22 +1000 (AEST)
Received: by mail-pf1-x441.google.com with SMTP id s13-v6so2782291pfi.7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Aug 2018 13:27:22 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 29 Aug 2018 13:27:18 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linux-hwmon@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] hwmon: drop unnecessary OF name NULL checks
Message-ID: <20180829202718.GB29801@roeck-us.net>
References: <20180829200221.13492-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180829200221.13492-1-robh@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 29, 2018 at 03:02:21PM -0500, Rob Herring wrote:
> Checking the child node names is pointless as the DT node name can
> never be NULL, so remove it.
> 
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linux-hwmon@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  drivers/hwmon/ibmpowernv.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/hwmon/ibmpowernv.c b/drivers/hwmon/ibmpowernv.c
> index 4935897f1527..0ccca87f5271 100644
> --- a/drivers/hwmon/ibmpowernv.c
> +++ b/drivers/hwmon/ibmpowernv.c
> @@ -458,9 +458,6 @@ static int populate_attr_groups(struct platform_device *pdev)
>  	for_each_child_of_node(opal, np) {
>  		const char *label;
>  
> -		if (np->name == NULL)
> -			continue;
> -
>  		type = get_sensor_type(np);
>  		if (type == MAX_SENSOR_TYPE)
>  			continue;
> @@ -589,9 +586,6 @@ static int create_device_attrs(struct platform_device *pdev)
>  		const char *label;
>  		enum sensors type;
>  
> -		if (np->name == NULL)
> -			continue;
> -
>  		type = get_sensor_type(np);
>  		if (type == MAX_SENSOR_TYPE)
>  			continue;
> -- 
> 2.17.1
> 

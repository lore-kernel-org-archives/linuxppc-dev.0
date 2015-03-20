Return-Path: <clg@fr.ibm.com>
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4805F1A2A86
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2015 19:06:48 +1100 (AEDT)
Received: from /spool/local
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@fr.ibm.com>;
 Fri, 20 Mar 2015 08:06:44 -0000
Message-ID: <550BD50E.2040009@fr.ibm.com>
Date: Fri, 20 Mar 2015 09:06:38 +0100
From: Cedric Le Goater <clg@fr.ibm.com>
MIME-Version: 1.0
To: lm-sensors@lm-sensors.org
Subject: Re: [PATCH v2 4/5] hwmon: (ibmpowernv) change create_hwmon_attr_name()
 prototype
References: <1423117857-32759-1-git-send-email-clg@fr.ibm.com>
 <1426787085-9004-5-git-send-email-clg@fr.ibm.com>
In-Reply-To: <1426787085-9004-5-git-send-email-clg@fr.ibm.com>
Content-Type: text/plain; charset=utf-8
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, Jean Delvare <jdelvare@suse.de>,
 Neelesh Gupta <neelegup@linux.vnet.ibm.com>, skiboot@lists.ozlabs.org,
 linuxppc-dev@lists.ozlabs.org, Guenter Roeck <linux@roeck-us.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[ ... ] 


> @@ -265,10 +261,17 @@ static int create_device_attrs(struct pl
> 
>  		sdata[count].id = sensor_id;
>  		sdata[count].type = type;
> -		err = create_hwmon_attr_name(&pdev->dev, type, np->name,
> -					     sdata[count].name);
> -		if (err)
> +
> +		attr_name = parse_opal_node_name(np->name, type, &opal_index);
> +		if (IS_ERR(attr_name)) {
> +			dev_err(&pdev->dev, "Sensor device node name '%s' is invalid\n",
> +				np->name);
> +			err = IS_ERR(attr_name);
                              ^^^^^^

Arg. Bad copy/paste. This should be PTR_ERR() ... 

Do you want a full patchset resend or just a resend of this patch ? or a fix maybe.

Sorry for the noise ...

C.  

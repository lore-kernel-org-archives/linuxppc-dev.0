Return-Path: <clg@kaod.org>
Received: from 14.mo6.mail-out.ovh.net (14.mo6.mail-out.ovh.net
 [46.105.56.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wC5V21TNszDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Apr 2017 00:40:26 +1000 (AEST)
Received: from player696.ha.ovh.net (b6.ovh.net [213.186.33.56])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id 5BDC5CEB9F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Apr 2017 16:34:52 +0200 (CEST)
Subject: Re: [PATCH] hwmon: (ibmpowernv) Add min/max attributes and current
 sensors
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
References: <1492749112-32465-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Cc: linux-hwmon@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, svaidy@linux.vnet.ibm.com,
 ego@linux.vnet.ibm.com, akshay.adiga@linux.vnet.ibm.com, andrew@aj.id.au
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <f10a3983-def5-e3dc-9c19-a1119e1dd612@kaod.org>
Date: Tue, 25 Apr 2017 16:34:32 +0200
MIME-Version: 1.0
In-Reply-To: <1492749112-32465-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

...

> +			sdata[count].id = sensor_id;
> +			sdata[count].type = type;
> +			sdata[count].hwmon_index = sdata[count - 1].hwmon_index;
> +			create_hwmon_attr(&sdata[count], attr_name,
> +					  show_sensor);
> +			pgroups[type]->attrs[sensor_groups[type].attr_count++] =
> +				&sdata[count++].dev_attr.attr;
> +		}

We are duplicating these lines at least three times. I wonder if we 
could make a routine for them. Don't bother doing so if the number
of arguments is too large.

Thanks,

C.

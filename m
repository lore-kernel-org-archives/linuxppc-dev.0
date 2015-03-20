Return-Path: <linux@roeck-us.net>
Received: from bh-25.webhostbox.net (bh-25.webhostbox.net [208.91.199.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1A6B71A2AA9
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Mar 2015 02:28:18 +1100 (AEDT)
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
 (envelope-from <linux@roeck-us.net>) id 1YYyqO-002oiH-24
 for linuxppc-dev@lists.ozlabs.org; Fri, 20 Mar 2015 15:28:16 +0000
Date: Fri, 20 Mar 2015 08:27:02 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Cedric Le Goater <clg@fr.ibm.com>
Subject: Re: [PATCH v2 4/5] hwmon: (ibmpowernv) change
 create_hwmon_attr_name() prototype
Message-ID: <20150320152702.GB10749@roeck-us.net>
References: <1423117857-32759-1-git-send-email-clg@fr.ibm.com>
 <1426787085-9004-5-git-send-email-clg@fr.ibm.com>
 <550BD50E.2040009@fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <550BD50E.2040009@fr.ibm.com>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, lm-sensors@lm-sensors.org,
 Neelesh Gupta <neelegup@linux.vnet.ibm.com>, skiboot@lists.ozlabs.org,
 linuxppc-dev@lists.ozlabs.org, Jean Delvare <jdelvare@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 20, 2015 at 09:06:38AM +0100, Cedric Le Goater wrote:
> [ ... ] 
> 
> 
> > @@ -265,10 +261,17 @@ static int create_device_attrs(struct pl
> > 
> >  		sdata[count].id = sensor_id;
> >  		sdata[count].type = type;
> > -		err = create_hwmon_attr_name(&pdev->dev, type, np->name,
> > -					     sdata[count].name);
> > -		if (err)
> > +
> > +		attr_name = parse_opal_node_name(np->name, type, &opal_index);
> > +		if (IS_ERR(attr_name)) {
> > +			dev_err(&pdev->dev, "Sensor device node name '%s' is invalid\n",
> > +				np->name);
> > +			err = IS_ERR(attr_name);
>                               ^^^^^^
> 
> Arg. Bad copy/paste. This should be PTR_ERR() ... 
> 
> Do you want a full patchset resend or just a resend of this patch ? or a fix maybe.
> 
No need to resend; I fixed it up.

Thanks,
Guenter

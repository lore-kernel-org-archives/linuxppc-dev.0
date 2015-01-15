Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 842E41A0279
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 16:51:52 +1100 (AEDT)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Thu, 15 Jan 2015 15:51:50 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 0C03D2CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 16:51:49 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0F5pm4B45285512
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 16:51:48 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0F5pmX1023694
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 16:51:48 +1100
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: Ryan Grimm <grimm@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/3] CXL: Add reset to sysfs
In-reply-to: <1421290601-3293-3-git-send-email-grimm@linux.vnet.ibm.com>
References: <1421290601-3293-1-git-send-email-grimm@linux.vnet.ibm.com>
 <1421290601-3293-3-git-send-email-grimm@linux.vnet.ibm.com>
Date: Thu, 15 Jan 2015 16:51:48 +1100
Message-Id: <1421300999-sup-3862@delenn.ozlabs.ibm.com>
Cc: mikey <mikey@neuling.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Excerpts from Ryan Grimm's message of 2015-01-15 13:56:41 +1100:
> +What:           /sys/class/cxl/<card>/reset
> +Date:           October 2014
> +Contact:        linuxppc-dev@lists.ozlabs.org
> +Description:    write only
> +                Writing 1 here will issue a PERST to card.

...

> +static ssize_t reset_adapter_store(struct device *device,
> +                   struct device_attribute *attr,
> +                   const char *buf, size_t count)
> +{
> +    struct cxl *adapter = to_cxl_adapter(device);
> +    int rc;
> +
> +    if ((rc = cxl_reset(adapter)))
> +        return rc;
> +    return count;
> +}

Looks like we reset the card no matter what is written to that file?

I like the description better - add a test here to match what it says.

Cheers,
-Ian

Return-Path: <ego@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7C0E31A0D83
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 22:13:11 +1100 (AEDT)
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C921A1402C0
 for <linuxppc-dev@ozlabs.org>; Tue, 12 Jan 2016 22:13:10 +1100 (AEDT)
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Tue, 12 Jan 2016 04:13:08 -0700
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 2495B1FF0046
 for <linuxppc-dev@ozlabs.org>; Tue, 12 Jan 2016 04:01:17 -0700 (MST)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0CBD6gF23134292
 for <linuxppc-dev@ozlabs.org>; Tue, 12 Jan 2016 11:13:06 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0CBD46W006905
 for <linuxppc-dev@ozlabs.org>; Tue, 12 Jan 2016 06:13:05 -0500
Date: Tue, 12 Jan 2016 16:43:01 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
 viresh.kumar@linaro.org, linux-pm@vger.kernel.org, pc@us.ibm.com,
 anton@samba.org, ego@linux.vnet.ibm.com, shreyas@linux.vnet.ibm.com
Subject: Re: [PATCH RESEND v4 4/4] cpufreq: powernv: Add sysfs attributes to
 show throttle stats
Message-ID: <20160112111301.GB4187@in.ibm.com>
Reply-To: ego@linux.vnet.ibm.com
References: <1452594267-12844-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1452594267-12844-5-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1452594267-12844-5-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Shilpa,

On Tue, Jan 12, 2016 at 04:24:27AM -0600, Shilpasri G Bhat wrote:

> +static inline int get_chip_index(struct kobject *kobj)

Probably have "get_chip_index(int id)". See the reason below.
> +{
> +	int i, id;
> +
> +	i = kstrtoint(kobj->name + 4, 0, &id);
> +	if (i)
> +		return i;
> +
> +	for (i = 0; i < nr_chips; i++)
> +		if (chips[i].id == id)
> +			return i;

This pattern to obtain a chip index from the chip id is repeated in
multiple place inside this file. Might be worthwhile to move this to a
helper function, i.e get_chip_index(id)!

> +	return -EINVAL;
> +}
> +
> +static ssize_t throttle_freq_show(struct kobject *kobj,
> +				  struct kobj_attribute *attr, char *buf)
> +{
> +	int i, count = 0, id;
> + 
        We obtain the id from kobj here and then obtain the index from
	id via the function below.
	

> +	id = get_chip_index(kobj);


> +	if (id < 0)
> +		return id;
> +
> +	for (i = 0; i < powernv_pstate_info.nr_pstates; i++)
> +		count += sprintf(&buf[count], "%d %d\n",
> +			       powernv_freqs[i].frequency,
> +			       chips[id].pstate_stat[i]);
> +
> +	return count;
> +}
> +
> +static struct kobj_attribute attr_throttle_frequencies =
> +__ATTR(throttle_frequencies, 0444, throttle_freq_show, NULL);
> +
--
Thanks and Regards
gautham.

Return-Path: <brking@linux.vnet.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 13096B7CEA
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 24 Feb 2010 11:05:36 +1100 (EST)
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by e5.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o1NNpuGc017090
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2010 18:51:56 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o1O05Xwm108316
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2010 19:05:33 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o1O05XvR019171
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2010 19:05:33 -0500
Message-ID: <4B846D56.2050100@linux.vnet.ibm.com>
Date: Tue, 23 Feb 2010 18:05:42 -0600
From: Brian King <brking@linux.vnet.ibm.com>
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 3/4] Provide VIO modalias
References: <20100205133552.GF12001@hansolo.jdub.homelinux.org>
	<20100205135354.GI12001@hansolo.jdub.homelinux.org>
	<1266929400.30247.2585.camel@macbook.infradead.org>
In-Reply-To: <1266929400.30247.2585.camel@macbook.infradead.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/23/2010 06:50 AM, David Woodhouse wrote:
>> +static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
>> +			     char *buf)
>> +{
>> +	const struct vio_dev *vio_dev = to_vio_dev(dev);
>> +	struct device_node *dn;
>> +	const char *cp;
>> +
>> +	dn = dev->archdata.of_node;
>> +	if (!dn)
>> +		return -ENODEV;
>> +	cp = of_get_property(dn, "compatible", NULL);
>> +	if (!cp)
>> +		return -ENODEV;
>> +
>> +	return sprintf(buf, "vio:T%sS%s\n", vio_dev->type, cp);
>> +}
>> +
>>  static struct device_attribute vio_dev_attrs[] = {
>>  	__ATTR_RO(name),
>>  	__ATTR_RO(devspec),
>> +	__ATTR_RO(modalias),
>>  	__ATTR_NULL
>>  };

You'll want to add this to vio_cmo_dev_attrs as well, as that is the
device attribute array that gets used when active memory sharing is enabled.

Thanks,

Brian

-- 
Brian King
Linux on Power Virtualization
IBM Linux Technology Center

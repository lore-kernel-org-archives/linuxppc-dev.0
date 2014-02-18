Return-Path: <turtle.in.the.kernel@gmail.com>
Received: from mail-qc0-x22a.google.com (mail-qc0-x22a.google.com
 [IPv6:2607:f8b0:400d:c01::22a])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 649FC2C01AB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Feb 2014 10:28:38 +1100 (EST)
Received: by mail-qc0-f170.google.com with SMTP id e9so26811150qcy.15
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Feb 2014 15:28:33 -0800 (PST)
Message-ID: <5303EC9E.7070507@gmail.com>
Date: Tue, 18 Feb 2014 15:28:30 -0800
From: Tyrel Datwyler <turtle.in.the.kernel@gmail.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@au1.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 3/3] powerpc/pseries: Report in kernel device tree
 update to drmgr
References: <1391212692-16217-1-git-send-email-tyreld@linux.vnet.ibm.com>
 <1391212692-16217-4-git-send-email-tyreld@linux.vnet.ibm.com>
 <1392596560.24061.12.camel@pasglop>
In-Reply-To: <1392596560.24061.12.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1
Cc: nfont@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/16/2014 04:22 PM, Benjamin Herrenschmidt wrote:
> On Fri, 2014-01-31 at 15:58 -0800, Tyrel Datwyler wrote:
>> Traditionally it has been drmgr's responsibilty to update the device tree
>> through the /proc/ppc64/ofdt interface after a suspend/resume operation.
>> This patchset however has modified suspend/resume ops to preform that update
>> entirely in the kernel during the resume. Therefore, a mechanism is required
>> for drmgr to determine who is responsible for the update. This patch adds a
>> show function to the "hibernate" attribute that returns 1 if the kernel
>> updates the device tree after the resume and 0 if drmgr is responsible.
> 
> This is not right.
> 
> We cannot change the kernel behaviour in a way that is incompatible with
> existing userspace, and unless you can explain me why that is not the
> case, it feels like this patch set does just that ....
> 
> What happens if you have an older drmgr which still does the update
> itself ?
> 

In this case we get a double update which I clearly neglected to mention
in the patch. The first patch in this series actually removes an
unnecessary double update from the existing kernel implementation. The
same information is returned by the update-nodes/properties call the
second time around and aside from being a waste of a few cycles is harmless.

Tyrel

> You can't just change user visible behaviours and interface without at
> least explaining why it's ok to do so at the very least (and ensuring
> that of course) without breaking existing userspace.
> 
> Now it's possible that the double update caused by this series is
> harmless, in which case please explain it in the changeset, I certainly
> can't assume it and if it's not, you'll need some other way for drmgr to
> signal the kernel to indicate it supports the new behaviour before you
> enable it.
> 
> Ben.
> 
>> Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/platforms/pseries/suspend.c | 25 ++++++++++++++++++++++++-
>>  1 file changed, 24 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/platforms/pseries/suspend.c b/arch/powerpc/platforms/pseries/suspend.c
>> index 1d9c580..b87b978 100644
>> --- a/arch/powerpc/platforms/pseries/suspend.c
>> +++ b/arch/powerpc/platforms/pseries/suspend.c
>> @@ -192,7 +192,30 @@ out:
>>  	return rc;
>>  }
>>  
>> -static DEVICE_ATTR(hibernate, S_IWUSR, NULL, store_hibernate);
>> +#define USER_DT_UPDATE	0
>> +#define KERN_DT_UPDATE	1
>> +
>> +/**
>> + * show_hibernate - Report device tree update responsibilty
>> + * @dev:		subsys root device
>> + * @attr:		device attribute struct
>> + * @buf:		buffer
>> + *
>> + * Report whether a device tree update is performed by the kernel after a
>> + * resume, or if drmgr must coordinate the update from user space.
>> + *
>> + * Return value:
>> + *	0 if drmgr is to initiate update, and 1 otherwise
>> + **/
>> +static ssize_t show_hibernate(struct device *dev,
>> +			      struct device_attribute *attr,
>> +			      char *buf)
>> +{
>> +	return sprintf(buf, "%d\n", KERN_DT_UPDATE);
>> +}
>> +
>> +static DEVICE_ATTR(hibernate, S_IWUSR | S_IRUGO,
>> +		   show_hibernate, store_hibernate);
>>  
>>  static struct bus_type suspend_subsys = {
>>  	.name = "power",
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 

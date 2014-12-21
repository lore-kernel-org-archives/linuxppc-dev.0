Return-Path: <rickard.strandqvist@spectrumdigital.se>
Received: from mail-la0-f47.google.com (mail-la0-f47.google.com
 [209.85.215.47])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CAC0E1A00A5
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Dec 2014 23:46:41 +1100 (AEDT)
Received: by mail-la0-f47.google.com with SMTP id hz20so2898261lab.34
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Dec 2014 04:46:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1419134735.27324.41.camel@neuling.org>
References: <1419092024-6701-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
 <1419134735.27324.41.camel@neuling.org>
From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Date: Sun, 21 Dec 2014 13:46:16 +0100
Message-ID: <CAFo99ga9TYf5hnwOcoRPKsTHhhknoz6_axzP7spe0mvd=YPMLw@mail.gmail.com>
Subject: Re: [PATCH] misc: cxl: sysfs.c: Remove unused function
To: Michael Neuling <mikey@neuling.org>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org, Ian Munsie <imunsie@au1.ibm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2014-12-21 5:05 GMT+01:00 Michael Neuling <mikey@neuling.org>:
>> Remove the function mmio_size_show() that is not used anywhere.
>
> Did you compile check this patch?
>
>   drivers/misc/cxl/sysfs.c:291:74: error: =E2=80=98mmio_size_show=E2=80=
=99 undeclared here (not in a function)
>
> It's used here:
>         static struct device_attribute afu_attrs[] =3D {
>                 __ATTR_RO(mmio_size),
>
>> This was partially found by using a static code analysis program called =
cppcheck.
>
> Thanks for letting me know which tool to avoid :-)
>
> Mikey
>
>
>>
>> Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.=
se>
>> ---
>>  drivers/misc/cxl/sysfs.c |   11 -----------
>>  1 file changed, 11 deletions(-)
>>
>> diff --git a/drivers/misc/cxl/sysfs.c b/drivers/misc/cxl/sysfs.c
>> index ce7ec06..0431ec3 100644
>> --- a/drivers/misc/cxl/sysfs.c
>> +++ b/drivers/misc/cxl/sysfs.c
>> @@ -102,17 +102,6 @@ static struct device_attribute afu_master_attrs[] =
=3D {
>>
>>  /*********  AFU attributes  *******************************************=
*******/
>>
>> -static ssize_t mmio_size_show(struct device *device,
>> -                           struct device_attribute *attr,
>> -                           char *buf)
>> -{
>> -     struct cxl_afu *afu =3D to_cxl_afu(device);
>> -
>> -     if (afu->pp_size)
>> -             return scnprintf(buf, PAGE_SIZE, "%llu\n", afu->pp_size);
>> -     return scnprintf(buf, PAGE_SIZE, "%llu\n", afu->adapter->ps_size);
>> -}
>> -
>>  static ssize_t reset_store_afu(struct device *device,
>>                              struct device_attribute *attr,
>>                              const char *buf, size_t count)
>


Hi

Sorry about that.

Strange because I compile everything as allyesconfig, allmodconfig and
allnoconfig.

Kind regards
Rickard Strandqvist

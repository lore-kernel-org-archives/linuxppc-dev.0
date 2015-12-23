Return-Path: <kda@linux-powerpc.org>
Received: from mail-yk0-x22b.google.com (mail-yk0-x22b.google.com
 [IPv6:2607:f8b0:4002:c07::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B390C1A0AB3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Dec 2015 23:16:41 +1100 (AEDT)
Received: by mail-yk0-x22b.google.com with SMTP id x184so193965516yka.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Dec 2015 04:16:41 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20151223084548.GW3011@voom.redhat.com>
References: <1450761298-12172-1-git-send-email-david@gibson.dropbear.id.au>
 <1450761298-12172-4-git-send-email-david@gibson.dropbear.id.au>
 <CAOJe8K3U-wF-kMXWwXnR=fPf0UCVfaLnqLOBfXCJFHEcpoXy5A@mail.gmail.com>
 <20151223084548.GW3011@voom.redhat.com>
Date: Wed, 23 Dec 2015 15:16:39 +0300
Message-ID: <CAOJe8K26k9+iAw1RM2oVCn=gYMCDgfWNhbGJT+kQ=VwM2kXz=A@mail.gmail.com>
Subject: Re: [RFC 3/3] pseries: sysfs hack to trigger a hash page table resize
From: Denis Kirjanov <kda@linux-powerpc.org>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: paulus@samba.org, benh@kernel.crashing.org, bharata@linux.vnet.ibm.com,
 lvivier@redhat.com, thuth@redhat.com, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/23/15, David Gibson <david@gibson.dropbear.id.au> wrote:
> On Tue, Dec 22, 2015 at 02:19:20PM +0300, Denis Kirjanov wrote:
>> On 12/22/15, David Gibson <david@gibson.dropbear.id.au> wrote:
>> > This patch adds a special file in /sys/kernel/mm which can be used to
>> > view
>> > the current size of the hash page table (as a bit shift) and to trigger
>> > a resize of the hash table on PAPR guests.
>> >
>> > Logically this would make more sense as a debugfs file, but that
>> > doesn't
>> > see to provide an obvious way to have a "store" function that has an
>> > effect
>> > other than updating a variable.
>> >
>> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>> > ---
>> >  arch/powerpc/platforms/pseries/lpar.c | 41
>> > +++++++++++++++++++++++++++++++++++
>> >  1 file changed, 41 insertions(+)
>> >
>> > diff --git a/arch/powerpc/platforms/pseries/lpar.c
>> > b/arch/powerpc/platforms/pseries/lpar.c
>> > index aadb242..2759767 100644
>> > --- a/arch/powerpc/platforms/pseries/lpar.c
>> > +++ b/arch/powerpc/platforms/pseries/lpar.c
>> > @@ -903,3 +903,44 @@ int pSeries_lpar_resize_hpt(unsigned long shift)
>> >
>> >  	return 0;
>> >  }
>> > +
>> > +static ssize_t ppc64_pft_size_show(struct kobject *kobj,
>> > +				   struct kobj_attribute *attr, char *buf)
>> > +{
>> > +	return sprintf(buf, "%llu\n", (unsigned long long)ppc64_pft_size);
>> > +}
>> > +
>> > +static ssize_t ppc64_pft_size_store(struct kobject *kobj,
>> > +				    struct kobj_attribute *attr,
>> > +				    const char *buf, size_t count)
>> > +{
>> > +	unsigned long new_shift;
>> > +	int rc;
>> > +
>> > +	pr_err("lpar: ppc64_pft_size_store() count=%zd\n", count);
>> Why pr_err?
>
> Uh.. good question.  That's a not particularly useful debug comment I
> should just remove anyway.
>
>> > +
>> > +	if (kstrtoul(buf, 0, &new_shift))
>> > +		return -EINVAL;
>> > +
>> > +	rc = pSeries_lpar_resize_hpt(new_shift);
>> > +	if (rc < 0)
>> > +		return rc;
>> > +
>> > +	return count;
>> > +}
>> > +
>> > +static struct kobj_attribute ppc64_pft_size_attr =
>> > +	__ATTR(ppc64_pft_size, 0600, ppc64_pft_size_show,
>> > ppc64_pft_size_store);
>> > +
>> > +static int __init pseries_lpar_sysfs(void)
>> > +{
>> > +	int rc;
>> > +
>> > +	rc = sysfs_create_file(mm_kobj, &ppc64_pft_size_attr.attr);
>> > +	if (rc)
>> > +		pr_err("lpar: unable to create ppc64_pft_size sysfs file (%d)\n",
>> > +		       rc);
>> > +
>> > +	return 0;
>> I think that we need to return rc value, right?
>
> No.  Failing to register this sysfs file shouldn't cause the boot to fail.
Then we don't need rc at all ;)
>
>> > +}
>> > +machine_device_initcall(pseries, pseries_lpar_sysfs);
>> >
>> > _______________________________________________
>> > Linuxppc-dev mailing list
>> > Linuxppc-dev@lists.ozlabs.org
>> > https://lists.ozlabs.org/listinfo/linuxppc-dev
>>
>
> --
> David Gibson			| I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
> 				| _way_ _around_!
> http://www.ozlabs.org/~dgibson
>

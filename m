Return-Path: <sudeep.holla@arm.com>
Received: from service87.mimecast.com (service87.mimecast.com [91.220.42.44])
 by lists.ozlabs.org (Postfix) with ESMTP id 3659C1A017D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jul 2014 23:36:10 +1000 (EST)
Message-ID: <53BE9713.8090700@arm.com>
Date: Thu, 10 Jul 2014 14:37:23 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
MIME-Version: 1.0
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/9] drivers: base: support cpu cache information interface
 to userspace via sysfs
References: <1403717444-23559-1-git-send-email-sudeep.holla@arm.com>
 <1403717444-23559-3-git-send-email-sudeep.holla@arm.com>
 <20140710000905.GA18025@kroah.com>
In-Reply-To: <20140710000905.GA18025@kroah.com>
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Cc: Rob Herring <robh@kernel.org>,
 Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Sudeep Holla <sudeep.holla@arm.com>,
 "linux390@de.ibm.com" <linux390@de.ibm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Greg,

Thanks for reviewing this.

On 10/07/14 01:09, Greg Kroah-Hartman wrote:
> On Wed, Jun 25, 2014 at 06:30:37PM +0100, Sudeep Holla wrote:
>> +static const struct device_attribute *cache_optional_attrs[] =3D {
>> +=09&dev_attr_coherency_line_size,
>> +=09&dev_attr_ways_of_associativity,
>> +=09&dev_attr_number_of_sets,
>> +=09&dev_attr_size,
>> +=09&dev_attr_attributes,
>> +=09&dev_attr_physical_line_partition,
>> +=09NULL
>> +};
>> +
>> +static int device_add_attrs(struct device *dev,
>> +=09=09=09    const struct device_attribute **dev_attrs)
>> +{
>> +=09int i, error =3D 0;
>> +=09struct device_attribute *dev_attr;
>> +=09char *buf;
>> +
>> +=09if (!dev_attrs)
>> +=09=09return 0;
>> +
>> +=09buf =3D kmalloc(PAGE_SIZE, GFP_KERNEL);
>> +=09if (!buf)
>> +=09=09return -ENOMEM;
>> +
>> +=09for (i =3D 0; dev_attrs[i]; i++) {
>> +=09=09dev_attr =3D (struct device_attribute *)dev_attrs[i];
>> +
>> +=09=09/* create attributes that provides meaningful value */
>> +=09=09if (dev_attr->show(dev, dev_attr, buf) < 0)
>> +=09=09=09continue;
>> +
>> +=09=09error =3D device_create_file(dev, dev_attrs[i]);
>> +=09=09if (error) {
>> +=09=09=09while (--i >=3D 0)
>> +=09=09=09=09device_remove_file(dev, dev_attrs[i]);
>> +=09=09=09break;
>> +=09=09}
>> +=09}
>> +
>> +=09kfree(buf);
>> +=09return error;
>> +}
>
> Ick, why create your own function for this when the driver core has this
> functionality built into it?  Look at the is_visible() callback, and how
> it is use for an attribute group please.
>

I agree even I added this function hesitantly as didn't realize that I can =
use
is_visible for this purpose. Thanks for pointing that out I will have a loo=
k
at it.

>> +static void device_remove_attrs(struct device *dev,
>> +=09=09=09=09const struct device_attribute **dev_attrs)
>> +{
>> +=09int i;
>> +
>> +=09if (!dev_attrs)
>> +=09=09return;
>> +
>> +=09for (i =3D 0; dev_attrs[i]; dev_attrs++, i++)
>> +=09=09device_remove_file(dev, dev_attrs[i]);
>> +}
>
> You should just remove a whole group at once, not individually.
>

Right, I must be able to get rid of these 2 functions once I use
is_visible callback.

>> +
>> +const struct device_attribute **
>> +__weak cache_get_priv_attr(struct device *cache_idx_dev)
>> +{
>> +=09return NULL;
>> +}
>> +
>> +/* Add/Remove cache interface for CPU device */
>> +static void cpu_cache_sysfs_exit(unsigned int cpu)
>> +{
>> +=09int i;
>> +=09struct device *tmp_dev;
>> +=09const struct device_attribute **ci_priv_attr;
>> +
>> +=09if (per_cpu_index_dev(cpu)) {
>> +=09=09for (i =3D 0; i < cache_leaves(cpu); i++) {
>> +=09=09=09tmp_dev =3D per_cache_index_dev(cpu, i);
>> +=09=09=09if (!tmp_dev)
>> +=09=09=09=09continue;
>> +=09=09=09ci_priv_attr =3D cache_get_priv_attr(tmp_dev);
>> +=09=09=09device_remove_attrs(tmp_dev, ci_priv_attr);
>> +=09=09=09device_remove_attrs(tmp_dev, cache_optional_attrs);
>> +=09=09=09device_unregister(tmp_dev);
>> +=09=09}
>> +=09=09kfree(per_cpu_index_dev(cpu));
>> +=09=09per_cpu_index_dev(cpu) =3D NULL;
>> +=09}
>> +=09device_unregister(per_cpu_cache_dev(cpu));
>> +=09per_cpu_cache_dev(cpu) =3D NULL;
>> +}
>> +
>> +static int cpu_cache_sysfs_init(unsigned int cpu)
>> +{
>> +=09struct device *dev =3D get_cpu_device(cpu);
>> +
>> +=09if (per_cpu_cacheinfo(cpu) =3D=3D NULL)
>> +=09=09return -ENOENT;
>> +
>> +=09per_cpu_cache_dev(cpu) =3D device_create(dev->class, dev, cpu,
>> +=09=09=09=09=09       NULL, "cache");
>> +=09if (IS_ERR_OR_NULL(per_cpu_cache_dev(cpu)))
>> +=09=09return PTR_ERR(per_cpu_cache_dev(cpu));
>> +
>> +=09/* Allocate all required memory */
>> +=09per_cpu_index_dev(cpu) =3D kzalloc(sizeof(struct device *) *
>> +=09=09=09=09=09 cache_leaves(cpu), GFP_KERNEL);
>> +=09if (unlikely(per_cpu_index_dev(cpu) =3D=3D NULL))
>> +=09=09goto err_out;
>> +
>> +=09return 0;
>> +
>> +err_out:
>> +=09cpu_cache_sysfs_exit(cpu);
>> +=09return -ENOMEM;
>> +}
>> +
>> +static int cache_add_dev(unsigned int cpu)
>> +{
>> +=09unsigned short i;
>> +=09int rc;
>> +=09struct device *tmp_dev, *parent;
>> +=09struct cacheinfo *this_leaf;
>> +=09const struct device_attribute **ci_priv_attr;
>> +=09struct cpu_cacheinfo *this_cpu_ci =3D get_cpu_cacheinfo(cpu);
>> +
>> +=09rc =3D cpu_cache_sysfs_init(cpu);
>> +=09if (unlikely(rc < 0))
>> +=09=09return rc;
>> +
>> +=09parent =3D per_cpu_cache_dev(cpu);
>> +=09for (i =3D 0; i < cache_leaves(cpu); i++) {
>> +=09=09this_leaf =3D this_cpu_ci->info_list + i;
>> +=09=09if (this_leaf->disable_sysfs)
>> +=09=09=09continue;
>> +=09=09tmp_dev =3D device_create_with_groups(parent->class, parent, i,
>> +=09=09=09=09=09=09    this_leaf,
>> +=09=09=09=09=09=09    cache_default_groups,
>> +=09=09=09=09=09=09    "index%1u", i);
>> +=09=09if (IS_ERR_OR_NULL(tmp_dev)) {
>> +=09=09=09rc =3D PTR_ERR(tmp_dev);
>> +=09=09=09goto err;
>> +=09=09}
>> +
>> +=09=09rc =3D device_add_attrs(tmp_dev, cache_optional_attrs);
>> +=09=09if (unlikely(rc))
>> +=09=09=09goto err;
>> +
>> +=09=09ci_priv_attr =3D cache_get_priv_attr(tmp_dev);
>> +=09=09rc =3D device_add_attrs(tmp_dev, ci_priv_attr);
>> +=09=09if (unlikely(rc))
>> +=09=09=09goto err;
>
> You just raced with userspace here, creating these files _after_ the
> device was announced to userspace, causing problems with anyone wanting
> to read these attributes :(
>
> I think if you fix up the is_visible() thing above, these calls will go
> away, right?
>

Yes I agree.

Regards,
Sudeep

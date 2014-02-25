Return-Path: <cody@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B8D242C00AC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Feb 2014 07:55:43 +1100 (EST)
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cody@linux.vnet.ibm.com>;
 Tue, 25 Feb 2014 13:55:40 -0700
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id EB6C319D8045
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Feb 2014 13:55:37 -0700 (MST)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by b03cxnp08025.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1PKtdZq10551710
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Feb 2014 21:55:39 +0100
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 s1PKx6ul019677
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Feb 2014 13:59:06 -0700
Message-ID: <530D033C.5080800@linux.vnet.ibm.com>
Date: Tue, 25 Feb 2014 12:55:24 -0800
From: Cody P Schafer <cody@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>,
 Linux PPC <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v2 09/11] powerpc/perf: add support for the hv 24x7
 interface
References: <20140225033329.BBB492C033B@ozlabs.org>
In-Reply-To: <20140225033329.BBB492C033B@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>,
 LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Paul Mackerras <paulus@samba.org>,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/24/2014 07:33 PM, Michael Ellerman wrote:
> On Fri, 2014-14-02 at 22:02:13 UTC, Cody P Schafer wrote:
>> This provides a basic interface between hv_24x7 and perf. Similar to
>> the one provided for gpci, it lacks transaction support and does not
>> list any events.
>>
>> Signed-off-by: Cody P Schafer <cody@linux.vnet.ibm.com>
>> ---
>>   arch/powerpc/perf/hv-24x7.c | 491 ++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 491 insertions(+)
>>   create mode 100644 arch/powerpc/perf/hv-24x7.c
>>
>> diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
>> new file mode 100644
>> index 0000000..13de140
>> --- /dev/null
>> +++ b/arch/powerpc/perf/hv-24x7.c
> ...
>> +
>> +/*
>> + * read_offset_data - copy data from one buffer to another while treating the
>> + *                    source buffer as a small view on the total avaliable
>> + *                    source data.
>> + *
>> + * @dest: buffer to copy into
>> + * @dest_len: length of @dest in bytes
>> + * @requested_offset: the offset within the source data we want. Must be > 0
>> + * @src: buffer to copy data from
>> + * @src_len: length of @src in bytes
>> + * @source_offset: the offset in the sorce data that (src,src_len) refers to.
>> + *                 Must be > 0
>> + *
>> + * returns the number of bytes copied.
>> + *
>> + * '.' areas in d are written to.
>> + *
>> + *                       u
>> + *   x         w	 v  z
>> + * d           |.........|
>> + * s |----------------------|
>> + *
>> + *                      u
>> + *   x         w	z     v
>> + * d           |........------|
>> + * s |------------------|
>> + *
>> + *   x         w        u,z,v
>> + * d           |........|
>> + * s |------------------|
>> + *
>> + *   x,w                u,v,z
>> + * d |------------------|
>> + * s |------------------|
>> + *
>> + *   x        u
>> + *   w        v		z
>> + * d |........|
>> + * s |------------------|
>> + *
>> + *   x      z   w      v
>> + * d            |------|
>> + * s |------|
>> + *
>> + * x = source_offset
>> + * w = requested_offset
>> + * z = source_offset + src_len
>> + * v = requested_offset + dest_len
>> + *
>> + * w_offset_in_s = w - x = requested_offset - source_offset
>> + * z_offset_in_s = z - x = src_len
>> + * v_offset_in_s = v - x = request_offset + dest_len - src_len
>> + * u_offset_in_s = min(z_offset_in_s, v_offset_in_s)
>> + *
>> + * copy_len = u_offset_in_s - w_offset_in_s = min(z_offset_in_s, v_offset_in_s)
>> + *						- w_offset_in_s
>
> Comments are great, especially for complicated code like this. But at a glance
> I don't actually understand what this comment is trying to tell me.

The function was composed via some number line logic. The comment tries 
to explain what that logic is. The ascii art is various overlapping 
buffers that we're copying between (the '+'s from the patch are messing 
with the indenting some of the labels). The only major omission I'm 
seeing is I failed to note that d=dest and s=src (though this could be 
inferred from the comment about '.' indicating a write).

Is there anything specific That doesn't make sense in the comment? (it 
may not be a comment that really can be read at a glance).

>
>> + */
>> +static ssize_t read_offset_data(void *dest, size_t dest_len,
>> +				loff_t requested_offset, void *src,
>> +				size_t src_len, loff_t source_offset)
>> +{
>> +	size_t w_offset_in_s = requested_offset - source_offset;
>> +	size_t z_offset_in_s = src_len;
>> +	size_t v_offset_in_s = requested_offset + dest_len - src_len;
>> +	size_t u_offset_in_s = min(z_offset_in_s, v_offset_in_s);
>> +	size_t copy_len = u_offset_in_s - w_offset_in_s;
>> +
>> +	if (requested_offset < 0 || source_offset < 0)
>> +		return -EINVAL;
>> +
>> +	if (z_offset_in_s <= w_offset_in_s)
>> +		return 0;
>> +
>> +	memcpy(dest, src + w_offset_in_s, copy_len);
>> +	return copy_len;
>> +}
>> +
>> +static unsigned long h_get_24x7_catalog_page(char page[static 4096],
>> +					     u32 version, u32 index)
>> +{
>> +	WARN_ON(!IS_ALIGNED((unsigned long)page, 4096));
>> +	return plpar_hcall_norets(H_GET_24X7_CATALOG_PAGE,
>> +			virt_to_phys(page),
>> +			version,
>> +			index);
>> +}
>> +
>> +static ssize_t catalog_read(struct file *filp, struct kobject *kobj,
>> +			    struct bin_attribute *bin_attr, char *buf,
>> +			    loff_t offset, size_t count)
>> +{
>> +	unsigned long hret;
>> +	ssize_t ret = 0;
>> +	size_t catalog_len = 0, catalog_page_len = 0, page_count = 0;
>> +	loff_t page_offset = 0;
>> +	uint32_t catalog_version_num = 0;
>> +	void *page = kmalloc(4096, GFP_USER);
>> +	struct hv_24x7_catalog_page_0 *page_0 = page;
>> +	if (!page)
>> +		return -ENOMEM;
>> +
>> +
>> +	hret = h_get_24x7_catalog_page(page, 0, 0);
>> +	if (hret) {
>> +		ret = -EIO;
>> +		goto e_free;
>> +	}
>> +
>> +	catalog_version_num = be32_to_cpu(page_0->version);
>> +	catalog_page_len = be32_to_cpu(page_0->length);
>> +	catalog_len = catalog_page_len * 4096;
>> +
>> +	page_offset = offset / 4096;
>> +	page_count  = count  / 4096;
>> +
>> +	if (page_offset >= catalog_page_len)
>> +		goto e_free;
>> +
>> +	if (page_offset != 0) {
>> +		hret = h_get_24x7_catalog_page(page, catalog_version_num,
>> +					       page_offset);
>> +		if (hret) {
>> +			ret = -EIO;
>> +			goto e_free;
>> +		}
>> +	}
>> +
>> +	ret = read_offset_data(buf, count, offset,
>> +				page, 4096, page_offset * 4096);
>> +e_free:
>> +	if (hret)
>> +		pr_err("h_get_24x7_catalog_page(ver=%d, page=%lld) failed: rc=%ld\n",
>> +				catalog_version_num, page_offset, hret);
>> +	kfree(page);
>> +
>> +	pr_devel("catalog_read: offset=%lld(%lld) count=%zu(%zu) catalog_len=%zu(%zu) => %zd\n",
>> +			offset, page_offset, count, page_count, catalog_len,
>> +			catalog_page_len, ret);
>> +
>> +	return ret;
>> +}
>> +
>> +#define PAGE_0_ATTR(_name, _fmt, _expr)				\
>> +static ssize_t _name##_show(struct device *dev,			\
>> +			    struct device_attribute *dev_attr,	\
>> +			    char *buf)				\
>> +{								\
>> +	unsigned long hret;					\
>> +	ssize_t ret = 0;					\
>> +	void *page = kmalloc(4096, GFP_USER);			\
>> +	struct hv_24x7_catalog_page_0 *page_0 = page;		\
>> +	if (!page)						\
>> +		return -ENOMEM;					\
>> +	hret = h_get_24x7_catalog_page(page, 0, 0);		\
>> +	if (hret) {						\
>> +		ret = -EIO;					\
>> +		goto e_free;					\
>> +	}							\
>> +	ret = sprintf(buf, _fmt, _expr);			\
>> +e_free:								\
>> +	kfree(page);						\
>> +	return ret;						\
>> +}								\
>> +static DEVICE_ATTR_RO(_name)
>> +
>> +PAGE_0_ATTR(catalog_version, "%lld\n",
>> +		(unsigned long long)be32_to_cpu(page_0->version));
>> +PAGE_0_ATTR(catalog_len, "%lld\n",
>> +		(unsigned long long)be32_to_cpu(page_0->length) * 4096);
>> +static BIN_ATTR_RO(catalog, 0/* real length varies */);
>
> So we're dumping the catalog out as a binary blob.

Yep

> Why do we want to do that?

Right now it's the only way to know what events are available. 
Additionally, even when the kernel starts parsing events out (and 
exposing them via sysfs), there is some additional powerpc specific 
structuring ("groups" and "schemas" that some userspace applications may 
want to take advantage of.

> It clearly violates the sysfs rule-of-sorts of ASCII and one value per file.
> Obviously there can be exceptions, but what's our justification?

Actual justification is above, but additionally:
I actually was looking at the acpi code that provides (among other 
binary tables) the dsdt as a binary blob in sysfs when I was putting 
this code together. The 24x7 catalog is, in the same manner, a binary 
blob provided by firmware.

>> +static struct bin_attribute *if_bin_attrs[] = {
>> +	&bin_attr_catalog,
>> +	NULL,
>> +};
>> +
>> +static struct attribute *if_attrs[] = {
>> +	&dev_attr_catalog_len.attr,
>> +	&dev_attr_catalog_version.attr,
>> +	NULL,
>> +};
>> +
>> +static struct attribute_group if_group = {
>> +	.name = "interface",
>> +	.bin_attrs = if_bin_attrs,
>> +	.attrs = if_attrs,
>> +};
>
> Both pmus have an "interface" directory, but they don't seem to have anything
> in common? Its feels a little ad-hoc.

It is absolutely ad-hoc. The only similarity is that both groups named 
"interface" provide some additional details about the firmware interface 
they're using to provide the perf data. We could easily call them both 
"misc", "details", put all the attributes in the device root, or call 
them some other generic name. I ended up choosing "interface" because 
we're provided details on the firmware interface, and it feels just a 
bit less generic. Having device specific names for the attribute group 
("24x7" and "gpci", for example) doesn't get us anything because the 
devices themselves already have those names ("hv_24x7" and "hv_gpci"). I 
don't see any reason to make them different.

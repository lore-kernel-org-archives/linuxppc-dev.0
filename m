Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp04.au.ibm.com", Issuer "GeoTrust SSL CA" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id D0322B6F18
 for <linuxppc-dev@ozlabs.org>; Mon, 28 Nov 2011 17:21:39 +1100 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Mon, 28 Nov 2011 06:09:18 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pAS6I5Bo2973736
 for <linuxppc-dev@ozlabs.org>; Mon, 28 Nov 2011 17:18:05 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pAS6LTgO002085
 for <linuxppc-dev@ozlabs.org>; Mon, 28 Nov 2011 17:21:31 +1100
Message-ID: <4ED3285D.4060100@linux.vnet.ibm.com>
Date: Mon, 28 Nov 2011 11:51:17 +0530
From: "Mahesh J. Salgaonkar" <mahesh@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [RFC PATCH v5 2/9] fadump: Reserve the memory for firmware
 assisted dump.
References: <20111115151145.16533.16384.stgit@mars.in.ibm.com>
 <20111115151343.16533.70101.stgit@mars.in.ibm.com>
 <20111124230213.GC19828@bloggs.ozlabs.ibm.com>
In-Reply-To: <20111124230213.GC19828@bloggs.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Anton Blanchard <anton@samba.org>, Amerigo Wang <amwang@redhat.com>,
 Kexec-ml <kexec@lists.infradead.org>,
 Linux Kernel <linux-kernel@vger.kernel.org>, Milton Miller <miltonm@bga.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>, Randy Dunlap <rdunlap@xenotime.net>,
 "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>
Reply-To: mahesh.j.salgaonkar@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/25/2011 04:32 AM, Paul Mackerras wrote:
> On Tue, Nov 15, 2011 at 08:43:43PM +0530, Mahesh J Salgaonkar wrote:
>> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>>
>> Reserve the memory during early boot to preserve CPU state data, HPTE region
>> and RMR region data in case of kernel crash. At the time of crash, powerpc
>> firmware will store CPU state data, HPTE region data and move RMR region
>> data to the reserved memory area.
> 
> What is "RMR"?  I don't see anywhere that you explain this acronym.
> Is it the same as the RMA (real mode area)?
> 

Yes, it is the same as the RMA. I think I will replace all RMR/RMO with RMA.

>> +config FA_DUMP
>> +	bool "Firmware-assisted dump"
> 
> Is this new fadump infrastructure intended to supersede the existing
> phyp dump code?  Does it use the same phyp interfaces as phyp dump?
> If so, you should probably remove the phyp dump code and config option
> as the final patch in your series.
> 
>> +/*
>> + * The RMR region will be saved for later dumping when kernel crashes.
>> + * Set this to RMO size.
>> + */
>> +#define RMR_START	0x0
>> +#define RMR_END		(ppc64_rma_size)
> 
> An explanation of "RMR" here, and what the distinction (if any)
> between RMR and RMA/RMO is, would help future readers.
> 

Will change this to RMA_START and RMA_END

>> +	sections = of_get_flat_dt_prop(node, "ibm,configure-kernel-dump-sizes",
>> +					&size);
>> +
>> +	if (!sections)
>> +		return 0;
>> +
>> +	num_sections = size / sizeof(struct dump_section);
>> +
>> +	for (i = 0; i < num_sections; i++) {
>> +		switch (sections[i].dump_section) {
>> +		case FADUMP_CPU_STATE_DATA:
>> +			fw_dump.cpu_state_data_size = sections[i].section_size;
>> +			break;
>> +		case FADUMP_HPTE_REGION:
>> +			fw_dump.hpte_region_size = sections[i].section_size;
>> +			break;
> 
> It's generally better to use of_read_number() or of_read_ulong() to
> parse OF properties, rather than using a structure like this.
> 
>> +	/* divide by 20 to get 5% of value */
>> +	size = memblock_end_of_DRAM();
>> +	do_div(size, 20);
> 
> You could just say size = memblock_end_of_DRAM() / 20 here; no need to
> use do_div, since we won't be using this code on 32-bit platforms.
> 
>> +	if (!fw_dump.fadump_supported) {
>> +		printk(KERN_ERR "Firmware-assisted dump is not supported on"
>> +				" this hardware\n");
> 
> This shouldn't be KERN_ERR; it's not an error to boot a kernel with
> fadump configured in on a machine that doesn't have firmware fadump
> support.  I don't think we really need any message, but if we have one
> it should be KERN_INFO at most.
> 
>> +/* Look for fadump= cmdline option. */
>> +static int __init early_fadump_param(char *p)
>> +{
>> +	if (!p)
>> +		return 1;
>> +
>> +	if (p[0] == '1')
>> +		fw_dump.fadump_enabled = 1;
>> +	else if (p[0] == '0')
>> +		fw_dump.fadump_enabled = 0;
> 
> I think it's usual to allow "on" and "off" as values for this kind of
> option.  There might be a handy little helper function to parse this
> sort of thing (but if there is I don't know what it is called).

Will rework on your suggestions. Thanks for the review.

Thanks,
-Mahesh.

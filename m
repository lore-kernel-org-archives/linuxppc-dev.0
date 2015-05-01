Return-Path: <jk@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 361C81A0D10
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 May 2015 13:46:04 +1000 (AEST)
Message-ID: <5542F6FA.5020702@ozlabs.org>
Date: Fri, 01 May 2015 11:46:02 +0800
From: Jeremy Kerr <jk@ozlabs.org>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/powernv: Add opal-prd channel
References: <1427868428.289931.158677373296.1.gpush@pablo>
 <1430356826.17831.157.camel@kernel.crashing.org>
In-Reply-To: <1430356826.17831.157.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,

>> +static LIST_HEAD(opal_prd_msg_queue);
>> +static DEFINE_SPINLOCK(opal_prd_msg_queue_lock);
>> +static DECLARE_WAIT_QUEUE_HEAD(opal_prd_msg_wait);
>> +static atomic_t usage;
> 
> opal_prd_usage ... otherwise  it's a mess in the symbols map

OK, I'll change this.

> Also why limit the number of opens ? we might want to have tools using
> the opal prd for xscom :-) (in absence of debugfs). .. as long as not
> two people read() it should be ok. Or a tool to dump the regions etc...
> 
> I don't see any reason to block multiple open's.

Simplicity, really. We can do a "get exclusive", but there's no
(current) use-case for multiple openers on a PRD interface.

Pulling this thread a little, you've hit on a key decision point of the
prd design - I see there being two directions we could take with this:

 1) This interface is specifically for PRD functions, or

 2) This interface is a generic userspace interface to OPAL,
    and PRD is a subset of that.

I've been aiming for (1) with the current code; and the nature of the
generic read() & write() operations being PRD-specific enforces that.

Allowing multiple openers will help with (2), but if we want to go in
that direction, I think we'd be better off doing a couple of other
changes too:

 * move the general functions (eg xscom, range mappings, OCC control)
   to a separate interface that isn't tied to PRD - say just /dev/opal

 * using this prd code for only the prd-event handling, possibly
   renamed to /dev/opal-prd-events. This would still need some
   method of enforcing exclusive access.

In this case, the actual PRD application would use both devices,
dequeueing events (and updating the ipoll mask) from the latter, and
using the former for helper functionality.

Other tools (eg generic xscom access) would just use the generic
interface, and not the PRD one, which wouldn't enforce exclusive access.

Regardless of the choice here, we could also remove the single-open
exclusion, and shift that responsibility to userspace (eg, flock() on
the PRD device node?). The main reason for the exclusion is to prevent
multiple prd daemons running, which may get messy when updating the
ipoll mask.

> Should we rely exclusively on userspace setting the right permissions or
> should we check CAP_SYSADMIN here ?

I'm okay with relying on userspace, is there any reason not to?


>> +	vma->vm_page_prot = phys_mem_access_prot(file, vma->vm_pgoff,
>> +						 size, vma->vm_page_prot)
>> +				| _PAGE_SPECIAL;
>> +
>> +	rc = remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff, size,
>> +			vma->vm_page_prot);
> 
> Do we still have the warnings of process exist about the map count or is
> that fixed ?

No, not fixed at present. I'll need to chat to you about that.


>> +	case OPAL_PRD_SCOM_READ:
>> +		rc = copy_from_user(&scom, (void __user *)param, sizeof(scom));
>> +		if (rc)
>> +			return -EFAULT;
>> +
>> +		rc = opal_xscom_read(scom.chip, scom.addr,
>> +				(__be64 *)&scom.data);
> 
> Are we exporting these for modules ?

No, but opal-prd isn't configurable as a module at the moment.

> 
>> +		scom.data = be64_to_cpu(scom.data);
>> +		pr_debug("ioctl SCOM_READ: chip %llx addr %016llx "
>> +				"data %016llx rc %d\n",
>> +				scom.chip, scom.addr, scom.data, rc);
> 
> pr_devel ?

This removes the possibility of CONFIG_DYNAMIC_DEBUG, is that intentional?

> 
>> +		if (rc)
>> +			return -EIO;
> 
> Should we consider returning more info about the SCOM error ? HBRT might
> actually need that... Maybe opal_prd_scom needs a field for the OPAL rc
> which is currently not very descriptive but that's fixable.

Sounds good, I'll add that in. On error, we'll return -EIO and have the
OPAL error code in the struct for further detail.


>> +	nr_ranges = of_property_count_strings(np, "reserved-names");
>> +	ranges_prop = of_get_property(np, "reserved-ranges", NULL);
>> +	if (!ranges_prop) {
>> +		of_node_put(np);
>> +		return -ENODEV;
>> +	}
> 
> Didn't we say we had a problem with using those properties due to
> coalescing ? Shouldn't we define specific ones for the HBRT regions ?

There's not a problem at the moment, but one day we will need to expand
the PRD's get_reserved_mem interface to allow per-chip ranges. This
would use a different device-tree representation.

However, I think it'd be better to remove this code entirely (ie, remove
the range member of struct opal_prd_info), and require userspace to do
the device-tree parsing.

>> +static int __init opal_prd_init(void)
>> +{
>> +	int rc;
>> +
>> +	/* parse the code region information from the device tree */
>> +	rc = parse_regions();
>> +	if (rc) {
>> +		pr_err("Couldn't parse region information from DT\n");
>> +		return rc;
>> +	}
> 
> Should we create a virtual device under the OPAL node in FW so we have
> something to attach to ? That way we get module autoload as well...

Can do, if we want to support modules...

> 
>> +	rc = opal_message_notifier_register(OPAL_MSG_PRD, &opal_prd_event_nb);
>> +	if (rc) {
>> +		pr_err("Couldn't register event notifier\n");
>> +		return rc;
>> +	}
>> +
>> +	rc = misc_register(&opal_prd_dev);
>> +	if (rc) {
>> +		pr_err("failed to register miscdev\n");
>> +		return rc;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static void __exit opal_prd_exit(void)
>> +{
>> +	misc_deregister(&opal_prd_dev);
>> +	opal_message_notifier_unregister(OPAL_MSG_PRD, &opal_prd_event_nb);
>> +}
> 
> Shouldn't you deregister the notifier first ?

Yup, updated.

Cheers,


Jeremy

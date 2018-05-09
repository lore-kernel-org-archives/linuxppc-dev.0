Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40gzp65hxHzF2N5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 May 2018 00:51:42 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Sam Bobroff <sbobroff@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 13/13] powerpc/eeh: Refactor report functions
In-Reply-To: <20180507052354.GB18123@tungsten.ozlabs.ibm.com>
References: <cover.1525242772.git.sbobroff@linux.ibm.com>
 <313ced0e1c4f5140566846bb41f1c42c26c96a0b.1525242772.git.sbobroff@linux.ibm.com>
 <87efisamz3.fsf@concordia.ellerman.id.au>
 <20180507052354.GB18123@tungsten.ozlabs.ibm.com>
Date: Thu, 10 May 2018 00:51:39 +1000
Message-ID: <87fu30zxtw.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sam Bobroff <sbobroff@linux.ibm.com> writes:
> On Thu, May 03, 2018 at 11:27:12PM +1000, Michael Ellerman wrote:
>> Sam Bobroff <sbobroff@linux.ibm.com> writes:
>> > diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
>> > index eb4feee81ff4..1c4336dcf9f5 100644
>> > --- a/arch/powerpc/kernel/eeh_driver.c
>> > +++ b/arch/powerpc/kernel/eeh_driver.c
>> > @@ -54,6 +54,25 @@ static int eeh_result_priority(enum pci_ers_result result)
>> >  	}
>> >  };
>> >  
>> > +const char *pci_ers_result_name(enum pci_ers_result r)
>> > +{
>> > +	switch (r) {
>> > +	case PCI_ERS_RESULT_NONE: return "none";
>> > +	case PCI_ERS_RESULT_CAN_RECOVER: return "can recover";
>> > +	case PCI_ERS_RESULT_NEED_RESET: return "need reset";
>> > +	case PCI_ERS_RESULT_DISCONNECT: return "disconnect";
>> > +	case PCI_ERS_RESULT_RECOVERED: return "recovered";
>> > +	case PCI_ERS_RESULT_NO_AER_DRIVER: return "no AER driver";
>> > +	default:
>> > +		WARN_ONCE(1, "Unknown result type");
>> > +		return "unknown";
>> > +	}
>> > +};
>> > +
>> > +#define eeh_infoline(EDEV, FMT, ...) \
>> > +pr_info("EEH: PE#%x (PCI %s): " pr_fmt(FMT) "\n", EDEV->pe_config_addr, \
>> > +((EDEV->pdev) ? dev_name(&EDEV->pdev->dev) : "NONE"), ##__VA_ARGS__)
>> 
>> Ooof, I guess.
>> 
>> It would be nicer as a function.
>
> OK (I'd prefer to avoid macros too), but I'm not sure what kind of
> function you mean. I initially tried to use a function, but the existing
> pr_*() type macros seemed to be macros all the way down to printk, so there
> didn't seem to be anywhere to hook into, and I ended up having to
> open-code the varargs and allocate a buffer to print into.  Then it can
> overflow etc. and it ended up seeming worse. Is there a better way I'm
> missing here?

Something like (not tested):

void eeh_edev_info(const struct eeh_info *info, const char *fmt, ...)
{
	struct va_format vaf;
	va_list args;

	va_start(args, fmt);

	vaf.fmt = fmt;
	vaf.va = &args;

        printk(KERN_INFO "EEH: PE#%x (PCI %s): %pV\n",
        	info->pe_config_addr,
                info->pdev ? dev_name(&info->pdev->dev) : "none",
                &vaf);

	va_end(args);
}

>
>> "infoline" annoys me for some reason, "eeh_info" ?
>
> OK. How about eeh_edev_info(), to indicate that it acts on an 'edev'?

Sounds good.

cheers

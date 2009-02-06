Return-Path: <gerickson@nuovations.com>
Received: from relay02.pair.com (relay02.pair.com [209.68.5.16])
	by ozlabs.org (Postfix) with SMTP id 7B244DDDFB
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Feb 2009 06:41:02 +1100 (EST)
Date: Fri, 06 Feb 2009 11:40:41 -0800
Subject: Re: [PATCH 1/1] edac: new ppc4xx driver module
From: Grant Erickson <gerickson@nuovations.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	<dougthompson@xmission.com>
Message-ID: <C5B1D239.14743%gerickson@nuovations.com>
In-Reply-To: <20090130140520.ca1b2b8e.akpm@linux-foundation.org>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/30/09 2:05 PM, Andrew Morton wrote:
> On Fri, 30 Jan 2009 09:54:42 -0700 dougthompson@xmission.com wrote:
>> From: Grant Erickson <gerickson@nuovations.com>
> 
> Perhaps a powerpc mailing list should have been cc'ed?

The first round patch went to Doug, the BlueSmoke (EDAC) mailing list and
the Linux/PowerPC mailing list. However, because the original patch was
split in two, subsequent revisions of just the EDAC piece went to Doug and
BlueSmoke. Doug then forwarded it to linux-kernel.

What's the preferred sign-off, ACK chain for this subsystem? Through
PowerPC/4xx or PowerPC GIT upstream or through you and -mm upstream?

> These comments try really hard to be in kerneldoc form, but don't quite
> succeed.
>
> And I don't think that kerneldoc understands `@return'?  It should :(

Aye. I was mistakenly under the impression that Doxygen == kernel-doc;
however, that's clearly not the case. The next revision of the patch will
have these rectified.

>> +static int
>> +ppc4xx_edac_generate_bank_message(const struct mem_ctl_info *mci,
>> +      const struct ppc4xx_ecc_status *status,
>> +      char *buffer,
>> +      size_t size)
>> +{
>> + int n, total = 0;
>> + size_t row, rows;
> 
> It seems strange to use a size_t here.

Stylistically, I tend to use 'size_t' for 'unsigned type where I am counting
things'. However, I can see where this usage might be confusing and
surprising for some.

The next revision of the patch will use 'unsigned int'.

>> +static void
>> +ppc4xx_edac_handle_ce(struct mem_ctl_info *mci,
>> +        const struct ppc4xx_ecc_status *status)
>> +{
>> + int row;
>> + char message[PPC4XX_EDAC_MESSAGE_SIZE];
> 
> 256 bytes on the stack is getting a bit large.

Would you characterize this as a "getting a bit large, but still OK" or
"getting a bit large, this MUST be changed"?

I took my guidance from drivers/edac/i5[04]000_edac.c which allocate around
200 bytes on the stack for a similar use.

However, Josh Boyer had suggested that given all the snprintf going on in
the interrupt handler, a work queue might be a better way to go. ISR timings
for a sample population of 300 events are/were:

                Ticks       Time / us
     --------------------------------
     Minimum     4150           10.38
     Maximum     9075           22.69
     Mean        8024           20.06
     Median      8297           20.74
     Mode        8869           22.17
     Std. Dev.    864            2.16
     --------------------------------

In short, if this is a MUST rather than a SHOULD, reworking the driver to
pull the message buffers off the stack and implementing a work loop might be
a two-for-one rework opportunity.

>> +static void
>> +ppc4xx_edac_handle_ue(struct mem_ctl_info *mci,
>> +        const struct ppc4xx_ecc_status *status)
>> +{
>> + const u64 bear = ((u64)status->bearh << 32 | status->bearl);
>> + const unsigned long pfn = bear >> PAGE_SHIFT;
> 
> The term `pfn' has a specific meaining in-kernel, and I have a
> suspicion that this variable doesn't match it.

I changed 'pfn' and 'poff' to 'page' and 'offset' respectively, in the next
revision of the patch.

Thanks for your feedback!

Regards,

Grant

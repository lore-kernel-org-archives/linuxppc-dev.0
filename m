Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 25668DDEFD
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Apr 2007 16:20:25 +1000 (EST)
In-Reply-To: <1177301062.3889.27.camel@concordia.ozlabs.ibm.com>
References: <20070419073555.D2C3EDDEFD@ozlabs.org>
	<5f69d29368a24aad95648b40e0dfc07e@bga.com>
	<1177301062.3889.27.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <63dd3d59fb8f043738b30026139feff6@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 6/7] MPIC MSI allocator
Date: Mon, 23 Apr 2007 01:20:11 -0500
To: michael@ellerman.id.au
Cc: linuxppc-dev@ozlabs.org, linux-pci <linux-pci@atrey.karlin.mff.cuni.cz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 22, 2007, at 11:04 PM, Michael Ellerman wrote:

> On Sat, 2007-04-21 at 18:17 -0500, Milton Miller wrote:
>> On Apr 19, 2007, Michael Ellerman wrote:
>>> To support MSI on MPIC we need a way to reserve and allocate hardware
>>> irq
>>> numbers, this patch implements an allocator for that.

>>> +	/* Reserve source numbers we know are reserved in the HW */
>>> +	for (i = 0;   i < 8;   i++) __mpic_msi_reserve_hwirq(mpic, i);
>>> +	for (i = 42;  i < 46;  i++) __mpic_msi_reserve_hwirq(mpic, i);
>>> +	for (i = 100; i < 105; i++) __mpic_msi_reserve_hwirq(mpic, i);
>>
>> More lines please.
>>
>>> +#else
>>> +static int mpic_msi_reserve_u3_hwirqs(struct mpic *mpic) { return 
>>> -1;
>>> }
>>
>> and here.
>
> Blank lines aren't free you know!

I didn't ask for any blank ones, so you can keep the bill. :-)

>>
>>> +	if (len % 8 != 0) {

Here you use 8 as the size of the element to process.

>>> +		printk(KERN_WARNING "mpic: Malformed msi-available-ranges "
>>> +		       "property on %s\n", mpic->of_node->full_name);
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	bitmap_allocate_region(mpic->hwirq_bitmap, 0,
>>> +			       fls(mpic->irq_count) - 1);
>>> +
>>> +	/* Format is: (<u32 start> <u32 count>)+ */
>>> +	len /= sizeof(u32);

Here you hide a divide by 4 and follow with divide by 2.

>>> +	for (i = 0; i < len / 2; i++, p += 2)
>>
>> how about just dividing by the calculated 8 above?  or use
>> count = len / 8.
>
> I'm not sure I follow. If you can think of a clearer way I'm all ears,
> or are you just trying to save a divide :)

I'm saying that it doesn't make sense to do both of the above.
I'd move the comment on being pairs of cells to before the
if () EINVAL then follow immediately with the divide.  If you
think that hides length being adjusted then I was optionally
suggesting making a new variable count to use in the for loop.

Actually, since i isn't used in the loop you could just
increment i by 8 while < len, and save both divides.

milton

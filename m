Return-Path: <B04825@freescale.com>
Received: from VA3EHSOBE001.bigfish.com (va3ehsobe001.messaging.microsoft.com
	[216.32.180.11]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5E388B6F94
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Jun 2011 06:26:46 +1000 (EST)
Message-ID: <4DE6A013.409@freescale.com>
Date: Wed, 1 Jun 2011 15:24:51 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 7/7] [v2] drivers/misc: introduce Freescale hypervisor
	management driver
References: <1306953337-15698-1-git-send-email-timur@freescale.com>
	<20110601204618.32190be9@lxorguk.ukuu.org.uk>
In-Reply-To: <20110601204618.32190be9@lxorguk.ukuu.org.uk>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: kumar.gala@freescale.com, linux-kernel@vger.kernel.org, akpm@kernel.org,
	linux-console@vger.kernel.org, greg@kroah.com,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alan Cox wrote:
> O> +	/* One partition must be local, the other must be remote.  In other
>> +	   words, if source and target are both -1, or are both not -1, then
>> +	   return an error. */
>> +	if ((param.source == -1) == (param.target == -1))
>> +		return -EINVAL;
> 
> Excess brackets (I just mention that one in passing)'

Do you mean excess parentheses?  If so, then I don't see how.  "(param.source ==
-1)" and "(param.target == -1)" are expressions that return a boolean.  I'm
comparing the two boolean results to see if they're equal.  I want to make sure
that the compiler doesn't do something like this:

	if (param.source == (-1 == (param.target == -1)))

I don't even know what that means, but it's not what I want.

>> +static char *strdup_from_user(const char __user *ustr, size_t max)
>> +{
>> +	size_t len;
>> +	char *str;
>> +
>> +	len = strnlen_user(ustr, max);
>> +	if (len > max)
>> +		return ERR_PTR(-ENAMETOOLONG);
>> +
>> +	str = kmalloc(len, GFP_KERNEL);
>> +	if (!str)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	if (copy_from_user(str, ustr, len))
>> +		return ERR_PTR(-EFAULT);
>> +
>> +	return str;
>> +}
> 
> This belongs on lib/ if its of general use which I think it perhaps is
> and if we don't have one already.

Where exactly in lib/ should it go?  lib/strings.c seems too low-level for a
function like this.  lib/string_helpers.c is for sprintf-like functions.  And
it's too generic for lib/powerpc/

>> +	default:
>> +		pr_debug("fsl-hv: unknown ioctl %u\n", cmd);
>> +		ret = -ENOIOCTLCMD;
> 
> -ENOTTY
> 
> (-ENOIOCTLCMD is an internal indicator designed so driver layers can say
> 'dunno, try the next layer up')
> 
>> +/* Linked list of processes that have us open */
>> +struct list_head db_list;
> 
> static ?
> 
> 
>> + * We use the same interrupt handler for all doorbells.  Whenever a doorbell
>> + * is rung, and we receive an interrupt, we just put the handle for that
>> + * doorbell (passed to us as *data) into all of the queues.
> 
> I wonder if these should be presented as IRQs or whether that makes no
> sense ?

Well, the "handles" are supposed to be just unique numbers.  In this case, they
are IRQs, but we don't want to expose that.  The application is supposed to scan
the device tree looking for the doorbell nodes that it wants, and in those nodes
there is a 'reg' property that contains the handle for that doorbell.  So the
numbers just need to match.  What they represent is not relevant.

>> +static irqreturn_t fsl_hv_state_change_isr(int irq, void *data)
>> +{
>> +	unsigned int status;
>> +	struct doorbell_isr *dbisr = data;
>> +	int ret;
>> +
>> +	/* Determine the new state, and if it's stopped, notify the clients. */
>> +	ret = fh_partition_get_status(dbisr->partition, &status);
>> +	if (!ret && (status == FH_PARTITION_STOPPED))
>> +		schedule_work(&dbisr->work);
>> +
>> +	/* Call the normal handler */
>> +	return fsl_hv_isr(irq, (void *) (uintptr_t) dbisr->doorbell);
>> +}
> 
> Would a threaded IRQ clean this up by avoiding the queue/work stuff ?

Yes, I think so.  V3 coming up.

-- 
Timur Tabi
Linux kernel developer at Freescale

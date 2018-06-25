Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Dm640f83zDrq6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2018 20:45:15 +1000 (AEST)
Date: Mon, 25 Jun 2018 18:45:05 +0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Pingfan Liu <kernelfans@gmail.com>
Cc: linux-kernel@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>,
 Christoph Hellwig <hch@infradead.org>,
 Bjorn Helgaas <helgaas@kernel.org>, Dave Young <dyoung@redhat.com>,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCHv2 2/2] drivers/base: reorder consumer and its children
 behind suppliers
Message-ID: <20180625104505.GA3058@kroah.com>
References: <1529912859-10475-1-git-send-email-kernelfans@gmail.com>
 <1529912859-10475-3-git-send-email-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1529912859-10475-3-git-send-email-kernelfans@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 25, 2018 at 03:47:39PM +0800, Pingfan Liu wrote:
> commit 52cdbdd49853 ("driver core: correct device's shutdown order")
> introduces supplier<-consumer order in devices_kset. The commit tries
> to cleverly maintain both parent<-child and supplier<-consumer order by
> reordering a device when probing. This method makes things simple and
> clean, but unfortunately, breaks parent<-child order in some case,
> which is described in next patch in this series.

There is no "next patch in this series" :(

> Here this patch tries to resolve supplier<-consumer by only reordering a
> device when it has suppliers, and takes care of the following scenario:
>     [consumer, children] [ ... potential ... ] supplier
>                          ^                   ^
> After moving the consumer and its children after the supplier, the
> potentail section may contain consumers whose supplier is inside
> children, and this poses the requirement to dry out all consumpers in
> the section recursively.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Grygorii Strashko <grygorii.strashko@ti.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Bjorn Helgaas <helgaas@kernel.org>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: linux-pci@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> ---
> note: there is lock issue in this patch, should be fixed in next version

Please send patches that you know are correct, why would I want to
review this if you know it is not correct?

And if the original commit is causing problems for you, why not just
revert that instead of adding this much-increased complexity?



> 
> ---
>  drivers/base/core.c | 132 ++++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 129 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 66f06ff..db30e86 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -123,12 +123,138 @@ static int device_is_dependent(struct device *dev, void *target)
>  	return ret;
>  }
>  
> -/* a temporary place holder to mark out the root cause of the bug.
> - * The proposal algorithm will come in next patch
> +struct pos_info {
> +	struct device *pos;
> +	struct device *tail;
> +};
> +
> +/* caller takes the devices_kset->list_lock */
> +static int descendants_reorder_after_pos(struct device *dev,
> +	void *data)

Why are you wrapping lines that do not need to be wrapped?

What does this function do?

> +{
> +	struct device *pos;
> +	struct pos_info *p = data;
> +
> +	pos = p->pos;
> +	pr_debug("devices_kset: Moving %s after %s\n",
> +		 dev_name(dev), dev_name(pos));

You have a device, use it for debugging, i.e. dev_dbg().

> +	device_for_each_child(dev, p, descendants_reorder_after_pos);

Recursive?

> +	/* children at the tail */
> +	list_move(&dev->kobj.entry, &pos->kobj.entry);
> +	/* record the right boundary of the section */
> +	if (p->tail == NULL)
> +		p->tail = dev;
> +	return 0;
> +}

I really do not understand what the above code is supposed to be doing :(

> +
> +/* iterate over an open section */
> +#define list_opensect_for_each_reverse(cur, left, right)	\
> +	for (cur = right->prev; cur == left; cur = cur->prev)
> +
> +static bool is_consumer(struct device *query, struct device *supplier)
> +{
> +	struct device_link *link;
> +	/* todo, lock protection */

Always run checkpatch.pl on patches so you do not get grumpy maintainers
telling you to run checkpatch.pl :(

> +	list_for_each_entry(link, &supplier->links.consumers, s_node)
> +		if (link->consumer == query)
> +			return true;
> +	return false;
> +}
> +
> +/* recursively move the potential consumers in open section (left, right)
> + * after the barrier

What barrier?

I'm stopping here as I have no idea what is going on, and this needs a
lot more work at the basic level of "it handles locking correctly"...

If you are working on this for power9, I'm guessing you work for IBM?
If so, please run this through your internal patch review process before
sending it out again...

thanks,

greg k-h

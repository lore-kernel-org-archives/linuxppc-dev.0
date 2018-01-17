Return-Path: <tcminyard@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zMBSN5c0dzF0Xr
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jan 2018 02:52:52 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id r19so5698925pgn.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jan 2018 07:52:52 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
Reply-To: minyard@acm.org
Subject: Re: [PATCH -next] ipmi/powernv: Fix error return code in
 ipmi_powernv_probe()
To: Wei Yongjun <weiyongjun1@huawei.com>
Cc: openipmi-developer@lists.sourceforge.net, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Jeremy Kerr <jk@ozlabs.org>,
 "Michael, Ellerman" <mpe@ellerman.id.au>,
 Alistair Popple <alistair@popple.id.au>
References: <1516188311-144227-1-git-send-email-weiyongjun1@huawei.com>
From: Corey Minyard <minyard@acm.org>
Message-ID: <e2e584e4-6919-132a-e79f-6aa242f782b9@acm.org>
Date: Wed, 17 Jan 2018 09:52:47 -0600
MIME-Version: 1.0
In-Reply-To: <1516188311-144227-1-git-send-email-weiyongjun1@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/17/2018 05:25 AM, Wei Yongjun wrote:
> Fix to return a negative error code from the request_irq() error
> handling case instead of 0, as done elsewhere in this function.

I think you are right here.  However, you had a bunch of people on the email
that probably didn't need to be there, and didn't have a few that should.
I've adjusted in this response.

This was introduced in change dce143c3381c355ef73be3dd97cf3ca1b15359b8,
you should add a "Fixes:" in the commit text.

I'll let the people that did this code comment, just to be sure, and 
wait for
a v2 patch from you after that.

Thanks,

-corey

> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>   drivers/char/ipmi/ipmi_powernv.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/char/ipmi/ipmi_powernv.c b/drivers/char/ipmi/ipmi_powernv.c
> index c687c8d..bcf493d 100644
> --- a/drivers/char/ipmi/ipmi_powernv.c
> +++ b/drivers/char/ipmi/ipmi_powernv.c
> @@ -250,8 +250,9 @@ static int ipmi_powernv_probe(struct platform_device *pdev)
>   		ipmi->irq = opal_event_request(prop);
>   	}
>   
> -	if (request_irq(ipmi->irq, ipmi_opal_event, IRQ_TYPE_LEVEL_HIGH,
> -				"opal-ipmi", ipmi)) {
> +	rc = request_irq(ipmi->irq, ipmi_opal_event, IRQ_TYPE_LEVEL_HIGH,
> +			 "opal-ipmi", ipmi);
> +	if (rc) {
>   		dev_warn(dev, "Unable to request irq\n");
>   		goto err_dispose;
>   	}
>

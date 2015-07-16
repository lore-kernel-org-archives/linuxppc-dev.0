Return-Path: <tcminyard@gmail.com>
Received: from mail-pd0-x230.google.com (mail-pd0-x230.google.com
 [IPv6:2607:f8b0:400e:c02::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2EF5A1A075D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2015 01:01:33 +1000 (AEST)
Received: by pdjr16 with SMTP id r16so45856244pdj.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2015 08:01:29 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Message-ID: <55A7C747.1050509@acm.org>
Date: Thu, 16 Jul 2015 10:01:27 -0500
From: Corey Minyard <minyard@acm.org>
Reply-To: minyard@acm.org
MIME-Version: 1.0
To: Neelesh Gupta <neelegup@linux.vnet.ibm.com>, alistair@popple.id.au,
 linuxppc-dev@lists.ozlabs.org, jk@ozlabs.org
Subject: Re: [PATCH] ipmi/powernv: Fix potential invalid pointer dereference
References: <20150716111628.28037.80799.stgit@localhost.localdomain>
In-Reply-To: <20150716111628.28037.80799.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ok, this looks fine.  A couple of question...

Do I need to send this upstream right now?  How well has this been tested?

Do you want this backported to 4.0 stable?

-corey

On 07/16/2015 06:16 AM, Neelesh Gupta wrote:
> If the OPAL call to receive the ipmi message fails, then we free up the
> smi message and return. But, the driver still holds the reference to
> old smi message in the 'cur_msg' which can potentially be accessed later
> and freed again leading to kernel oops. To fix it up,
>
> The kernel driver should reset the 'cur_msg' and send reply to the user
> in addition to freeing the message.
>
> Signed-off-by: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
> ---
>  drivers/char/ipmi/ipmi_powernv.c |   13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/char/ipmi/ipmi_powernv.c b/drivers/char/ipmi/ipmi_powernv.c
> index 9b409c0..637486d 100644
> --- a/drivers/char/ipmi/ipmi_powernv.c
> +++ b/drivers/char/ipmi/ipmi_powernv.c
> @@ -143,9 +143,16 @@ static int ipmi_powernv_recv(struct ipmi_smi_powernv *smi)
>  	pr_devel("%s:   -> %d (size %lld)\n", __func__,
>  			rc, rc == 0 ? size : 0);
>  	if (rc) {
> -		spin_unlock_irqrestore(&smi->msg_lock, flags);
> -		ipmi_free_smi_msg(msg);
> -		return 0;
> +		/* If came via the poll, and response was not yet ready */
> +		if (rc == OPAL_EMPTY) {
> +			spin_unlock_irqrestore(&smi->msg_lock, flags);
> +			return 0;
> +		} else {
> +			smi->cur_msg = NULL;
> +			spin_unlock_irqrestore(&smi->msg_lock, flags);
> +			send_error_reply(smi, msg, IPMI_ERR_UNSPECIFIED);
> +			return 0;
> +		}
>  	}
>  
>  	if (size < sizeof(*opal_msg)) {
>

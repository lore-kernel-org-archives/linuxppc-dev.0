Return-Path: <tcminyard@gmail.com>
Received: from mail-qk0-x232.google.com (mail-qk0-x232.google.com
 [IPv6:2607:f8b0:400d:c09::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 524901A084E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 21:47:54 +1000 (AEST)
Received: by qkx62 with SMTP id 62so26728286qkx.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 04:47:52 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Message-ID: <5527B863.6080901@acm.org>
Date: Fri, 10 Apr 2015 06:47:47 -0500
From: Corey Minyard <minyard@acm.org>
Reply-To: minyard@acm.org
MIME-Version: 1.0
To: Alistair Popple <alistair@popple.id.au>,
 openipmi-developer@lists.sourceforge.net
Subject: Re: [Openipmi-developer] [PATCH] ipmi/powernv: Fix minor locking bug
References: <1428651140-13665-1-git-send-email-alistair@popple.id.au>
In-Reply-To: <1428651140-13665-1-git-send-email-alistair@popple.id.au>
Content-Type: text/plain; charset=windows-1252
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, jk@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I should have caught that one.  Thanks.

-corey

On 04/10/2015 02:32 AM, Alistair Popple wrote:
> If ipmi_powernv_recv(...) is called without a current message it
> prints a warning and returns. However it fails to release the message
> lock causing the system to dead lock during any subsequent IPMI
> operations.
>
> This error path should never normally be taken unless there are bugs
> elsewhere in the system.
>
> Signed-off-by: Alistair Popple <alistair@popple.id.au>
> ---
>  drivers/char/ipmi/ipmi_powernv.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/char/ipmi/ipmi_powernv.c b/drivers/char/ipmi/ipmi_powernv.c
> index b3a2224..9b409c0 100644
> --- a/drivers/char/ipmi/ipmi_powernv.c
> +++ b/drivers/char/ipmi/ipmi_powernv.c
> @@ -126,6 +126,7 @@ static int ipmi_powernv_recv(struct ipmi_smi_powernv *smi)
>  	spin_lock_irqsave(&smi->msg_lock, flags);
>  
>  	if (!smi->cur_msg) {
> +		spin_unlock_irqrestore(&smi->msg_lock, flags);
>  		pr_warn("no current message?\n");
>  		return 0;
>  	}

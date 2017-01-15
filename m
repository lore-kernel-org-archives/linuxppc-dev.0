Return-Path: <tcminyard@gmail.com>
Received: from mail-oi0-x241.google.com (mail-oi0-x241.google.com
 [IPv6:2607:f8b0:4003:c06::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v1nxb0XnnzDqVJ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jan 2017 07:28:19 +1100 (AEDT)
Received: by mail-oi0-x241.google.com with SMTP id w144so6823169oiw.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Jan 2017 12:28:18 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
Reply-To: minyard@acm.org
Subject: Re: [PATCH] char: ipmi: constify ipmi_smi_handlers structures
References: <1484507700-28236-1-git-send-email-bhumirks@gmail.com>
To: Bhumika Goyal <bhumirks@gmail.com>, julia.lawall@lip6.fr,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 openipmi-developer@lists.sourceforge.net, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
From: Corey Minyard <minyard@acm.org>
Message-ID: <398c5909-834a-5628-fdd3-8729fe74a6de@acm.org>
Date: Sun, 15 Jan 2017 14:28:12 -0600
MIME-Version: 1.0
In-Reply-To: <1484507700-28236-1-git-send-email-bhumirks@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/15/2017 01:15 PM, Bhumika Goyal wrote:
> Declare ipmi_smi_handlers structures as const as they are only passed as
> an argument to the function ipmi_register_smi. This argument is of type
> const, so ipmi_smi_handlers structures having similar properties can be
> declared const too.
> Done using Coccinelle:

Thanks, queues for the next Linux patch mayhem.

-corey

> @r1 disable optional_qualifier@
> identifier i;
> position p;
> @@
> static struct ipmi_smi_handlers i@p={...};
>
> @ok1@
> identifier r1.i;
> position p;
> @@
> ipmi_register_smi(&i@p,...)
>
> @bad@
> position p!={r1.p,ok1.p};
> identifier r1.i;
> @@
> i@p
>
> @depends on !bad disable optional_qualifier@
> identifier r1.i;
> @@
> +const
> struct ipmi_smi_handlers i;
>
> Size details after cross compiling the .o file for powerpc architecture
>
> File size before:
>    text	   data	    bss	    dec	    hex	filename
>    2777	    288	      0	   3065	    bf9	drivers/char/ipmi/ipmi_powernv.o
>
> File size after:
>    text	   data	    bss	    dec	    hex	filename
>     2873	    192	      0	   3065	    bf9	drivers/char/ipmi/ipmi_powernv.o
>
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
> ---
>   drivers/char/ipmi/ipmi_powernv.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/char/ipmi/ipmi_powernv.c b/drivers/char/ipmi/ipmi_powernv.c
> index 6e658aa..b338a4b 100644
> --- a/drivers/char/ipmi/ipmi_powernv.c
> +++ b/drivers/char/ipmi/ipmi_powernv.c
> @@ -196,7 +196,7 @@ static void ipmi_powernv_poll(void *send_info)
>   	ipmi_powernv_recv(smi);
>   }
>   
> -static struct ipmi_smi_handlers ipmi_powernv_smi_handlers = {
> +static const struct ipmi_smi_handlers ipmi_powernv_smi_handlers = {
>   	.owner			= THIS_MODULE,
>   	.start_processing	= ipmi_powernv_start_processing,
>   	.sender			= ipmi_powernv_send,

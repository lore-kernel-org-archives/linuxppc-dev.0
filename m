Return-Path: <muriloo@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 402L2x16CRzF1KJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Mar 2018 07:36:08 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2FKYwEX047862
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Mar 2018 16:36:06 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gqvg89xh9-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Mar 2018 16:36:06 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <muriloo@linux.vnet.ibm.com>;
 Thu, 15 Mar 2018 14:36:04 -0600
Subject: Re: [PATCH v3 1/5] rfi-flush: Move the logic to avoid a redo into the
 debugfs code
To: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, msuchanek@suse.de
References: <1521067243-19520-1-git-send-email-mauricfo@linux.vnet.ibm.com>
 <1521067243-19520-2-git-send-email-mauricfo@linux.vnet.ibm.com>
From: Murilo Opsfelder Araujo <muriloo@linux.vnet.ibm.com>
Date: Thu, 15 Mar 2018 17:36:00 -0300
MIME-Version: 1.0
In-Reply-To: <1521067243-19520-2-git-send-email-mauricfo@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <4ae7af3f-219e-33dc-d7fa-49141d268222@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/14/2018 07:40 PM, Mauricio Faria de Oliveira wrote:
> From: Michael Ellerman <mpe@ellerman.id.au>
> 
> rfi_flush_enable() includes a check to see if we're already
> enabled (or disabled), and in that case does nothing.
> 
> But that means calling setup_rfi_flush() a 2nd time doesn't actually
> work, which is a bit confusing.
> 
> Move that check into the debugfs code, where it really belongs.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/setup_64.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
> index c388cc3..3efc01a 100644
> --- a/arch/powerpc/kernel/setup_64.c
> +++ b/arch/powerpc/kernel/setup_64.c
> @@ -846,9 +846,6 @@ static void do_nothing(void *unused)
> 
>  void rfi_flush_enable(bool enable)
>  {
> -	if (rfi_flush == enable)
> -		return;
> -
>  	if (enable) {
>  		do_rfi_flush_fixups(enabled_flush_types);
>  		on_each_cpu(do_nothing, NULL, 1);
> @@ -902,13 +899,19 @@ void __init setup_rfi_flush(enum l1d_flush_type types, bool enable)
>  #ifdef CONFIG_DEBUG_FS
>  static int rfi_flush_set(void *data, u64 val)
>  {
> +	bool enable;
> +
>  	if (val == 1)
> -		rfi_flush_enable(true);
> +		enable = true;
>  	else if (val == 0)
> -		rfi_flush_enable(false);
> +		enable = false;
>  	else
>  		return -EINVAL;
> 
> +	/* Only do anything if we're changing state */
> +	if (enable != rfi_flush)

Hi, Mauricio.

Do we need to take into account if no_rfi_flush == true?

    if ((enable != rfi_flush) && !no_rfi_flush)

> +		rfi_flush_enable(enable);
> +
>  	return 0;
>  }
> 

Cheers
Murilo

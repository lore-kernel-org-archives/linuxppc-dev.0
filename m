Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40cc8M6ZvNzF0PW
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 May 2018 12:55:47 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Sam Bobroff <sbobroff@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 02/13] powerpc/eeh: Add final message for successful
 recovery
In-Reply-To: <e2cc8562dcce1d8bc38084bc45414c048b5a441d.1525242772.git.sbobroff@linux.ibm.com>
References: <cover.1525242772.git.sbobroff@linux.ibm.com>
 <e2cc8562dcce1d8bc38084bc45414c048b5a441d.1525242772.git.sbobroff@linux.ibm.com>
Date: Fri, 04 May 2018 12:55:42 +1000
Message-ID: <874ljo9ljl.fsf@concordia.ellerman.id.au>
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

> Add a single log line at the end of successful EEH recovery, so that
> it's clear that event processing has finished.
>
> Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>
> ---
>  arch/powerpc/kernel/eeh_driver.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
> index 56a60b9eb397..07e0a42035ce 100644
> --- a/arch/powerpc/kernel/eeh_driver.c
> +++ b/arch/powerpc/kernel/eeh_driver.c
> @@ -910,6 +910,7 @@ void eeh_handle_normal_event(struct eeh_pe *pe)
>  	pr_info("EEH: Notify device driver to resume\n");
>  	eeh_pe_dev_traverse(pe, eeh_report_resume, NULL);
>  
> +	pr_info("EEH: Recovery successful.\n");

Is it possible for recovery for multiple devices to be interleaved?

Should that message include the device?

cheers

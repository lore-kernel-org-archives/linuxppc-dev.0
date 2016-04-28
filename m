Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x22d.google.com (mail-pa0-x22d.google.com
 [IPv6:2607:f8b0:400e:c03::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qwSJS5yBpzDq5g
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Apr 2016 16:55:20 +1000 (AEST)
Received: by mail-pa0-x22d.google.com with SMTP id r5so28996927pag.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Apr 2016 23:55:20 -0700 (PDT)
Subject: Re: [PATCH] powerpc: Add out of bounds check to
 crash_shutdown_unregister()
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
References: <1461824265-30592-1-git-send-email-sjitindarsingh@gmail.com>
Cc: paulus@samba.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <5721B3D1.2060007@gmail.com>
Date: Thu, 28 Apr 2016 16:55:13 +1000
MIME-Version: 1.0
In-Reply-To: <1461824265-30592-1-git-send-email-sjitindarsingh@gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 28/04/16 16:17, Suraj Jitindar Singh wrote:
> When unregistering a crash_shutdown_handle in the function
> crash_shutdown_unregister() the other handles are shifted down in the
> array to replace the unregistered handle. The for loop assumes that the
> last element in the array is null and uses this as the stop condition,
> however in the case that the last element is not null there is no check
> to ensure that an out of bounds access is not performed.
> 
> Add a check to terminate the shift operation when CRASH_HANDLER_MAX is
> reached in order to protect against out of bounds accesses.
> 
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> ---
>  arch/powerpc/kernel/crash.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/crash.c b/arch/powerpc/kernel/crash.c
> index 2bb252c..6b267af 100644
> --- a/arch/powerpc/kernel/crash.c
> +++ b/arch/powerpc/kernel/crash.c
> @@ -288,7 +288,7 @@ int crash_shutdown_unregister(crash_shutdown_t handler)
>  		rc = 1;
>  	} else {
>  		/* Shift handles down */
> -		for (; crash_shutdown_handles[i]; i++)
> +		for (; crash_shutdown_handles[i] && i < CRASH_HANDLER_MAX; i++)
>  			crash_shutdown_handles[i] =
>  				crash_shutdown_handles[i+1];
>  		rc = 0;
> 

with i = CRASH_HANDLER_MAX-1 we could end up with crash_shutdown_handles[i+1] already out of bounds
I think you need to check that i+1 does not overflow

Balbir

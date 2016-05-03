Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qzTWq6g1xzDq6B
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 15:00:39 +1000 (AEST)
In-Reply-To: <1461824265-30592-1-git-send-email-sjitindarsingh@gmail.com>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: paulus@samba.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Subject: Re: powerpc: Add out of bounds check to crash_shutdown_unregister()
Message-Id: <3qzTWq5vWxz9t4k@ozlabs.org>
Date: Tue,  3 May 2016 15:00:39 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-28-04 at 06:17:45 UTC, Suraj Jitindar Singh wrote:
> When unregistering a crash_shutdown_handle in the function
> crash_shutdown_unregister() the other handles are shifted down in the
> array to replace the unregistered handle. The for loop assumes that the
> last element in the array is null and uses this as the stop condition,
> however in the case that the last element is not null there is no check
> to ensure that an out of bounds access is not performed.

But AFAICS the code ensures that entry will always be NULL. So there's no bug at
the moment.

> Add a check to terminate the shift operation when CRASH_HANDLER_MAX is
> reached in order to protect against out of bounds accesses.

Doing it this way is more robust though. The chance of the NULL terminator being
corrupted is definitely higher than the code being corrupted, and if the latter
happens we're probably toast anyway.

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

So if I'm reading it right, with this change we have removed all the code that
uses the NULL-terminated property of the list.

If so we should also shrink the array to be only CRASH_HANDLER_MAX in size, and
remove any references to it being NULL terminated.

cheers

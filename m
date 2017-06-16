Return-Path: <akpm@linux-foundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wq80B136gzDqJ1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Jun 2017 04:24:10 +1000 (AEST)
Date: Fri, 16 Jun 2017 11:24:07 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Don Zickus <dzickus@redhat.com>, Babu Moger <babu.moger@oracle.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 4/5] watchdog: provide watchdog_reconfigure() for
 arch watchdogs
Message-Id: <20170616112407.e150c215209d86d7e8916a47@linux-foundation.org>
In-Reply-To: <20170616065715.18390-5-npiggin@gmail.com>
References: <20170616065715.18390-1-npiggin@gmail.com>
 <20170616065715.18390-5-npiggin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 16 Jun 2017 16:57:14 +1000 Nicholas Piggin <npiggin@gmail.com> wrote:

> After reconfiguring watchdog sysctls etc., architecture specific
> watchdogs may not get all their parameters updated.
> 
> watchdog_reconfigure() can be implemented to pull the new values
> in and set the arch NMI watchdog.
> 

I'll update the title and changelog to say "watchdog_nmi_reconfigure".

> --- a/kernel/watchdog.c
> +++ b/kernel/watchdog.c
> @@ -123,6 +123,11 @@ void __weak watchdog_nmi_disable(unsigned int cpu)
>  {
>  }
>  
> +void __weak watchdog_nmi_reconfigure(void)
> +{
> +}

Can we please get some documentation in here describing what it's for? 
How arch maintainers might use this?  When and why it is called, what
it must do?  etc.

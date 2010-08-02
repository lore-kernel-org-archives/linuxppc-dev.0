Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 81F8DB6F06
	for <linuxppc-dev@ozlabs.org>; Mon,  2 Aug 2010 17:02:53 +1000 (EST)
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id o7272lKk023538
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Aug 2010 02:02:49 -0500
Subject: Re: [PATCH 02/11] powerpc/nvram: More flexible
	nvram_create_partition()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <1280710522-6362-3-git-send-email-benh@kernel.crashing.org>
References: <1280710522-6362-1-git-send-email-benh@kernel.crashing.org>
	<1280710522-6362-2-git-send-email-benh@kernel.crashing.org>
	<1280710522-6362-3-git-send-email-benh@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 02 Aug 2010 17:02:46 +1000
Message-ID: <1280732566.1902.54.camel@pasglop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2010-08-02 at 10:55 +1000, Benjamin Herrenschmidt wrote:
> Replace nvram_create_os_partition() with a variant that takes
> the partition name, signature and size as arguments.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>  arch/powerpc/kernel/nvram_64.c         |   46 +++++++++++++++++++------------
>  arch/powerpc/platforms/pseries/nvram.c |    6 ++--
>  2 files changed, 31 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/nvram_64.c b/arch/powerpc/kernel/nvram_64.c
> index a8154f1..974b3ec 100644
> --- a/arch/powerpc/kernel/nvram_64.c
> +++ b/arch/powerpc/kernel/nvram_64.c
> @@ -307,13 +307,15 @@ static int __init nvram_remove_os_partition(void)
>  	return 0;
>  }
>  
> -/* nvram_create_os_partition
> - *
> - * Create a OS linux partition to buffer error logs.
> - * Will create a partition starting at the first free
> - * space found if space has enough room.
> +/**
> + * nvram_create_partition - Create a partition in nvram
> + * @name: name of the partition to create
> + * @sig: signature of the partition to create
> + * @req_size: size to allocate preferrably
> + * @min_size: minimum acceptable size (0 means req_size)
>   */
> -static int __init nvram_create_os_partition(void)
> +static int __init nvram_create_partition(const char *name, int sig,
> +					 int req_size, int min_size)
>  {

Order of args is req , min but...

> +	rc = 	nvram_create_partition("ppc64,linux", NVRAM_SIG_OS,
> +				       NVRAM_MIN_REQ, NVRAM_MAX_REQ);
>  	if (rc) {

I call it the other way around :-)

I should have tested this more before sending for RFC :-) Anyways, I
found more crap, like the way the list head is allocated etc...

I'll do another pass this week after I've dealt with the merge window.

Cheers,
Ben.

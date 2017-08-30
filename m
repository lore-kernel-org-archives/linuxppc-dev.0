Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xhqNX3zDszDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Aug 2017 12:35:08 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: John Allen <jallen@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/pseries: Don't attempt to acquire drc during
 memory hot add for assigned lmbs
In-Reply-To: <fc2ad536-a772-f006-43c4-1ddf6e296ebb@linux.vnet.ibm.com>
References: <fc2ad536-a772-f006-43c4-1ddf6e296ebb@linux.vnet.ibm.com>
Date: Wed, 30 Aug 2017 12:35:07 +1000
Message-ID: <87bmmx3hr8.fsf@concordia.ellerman.id.au>
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

John Allen <jallen@linux.vnet.ibm.com> writes:

> Check if an LMB is assigned before attempting to call dlpar_acquire_drc in
> order to avoid any unnecessary rtas calls. This substantially reduces the
> running time of memory hot add on lpars with large amounts of memory.
>
> Signed-off-by: John Allen <jallen@linux.vnet.ibm.com>
> ---
> diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
> index ca9b2f4..95cf2ff 100644
> --- a/arch/powerpc/platforms/pseries/hotplug-memory.c
> +++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
> @@ -817,6 +817,9 @@ static int dlpar_memory_add_by_count(u32 lmbs_to_add, struct property *prop)
>  		return -EINVAL;
>
>  	for (i = 0; i < num_lmbs && lmbs_to_add != lmbs_added; i++) {
> +		if (lmbs[i].flags & DRCONF_MEM_ASSIGNED)
> +			continue;
> +
>  		rc = dlpar_acquire_drc(lmbs[i].drc_index);
>  		if (rc)
>  			continue;

This doesn't build for me, see below. What compiler are you using to
test this?

  arch/powerpc/platforms/pseries/hotplug-memory.c: In function 'dlpar_memory':
  arch/powerpc/platforms/pseries/hotplug-memory.c:1081:2: error: 'rc' may be used uninitialized in this function [-Werror=maybe-uninitialized]
    return rc;
    ^

It's a bit confusing because you didn't modify that function, but the
function you did modify has been inlined into there.

Possibly the compiler is wrong and we do always initialise rc, but it's
not clear at all.

And it raises a bigger question, how is this supposed to actually work?

If we go around the loop and find that something is already assigned:

	for (i = 0; i < num_lmbs && lmbs_to_add != lmbs_added; i++) {
		if (lmbs[i].flags & DRCONF_MEM_ASSIGNED)
			continue;
                ...
		lmbs_added++;
                ...
        }

We don't increment lmbs_added, so at the end of the loop we will see
that lmbs_added is not equal to lmbs_to_add, and so we remove
everything:

	if (lmbs_added != lmbs_to_add) {
		pr_err("Memory hot-add failed, removing any added LMBs\n");

		for (i = 0; i < num_lmbs; i++) {
			if (!lmbs[i].reserved)
				continue;

			rc = dlpar_remove_lmb(&lmbs[i]);


So it seems like if we ever hit that continue you added, the whole
operation will fail anyway. So I'm confused.

cheers

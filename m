Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41l4vC72chzDqYL
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Aug 2018 16:52:07 +1000 (AEST)
Message-ID: <a31af3ea8c1bd19aeae0e0ba493f8c1dfb29f0a0.camel@neuling.org>
Subject: Re: [PATCH 1/2] powerpc: Allow memory that has been hot-removed to
 be hot-added
From: Michael Neuling <mikey@neuling.org>
To: Rashmica Gupta <rashmica.g@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
 bsingharora@gmail.com
Date: Tue, 07 Aug 2018 16:52:07 +1000
In-Reply-To: <20180803060601.724-1-rashmica.g@gmail.com>
References: <20180803060601.724-1-rashmica.g@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-08-03 at 16:06 +1000, Rashmica Gupta wrote:
> This patch allows the memory removed by memtrace to be readded to the
> kernel. So now you don't have to reboot your system to add the memory
> back to the kernel or to have a different amount of memory removed.
>=20
> Signed-off-by: Rashmica Gupta <rashmica.g@gmail.com>

Tested-by: Michael Neuling <mikey@neuling.org>

> ---
> To remove 1GB from each node:
> echo 1073741824  >  /sys/kernel/debug/powerpc/memtrace/enable
>=20
> To add this memory back and remove 2GB:
> echo 2147483648 >  /sys/kernel/debug/powerpc/memtrace/enable=20
>=20
> To just re-add memory:
> echo 0  >  /sys/kernel/debug/powerpc/memtrace/enable=20

Nice... thanks!

Mikey

>=20
>=20
>  arch/powerpc/platforms/powernv/memtrace.c | 93 +++++++++++++++++++++++++=
+++
> ---
>  1 file changed, 86 insertions(+), 7 deletions(-)
>=20
> diff --git a/arch/powerpc/platforms/powernv/memtrace.c
> b/arch/powerpc/platforms/powernv/memtrace.c
> index b99283df8584..51fe0862dcab 100644
> --- a/arch/powerpc/platforms/powernv/memtrace.c
> +++ b/arch/powerpc/platforms/powernv/memtrace.c
> @@ -206,8 +206,11 @@ static int memtrace_init_debugfs(void)
> =20
>  		snprintf(ent->name, 16, "%08x", ent->nid);
>  		dir =3D debugfs_create_dir(ent->name, memtrace_debugfs_dir);
> -		if (!dir)
> +		if (!dir) {
> +			pr_err("Failed to create debugfs directory for node
> %d\n",
> +				ent->nid);
>  			return -1;
> +		}
> =20
>  		ent->dir =3D dir;
>  		debugfs_create_file("trace", 0400, dir, ent, &memtrace_fops);
> @@ -218,18 +221,94 @@ static int memtrace_init_debugfs(void)
>  	return ret;
>  }
> =20
> +static int online_mem_block(struct memory_block *mem, void *arg)
> +{
> +	return device_online(&mem->dev);
> +}
> +
> +/*
> + * Iterate through the chunks of memory we have removed from the kernel
> + * and attempt to add them back to the kernel.
> + */
> +static int memtrace_online(void)
> +{
> +	int i, ret =3D 0;
> +	struct memtrace_entry *ent;
> +
> +	for (i =3D memtrace_array_nr - 1; i >=3D 0; i--) {
> +		ent =3D &memtrace_array[i];
> +
> +		/* We have onlined this chunk previously */
> +		if (ent->nid =3D=3D -1)
> +			continue;
> +
> +		/* Remove from io mappings */
> +		if (ent->mem) {
> +			iounmap(ent->mem);
> +			ent->mem =3D 0;
> +		}
> +
> +		if (add_memory(ent->nid, ent->start, ent->size)) {
> +			pr_err("Failed to add trace memory to node %d\n",
> +					 ent->nid);
> +			ret +=3D 1;
> +			continue;
> +		}
> +
> +		/*
> +		 * If kernel isn't compiled with the auto online option
> +		 * we need to online the memory ourselves.
> +		 */
> +		if (!memhp_auto_online) {
> +			walk_memory_range(PFN_DOWN(ent->start),
> +				PFN_UP(ent->start + ent->size - 1),
> +				NULL, online_mem_block);
> +		}
> +
> +		/*
> +		 * Memory was added successfully so clean up references to it
> +		 * so on reentry we can tell that this chunk was added.
> +		 */
> +		debugfs_remove_recursive(ent->dir);
> +		pr_info("Added trace memory back to node %d\n", ent->nid);
> +		ent->size =3D ent->start =3D ent->nid =3D -1;
> +	}
> +	if (ret)
> +		return ret;
> +
> +	/* If all chunks of memory were added successfully, reset globals */
> +	kfree(memtrace_array);
> +	memtrace_array =3D NULL;
> +	memtrace_size =3D 0;
> +	memtrace_array_nr =3D 0;
> +	return 0;
> +
> +}
> +
>  static int memtrace_enable_set(void *data, u64 val)
>  {
> -	if (memtrace_size)
> +	uint64_t bytes;
> +
> +	/*
> +	 * Don't attempt to do anything if size isn't aligned to a memory
> +	 * block or equal to zero.
> +	 */
> +	bytes =3D memory_block_size_bytes();
> +	if (val & (bytes - 1)) {
> +		pr_err("Value must be aligned with 0x%llx\n", bytes);
>  		return -EINVAL;
> +	}
> =20
> -	if (!val)
> -		return -EINVAL;
> +	/* Re-add/online previously removed/offlined memory */
> +	if (memtrace_size) {
> +		if (memtrace_online())
> +			return -EAGAIN;
> +	}
> =20
> -	/* Make sure size is aligned to a memory block */
> -	if (val & (memory_block_size_bytes() - 1))
> -		return -EINVAL;
> +	if (!val)
> +		return 0;
> =20
> +	/* Offline and remove memory */
>  	if (memtrace_init_regions_runtime(val))
>  		return -EINVAL;
> =20

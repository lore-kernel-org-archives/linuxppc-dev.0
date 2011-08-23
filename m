Return-Path: <geoff@infradead.org>
Message-ID: <4E54134D.7080004@infradead.org>
Date: Tue, 23 Aug 2011 13:53:33 -0700
From: Geoff Levand <geoff@infradead.org>
MIME-Version: 1.0
To: Andre Heider <a.heider@gmail.com>
Subject: Re: [PATCH part1 v2 2/9] ps3: Add helper functions to read highmem
	info from the repository
References: <1312228986-32307-1-git-send-email-a.heider@gmail.com>
	<1313091073-4572-1-git-send-email-a.heider@gmail.com>
	<1313091073-4572-3-git-send-email-a.heider@gmail.com>
In-Reply-To: <1313091073-4572-3-git-send-email-a.heider@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: cbe-oss-dev@lists.ozlabs.org, Hector Martin <hector@marcansoft.com>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/11/2011 12:31 PM, Andre Heider wrote:
> An earlier step in the boot chain can preallocate the highmem region.
> A boot loader doing so will place the region infos in the repository.
> Provide helper functions to read the required nodes.
> 
> Signed-off-by: Andre Heider <a.heider@gmail.com>
> ---
>  arch/powerpc/platforms/ps3/platform.h   |    3 ++
>  arch/powerpc/platforms/ps3/repository.c |   36 +++++++++++++++++++++++++++++++
>  2 files changed, 39 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/ps3/platform.h b/arch/powerpc/platforms/ps3/platform.h
> index 9a196a8..d9b4ec0 100644
> --- a/arch/powerpc/platforms/ps3/platform.h
> +++ b/arch/powerpc/platforms/ps3/platform.h
> @@ -187,6 +187,9 @@ int ps3_repository_read_rm_size(unsigned int ppe_id, u64 *rm_size);
>  int ps3_repository_read_region_total(u64 *region_total);
>  int ps3_repository_read_mm_info(u64 *rm_base, u64 *rm_size,
>  	u64 *region_total);
> +int ps3_repository_read_highmem_base(u64 *highmem_base);
> +int ps3_repository_read_highmem_size(u64 *highmem_size);
> +int ps3_repository_read_highmem_info(u64 *highmem_base, u64 *highmem_size);

In the general case we could have multiple regions.  If we
add a region arg here we can handle that if needed.
region_index would be {1..}.  ps3_repository_read_highmem_info
could hold how many regions, so:

  int ps3_repository_read_highmem_base(unsigned int region_index, u64 *highmem_base);
  int ps3_repository_read_highmem_size(unsigned int region_index, u64 *highmem_size);
  int ps3_repository_read_highmem_region(unsigned int region_index, u64 *highmem_base, u64 *highmem_size);

>  
>  /* repository pme info */
>  
> diff --git a/arch/powerpc/platforms/ps3/repository.c b/arch/powerpc/platforms/ps3/repository.c
> index 5e304c2..9908d61 100644
> --- a/arch/powerpc/platforms/ps3/repository.c
> +++ b/arch/powerpc/platforms/ps3/repository.c
> @@ -778,6 +778,42 @@ int ps3_repository_read_mm_info(u64 *rm_base, u64 *rm_size, u64 *region_total)
>  		: ps3_repository_read_region_total(region_total);
>  }
>  
> +int ps3_repository_read_highmem_base(u64 *highmem_base)
> +{
> +	return read_node(PS3_LPAR_ID_CURRENT,
> +			 make_first_field("bi", 0),
> +			 make_field("highmem", 0),
> +			 make_field("base", 0),
> +			 0,
> +			 highmem_base, NULL);
> +}

I think something like this seems better:

int ps3_repository_read_highmem_base(unsigned int region_index, u64 *highmem_base)
{
	return read_node(PS3_LPAR_ID_CURRENT,
		make_first_field("highmem", 0),
		make_field("region", region_index),
		make_field("base", 0),
		0,
		highmem_base, NULL);
}

> +
> +int ps3_repository_read_highmem_size(u64 *highmem_size)
> +{
> +	return read_node(PS3_LPAR_ID_CURRENT,
> +			 make_first_field("bi", 0),
> +			 make_field("highmem", 0),
> +			 make_field("size", 0),
> +			 0,
> +			 highmem_size, NULL);
> +}
> +
> +/**
> + * ps3_repository_read_highmem_info - Read high memory info
> + * @highmem_base: High memory base address.
> + * @highmem_size: High mode memory size.
> + */
> +
> +int ps3_repository_read_highmem_info(u64 *highmem_base, u64 *highmem_size)
> +{
> +	int result;
> +
> +	*highmem_base = 0;
> +	result = ps3_repository_read_highmem_base(highmem_base);
> +	return result ? result
> +		: ps3_repository_read_highmem_size(highmem_size);


	ps3_repository_read_highmem_base(1, highmem_base);
	...
> +}
> +
>  /**
>   * ps3_repository_read_num_spu_reserved - Number of physical spus reserved.
>   * @num_spu: Number of physical spus.

-Geoff

Return-Path: <mpe@ellerman.id.au>
Date: Thu, 21 Nov 2013 22:51:04 +1100
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 2/9] pseries: Add H_SET_MODE to change exception endianness
Message-ID: <20131121115104.GC15913@concordia>
References: <1384946106-18200-1-git-send-email-anton@samba.org>
 <1384946106-18200-3-git-send-email-anton@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1384946106-18200-3-git-send-email-anton@samba.org>
Cc: rusty@rustcorp.com.au, Ulrich.Weigand@de.ibm.com, paulus@samba.org,
 alistair@popple.id.au, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 20, 2013 at 10:14:59PM +1100, Anton Blanchard wrote:
> On little endian builds call H_SET_MODE so exceptions have the
> correct endianness. We need to reset the endian during kexec
> so do that in the MMU hashtable clear callback.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>
> ---
>  arch/powerpc/include/asm/hvcall.h         |  2 ++
>  arch/powerpc/include/asm/plpar_wrappers.h | 26 +++++++++++++++++++
>  arch/powerpc/platforms/pseries/lpar.c     | 17 +++++++++++++
>  arch/powerpc/platforms/pseries/setup.c    | 42 +++++++++++++++++++++++++++++++
>  4 files changed, 87 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
> index 0c7f2bf..d8b600b 100644
> --- a/arch/powerpc/include/asm/hvcall.h
> +++ b/arch/powerpc/include/asm/hvcall.h
> @@ -403,6 +403,8 @@ static inline unsigned long cmo_get_page_size(void)
>  extern long pSeries_enable_reloc_on_exc(void);
>  extern long pSeries_disable_reloc_on_exc(void);
>  
> +extern long pseries_big_endian_exceptions(void);
> +
>  #else
>  
>  #define pSeries_enable_reloc_on_exc()  do {} while (0)
> diff --git a/arch/powerpc/include/asm/plpar_wrappers.h b/arch/powerpc/include/asm/plpar_wrappers.h
> index a63b045..12c32c5 100644
> --- a/arch/powerpc/include/asm/plpar_wrappers.h
> +++ b/arch/powerpc/include/asm/plpar_wrappers.h
> @@ -287,6 +287,32 @@ static inline long disable_reloc_on_exceptions(void) {
>  	return plpar_set_mode(0, 3, 0, 0);
>  }
>  
> +/*
> + * Take exceptions in big endian mode on this partition
> + *
> + * Note: this call has a partition wide scope and can take a while to complete.
> + * If it returns H_LONG_BUSY_* it should be retried periodically until it
> + * returns H_SUCCESS.
> + */
> +static inline long enable_big_endian_exceptions(void)
> +{
> +	/* mflags = 0: big endian exceptions */
> +	return plpar_set_mode(0, 4, 0, 0);
> +}
> +
> +/*
> + * Take exceptions in little endian mode on this partition
> + *
> + * Note: this call has a partition wide scope and can take a while to complete.
> + * If it returns H_LONG_BUSY_* it should be retried periodically until it
> + * returns H_SUCCESS.
> + */
> +static inline long enable_little_endian_exceptions(void)
> +{
> +	/* mflags = 1: little endian exceptions */
> +	return plpar_set_mode(1, 4, 0, 0);
> +}
> +

...

> diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
> index 1f97e2b..c1f1908 100644
> --- a/arch/powerpc/platforms/pseries/setup.c
> +++ b/arch/powerpc/platforms/pseries/setup.c
> @@ -442,6 +442,32 @@ static void pSeries_machine_kexec(struct kimage *image)
>  }
>  #endif

Nit picking, but I'm not sure the enable_big/little_endian_exceptions()
wrappers buy us much. And they mean you end up with essentially the same
routine twice below:
  
> +#ifdef __LITTLE_ENDIAN__
> +long pseries_big_endian_exceptions(void)
> +{
> +	long rc;
> +
> +	while (1) {
> +		rc = enable_big_endian_exceptions();
> +		if (!H_IS_LONG_BUSY(rc))
> +			return rc;
> +		mdelay(get_longbusy_msecs(rc));
> +	}
> +}
> +
> +static long pseries_little_endian_exceptions(void)
> +{
> +	long rc;
> +
> +	while (1) {
> +		rc = enable_little_endian_exceptions();
> +		if (!H_IS_LONG_BUSY(rc))
> +			return rc;
> +		mdelay(get_longbusy_msecs(rc));
> +	}
> +}
> +#endif

Whereas you could do:

static long pseries_big_endian_exceptions(bool big_endian)
{
	int mflags;
	long rc;

	mflags = big_endian ? 0 : 1;

	while (1) {
		rc = plpar_set_mode(mflags, 4, 0, 0);

		if (!H_IS_LONG_BUSY(rc))
			return rc;
		mdelay(get_longbusy_msecs(rc));
	}
}

Perhaps pseries_big_endian_exceptions(false) looks a bit odd though ..

cheers

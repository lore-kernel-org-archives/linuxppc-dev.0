Return-Path: <paulus@ozlabs.org>
Date: Mon, 23 Jul 2012 10:20:19 +1000
From: Paul Mackerras <paulus@samba.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH -V3 08/11] arch/powerpc: Make some of the PGTABLE_RANGE
 dependency explicit
Message-ID: <20120723002019.GJ17790@bloggs.ozlabs.ibm.com>
References: <1341839621-28332-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1341839621-28332-9-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1341839621-28332-9-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 09, 2012 at 06:43:38PM +0530, Aneesh Kumar K.V wrote:
> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> 
> slice array size and slice mask size depend on PGTABLE_RANGE. We
> can't directly include pgtable.h in these header because there is
> a circular dependency. So add compile time check for these values.

Some comments below...

>  struct slice_mask {
>  	u16 low_slices;
>  	/*
> -	 * This should be derived out of PGTABLE_RANGE. For the current
> -	 * max 64TB, u64 should be ok.
> +	 * We do this as a union so that we can verify
> +	 * SLICE_MASK_SIZE against PGTABLE_RANGE
>  	 */
> -	u64 high_slices;
> +	union {
> +		u64 high_slices;
> +		unsigned char not_used[SLICE_MASK_SIZE];
> +	};

Seems ugly to have to have a union just for that.  Can't we do
something like BUILD_BUG_ON(sizeof(u64) < SLICE_MASK_SIZE) instead?

> @@ -73,7 +73,7 @@ static struct slice_mask slice_range_to_mask(unsigned long start,
>  					     unsigned long len)
>  {
>  	unsigned long end = start + len - 1;
> -	struct slice_mask ret = { 0, 0 };
> +	struct slice_mask ret = { 0, {0} };

Wouldn't { 0 } suffice?  Similarly in several places below.

Paul.

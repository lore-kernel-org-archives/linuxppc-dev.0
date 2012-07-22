Return-Path: <paulus@ozlabs.org>
Date: Mon, 23 Jul 2012 09:42:03 +1000
From: Paul Mackerras <paulus@samba.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH -V3 03/11] arch/powerpc: Convert virtual address to vpn
Message-ID: <20120722234203.GC17790@bloggs.ozlabs.ibm.com>
References: <1341839621-28332-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1341839621-28332-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1341839621-28332-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 09, 2012 at 06:43:33PM +0530, Aneesh Kumar K.V wrote:
> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> 
> This patch convert different functions to take virtual page number
> instead of virtual address. Virtual page number is virtual address
> shifted right by VPN_SHIFT (12) bits. This enable us to have an
> address range of upto 76 bits.

Some comments inline below...

> +/*
> + * encode page number shift.
> + * Inorder to fit the 78 bit va in a 64 bit variable we shift the va by
      ^ "in order"

> + * 12 bits. This enable us to address upto 76 bit va.
                                         ^ "up to"

> + * For hpt hash from a va we can ignore the page size bits of va and for
> + * hpte encoding we ignore upto 23 bits of va. So ignoring lower 12 bits ensure
> + * we work in all cases including 4k page size.
> + */
> +#define VPN_SHIFT	12

This can't be more than 12 bits because we sometimes use 4k pages even
in a kernel configured for 64k pages (e.g. with the subpage_protection
system call).

> +static inline unsigned long hpte_encode_avpn(unsigned long vpn, int psize,
> +					     int ssize)
> +{
> +	unsigned long v;
> +	/*
> +	 * The AVA field omits the low-order 23 bits of the 78 bits VA.
> +	 * These bits are not needed in the PTE, because the
> +	 * low-order b of these bits are part of the byte offset
> +	 * into the virtual page and, if b < 23, the high-order
> +	 * 23-b of these bits are always used in selecting the
> +	 * PTEGs to be searched
> +	 */
> +	BUG_ON(VPN_SHIFT > 23);

I don't think we need this.  If VPN_SHIFT was computed by some complex
expression whose value is not obvious, then BUG_ON (or BUILD_BUG_ON)
would be appropriate, but since it's just a #define, a comment at the
site of the definition will suffice.

>  static inline unsigned long hpt_hash(unsigned long va, unsigned int shift,
>  				     int ssize)
>  {
> +	int mask;
>  	unsigned long hash, vsid;
>  
> +	BUG_ON(shift < VPN_SHIFT);

So VPN_SHIFT can be at most 12, since 12 is the smallest shift value
possible here.

> -static inline void __tlbiel(unsigned long va, int psize, int ssize)
> +static inline void __tlbiel(unsigned long vpn, int psize, int ssize)
>  {
> +	unsigned long va;
>  	unsigned int penc;
>  
> +	BUG_ON((77 - 65) > VPN_SHIFT);
> +	va = vpn << VPN_SHIFT;

So VPN_SHIFT has to be at least 12.  What is the significance of 77
and 65 here?

Paul.

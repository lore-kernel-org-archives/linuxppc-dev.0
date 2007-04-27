Return-Path: <miltonm@bga.com>
In-Reply-To: <1177601310.24866.94.camel@luke-laptop>
References: <1177626236.24866.99.camel@luke-laptop>,
	<1177601310.24866.94.camel@luke-laptop>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <772e4d4c76807769449cf1bf874d2ce1@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH v3] powerpc: 64K page support for kexec
Date: Thu, 26 Apr 2007 23:36:35 -0500
To: Luke Browning <lukebr@linux.vnet.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>,
	Olof Johansson <olof@lixom.net>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Apr 26, 2007, at 5:23 PM, Luke Browning wrote:
> This patch fixes a couple of kexec problems related to 64K page
> support in the kernel.  kexec issues a tlbie for each pte.  The
> parameters for the tlbie are the page size and the virtual address.
> Support was missing for the computation of these two parameters
> for 64K pages.  This patch adds that support.
>
> Signed-off-by: Luke Browning <lukebrowning@us.ibm.com>
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>

> -		va |= vpi << PAGE_SHIFT;
> +	/*
> +	 * FIXME, the code below works for 16M, 64K, and 4K pages as these
> +	 * fall under the p<=23 rules for calculating the virtual address.
> +	 * In the case of 16M pages, an extra bit is stolen from the AVPN
> +	 * field to achieve the requisite 24 bits.
> +	 *
> +	 * 16G pages are not supported by the code below.
> +	 */
> +	BUG_ON(hpte_v & 0x4000000000000000UL);		/* 1T segment */
> +	BUG_ON(size == MMU_PAGE_16G);
> +	BUG_ON(size == MMU_PAGE_64K_AP);
> +
> +	shift = mmu_psize_defs[size].shift;
> +	if (mmu_psize_defs[size].avpnm)
> +		avpnm_bits = __ilog2_u64(mmu_psize_defs[size].avpnm) + 1;
> +	else
> +		avpnm_bits = 0;
>


I have to continue to disagree on the above BUG_ONs.

>  /*
> @@ -374,15 +417,14 @@ static unsigned long slot2va(unsigned lo
>   *
>   * TODO: add batching support when enabled.  remember, no dynamic 
> memory here,
>   * athough there is the control page available...
> - *
> - * XXX FIXME: 4k only for now !
>   */
>  static void native_hpte_clear(void)
>  {
>  	unsigned long slot, slots, flags;
>  	hpte_t *hptep = htab_address;
> -	unsigned long hpte_v;
> +	unsigned long hpte_v, va;
>  	unsigned long pteg_count;
> +	int psize;
>
>  	pteg_count = htab_hash_mask + 1;
>
> @@ -408,8 +450,9 @@ static void native_hpte_clear(void)
>  		 * already hold the native_tlbie_lock.
>  		 */
>  		if (hpte_v & HPTE_V_VALID) {
> +			hpte_decode(hptep, slot, &psize, &va);
>  			hptep->v = 0;
> -			__tlbie(slot2va(hpte_v, slot), MMU_PAGE_4K);
> +			__tlbie(va, psize);
>  		}
>  	}
>

<speculation severity=minor>
I'm guessing hpte_decode is not inlined by gcc anymore?  (I
didn't get a chance to try it).   I believed you said
hpte_decode is basically doing two things, (1) calculating
the page size, and (2) using that additional information to
calculate the va.   If we split those two functions apart,
does it change the inlining decsions?

Actually this is all optimizing an infrequent path, although
it is a path that counts as downtime.
</speculation>


Luke later wrote:
> Ben H Wrote:
>> (Have you added some debug to check we get the 16M case right ?)
>>
>> Note that Milton is against using BUG_ON's in here since that code is
>> used for crash dumps.
>
> I would prefer to leave BUG_ON()s in the code as they work in many
> cases.  It depends on how far you have get in the algorithm.  I added
> BUG_ON(size == 16M) which is hit after a hundred entries or so have 
> been
> processed.  See output below.

BUG_ON will fail as soon as you invalidate the page
containing the program_check handler, or anything leading up
to it.   Since the kernel text is normally mapped with 16M
pages, it doesn't surprise me when you BUG before unmapping
any 16M pages.

It also depends on your output device.   Your cell blade has
this nice real mode RTAS.  Go to a real serial port and try
to debug the mess (recursive faults) when the port iomap is
unmapped.

> I also put a BUG_ON() at the end of the
> table scan but no output was presented so there are limitations, but I
> don't believe that there is a downside.  The BUG_ON() at the end of the
> sequence presented the original symptom so there is no difference from 
> a
> user perspective when the algorithm was completely broken.

I have had very different experiences when stopping execution, loading
a new kernel, setting the entrypoint, and starting the new kernel.   I
usually die when starting init, but get through all of the kernel init
without incident.   This is going from a 4k kernel to 4k kernel, with
most used drivers built in. In effect, this is doing a kexec without
any hash table clear.   I've even gotten away with it when I do this
because I forgot the initramfs the first time or a driver init paniced.

> During the
> development of this feature, we encountered a lot of false hits though
> as the system continued and experienced a bunch of false symptoms. This
> is worse as it is better to have the system fail in a deterministic way
> than to fail in random way.  Some of the failures that we experienced
> were dma, timer, and module initialization problems.  These were all 
> red
> herrings.

Was your development testing going from 64k to 64k base
kernel?   Or 64k to 4k or 4k to 64k?   Did your development
break 4k pages along the way?

The reason I ask is because when starting a similar kernel,
I expect any failures of invalidating the kernel linear
mapping to be mapped with the same mapping the next time.
If you were going to a dissimilar kernel, or possibly a
modular kernel with modules loaded in random order, I would
expect incorrect io-mapping and vmalloc could also pose
problems you mentioned.

It appears the distros want to use a similar kernel for
their dump kernel.  The would prefer it be the same binary;
I'm trying to influence people that it is a softer requirement
than not slowing down the primary kernel.

> Having BUG_ONs in the code allows developers to make
> assertions about the code which is important when diagnosing strange
> system crashes and provides a clue to future developers that they need
> to add support for something.  Comments are fine, but asserts are 
> better
> in that they show up in cscope and other development tools.  So all
> things considered I think it is better to include them.

I think a better way to debug this code is to call it from a
debugfs hook or xmon dump command to scan the table and do
the computation.  That code would have the full debugger to
notice and print the assert.

Having a xmon function to dump the hash table or a slot
might be useful for other purposes.

If you think you need the assert, then I ask it be put under
an ifdef or it not be triggered when kexec is called with
panic=1  (ie BUG_ON(x && !panic).  Alternatively you could
run the table with dry-run sometime between cpu_down and the
kernel copy.

> > Appart from that,
> >
> > Acked-by: Benjamin Herrenschmidt <benh at kernel.crashing.org>
> >

milton

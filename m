Message-ID: <394110AB.1B25BBF4@embeddededge.com>
Date: Fri, 09 Jun 2000 11:43:39 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Daniel Wu <Daniel.Wu@alcatel.com.au>
CC: Dan Malek <dan@netx4.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Using zImage.initrd
References: <00Jun9.083821est.115346@border.alcanet.com.au>
	 <3940614D.5BB18EF9@embeddededge.com> <00Jun9.185145est.115383@border.alcanet.com.au>
Content-Type: multipart/mixed;
 boundary="------------D8DE28EE2EF24951C75A6870"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------D8DE28EE2EF24951C75A6870
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Daniel Wu wrote:


> .... The loader is
> copied to 0x600000 and execute from there ( I've reserved 4M for the boot +
> zImage + initrd). Will this be a problem?

That isn't necessary.  The code in the mbxboot directory takes care
of reserving space.  It assumes the loader is copied into _lower_
memory from the load point.  All of these build procedures in the
generic sources work very nicely and you shouldn't have to change
anything.



> The CPU is 860T (XPC860TZP50B3). The caches are enabled as far as I can tell
> from the code.

So, have you run any diagnostics to make sure your UPM programming
is working correctly?  When Linux comes to life with caches, MMU,
and the CPM running, it creates worst case memory cycles that are
very difficult to duplicate with diagnostic programs.  Any little
memory timing problem will show up here.  I would suggest completely
disabling the cache (I guess I should add a kernel configuration
for this).  See the attachment.

> > What is the rest of this backtrace?
> >
>
> C00FF71B buf
> C00B8474 extract_entropy
> C00B8648 get random_bytes
> C00FA2B4 init_elf_binfmt
> C00F7774 start_kernel
> C000221C start_here

Oh wow.....If this is really where the code is running, something
very fundamental is broken in the hardware because there should have
been lots more printed out on the console.  You are still running in
very generic kernel functions that work on all architectures.


	-- Dan
--------------D8DE28EE2EF24951C75A6870
Content-Type: text/plain; charset=us-ascii;
 name="head_nocache"
Content-Disposition: inline;
 filename="head_nocache"
Content-Transfer-Encoding: 7bit



Change the code that looks like this:


	lis	r8, IDC_INVALL@h
	mtspr	IC_CST, r8
	mtspr	DC_CST, r8
	lis	r8, IDC_ENABLE@h
	mtspr	IC_CST, r8
#ifdef CONFIG_8xx_COPYBACK
	mtspr	DC_CST, r8
#else
	/* For a debug option, I left this here to easily enable
	 * the write through cache mode
	 */
	lis	r8, DC_SFWT@h
	mtspr	DC_CST, r8
	lis	r8, IDC_ENABLE@h
	mtspr	DC_CST, r8
#endif

/* We now have the lower 8 Meg mapped into TLB entries, and the caches
 * ready to work.
 */
#endif /* CONFIG_8xx */
	b	turn_on_mmu



To look like this:


	lis	r8, IDC_INVALL@h
	mtspr	IC_CST, r8
	mtspr	DC_CST, r8
#if 0
	lis	r8, IDC_ENABLE@h
	mtspr	IC_CST, r8
#ifdef CONFIG_8xx_COPYBACK
	mtspr	DC_CST, r8
#else
	/* For a debug option, I left this here to easily enable
	 * the write through cache mode
	 */
	lis	r8, DC_SFWT@h
	mtspr	DC_CST, r8
	lis	r8, IDC_ENABLE@h
	mtspr	DC_CST, r8
#endif
#else
	lis	r8, IDC_DISABLE@h
	mtspr	IC_CST, r8
	mtspr	DC_CST, r8
#endif

--------------D8DE28EE2EF24951C75A6870--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

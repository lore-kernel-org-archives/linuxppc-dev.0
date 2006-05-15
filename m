Return-Path: <mgreer@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id A2C57679FC
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 16 May 2006 04:58:02 +1000 (EST)
Date: Mon, 15 May 2006 11:59:51 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Assaf Hoffman <hoffman@marvell.com>
Subject: Re: Setting I&D cache enable in the same mtspr instruction
Message-ID: <20060515185951.GE6996@mag.az.mvista.com>
References: <B9FFC3F97441D04093A504CEA31B7C419E2438@msilexch01.marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <B9FFC3F97441D04093A504CEA31B7C419E2438@msilexch01.marvell.com>
Cc: Ronen Shitrit <rshitrit@marvell.com>, Rita Shtern <rita@marvell.com>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, May 08, 2006 at 01:39:13PM +0300, Assaf Hoffman wrote:
> Hi,
> I think the implementation of setup_common_caches() in file
> cpu_setup_6xx.S; not according to the spec as far as MPC74xx concerns.
> Looking in the spec (MPC7450 RISC Microprocessor Family Reference
> Manual, MPC7450UM Rev. 5 1/2005) section 3.4.1.5 L1 Instruction and Data
> Cache Flash Invalidation it says: 
> "Note that HID0[ICFI] and HID0[DCFI] must not both be set with the same
> mtspr instruction, due to the synchronization requirements described in
> Section 2.4.2.4.1, "Context Synchronization."
> But in the code those two do set together.
> Also, the same section says: 
> "An isync must precede the setting of the HID0[ICFI] in order for the
> setting to take effect."
> But in the code, only 'sync' can be found.
> 
> /* Enable caches for 603's, 604, 750 & 7400 */
> setup_common_caches:
> 	mfspr	r11,SPRN_HID0
> 	andi.	r0,r11,HID0_DCE
> 	ori	r11,r11,HID0_ICE|HID0_DCE
> 	ori	r8,r11,HID0_ICFI
> 	bne	1f			/* don't invalidate the D-cache
> */
> 	ori	r8,r8,HID0_DCI		/* unless it wasn't enabled */
> 1:	sync
> 	mtspr	SPRN_HID0,r8		/* enable and invalidate caches
> */ 
>       ^^^^^^^^^^^^^^^^^^^ Here we set both ICFI and DCFI in the same
> mtspr instruction. Also, no isync before setting ICFI.
> 	sync
> 	mtspr	SPRN_HID0,r11		/* enable caches */
> 	sync
> 	isync
> 	blr
> 
> Please advice.
> Thanks.

Yep, looks like a bug.  How about a patch?  :)

Mark

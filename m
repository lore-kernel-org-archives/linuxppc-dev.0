Message-ID: <408FEBB6.105@nortelnetworks.com>
Date: Wed, 28 Apr 2004 13:36:54 -0400
From: Chris Friesen <cfriesen@nortelnetworks.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org, linuxppc-dev@lists.linuxppc.org
Subject: confused about HID1 bits and G5
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm looking at 2.6.5, in the setup for the G5, specifically the HID1 register.

According to the docs for the chip, the default setting is all zeros, and the preferred setting is
0xFD3C200000000000.

The only place I see HID1 being set is in __power4_cpu_preinit, and it executes the following:


	mfspr	r0,SPRN_HID1
	li	r11,0x1200		/* enable i-fetch cacheability */
	sldi	r11,r11,44		/* and prefetch */
	or	r0,r0,r11
	mtspr	SPRN_HID1,r0
	mtspr	SPRN_HID1,r0
	isync

It appears that we're relying on the firmware to set up a lot of the bits in this register--is there
any reason we aren't forcing particular values?

Chris


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

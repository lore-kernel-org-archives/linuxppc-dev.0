Return-Path: <ntl@pobox.com>
Received: from rune.pobox.com (rune.pobox.com [208.210.124.79])
	by ozlabs.org (Postfix) with ESMTP id 77124DDE06
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Jan 2007 10:50:00 +1100 (EST)
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 1C6C0A48B8
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Jan 2007 18:50:15 -0500 (EST)
Received: from hawkeye (cpe-70-113-24-163.austin.res.rr.com [70.113.24.163])
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id EDBD0A2954
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Jan 2007 18:50:14 -0500 (EST)
Date: Thu, 4 Jan 2007 17:49:51 -0600
From: Nathan Lynch <ntl@pobox.com>
To: linuxppc-dev@ozlabs.org
Subject: [BUG] flash failure with CONFIG_RTAS_FLASH=m
Message-ID: <20070104234951.GJ6279@localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi-

Was trying to flash firmware on a JS20 with the rtas flash code built
modular and I got the "kernel bug" printk in rtas_flash_firmware:

        /* NOTE: the "first" block list is a global var with no data
         * blocks in the kernel data segment.  We do this because
         * we want to ensure this block_list addr is under 4GB.
         */
        rtas_firmware_flash_list.num_blocks = 0;
        flist = (struct flash_block_list *)&rtas_firmware_flash_list;
        rtas_block_list = virt_to_abs(flist);
        if (rtas_block_list >= 4UL*1024*1024*1024) {
                printk(KERN_ALERT "FLASH: kernel bug...flash list
        header addr above 4GB\n");
                return;
        }

The problem doesn't happen if CONFIG_RTAS_FLASH=y.

What's the best way to fix this?  Should rtas_firmware_flash_list be
defined in some non-modular code and exported?

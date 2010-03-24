Return-Path: <amit.shah@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id F2D8FB7CF3
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Mar 2010 02:36:11 +1100 (EST)
Date: Wed, 24 Mar 2010 21:04:08 +0530
From: Amit Shah <amit.shah@redhat.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Problem with multiple hvc consoles via virtio-console
Message-ID: <20100324153408.GB18581@amit-x200.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org,
	Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

When multiple hvc console ports are initialised and used via the
virtio_console driver, I can interact with only the first console, the
2nd one doesn't respond.

If I call hvc_kick() even if hvc_poll() returns 0, the 2nd console
becomes responsive.

I've checked that hvc_poll() receives data via get_chars() and feeds it
to tty_insert_flip_char().

Any idea what could be going wrong? This is reproducible on Linus' git
kernel as the guest kernel with the qemu.git repo.

Any pointers?

Thanks,
		Amit

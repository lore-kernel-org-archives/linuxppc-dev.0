Date: Thu, 25 Sep 2003 16:27:05 -0500 (CDT)
From: Bret Indrelee <Bret.Indrelee@qlogic.com>
Reply-To: Bret Indrelee <Bret.Indrelee@qlogic.com>
To: Matt Porter <mporter@kernel.crashing.org>,
	Roland Dreier <roland@topspin.com>
Cc: Linux PPC Embedded mailing list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Any restrictions on DMA address boundry?
In-Reply-To: <20030925135552.B17028@home.com>
Message-ID: <Pine.LNX.4.44.0309251613360.12966-100000@spider.ancor.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Just wanted to thank both Matt Porter and Roland Dreier for taking
the time to explain the situation.

I've aligned our buffers to 32 bytes on PPC and am in the process of
confirming the x86 snoop/coherency situation. Aligning it this way
makes the transfer slightly faster anyways, since the 8245 PCI
bridge will cause a disconnect at every 32-byte boundary on a
PCI burst read.

Since the work I'm doing is embedded and we use the same buffer
format between application and driver/kernel space, I'm using
a fixed number rather than L1_CACHE_BYTES. The define for L1_CACHE_BYTES
is only available (as it probably should be) only if you've defined
KERNEL.

-Bret

--
Bret Indrelee                 QLogic Corporation
Bret.Indrelee@qlogic.com      6321 Bury Drive, St 13, Eden Prairie, MN 55346


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

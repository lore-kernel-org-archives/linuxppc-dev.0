Message-ID: <3E40E4A6.50303@imms.de>
Date: Wed, 05 Feb 2003 11:17:10 +0100
From: Rolf Peukert <rolf.peukert@imms.de>
MIME-Version: 1.0
To: Linux-PPC-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: MPC850 SCC3/USB host conflict
References: <3E3A9FAD.9070409@imms.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Rolf Peukert wrote:
...

 > USB works fine when SCC3 UART is not enabled, as does SCC3 without
 > USB. But when both config options are selected, the kernel will hang
 > during bootup, ...

It turned out our problems were caused by m8xx_cpm_dpalloc() running out
of memory.
We didn't notice this for so long, because the return value of some
...dpalloc calls in uart.c and enet.c isn't checked. Even worse, our
version of m8xx_cpm_dpalloc didn't return the predefined error flag
CPM_DP_NOSPACE, but just a 0 upon failure (AFAIK the version in the
current kernel doesn't have this problem).

We solved the conflict by making more memory available for ...dpalloc,
as the USB microcode patch only needs the first 512 and last 256 bytes
reserved (CPM_DATAONLY_BASE is now 0x0200, CPM_DATAONLY_SIZE 0x0D00).

Best wishes,
Rolf


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

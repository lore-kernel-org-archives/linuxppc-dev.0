Message-ID: <39F866D9.B167DC78@mvista.com>
Date: Thu, 26 Oct 2000 10:16:09 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
Reply-To: mgreer@mvista.com
MIME-Version: 1.0
To: Topi Kanerva <tkanerva@ees2.oulu.fi>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: sandpoint woes.
References: <Pine.GSO.4.21.0010261820540.18282-100000@stekt6>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Topi Kanerva wrote:

> init started:  BusyBox v0.43 (2000.07.20-00:29+0000) multi-call binary
> Sorry, your computer does not have enough memory.              \
>
> ...
> DINK reports that my sandpoint does have 64M of memory, but when Linux
> kernel boots, it only finds 32M of memory (29056k available (944k kernel
> code, 404k data, 172k init)) ... I even tried to put a "mem=64M" kernel
> bootoption, but it didn't make any difference. Any ideas?

Yes, DINK lies.  At least on all the boards I have, there are 32 MB of memory
even though DINK says there are 64MB (DINK enables an extra memory bank of 32 MB
in the mem ctlr even though the memory doesn't exist).  To combat that, I
hard-coded 32MB--yes, an ugly hack--in
arch/ppc/mm/init.c:sandpoint_find_end_of_memory().  If you believe you really
have 64 MB, go ahead and change that routine to report 64MB or whatever you
think is appropriate.

Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

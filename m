Message-ID: <3E300E28.4010804@embeddededge.com>
Date: Thu, 23 Jan 2003 10:45:44 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Shen Rong <rshen@udtech.com.cn>
Cc: Joakim Tjernlund <Joakim.Tjernlund@lumentis.se>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: wrong definition in cpm_8260.h?
References: <IGEFJKJNHJDCBKALBJLLGEIOFJAA.joakim.tjernlund@lumentis.se> <3E2F1920.9070702@embeddededge.com> <001301c2c26b$2a06e7a0$020120b0@jockeXP> <013f01c2c283$d2511a30$e600a8c0@udtech.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Shen Rong wrote:

> I am changing the fcc enet buffer management and interrupt
> strategy to reduce the interrupt number when receiving the
> small frame(say 64 bytes).

I don't understand.  The current driver will get exactly one
interrupt per frame (or maybe less if frames are coming in fast
and they are queued), regardless of the frame size.

> .... But at least the so called final_version in fcc_enet_rx
> need to be changed since it's do nothing but eat the cpu.

This was just for debugging, I don't even think that code is compiled anymore.
Take it out if you wish.  This driver is....hell....six or seven years old
already and was used to debug 8xx silicon.  We were happy when it actually
sent and received frames on the wire, so there is likely to be some debug
stuff here that can be removed.

The purpose for using first/last is so you can split a frame across multiple
BDs, making the use of memory a little more efficient.  Using this method,
you can't dma directly into sk buffers, you will have to check for the
buffer sequences and copy the data into the sk buffers.  This method also
increases the number of interrupts you will receive (all high performance
network devices are polled with carefully tuned data transfer functions)
and increases the amount of CPU needed for processing every frame.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

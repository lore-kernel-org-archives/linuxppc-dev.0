Message-ID: <3DD25896.6020603@uab.ericsson.se>
Date: Wed, 13 Nov 2002 14:50:14 +0100
From: Hans Feldt <Hans.Feldt@uab.ericsson.se>
MIME-Version: 1.0
To: Joakim Tjernlund <Joakim.Tjernlund@lumentis.se>
Cc: linuxppc-embedded@lists.linuxppc.org, scop@digitel.com.br,
	thomas@corelatus.com
Subject: Re: [PATCH] arch/ppc/8xx_io/enet.c, version 2
References: <200210241423.g9OENV4d024137@blooper.utfors.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On 10/24/02 04:23 PM, Joakim Tjernlund wrote:
> Hi
>
> This is the second version of my patch that removes the expensive memcpy of
> received
> ethernet frames in interrupt context.

Isn't it so that this patch works because you have snooping? Without
snooping the driver would fail because of cache line replacement which
could trash received data.

The buffer invalidate in this case is unneeded. But if you wanna
optimise you should invalidate the whole buffer before giving it to DMA
thus getting rid of the flush implied by memory coherence.

Tried this out in a driver for a processor without snooping, now and
then received packets got corrupted, cache line wise...

Just trying to understand how things really work, please correct me if I
am wrong.

Cheers,
Hans


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

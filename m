Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 07145B6F2B
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  3 Sep 2009 17:32:15 +1000 (EST)
In-Reply-To: <200909031015.15080.ganeshkumar@signal-networks.com>
References: <200908281734.56489.ganeshkumar@signal-networks.com>
	<OF0B184DAC.3E68F19C-ONC1257620.0044C588-C1257620.00466F8B@transmode.se>
	<200909031015.15080.ganeshkumar@signal-networks.com>
Subject: Re: MPC866 FEC's Receive processing thru pre allocated buffers
To: Ganesh Kumar <ganeshkumar@signal-networks.com>
Message-ID: <OF50B534B1.B806E4DC-ONC1257626.00275980-C1257626.002875D7@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Thu, 3 Sep 2009 09:21:56 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ganesh Kumar <ganeshkumar@signal-networks.com> wrote on 03/09/2009 06:45:14:
>
> Hi Tjernlund,
>
>     Thanks a lot for the reply.
>
> I checked in my code regarding to the invalidate/flushing of the
> data cache. In the fec_init its been done by calling the sequence
>
>        /* Make it uncached.
>         */
>         pte = va_to_pte(mem_addr);
>         pte_val(*pte) |= _PAGE_NO_CACHE;
>         flush_tlb_page(init_mm.mmap, mem_addr);
> So I did the same thing whenever I allocated new skb, but the
> problems still showed up, then I saw one comment in FEC code where
> it says
>
>         /* This does 16 byte alignment, exactly what we need.
>          * The packet length includes FCS, but we don't want to
>          * include that when passing upstream as it messes up
>          * bridging applications.
>          */
> while receiving the frames, I checked my modified code w.r.t the length,
> since I was not knowing the receive lengthn while allocating for the
> RX ring, I did with a maximum of 2048 bytes length and called the skb_put
> to reserve 2048 bytes for data, calling of the skb_put also updated the
> skb->len field with 2048, this was causing the problem, the bridge module
> was trying to send the frame with 2048 bytes even though the actual length
> was less number of bytes, so even after sending it to the FEC, the frame was
> getting transmitted successfully. So I updated the actual length to the
> skb->len field in the rx ISR, the problem is solved now.
>
> But I'm facing problems during load time in bridge mode
>  PC-1 ---->eth0  [Bridge machine] eth1 ----> PC-2
> With the above setup I initiate 1500 pings each  of 1400  bytes
> from PC1 to PC2, then the ping sequence starts, but after some time
> say some 25-35(all 1500 instances) sequences all of a sudden no
> ping reply is received for any request.
> At that time if I observe in the Bridge machine cat /proc/interrupts
> the fec interrupts will not get updated there(initially it used to)
> again it resumes after some 45-60 seconds and the sequence repeats.
> Dunno what's happening with in the FEC if configured in bridge mode
> any clue on this, Thanks a lakh in advance.

If I remember correctly, this is what you get when the invalidation
of the skb buffers isn't working properly.

Guessing again, but you seem to split up the page into two buffers of len 2048,
but you flush/invalidate the whole page. That won't work.

You are much better off by just using plain skb allocation and invalidate
the buffer before passing it to the CPM/FEC. Just make sure that the allocated
buffer has a cache aligned length. This is what I did long time ago and it worked
out perfectly.

 Jocke

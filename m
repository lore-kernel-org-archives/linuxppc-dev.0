Return-Path: <ganeshkumar@signal-networks.com>
Received: from smtp.bizmail.net4india.com (smtp1.bizmail.net4india.com
	[202.71.129.104])
	by bilbo.ozlabs.org (Postfix) with ESMTP id E52F5B7093
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  3 Sep 2009 14:42:00 +1000 (EST)
Received: from [122.166.21.73] (helo=signal-networks.com)
	by smtp.bizmail.net4india.com with esmtp (Exim 4.69)
	(envelope-from <ganeshkumar@signal-networks.com>) id 1Mj48A-0002MH-6P
	for linuxppc-dev@lists.ozlabs.org; Thu, 03 Sep 2009 10:11:40 +0530
Received: from [192.168.1.13] by signal-networks.com (MDaemon Standard v10.0.5)
	with ESMTP id md50000414031.msg
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Sep 2009 10:20:46 +0530
From: Ganesh Kumar <ganeshkumar@signal-networks.com>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: MPC866 FEC's Receive processing thru pre allocated buffers
Date: Thu, 3 Sep 2009 10:15:14 +0530
References: <200908281734.56489.ganeshkumar@signal-networks.com>
	<OF0B184DAC.3E68F19C-ONC1257620.0044C588-C1257620.00466F8B@transmode.se>
In-Reply-To: <OF0B184DAC.3E68F19C-ONC1257620.0044C588-C1257620.00466F8B@transmode.se>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200909031015.15080.ganeshkumar@signal-networks.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Tjernlund,

    Thanks a lot for the reply.

I checked in my code regarding to the invalidate/flushing of the=20
data cache. In the fec_init its been done by calling the sequence

       /* Make it uncached.
        */
        pte =3D va_to_pte(mem_addr);
        pte_val(*pte) |=3D _PAGE_NO_CACHE;
        flush_tlb_page(init_mm.mmap, mem_addr);
So I did the same thing whenever I allocated new skb, but the=20
problems still showed up, then I saw one comment in FEC code where=20
it says

        /* This does 16 byte alignment, exactly what we need.
         * The packet length includes FCS, but we don't want to
         * include that when passing upstream as it messes up
         * bridging applications.
         */
while receiving the frames, I checked my modified code w.r.t the length,
since I was not knowing the receive lengthn while allocating for the
RX ring, I did with a maximum of 2048 bytes length and called the skb_put
to reserve 2048 bytes for data, calling of the skb_put also updated the
skb->len field with 2048, this was causing the problem, the bridge module=20
was trying to send the frame with 2048 bytes even though the actual length
was less number of bytes, so even after sending it to the FEC, the frame was
getting transmitted successfully. So I updated the actual length to the
skb->len field in the rx ISR, the problem is solved now.

But I'm facing problems during load time in bridge mode
 PC-1 ---->eth0  [Bridge machine] eth1 ----> PC-2
With the above setup I initiate 1500 pings each  of 1400  bytes
from PC1 to PC2, then the ping sequence starts, but after some time
say some 25-35(all 1500 instances) sequences all of a sudden no=20
ping reply is received for any request.
At that time if I observe in the Bridge machine cat /proc/interrupts
the fec interrupts will not get updated there(initially it used to)
again it resumes after some 45-60 seconds and the sequence repeats.
Dunno what's happening with in the FEC if configured in bridge mode
any clue on this, Thanks a lakh in advance.

=2D-Ganesh

On Friday 28 August 2009 18:19, you wrote:
> > Hi All,
> >
> > I've already sent this almost before 6-7 hours, but the
> > mail did not appear on the Aug 2009 archives, So I'm sending
> > it again. Sorry for this!!. Thanks in advance.
> >
> > =A0 =A0 =A0 =A0 I'm working on MPC860 with Linux Kernel 2.4.18.
> > As I'm fine tuning the FEC(Fast Ethernet Controller) driver,
> > I came across the receive side processing of the ethernet frames
> > where in the Rx BD rings are preallocated with the buffers and each time
> > a new frame is received, the whole frame will get copied from the Buffer
> > Descriptors to the external memory by allocating the skb.
> > Is this the right way to do that ?, as memcpy is not efficient inside t=
he
> > ISRs.
> > So I did some changes in the RX BDs initialization, like allocate the s=
kb
> > and initialize the BD's address pointer with the skb->data(using __pa)
> > and then on reception of the frame I take out the skb from theBD and
> > allocate a new skb and reinit the BD address with the newly allocated
> > skb->data.
> >
> > It works for normal conditions, but if I load the driver then
> > I receive lots of corrupted frames, So I tried increasing the
> > RX_RING_SIZE(16) and also enabling the receive dscriptor active only
> > after I come out of the while loop (inside fec_enet_rx)
> > Increasing the Rx ring eliminated the frame corruption and runs fine on
> > load test.
> >
> > But if I configure my Linux box in bridge mode then it doesn't work,
> > i.e., the bridging doesn't happen,
> >
> > =A0 =A0PC-1 ---->eth0 =A0[Bridge machine] eth1 ----> PC-2
> > What I mean here is if we initiate a ping from the
> > PC-1 to PC-2, I don't get any response,
> > it continously try to resole the ARP.
> >
> > What may be the reason??
> > Thanks in advance
>
> A guess, you are missing invalidating the dcache when handing a skb to
> the CPM:
>
> #define CPM_ENET_RX_FRSIZE	L1_CACHE_ALIGN(PKT_MAXBUF_SIZE) /* This is
> needed so that invalidate_xxx wont invalidate too much */
>
> static inline void invalidate_dcache_region(void *adr, unsigned long len)
> {
> 	/* if(len =3D=3D 0) return; len will never be zero */
> 	len =3D ((len-1) >> LG_L1_CACHE_LINE_SIZE) +1;
> 	do {
> 		asm  ("dcbi     0,%0" : : "r" (adr) : "memory");
> 		adr +=3D L1_CACHE_LINE_SIZE;
> 	} while(--len);
> }
> then:
>   invalidate_dcache_region(skb->data, CPM_ENET_RX_FRSIZE);
>   bdp->cbd_bufaddr =3D __pa(skb->data);

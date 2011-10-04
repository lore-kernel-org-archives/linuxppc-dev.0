Return-Path: <cascardo@linux.vnet.ibm.com>
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e24smtp05.br.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 56799B6F75
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  5 Oct 2011 07:26:34 +1100 (EST)
Received: from /spool/local by br.ibm.com with XMail ESMTP
	for <linuxppc-dev@lists.ozlabs.org> from <cascardo@linux.vnet.ibm.com>;
	Tue, 4 Oct 2011 17:26:29 -0300
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
	by d24relay01.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p94KPBbI3379260
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Oct 2011 17:25:11 -0300
Received: from d24av05.br.ibm.com (loopback [127.0.0.1])
	by d24av05.br.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p94KQMuF022890
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Oct 2011 17:26:22 -0300
Date: Tue, 4 Oct 2011 17:26:20 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] mlx4_en: fix transmit of packages when blue frame is
	enabled
Message-ID: <20111004202620.GA3455@oc1711230544.ibm.com>
References: <1317388995-411-1-git-send-email-cascardo@linux.vnet.ibm.com>
	<953B660C027164448AE903364AC447D2235D9A8C@MTLDAG02.mtl.com>
	<20111003143721.GA3596@oc1711230544.ibm.com>
	<953B660C027164448AE903364AC447D2235DAA9D@MTLDAG02.mtl.com>
	<20111003205358.GB3596@oc1711230544.ibm.com>
	<1317708132.29415.213.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1317708132.29415.213.camel@pasglop>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Eli Cohen <eli@mellanox.co.il>,
	"eli@dev.mellanox.co.il" <eli@dev.mellanox.co.il>,
	linuxppc-dev@lists.ozlabs.org, Yevgeny Petrilin <yevgenyp@mellanox.co.il>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 04, 2011 at 08:02:12AM +0200, Benjamin Herrenschmidt wrote:
> On Mon, 2011-10-03 at 17:53 -0300, Thadeu Lima de Souza Cascardo wrote:
> 
>  .../...
> 
> > > Can you also send me the output of ethtool -i?
> > > It seems that there is a problem with write combining on Power processors, we will check this issue.
> > > 
> > > Yevgeny
> > 
> > Hello, Yevgeny.
> > 
> > You will find the output of ethtool -i below.
> > 
> > I am copying Ben and powerpc list, in case this is an issue with Power
> > processors. They can provide us some more insight into this.
> 
> May I get some background please ? :-)
> 
> I'm not aware of a specific issue with write combining but I'd need to
> know more about what you are doing and the code to do it to comment on
> whether it should work or not.
> 
> Cheers,
> Ben.
> 
> 

Hello, Ben.

Sorry for that. I am testing mlx4_en driver on a POWER. Yevgeny has
added blue frame support, that does not require writing to the device
memory to indicate a new packet (the doorbell register as it is called).

Well, the ring is getting full with no interrupt or packets transmitted.
I simply added a write to the doorbell register and it works for me.
Yevgeny says this is not the right fix, claiming there is a problem with
write combining on POWER. The code uses memory barriers, so I don't know
why there is any problem.

I am posting the code here to show better what the situation is.
Yevgeny can tell more about the device and the driver.

The code below is the driver as of now, including a diff with what I
changed and had resulted OK for me. Before the blue frame support, the
only code executed was the else part. I can't tell much what the device
should be seeing and doing after the blue frame part of the code is
executed. But it does send the packet if I write to the doorbell
register.

Yevgeny, can you tell us what the device should be doing and why you
think this is a problem on POWER? Is it possible that this is simply a
problem with the firmware version?

Thanks,
Cascardo.

---
        if (ring->bf_enabled && desc_size <= MAX_BF && !bounce &&
!vlan_tag) {
                *(u32 *) (&tx_desc->ctrl.vlan_tag) |=
ring->doorbell_qpn;
                op_own |= htonl((bf_index & 0xffff) << 8);
                /* Ensure new descirptor hits memory
                * before setting ownership of this descriptor to HW */
                wmb();
                tx_desc->ctrl.owner_opcode = op_own;

                wmb();

                mlx4_bf_copy(ring->bf.reg + ring->bf.offset, (unsigned
long *) &tx_desc->ctrl,
                     desc_size);

                wmb();

                ring->bf.offset ^= ring->bf.buf_size;
        } else {
                /* Ensure new descirptor hits memory
                * before setting ownership of this descriptor to HW */
                wmb();
                tx_desc->ctrl.owner_opcode = op_own;
-               wmb();
-               writel(ring->doorbell_qpn, ring->bf.uar->map +
MLX4_SEND_DOORBELL);
        }

+       wmb();
+       writel(ring->doorbell_qpn, ring->bf.uar->map +
MLX4_SEND_DOORBELL);
+
---

Return-Path: <ganeshkumar@signal-networks.com>
Received: from smtp.bizmail.net4india.com (smtp1.bizmail.net4india.com
	[202.71.129.104])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 8D611B7C0E
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 29 Aug 2009 02:41:04 +1000 (EST)
Received: from [122.166.21.73] (helo=signal-networks.com)
	by smtp.bizmail.net4india.com with esmtp (Exim 4.69)
	(envelope-from <ganeshkumar@signal-networks.com>) id 1MguiY-0000s6-Sa
	for linuxppc-dev@lists.ozlabs.org; Fri, 28 Aug 2009 11:43:47 +0530
Received: from [192.168.1.13] by signal-networks.com (MDaemon Standard v10.0.5)
	with ESMTP id md50000411656.msg
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Aug 2009 11:55:35 +0530
From: Ganesh Kumar <ganeshkumar@signal-networks.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: MPC866 FEC's Receive processing thru pre allocated buffers
Date: Fri, 28 Aug 2009 11:50:40 +0530
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200908281150.40521.ganeshkumar@signal-networks.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

        I'm working on MPC860 with Linux Kernel 2.4.18.
As I'm fine tuning the FEC(Fast Ethernet Controller) driver,
I came across the receive side processing of the ethernet frames
where in the Rx BD rings are preallocated with the buffers and each time
a new frame is received, the whole frame will get copied from the Buffer
Descriptors to the external memory by allocating the skb.
Is this the right way to do that ?, as memcpy is not efficient inside the
ISRs.
So I did some changes in the RX BDs initialization, like allocate the skb
and initialize the BD's address pointer with the skb->data(using __pa)
and then on reception of the frame I take out the skb from theBD and allocate
a new skb and reinit the BD address with the newly allocated skb->data.

It works for normal conditions, but if I load the driver then
I receive lots of corrupted frames, So I tried increasing the RX_RING_SIZE(16)
and also enabling the receive dscriptor active only after I come out of the 
while loop (inside fec_enet_rx) 
Increasing the Rx ring eliminated the frame corruption and runs fine on load
test.

But if I configure my Linux box in bridge mode then it doesn't work,
i.e., the bridging doesn't happen,

   PC-1 ---->eth0  [Bridge machine] eth1 ----> PC-2
What I mean here is if we initiate a ping from the 
PC-1 to PC-2, I don't get any response,
it continously try to resole the ARP.

What may be the reason??
Thanks in advance

Please do CC to me as I'm not subscribed to this list.

--GK

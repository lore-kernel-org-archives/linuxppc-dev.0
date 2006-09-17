Return-Path: <Phillip.Knaack@motorola.com>
Received: from motgate8.mot.com (motgate8.mot.com [129.188.136.8])
	by ozlabs.org (Postfix) with ESMTP id 27C7A67B69
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 17 Sep 2006 14:38:44 +1000 (EST)
Received: from il06exr04.mot.com (il06exr04.mot.com [129.188.137.134])
	by motgate8.mot.com (8.12.11/Motorola) with ESMTP id k8H4cg3v018675
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 16 Sep 2006 21:38:42 -0700 (MST)
Received: from de01exm71.ds.mot.com (de01exm71.am.mot.com [10.176.8.27])
	by il06exr04.mot.com (8.13.1/8.13.0) with ESMTP id k8H4cg76016938
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 16 Sep 2006 23:38:42 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: Unicast DHCP OFFER?
Date: Sun, 17 Sep 2006 00:38:41 -0400
Message-ID: <69BAB3EF0F351C408644243926DF3A5101369BEA@de01exm71.ds.mot.com>
From: "Knaack Phillip-PKNAACK1" <Phillip.Knaack@motorola.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Greetings!

You should all ignore this message. I found that someone here had
modified the netif_rx code in a really stupid way.  I now see how it
works.

-Phil K

-----Original Message-----
From: Knaack Phillip-PKNAACK1=20
Sent: Saturday, September 16, 2006 5:02 PM
To: 'linuxppc-embedded@ozlabs.org'
Subject: Unicast DHCP OFFER?

Greetings!

This isn't really a powerpc question, more of a general Linux question,
although I'm working on an embedded powerpc target board.  It's a stupid
question about DHCP.

My target is running udhcpc over a wireless (not wi-fi) interface to a
remote radio which is running a dhcp relay agent. I see the DHCP
discover sent out, and I see (at the driver level) the DHCP offer coming
back.  However, the offer is being sent unicast directly to my (new) IP
address, which I don't know yet.  As a result, the ip stack is dropping
the packet because of "no route".  So I ask myself, how can I receive a
UDP packet addressed directly to me if I don't yet know my own address?
It defies logic.
And the odd part is, it works with another version of this card on
Windows, though I wouldn't be surprised if they just hacked it up to
"just work" anyway.

Because of the nature of this wireless connection, it really needs to be
unicast.  I'm thinking of recognizing a UDP/DHCP packet in the radio
driver and hacking the iphdr source addr to be a broadcast, so the raw
socket in udhcpc will receive it, but this shouldn't be necessary.

So-- how is a unicast dhcp offer supposed to work?

-Phil K

Return-Path: <Alexandre.Bounine@tundra.com>
Received: from mx2.tundra.com (mail2.tundra.com [142.46.200.162])
	by ozlabs.org (Postfix) with ESMTP id 420C0DE181
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 03:24:36 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] Fix Tsi108 ethernet driver performance
Date: Mon, 16 Jul 2007 13:25:27 -0400
Message-ID: <1B5F013528140F45B5C671039279CA5701F834AD@NANUK.pc.tundra.com>
In-Reply-To: <4697E160.9000009@freescale.com>
From: "Alexandre Bounine" <Alexandre.Bounine@tundra.com>
To: "Scott Wood" <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I agree that 20 ms is not the best option. But, as you mentioned as
well, shorter period may bring more wasted CPU cycles.
Using this approach to interrupt moderation I see performance
improvement using frame flow that generates about one interrupt per
frame. Below are CPU usage numbers reported by top for the current and
patched versions of the Tsi108_eth driver.=20=20=20=20=20=20=20

Current version:
Cpu(s):  0.0% us, 0.3% sy, 0.0% ni, 14.6% id, 0.0% wa, 14.6% hi, 70.4%
si

Patched version:
Cpu(s):  0.0% us, 0.0% sy, 0.0% ni, 35.2% id, 1.2% wa, 2.4% hi, 61.2% si

- Alex.


-----Original Message-----
From: Scott Wood [mailto:scottwood@freescale.com]=20
Sent: Friday, July 13, 2007 4:33 PM
To: Scott Wood
Cc: Alexandre Bounine; linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Fix Tsi108 ethernet driver performance

Scott Wood wrote:
> Wouldn't this cause latencies of up to a second in responding to=20
> received packets?  I'd think that would be considered excessive.
>=20
> And shouldn't NAPI be reducing the RX interrupt load anyway?

Sorry, I missed that you reduced the interval to 20 ms.  Still, a bit on

the high side, and a source of wasted CPU cycles when the network isn't=20
heavily loaded.  How much of a difference in CPU usage did you see with=20
this patch?

-Scott

---=0D
=0D
Important Notice: This message is intended for the use of the individual to=
 whom it is addressed and may contain information which is privileged, conf=
idential and/or exempt from disclosure under applicable law. If the reader =
of this message is not the intended recipient, or is not the employee or ag=
ent responsible for delivering the message to the intended recipient, you a=
re hereby notified that any dissemination, distribution, or copying of this=
 communication is strictly prohibited. If you have received this communicat=
ion in error, please notify the sender immediately by telephone or return e=
-mail and delete the original message from your systems. Thank you. =0D

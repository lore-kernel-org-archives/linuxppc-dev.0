Return-Path: <glikely@secretlab.ca>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.29])
	by ozlabs.org (Postfix) with ESMTP id 7DB64DDFEC
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Apr 2009 03:12:13 +1000 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so1703656yxg.39
	for <linuxppc-dev@ozlabs.org>; Tue, 07 Apr 2009 10:12:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <49DB8033.1090908@embeddedarm.com>
References: <49DB8033.1090908@embeddedarm.com>
Date: Tue, 7 Apr 2009 10:11:56 -0700
Message-ID: <fa686aa40904071011n22084931wc8900606fd62f167@mail.gmail.com>
Subject: Re: AMCC 440EP phy detection
From: Grant Likely <grant.likely@secretlab.ca>
To: Eddie Dawydiuk <eddie@embeddedarm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 7, 2009 at 9:32 AM, Eddie Dawydiuk <eddie@embeddedarm.com> wrot=
e:
> Hello,
>
> I'm working on a board based on the Yosemite AMCC 440EP eval board. I'm
> having some difficulty getting both network interfaces working. The first
> problem I found is the ibm_newemac driver was detecting the two phys at
> address 0 and 1 where we have them wired for addresses 1 and 3. As a resu=
lt
> I hardcoded the phy-address in the dts file. I then found I was able to
> receive and send data on eth1(phy-address 3) without incident. Although I
> found eth0 can receive data but I see no packets being transmitted(using =
a
> packet sniffer) and I see no indication from a software standpoint of any
> transmit failures. We are using Micrel KSZ8041FTL phys(RMII mode) where t=
he
> Yosemite board used Micrel KS8721BL phys. =A0I've reviewed the schematic =
and
> it appears both phys are connected identically and I've seen this same
> failure on multiple boards. I thought the fact that the driver detected a
> phy at address 0 might be a clue, but I can't make much of the clue. So I
> thought I'd post this info in the hopes someone else might have run into =
a
> similar problem or have a suggestion.

Phy address 0 is the broadcast address.  All phys will usually respond
to address 0 accesses.  Off the top of my head, It sounds like one PHY
is responding to addresses 0 & 1, and the other phy isn't responding
at all.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

Return-Path: <pppeterpppan@gmail.com>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.145])
	by ozlabs.org (Postfix) with ESMTP id 65CC0B7080
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 31 Mar 2010 14:16:02 +1100 (EST)
Received: by qw-out-1920.google.com with SMTP id 4so2992022qwk.50
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 30 Mar 2010 20:16:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4BB2BB24.6080003@conspiracy.net>
References: <48abf2c21003301846h67106ce6h8d51ad167374793f@mail.gmail.com>
	<4BB2BB24.6080003@conspiracy.net>
Date: Wed, 31 Mar 2010 11:15:59 +0800
Message-ID: <48abf2c21003302015m4c123d65hbee4525a1213b91d@mail.gmail.com>
Subject: Re: I can not get my MII working on MPC8247 with Linux 2.6.32.6
From: Peter Pan <pppeterpppan@gmail.com>
To: "paul@conspiracy.net" <paulfax@conspiracy.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I tried to skip the turn around bit check in source, but the mii bus
still get the 0xffffffff PHYIDs.
I will check if there is any pull ups on mdio line.
Thank you.

2010/3/31 paul@conspiracy.net <paulfax@conspiracy.net>:
> I had the same issue on a board. =A0The original was config was a 8247
> with 2.6.27 and changed the CPU card in the system to 8567 & 2.6.32.
> The old code did not check the turn around bit. =A0Can't remember the
> exact fix but as I remember if there are no pull ups on the mdio line
> the turn around bit will not be in the correct state (it just opens the
> line not not driving it to 1). =A0Will try to ask the hw guy if he
> remembers when he comes in tomorrow.
> Paul
>
> On 3/30/2010 8:46 PM, Peter Pan wrote:
>> Recently, I'm porting Linux 2.6.32.6 to our customized MPC8247 based
>> board. Everything is fine out except my ethernets. I uses
>> cpm2-scc-enet and cpm2-fcc-enet drivers.
>> My ethernet works fine in U-Boot with the same setting, and our
>> previous Linux 2.6.22 is also working, so there should be nothing
>> wrong with the hardware.
>> The boot log of the MII part is:
>>
>> CPM2 Bitbanged MII: probed
>> mdio_bus f0010d00: error probing PHY at address 0
>> mdio_bus f0010d00: error probing PHY at address 1
>>
>> I add some print, and find out that the MII bus can not be get the
>> turn around bit, and can not get the PHYIDs. That makes the PHY probe
>> failed.
>> Maybe it's because my wrongly typed dts file? My ethernet part of my
>> dts file is:
>> My MDIO pin is using PA23, MDC pin is using PA22.

>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@lists.ozlabs.org
>> https://lists.ozlabs.org/listinfo/linuxppc-dev
>>
>
>

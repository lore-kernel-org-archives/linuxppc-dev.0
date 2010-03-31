Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 99CDDB7CF4
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 31 Mar 2010 21:17:27 +1100 (EST)
Message-ID: <4BB320D3.9090308@grandegger.com>
Date: Wed, 31 Mar 2010 12:15:47 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Roman Fietze <roman.fietze@telemotive.de>
Subject: Re: MPC5200B, many FEC_IEVENT_RFIFO_ERRORs until link down
References: <201003301200.54609.roman.fietze@telemotive.de>
	<4BB1D674.2050800@grandegger.com>
In-Reply-To: <4BB1D674.2050800@grandegger.com>
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

Hi Roman,

Wolfgang Grandegger wrote:
> Roman Fietze wrote:
>> Hello,
>>
>> I think this is a never ending story. This error still happens under
>> higher load every few seconds, until I get a "PHY: f0003000:00 - Link
>> is Down", on my box easiliy reproducable after maybe 15 to 30 seconds.
>> I can recover using "ip link set down/up dev eth0".
>>
>> I double checked that I'm using the most recent version of this driver
>> (checked with DENX, benh master/next, using Wolfgang Denk's version of
>> the 2.6.33), this includes the locking patches from Asier Llano, the
>> hard setting of mii_speed in the PHY mdio transfer routine of course.
>> I tried all 8 combinations of PLDIS, BSDIS and SE, with and without
>> CONFIG_NOT_COHERENT_CACHE.
>>
>> As some of you probably remember, I'm running this controller under
>> high load on FEC, ATA and LPC. As soon as "the" load is going above a
>> certain level I get those FEC RFIFO errors, sometimes ATA errors
>> (MWDMA2) and sometimes even lost SDMA interrupts using BestComm with
>> the SCLPC (now switched back to simple PIO). I quite sure almost all
>> of this is the BestComm's fault.
> 
> This problem shows up quickly with NAPI, but I have never observed it
> with the current version. The error occurs when the software is not able
> to readout the messages in time. Unfortunately, dealing with Bestcomm is
> a pain.
> 
>> Did somebody already try the latest NAPI patches, which might give me
>> a slight chance to have a workaround? Any idea or upcoming patch to
>> address this problem once more, and if it's just by recovering e.g.
>> within mpc52xx_fec_mdio_transfer's timeout using some other dirty
>> workaround?
> 
> Yes, I have a NAPI version ready for testing. I will roll it out as RFC
> today or tomorrow.

I just sent out the patch. Would be nice if you, or somebody else, could
do some testing and provide some feedback. FYI, I will be out of office
next week.

Thanks,

Wolfgang.

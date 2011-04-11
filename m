Return-Path: <fabeisageek@googlemail.com>
Received: from mail-iw0-f170.google.com (mail-iw0-f170.google.com
	[209.85.214.170]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8C888B6F16
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Apr 2011 18:23:27 +1000 (EST)
Received: by iwn3 with SMTP id 3so7889919iwn.15
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Apr 2011 01:23:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <071A08F2C6A57E4E94D980ECA553F87416D42F@039-SN1MPN1-004.039d.mgd.msft.net>
References: <4B27FEE3.80001@embedded-sol.com>
	<0949C49693EF1A47A54B0F0113CDB4A607674F@zin33exm23.fsl.freescale.net>
	<4B28A7C3.6040209@embedded-sol.com>
	<0949C49693EF1A47A54B0F0113CDB4A6076776@zin33exm23.fsl.freescale.net>
	<4B28CBC4.4010501@embedded-sol.com>
	<0949C49693EF1A47A54B0F0113CDB4A6076791@zin33exm23.fsl.freescale.net>
	<4B29DC2B.8090405@embedded-sol.com>
	<0949C49693EF1A47A54B0F0113CDB4A60767E8@zin33exm23.fsl.freescale.net>
	<4B29F23A.9070001@embedded-sol.com>
	<0949C49693EF1A47A54B0F0113CDB4A60767F0@zin33exm23.fsl.freescale.net>
	<EBE3ECA5-AC1B-4E1C-A0DA-89260D0F03F6@kernel.crashing.org>
	<4B2A946E.4040907@embedded-sol.com>
	<BANLkTimf8uwgew3YPcNxdNj+4XamPhbxbQ@mail.gmail.com>
	<071A08F2C6A57E4E94D980ECA553F87416D42F@039-SN1MPN1-004.039d.mgd.msft.net>
Date: Mon, 11 Apr 2011 10:23:23 +0200
Message-ID: <BANLkTi=QHOPTiuu2uXr1AcCXrpL3AT4cUw@mail.gmail.com>
Subject: Re: Problem with mini-PCI-E slot on P2020RDB
From: Fabian Bertholm <fabeisageek@googlemail.com>
To: Kushwaha Prabhakar-B32579 <B32579@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Mahajan Vivek-B08308 <B08308@freescale.com>,
	Felix Radensky <felix@embedded-sol.com>,
	Aggrwal Poonam-B10812 <B10812@freescale.com>,
	Leon Woestenberg <leon.woestenberg@gmail.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Gupta Maneesh-B18878 <B18878@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Kushwaha Prabhakar,

Our impression is that there is the same issue on the P1020/P1011 RDB.
Can you confirm this?

Best Regards,
Fabe


2011/4/8 Kushwaha Prabhakar-B32579 <B32579@freescale.com>:
>
>
>> -----Original Message-----
>> From: Leon Woestenberg [mailto:leon.woestenberg@gmail.com]
>> Sent: Thursday, April 07, 2011 10:50 PM
>> To: linuxppc-dev@ozlabs.org
>> Cc: Kumar Gala; Mahajan Vivek-B08308; Aggrwal Poonam-B10812; Felix
>> Radensky; Kushwaha Prabhakar-B32579
>> Subject: Re: Problem with mini-PCI-E slot on P2020RDB
>>
>> Hello,
>>
>> On Thu, Dec 17, 2009 at 9:28 PM, Felix Radensky <felix@embedded-sol.com>
>> wrote:
>> > Kumar Gala wrote:
>> >> On Dec 17, 2009, at 2:59 AM, Mahajan Vivek-B08308 wrote:
>> >>>> Thanks a lot. If I understand you correctly, the only way I can get
>> >>>> ath9k driver to work on this board using legacy interrupts is to
>> >>>> wait for a hardware fix. Right ?
>> >>>>
>> >>> Correct
>> >>
>> >> I'm confused. =A0What's the issue with IRQ0 on the P2020RDB? =A0Is it
>> >> used for another purpose?
>> >
>> > There's a problem with IRQ0 with respect to mini-PCI-E slot. I have
>> > Atheros wireless card plugged into it. ath9k wireless driver for this
>> > card uses legacy PCI-E interrupts, and I get "irq 16: nobody cared"
>> > message when driver executes request_irq(). Vivek has come to a
>> > conclusion that the problem is related to incorrect IRQ0 routing for
>> > mini-PCI-E slot on P2020RDB.
>> >
>>
>> I would like to understand this issue better, as I seem to be running
>> into something similar, and it puts my board design on hold.
>>
>> Can someone (from Freescale) explain what happens if a PCI Express end
>> point on the mini-PCIe slot raises a legacy interrupt, and where this
>> goes wrong?
>>
>> From what document or source code file can I conclude that the PCIe
>> legacy interrupt is shared with IRQ0?
>>
>>
>> I found this:
>>
>> P1020E/P2020E RDB System Errata, Last Update: 2/15/2010:
>> Problem:IRQ0 held low
>> Fix: Add 4.7K pull-up (to 3.3.V) for RTC_INT_N.
>> See R420 in Rev D schematic.
>> Add 4.7K pull-up (to 3.3.V) for MCU_INT_N.
>> See R423 in Rev D schematic.
>>
>>
>
> Hello Leon,
>
> =A0Yes you are right, PCIe leagacy interrupt is shared with IRQ0. For Ath=
eros issue.
> =A0Can you please try followings, Meanwhile I will try to dig into it.
> =A0 http://old.nabble.com/Problem-with-mini-PCI-E-slot-on-P2020RDB-td2680=
2038.html
>
> Regarding sata_sil24, Please see my e-mail on Linux-ide for correct IDSEL=
 value.
> Please first try IDSEL value mentioned in email on Linux-ide. Then try th=
is URL..
>
> --Prabhakar
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>

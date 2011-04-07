Return-Path: <leon.woestenberg@gmail.com>
Received: from mail-px0-f169.google.com (mail-px0-f169.google.com
	[209.85.212.169]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3CD41B6F72
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Apr 2011 03:20:28 +1000 (EST)
Received: by pxi9 with SMTP id 9so1426100pxi.0
	for <linuxppc-dev@ozlabs.org>; Thu, 07 Apr 2011 10:20:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4B2A946E.4040907@embedded-sol.com>
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
Date: Thu, 7 Apr 2011 19:20:24 +0200
Message-ID: <BANLkTimf8uwgew3YPcNxdNj+4XamPhbxbQ@mail.gmail.com>
Subject: Re: Problem with mini-PCI-E slot on P2020RDB
From: Leon Woestenberg <leon.woestenberg@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
Cc: Mahajan Vivek-B08308 <B08308@freescale.com>,
	Felix Radensky <felix@embedded-sol.com>,
	Aggrwal Poonam-B10812 <B10812@freescale.com>,
	Kushwaha Prabhakar-B32579 <B32579@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

On Thu, Dec 17, 2009 at 9:28 PM, Felix Radensky <felix@embedded-sol.com> wr=
ote:
> Kumar Gala wrote:
>> On Dec 17, 2009, at 2:59 AM, Mahajan Vivek-B08308 wrote:
>>>> Thanks a lot. If I understand you correctly, the only way I can get
>>>> ath9k driver to work on this board using legacy interrupts is to wait =
for a
>>>> hardware fix. Right ?
>>>>
>>> Correct
>>
>> I'm confused. =A0What's the issue with IRQ0 on the P2020RDB? =A0Is it us=
ed for
>> another purpose?
>
> There's a problem with IRQ0 with respect to mini-PCI-E slot. I have Ather=
os
> wireless card plugged
> into it. ath9k wireless driver for this card uses legacy PCI-E interrupts=
,
> and I get "irq 16: nobody cared"
> message when driver executes request_irq(). Vivek has come to a conclusio=
n
> that the problem is
> related to incorrect IRQ0 routing for mini-PCI-E slot on P2020RDB.
>

I would like to understand this issue better, as I seem to be running
into something similar, and it puts my board design on hold.

Can someone (from Freescale) explain what happens if a PCI Express end
point on the mini-PCIe slot raises a legacy interrupt, and where this
goes wrong?

>From what document or source code file can I conclude that the PCIe
legacy interrupt is shared with IRQ0?


I found this:

P1020E/P2020E RDB System Errata, Last Update: 2/15/2010:
Problem:IRQ0 held low
Fix: Add 4.7K pull-up (to 3.3.V) for RTC_INT_N.
See R420 in Rev D schematic.
Add 4.7K pull-up (to 3.3.V) for MCU_INT_N.
See R423 in Rev D schematic.


Regards,
--=20
Leon

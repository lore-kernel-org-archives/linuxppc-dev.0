Return-Path: <clemens.koller@anagramm.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 83B59DDE02
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 31 Jul 2007 21:44:06 +1000 (EST)
Message-ID: <46AF2085.1060603@anagramm.de>
Date: Tue, 31 Jul 2007 13:44:05 +0200
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: Ansari <ma.harounansari@gdatech.co.in>
Subject: Re: Reboot Command Makes kernel to hang (MPC8560)
References: <000801c7cf51$f98ebb90$9503a8c0@Ansari>	<880B302A-742A-4CC1-BB41-E7BD1CE570C6@kernel.crashing.org>
	<007001c7d341$d3ae29d0$9503a8c0@Ansari>
In-Reply-To: <007001c7d341$d3ae29d0$9503a8c0@Ansari>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi, Ansari!

Ansari schrieb:
> Hi Kumar,
> 
> First of all thanks for ur reply .
> 
> Even i went through the linux source . And i have observe that the reboot 
> command used to hard reset the core . I have few doubts can u please clarify 
> me.
> 
> 1. Is there any way to reset the full chip with out using any external 
> signal (MPC8560) ? (like any register that can be used for reseting the 
> processor)

I RTFM:
It should be the bits RST[1:0] in the Debug Control Register 0 (DBCR0).

I didn't find details how the external signals are affected: HRESET_REQ# and friends.
The HRESET_REQ# is usually fed back to the CPU's HRESET#.
So if the HRESET_REQ# gets asserted by writing to above registers it should really bring
down the CPU, it's internal as well as it's external components, which are usually
connected to a replication of that signal.

However the existence of cpm2_reset() and a qe_reset() (QuiccEngine?)
in the code tells me that the above expectations could be wrong.

Would be nice to have that verified by some hardware guys from freescale...

> 2. Even same reboot command works fine for MPC8540 Processor ?.

...because it doesn't have a cpm ?

> 3. what are the factors that makes ramdisk hangs . When its uncompressing ?

Well, side effects ?

Regards,
-- 
Clemens Koller
__________________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Straße 45/1
Linhof Werksgelände
D-81379 München
Tel.089-741518-50
Fax 089-741518-19
http://www.anagramm-technology.com

Return-Path: <ma.harounansari@gdatech.co.in>
Received: from gdatech.co.in (mail.gdatech.co.in [202.144.30.226])
	by ozlabs.org (Postfix) with ESMTP id ED055DDDF3
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  2 Aug 2007 16:48:33 +1000 (EST)
Received: from [192.168.0.2] (localhost.localdomain [127.0.0.1])
	by predator.gdatech.co.in (Postfix-out) with ESMTP id 272BE87810D
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  1 Aug 2007 23:48:18 -0700 (PDT)
Received: from mail.gdatech.co.in (unknown [192.168.0.1])
	by predator.gdatech.co.in (Postfix-out) with ESMTP id E32E1878102
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  1 Aug 2007 23:48:17 -0700 (PDT)
Message-ID: <000b01c7d4d1$1ac37920$9503a8c0@Ansari>
From: "Ansari" <ma.harounansari@gdatech.co.in>
To: "Kumar Gala" <galak@kernel.crashing.org>,
	"Clemens Koller" <clemens.koller@anagramm.de>
References: <000801c7cf51$f98ebb90$9503a8c0@Ansari>	<880B302A-742A-4CC1-BB41-E7BD1CE570C6@kernel.crashing.org><007001c7d341$d3ae29d0$9503a8c0@Ansari><46AF2085.1060603@anagramm.de>
	<00C9C80A-3276-4BC1-9ADA-48CE2002BADA@kernel.crashing.org>
Subject: Re: Reboot Command Makes kernel to hang (MPC8560)
Date: Thu, 2 Aug 2007 12:18:16 +0530
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=response
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

Hi Koller & Kumar

Thanks for ur reply.

Is there a way to reset the full chip (MPC8560)  whenever core reset occu=
rs=20
(using hardware or software) ??

Regards
Haroun Ansari M A





----- Original Message -----=20
From: "Kumar Gala" <galak@kernel.crashing.org>
To: "Clemens Koller" <clemens.koller@anagramm.de>
Cc: "Ansari" <ma.harounansari@gdatech.co.in>; <linuxppc-embedded@ozlabs.o=
rg>
Sent: Tuesday, July 31, 2007 7:41 PM
Subject: Re: Reboot Command Makes kernel to hang (MPC8560)



On Jul 31, 2007, at 6:44 AM, Clemens Koller wrote:

> Hi, Ansari!
>
> Ansari schrieb:
>> Hi Kumar,
>> First of all thanks for ur reply .
>> Even i went through the linux source . And i have observe that the=20
>> reboot command used to hard reset the core . I have few doubts can  u=20
>> please clarify me.
>> 1. Is there any way to reset the full chip with out using any  externa=
l=20
>> signal (MPC8560) ? (like any register that can be used  for reseting t=
he=20
>> processor)
>
> I RTFM:
> It should be the bits RST[1:0] in the Debug Control Register 0  (DBCR0)=
.

This only resets the core on the 8560.

> I didn't find details how the external signals are affected:  HRESET_RE=
Q#=20
> and friends.
> The HRESET_REQ# is usually fed back to the CPU's HRESET#.
> So if the HRESET_REQ# gets asserted by writing to above registers  it=20
> should really bring
> down the CPU, it's internal as well as it's external components,  which=
=20
> are usually
> connected to a replication of that signal.

This is roughly correct.  The only way on 8560 to generate
HRESET_REQ# is to cause a core watchdog timeout.

> However the existence of cpm2_reset() and a qe_reset() (QuiccEngine?)
> in the code tells me that the above expectations could be wrong.
>
> Would be nice to have that verified by some hardware guys from=20
> freescale...

cpm2_reset/qe_reset are more related to SW than any HW reset.

>
>> 2. Even same reboot command works fine for MPC8540 Processor ?.
>
> ...because it doesn't have a cpm ?

That's more luck than anything else.

>> 3. what are the factors that makes ramdisk hangs . When its=20
>> uncompressing ?
>
> Well, side effects ?
>
> Regards,
> --=20
> Clemens Koller
> __________________________________
> R&D Imaging Devices
> Anagramm GmbH
> Rupert-Mayer-Stra=DFe 45/1
> Linhof Werksgel=E4nde
> D-81379 M=FCnchen
> Tel.089-741518-50
> Fax 089-741518-19
> http://www.anagramm-technology.com

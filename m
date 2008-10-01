Return-Path: <rlefevre@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.177])
	by ozlabs.org (Postfix) with ESMTP id 4D719DDDEF
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  1 Oct 2008 23:36:06 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m33so284208wag.9
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 01 Oct 2008 06:36:05 -0700 (PDT)
Message-ID: <4e0b9cb00810010636h10c0d1fw3385ecf1f0a27be5@mail.gmail.com>
Date: Wed, 1 Oct 2008 15:36:05 +0200
From: "Remi Lefevre" <rlefevre@gmail.com>
To: "Scott Wood" <scottwood@freescale.com>
Subject: Re: FS_ENET ERROR(s) 0x12 at second NFS RPC port lookup (100005/1)
In-Reply-To: <48E262FF.9020108@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <4e0b9cb00809300944r2c2359dbx6df882705106c4d1@mail.gmail.com>
	<48E262FF.9020108@freescale.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Scott Wood  wrote:
>>
>> [    5.573391] fs_enet: eth0 FS_ENET ERROR(s) 0x12
>
> This is a transmit error; more detail can be found in the buffer descript=
or.
>
> Check your pin and clock configuration.

Thanks Scott,

Errors encountered are "Underrun" errors (from bd).
A "do_restart" in the driver is then tried, but this has no effect.

I'm pretty confident about my pin configuration as:
- I have exactly the same behavior on other FCC devices
- They work fine in U-Boot TFTP transfers
- FCC2 pins for example are identical to ep8248e ones included in the kerne=
l

I also think that cpm2_clk_setup calls are correct (and commenting them to =
keep
the configuration set by U-Boot leads to the same results).

Concerning clocks, they are identical to U-Boot ones:
Bus clock =3D 82.944 MHz

[    0.000000] time_init: decrementer frequency =3D 20.736000 MHz
[    0.000000] time_init: processor frequency   =3D 414.720000 MHz
[    0.000000] clocksource: timebase mult[c0e6b75] shift[22] registered
[    0.000000] clockevent: decrementer mult[54e] shift[16] cpu[0]
[    0.000351] cpm-brg clock frequency =3D 36.288000 MHz
[    0.554442] Calibrating delay loop... 41.34 BogoMIPS (lpj=3D82688)

CPM clock-frequency is not defined in the DTS, neither filled by U-Boot,
but it doesn't seem to be needed, does it ?

I'm a little confused, and find strange that the first UDP request complete=
s
correctly, as well as latter ARP ones.

R=E9mi

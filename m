Return-Path: <sylvain.joyeau@gmail.com>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.172])
	by ozlabs.org (Postfix) with ESMTP id C8075DDF33
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 13 Jun 2008 05:14:59 +1000 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so3866500wfg.15
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 Jun 2008 12:14:58 -0700 (PDT)
Message-ID: <d194b8ce0806121214w2ac2edf6n7f222eb51463a989@mail.gmail.com>
Date: Thu, 12 Jun 2008 21:14:58 +0200
From: "Sylvain Joyeau" <sylvain.joyeau@gmail.com>
To: "Florian Boelstler" <euphoria@arcor.de>
Subject: Re: Reserving small amounts of memory with mem= (MPC85xx,
	2.6.15 arch/ppc)
In-Reply-To: <g2ri8j$qlk$1@ger.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <g2ri8j$qlk$1@ger.gmane.org>
Cc: linuxppc-embedded@ozlabs.org
Reply-To: sjoyeau@wanadoo.fr
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

Residual memory size is what Linux couldn't map with its three CAM
entries. The main figure you can check is the sum of the three first
CAMs   plus residual is what you specified (CAM0+CAM1+CAM2+residuak =3D=3D
'mem'). It's not weird to get a residual !=3D 0 when specified memory
size isn't a good combination of power of 2.
Stupid question: have you tried mem=3D512M and a correct RAM disk address ?
No more comments...

--
sj

2008/6/12 Florian Boelstler <euphoria@arcor.de>:
> Hi,
>
> I ran into problems reserving small amounts of memory using command line
> argument 'mem'.
> Limiting a MPC8540 with 512MB physical available memory down to 256MB has
> been successfully done using U-Boot:
>
> =3D> setenv bootargs console=3DttyS0,115200 mem=3D256M
> =3D> setenv initrd_high 10000000
> =3D> bootm 0x02100000
>
> ## Booting image at 02100000 ...
>   Image Name:   Linux 2.6.15
>   Image Type:   PowerPC Linux Multi-File Image (gzip compressed)
>   Data Size:    6965022 Bytes =3D  6.6 MB
>   Load Address: 00000000
>   Entry Point:  00000000
>   Contents:
>   Image 0:  1099550 Bytes =3D  1 MB
>   Image 1:  5865458 Bytes =3D  5.6 MB
>   Verifying Checksum ... OK
>   Uncompressing Multi-File Image ... OK
> [...]
>   Loading Ramdisk to 0fa68000, end 0ffffff2 ... OK
>
> Memory CAM mapping: CAM0=3D256Mb, CAM1=3D0Mb, CAM2=3D0Mb residual: 0Mb
> Linux version 2.6.15 (flo@escape) (gcc version 3.4.3) #21 PREEMPT Fri Nov=
 30
> 16:47:32 CET 2007
> [...]
>
> root@mpc0:/# cat /proc/meminfo
> MemTotal:       257272 kB
> MemFree:        226332 kB
> [...]
>
> When a larger size for 'mem' (say 508M for reserving 4M) and appropriate
> 'initrd_high' is used, U-Boot is still able to load the ramdisk to its
> correct place in RAM. However Linux seems to not accept that memory regio=
n
> and removes the memory using mem_pieces_remove(), which leads to a crash
> since it cannot access area used for the ramdisk(?).
> In that case output of "residual" for CAM mapping shows a value !=3D 0.
>
> My assumption is that these CAM mappings cannot be used for memory portio=
ns
> less than a certain size.
> I need to dig into that, please correct me if I'm wrong.
>
> Linux 2.6.15 build for arch/ppc on custom MPC8540 board (Linux BSP simila=
r
> to MPC8540ads). U-Boot 1.2.0.
>
> Thanks for any suggestions.
>
>  Florian
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>



--=20
------------------
Sylvain JOYEAU
Freelance Engineer
Software RT-OS R&D
sylvain.joyeau@gmail.com
T=E9l: +33-(0)667 477 052
"A good idea is one side of the coin. The other side is the practical
usefulness". J. Liedke.

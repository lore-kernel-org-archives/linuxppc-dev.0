Return-Path: <sipcop009@gmail.com>
Received: from zproxy.gmail.com (zproxy.gmail.com [64.233.162.193])
	by ozlabs.org (Postfix) with ESMTP id C442167C39
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Jul 2005 03:18:39 +1000 (EST)
Received: by zproxy.gmail.com with SMTP id j25so1184432nzf
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Jul 2005 10:18:37 -0700 (PDT)
Message-ID: <5a4792c005071910184f41c699@mail.gmail.com>
Date: Tue, 19 Jul 2005 10:18:14 -0700
From: SIP COP 009 <sipcop009@gmail.com>
To: Mike Rapoport <mike@compulab.co.il>
In-Reply-To: <42DA0024.3050005@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <5a4792c0050713235574522cfb@mail.gmail.com>
	<42DA0024.3050005@compulab.co.il>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: 8272ADS and Linux 2.6.12
Reply-To: SIP COP 009 <sipcop009@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Thanks all for the replies and help. I have the 2.6 Kernel running
now. Here are few of the things that i did to make it happen:

1: make ads8272_defconfig
2: edit .config to add the follow:
CONFIG_SERIAL_CORE=3Dy
CONFIG_SERIAL_CORE_CONSOLE=3Dy
CONFIG_SERIAL_CPM=3Dy
CONFIG_SERIAL_CPM_CONSOLE=3Dy
CONFIG_SERIAL_CPM_SCC1=3Dy
CONFIG_SERIAL_CPM_SCC2=3Dy

3. In u-boot, set the bootargs to
bootargs=3Droot=3D/dev/ram rw console=3DttyCPM0,115200

4.Modify the file arch/ppc/platforms/pq2ads.h,
// #define BCSR_ADDR            ((uint)0xf4500000)
#define BCSR_ADDR ((uint)0xff080000)

Thanks!
ashutosh



On 7/16/05, Mike Rapoport <mike@compulab.co.il> wrote:
> SIP COP 009 wrote:
>=20
> >Hello,
> >
> >We have a MPC8272 Eval Board which came with Linux 2.4 and U-boot. We
> >wanted to move to 2.6. I downloaded the latest 2.6.12 sources and
> >compiled the sources for this platform. The kernel is built, have run
> >the mkimage tool, but the kernel wont boot.  It just hangs after
> >decompressing the image.
> >
> >
> >
>=20
> >Any ideas  ? Anything different that needs to be done for 2.6 ? Or any
> >known issues ?
> >
> >
> >
> If you're using the u-boot that came with MPC8272 Eval board it may
> happen that BCSR is mapped differently in u-boot and the kernel 2.6.
> That's what happened when I tried to boot linux 2.6 on MPC8272ADS. Check
> the value of CFG_BCSR in u-boot/include/configs/MPC8260ADS.h and
> BCSR_ADDR in linux/arch/ppc/platforms/pq2ads.h
>=20
> >Thanks!
> >ashutosh
> >
> >
> --
> Sincerely yours,
> Mike
>=20
>

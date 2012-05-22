Return-Path: <B29882@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CE3FEB6EEB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2012 01:34:46 +1000 (EST)
From: McClintock Matthew-B29882 <B29882@freescale.com>
To: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Subject: Re: Handling spin table in kdump
Date: Tue, 22 May 2012 15:34:35 +0000
Message-ID: <CAEsOVNeg2aogCwCy-v3ez4cC4VPF79A4PWRaO2ohDj_ypqCWmg@mail.gmail.com>
References: <4FBB89A2.90709@in.ibm.com>
In-Reply-To: <4FBB89A2.90709@in.ibm.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Reply-To: McClintock Matthew-B29882 <B29882@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 22, 2012 at 7:42 AM, Suzuki K. Poulose <suzuki@in.ibm.com> wrot=
e:
> Hi
>
> I came across the following issue while testing Kdump on an SMP
> board(Currituck) running a non-SMP kernel. Even though the kernel is UP,
> the device-tree has the nodes for second CPU and the related details.
>
>
> The kexec tool adds the spin table area as a reserved section in the devi=
ce
> tree for the dump capture kernel. This value is read from the
> 'cpu-release-addr'.
>
> But now, if the spin table is not located within the 'Reserved region' fo=
r
> the crash kernel, the dump capture kernel would fail to boot, hitting a B=
UG
> in mm/bootmem.c as in [1].
>
> This is because we try to reserve a region which is not available to the
> kernel.
>
> So I am wondering how is this handled really on an SMP board (Fsl_bookE).
>
> There are two possible solutions :
> 1) Do not reserve the regions for the spin-table, as we will use
> only the crashing CPU in the second kernel(maxcpus=3D1).
>
>
> 2) Add the spin-table region to the available memory regions passed
> to the kernel by kexec-tools.
>
> I have tested (1) and it works fine for me. Yet to test (2).
>
>
> Thoughts ?

I would think option 1 is acceptable. The crash kernel will never
attempt to use the memory outside of the crash kernel region therefore
it does not need to be reserved.

However, I thought we were able to boot SMP into the crash kernel on
our parts... not sure how that effects things (although the maxcpus=3D1
here is a perfectly acceptable and safer thing to do anyways)

-M


>
>
> Thanks
> Suzuki
>
>
>
> [1] Kernel Bug
> ----------------
>
>
> Linux version 3.3.0-rc5 (root@suzukikp.in.ibm.com) (gcc version 4.3.4
> [gcc-4_3-branch revision 152973] (GCC) ) #12 Tue May 22 18:03:01 IST2
> Found legacy serial port 0 for /plb/opb/serial@10000000
> =A0mem=3D20010000000, taddr=3D20010000000, irq=3D0, clk=3D1851851, speed=
=3D115200
> ------------[ cut here ]------------
> kernel BUG at mm/bootmem.c:351!
> Vector: 700 (Program Check) at [c8a61e90]
> =A0 =A0pc: c847f91c: mark_bootmem+0xa0/0x14c
> =A0 =A0lr: c8472670: do_init_bootmem+0x1ac/0x218
> =A0 =A0sp: c8a61f40
> =A0 msr: 21000
> =A0current =3D 0xc8a4a500
> =A0 =A0pid =A0 =3D 0, comm =3D swapper
> kernel BUG at mm/bootmem.c:351!
> enter ? for help
> [c8a61f70] c8472670 do_init_bootmem+0x1ac/0x218
> [c8a61f90] c847025c setup_arch+0x1bc/0x234
> [c8a61fb0] c846b62c start_kernel+0x98/0x358
> [c8a61ff0] c80000b4 _start+0xb4/0xf8
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev=

Return-Path: <sprasad@bivio.net>
Received: from corpexc01.corp.networkrobots.com (nofear-snat.bivio.net
	[216.142.75.231]) by ozlabs.org (Postfix) with ESMTP id 5BCE4DDE03
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Dec 2007 12:09:20 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Regarding MPC8641D
Date: Wed, 5 Dec 2007 17:05:49 -0800
Message-ID: <D83235F0F3C86D4D889D8B9A0DA8C6D7011A75D5@corpexc01.corp.networkrobots.com>
In-Reply-To: <mailman.9.1196902804.16874.linuxppc-dev@ozlabs.org>
References: <mailman.9.1196902804.16874.linuxppc-dev@ozlabs.org>
From: "Siva Prasad" <sprasad@bivio.net>
To: <linuxppc-dev@ozlabs.org>
Cc: rameshmrm@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

If you want to use SMP, do not enable low memory offset mode. That is
only and only for AMP, not for SMP. All the exception vectors go into a
different address range for core1, once you enable that, resulting in a
need for entirely different copy of OS (be it Linux, or any other OS).

You are in the right path. Just don't enable low memory offset mode,
unless you are looking for Assymetric multi-processing.

- siva




Message: 6
Date: Wed, 5 Dec 2007 16:45:31 -0800 (PST)
From: sivaji <rameshmrm@gmail.com>
Subject: Re: Regarding MPC8641D
To: linuxppc-dev@ozlabs.org
Message-ID: <14184234.post@talk.nabble.com>
Content-Type: text/plain; charset=3Dus-ascii


Hai,
             The kernel was compiled in SMP mode. The low memory offset
mode
is only for AMP mode means, then how we test both the core 0 and 1 in
the
linux kernel ?. Asper my understanding if we enable the Low Memory
Offset
mode, then only the core1 translation is enabled. If we disalbed the Low
Memory offset mode, Only Core 0  will work in SMP mode and Core 1 will
idle.
If we want to test the efficient of Dual core means we need to enable
both
the core and Low Memory Offset Mode. For this configuration linux kernel
was
not up.
( Please correct me if I am wrong )

Thanks and Regards
Sivaji


Chris Fester wrote:
>=20
> On Tue, 2007-12-04 at 23:51 -0800, sivaji wrote:
>>             We have designed  a MPC8641D based AMC card. We are using
the
>> kernel (2.6.23-rc4) and uboot (1.2.0).  When we disable the core1 Low
>> Memory
>> offset mode the kernel was up and when we enable this core1 Low
Memory
>> offset mode kernel was not up, It was hang after MPIC initialization.
> [snip!]
>>                      After this the kernel was hang, i want to know
why
>> kernel was hang when we enalbe Low memory Offset mode. Please help me
to
>> fix
>> this issue.
>=20
> Have you compiled your kernel for SMP mode?  I believe the Low memory
> offset mode is only for AMP mode (vxworks can use this, probably other
> OSes).  I don't know if the kernel has support for any multiprocessing
> mode other than SMP.
>=20
> Hope that helps,
> Chris
>=20

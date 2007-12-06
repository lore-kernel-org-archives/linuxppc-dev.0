Return-Path: <sprasad@bivio.net>
Received: from corpexc01.corp.networkrobots.com (nofear-snat.bivio.net
	[216.142.75.231]) by ozlabs.org (Postfix) with ESMTP id 2EE46DDF81
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2007 04:57:44 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Regarding MPC8641D
Date: Thu, 6 Dec 2007 09:54:08 -0800
Message-ID: <D83235F0F3C86D4D889D8B9A0DA8C6D7011A7671@corpexc01.corp.networkrobots.com>
References: <mailman.414.1196916416.10024.linuxppc-dev@ozlabs.org> 
From: "Siva Prasad" <sprasad@bivio.net>
To: <rameshmrm@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hello Bala,

I don't think the ioremap issues are related with low memory offset
mode. But again, I am not sure if you (system by default does not do it)
are reserving that area (from 256 to 512 which is low memory offset
region). Further, where do you get this 504 number specifically?

If you want, I can try out your code on my 8641D board.

Thanks
Siva


Date: Wed, 5 Dec 2007 17:45:01 -0800 (PST)
From: sivaji <rameshmrm@gmail.com>
Subject: Re: Regarding MPC8641D
To: linuxppc-dev@ozlabs.org
Message-ID: <14184891.post@talk.nabble.com>
Content-Type: text/plain; charset=3Dus-ascii


Hi,
           We need only SMP mode, asper ur idea let me disable the Low
memory offset mode. We face some issues when ioremap in the kernel, we
guess
the problem is related to Low memory offset mode so only we go for that.
Consider now the Low memory offset is disable the bootargs
(root=3D/dev/ram
console=3DttyS0, mem=3D504M). When mem=3D504 or greater than  we are not =
able
to
ioremap, if mem is less than 500 there was no issues on ioremap. We
can't
understand why ioremap was failed for 504M?

Thanks and Regards
S.Balamurugan


Siva Prasad-3 wrote:
>=20
> Hi,
>=20
> If you want to use SMP, do not enable low memory offset mode. That is
> only and only for AMP, not for SMP. All the exception vectors go into
a
> different address range for core1, once you enable that, resulting in
a
> need for entirely different copy of OS (be it Linux, or any other OS).
>=20
> You are in the right path. Just don't enable low memory offset mode,
> unless you are looking for Assymetric multi-processing.
>=20
> - siva
>=20
>=20
>=20
>=20
> Message: 6
> Date: Wed, 5 Dec 2007 16:45:31 -0800 (PST)
> From: sivaji <rameshmrm@gmail.com>
> Subject: Re: Regarding MPC8641D
> To: linuxppc-dev@ozlabs.org
> Message-ID: <14184234.post@talk.nabble.com>
> Content-Type: text/plain; charset=3Dus-ascii
>=20
>=20
> Hai,
>              The kernel was compiled in SMP mode. The low memory
offset
> mode
> is only for AMP mode means, then how we test both the core 0 and 1 in
> the
> linux kernel ?. Asper my understanding if we enable the Low Memory
> Offset
> mode, then only the core1 translation is enabled. If we disalbed the
Low
> Memory offset mode, Only Core 0  will work in SMP mode and Core 1 will
> idle.
> If we want to test the efficient of Dual core means we need to enable
> both
> the core and Low Memory Offset Mode. For this configuration linux
kernel
> was
> not up.
> ( Please correct me if I am wrong )
>=20
> Thanks and Regards
> Sivaji
>=20
>=20
> Chris Fester wrote:
>>=20
>> On Tue, 2007-12-04 at 23:51 -0800, sivaji wrote:
>>>             We have designed  a MPC8641D based AMC card. We are
using
> the
>>> kernel (2.6.23-rc4) and uboot (1.2.0).  When we disable the core1
Low
>>> Memory
>>> offset mode the kernel was up and when we enable this core1 Low
> Memory
>>> offset mode kernel was not up, It was hang after MPIC
initialization.
>> [snip!]
>>>                      After this the kernel was hang, i want to know
> why
>>> kernel was hang when we enalbe Low memory Offset mode. Please help
me
> to
>>> fix
>>> this issue.
>>=20
>> Have you compiled your kernel for SMP mode?  I believe the Low memory
>> offset mode is only for AMP mode (vxworks can use this, probably
other
>> OSes).  I don't know if the kernel has support for any
multiprocessing
>> mode other than SMP.
>>=20
>> Hope that helps,
>> Chris
>>=20
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>=20
>=20

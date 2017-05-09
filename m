Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wMsXm1KZdzDqKk
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 May 2017 07:13:12 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Scott Wood <oss@buserror.net>, linuxppc-dev@ozlabs.org
Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/64e: Don't place the stack beyond TASK_SIZE
In-Reply-To: <1494258757.3694.1.camel@buserror.net>
References: <20170505063145.21631-1-oss@buserror.net>
 <87zien7841.fsf@concordia.ellerman.id.au>
 <1494258757.3694.1.camel@buserror.net>
Date: Wed, 10 May 2017 07:13:08 +1000
Message-ID: <87r2zx7mzf.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott Wood <oss@buserror.net> writes:

> On Tue, 2017-05-09 at 00:09 +1000, Michael Ellerman wrote:
>> Scott Wood <oss@buserror.net> writes:
>>=20
>> > Commit f4ea6dcb08ea ("powerpc/mm: Enable mappings above 128TB") increa=
sed
>> > the task size on book3s, and introduced a mechanism to dynamically
>> > control whether a task uses these larger addresses.=C2=A0=C2=A0While t=
he change to
>> > the task size itself was ifdef-protected to only apply on book3s, the
>> > change to STACK_TOP_USER64 was not.=C2=A0=C2=A0On book3e, this had the=
 effect of
>> > trying to use addresses up to 128TiB for the stack despite a 64TiB task
>> > size limit -- which broke 64-bit userspace producing the following err=
ors:
>> >=20
>> > Starting init: /sbin/init exists but couldn't execute it (error -14)
>> > Starting init: /bin/sh exists but couldn't execute it (error -14)
>> > Kernel panic - not syncing: No working init found.=C2=A0=C2=A0Try pass=
ing init=3D
>> > option to kernel. See Linux Documentation/admin-guide/init.rst for
>> > guidance.
>>=20
>> For some reason I am not seeing this on my p5020ds?
>>=20
>> I just checked, it's definitely booting:
>>=20
>> =C2=A0 [=C2=A0=C2=A0=C2=A0=C2=A00.000000] Linux version 4.11.0-gcc5-g13e=
0988 (kerkins@alpine1-p1)
>> (gcc version 5.2.1 20151001 (GCC) ) #1 SMP Mon May 8 05:33:22 AEST 2017
>> =C2=A0 [=C2=A0=C2=A0=C2=A0=C2=A00.000000] Using CoreNet Generic machine =
description
>> =C2=A0 ...
>> =C2=A0 [=C2=A0=C2=A0=C2=A0=C2=A03.216940] systemd[1]: Detected architect=
ure ppc64.
>> =C2=A0 ...
>> =C2=A0 Debian GNU/Linux stretch/sid p5020ds ttyS0
>> =C2=A0=C2=A0
>> =C2=A0 p5020ds login:
>>=20
>>=20
>> Anyway patch looks good, I'll pull it in with the rest of your tree.
>
> Are you using a 64-bit userspace?

Ah of course. It's debian so it's mostly 32-bit. I'd forgotten 32-bit
userspace was a thing! :)

I'll fix my tests to run some 64-bit binaries.

cheers

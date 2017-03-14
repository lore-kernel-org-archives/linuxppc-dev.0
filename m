Return-Path: <Chris.Packham@alliedtelesis.co.nz>
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz
 [202.36.163.20])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vjPxs4ZqMzDqfX
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Mar 2017 06:32:01 +1100 (AEDT)
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: Michael Ellerman <mpe@ellerman.id.au>, Chandan Rajendra
 <chandan@linux.vnet.ibm.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
CC: Paul Mackerras <paulus@samba.org>
Subject: Re: syscall statx not implemented on powerpc
Date: Tue, 14 Mar 2017 19:31:57 +0000
Message-ID: <67f921484d2e42a8975361e821a4b2a7@svr-chch-ex1.atlnz.lc>
References: <7dba3a5469d34ac3890a5eaa16822a75@svr-chch-ex1.atlnz.lc>
 <4396749.JbYdqAFZXV@localhost.localdomain>
 <6226603a58ba485391854ba231193741@svr-chch-ex1.atlnz.lc>
 <87o9x4ul3g.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 15/03/17 00:57, Michael Ellerman wrote:=0A=
> Chris Packham <Chris.Packham@alliedtelesis.co.nz> writes:=0A=
>=0A=
>> On 13/03/17 21:52, Chandan Rajendra wrote:=0A=
>>> On Monday, March 13, 2017 03:33:07 AM Chris Packham wrote:=0A=
>>>> Hi,=0A=
>>>>=0A=
>>>> I've just attempted to build a powerpc kernel from 4.11-rc2 using a=0A=
>>>> custom defconfig (available on request) and I'm hitting the following=
=0A=
>>>> error in the early stages of compilation.=0A=
>>>>=0A=
>>>> <stdin>:1325:2: error: #warning syscall statx not implemented [-Werror=
=3Dcpp]=0A=
>>>>=0A=
>>>> Same thing seems to happen with mpc85xx_basic_defconfig.=0A=
>>>>=0A=
>>>> I don't actually need this syscall so I'd be happy to turn something o=
ff=0A=
>>>> to get things building. I did a quick search and couldn't see anything=
=0A=
>>>> on linuxppc-dev but google keeps correcting "statx" to "stats" so I=0A=
>>>> could have missed it.=0A=
>>>>=0A=
>>>=0A=
>>> The upstream commit=0A=
>>> (https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/com=
mit/?id=3Da528d35e8bfcc521d7cb70aaf03e1bd296c8493f)=0A=
>>> that introduces the statx syscall provides a test program. I will wire-=
up the=0A=
>>> syscall on ppc64, run that test program and post the patch if the test =
program=0A=
>>> works well.=0A=
>>>=0A=
>>=0A=
>> Thanks, I'd be happy to test a patch here.=0A=
>>=0A=
>> In the meantime I worked around the build issue by adding __INGORE_statx=
=0A=
>> to checksyscalls.sh.=0A=
>=0A=
> Is it actually breaking the build? It's meant to be a warning, and=0A=
> that's all I get.=0A=
>=0A=
> cheers=0A=
>=0A=
=0A=
It breaks my builds for ppc and arm. We do have KCFLAGS=3D-Werror in our =
=0A=
environment but KCPPFLAGS=3D is not set so I'm not sure why it's stopping =
=0A=
compilation.=0A=

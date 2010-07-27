Return-Path: <msm@freescale.com>
Received: from TX2EHSOBE004.bigfish.com (tx2ehsobe002.messaging.microsoft.com
	[65.55.88.12]) by ozlabs.org (Postfix) with ESMTP id 4E0341007D3
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 27 Jul 2010 14:23:19 +1000 (EST)
Subject: Re: [PATCH v3 0/7] Fixup booting with device trees and uImage/elf on
	ppc32
MIME-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset="us-ascii"
From: Matthew McClintock <msm@freescale.com>
In-Reply-To: <20100727025506.GA1944@verge.net.au>
Date: Mon, 26 Jul 2010 23:22:58 -0500
Message-ID: <14FA0578-0D5B-48D1-BF5D-EB39DF1432D1@freescale.com>
References: <1279687384-9770-1-git-send-email-msm@freescale.com>
	<20100727025506.GA1944@verge.net.au>
To: Simon Horman <horms@verge.net.au>
Cc: muvarov@gmail.com, linuxppc-dev@lists.ozlabs.org, sebastian@breakpoint.cc,
	kexec@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 26, 2010, at 9:55 PM, Simon Horman wrote:

> [Cced linuxppc-dev]
>=20
> On Tue, Jul 20, 2010 at 11:42:57PM -0500, Matthew McClintock wrote:
>> This patch series adds full support for booting with a flat device =
tree
>> with either uImage or elf file formats. Kexec and Kdump should work, =
and
>> you should also be able to use ramdisks or reuse your current ramdisk =
as well
>>=20
>> This patch series was tested on an mpc85xx system with a kernel =
version
>> 2.6.35-rc3
>>=20
>> v1: Initial version
>>=20
>> v2: Added support for fs2dt (file system to device tree)
>>=20
>> v3: Fix some misc. git problems I had and other code cleanups
>=20
> Hi Matthew,
>=20
> I'm a little concerned that these changes are non trivial and haven't =
had
> much review. But I am prepared to put them into my tree once 2.0.2 is
> released - perhaps that way they will get some test coverage. Does
> that work for you?

Either way works for me. I know they could use more review, however as =
Maxim said the current tree does not work AFAIK. Either way, I'm willing =
to keeping addressing everyones concerns and wait or move forward and =
make some quick fixes as well.

-M

>=20
>>=20
>> Matthew McClintock (7):
>>  Restore kexec uImage-ppc to working state
>>  Fix case where phys_addr_t !=3D unsigned long when reading proc =
entries
>>  Update uImage to support crash kernel and misc fixes
>>  Update Elf-ppc to support crash kernel and misc fixes
>>  Add support for ramdisk on ppc32 for uImage-ppc and Elf-ppc
>>  Add support for reworking flat device tree support
>>  Add documentation/howto for mpc85xx systems
>>=20
>> doc/mpc85xx.txt                       |  190 +++++++++++++++++++++
>> kexec/arch/ppc/Makefile               |    1 +
>> kexec/arch/ppc/fixup_dtb.c            |  298 =
++++++++++++++++++++++++++++++++-
>> kexec/arch/ppc/fixup_dtb.h            |    6 +-
>> kexec/arch/ppc/include/arch/options.h |    3 +
>> kexec/arch/ppc/kexec-elf-ppc.c        |  186 +++++++++------------
>> kexec/arch/ppc/kexec-ppc.c            |  262 =
+++++++++++++++++------------
>> kexec/arch/ppc/kexec-ppc.h            |    3 +
>> kexec/arch/ppc/kexec-uImage-ppc.c     |  136 ++++++++++++---
>> kexec/arch/ppc/ops.h                  |    1 -
>> purgatory/arch/ppc/purgatory-ppc.c    |    5 +
>> 11 files changed, 852 insertions(+), 239 deletions(-)
>> create mode 100644 doc/mpc85xx.txt
>>=20
>>=20
>>=20
>> _______________________________________________
>> kexec mailing list
>> kexec@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kexec
>=20

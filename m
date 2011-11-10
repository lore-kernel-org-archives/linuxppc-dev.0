Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 31959B6F85
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Nov 2011 05:50:37 +1100 (EST)
Subject: Re: [RFC][PATCH 15/30] powerpc/85xx: Rework P1022DS device tree
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=windows-1252
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <CAOZdJXXh571mgF2rFWqfWOVDBLyS10TdKt9Gk86FhwObaiXjOw@mail.gmail.com>
Date: Thu, 10 Nov 2011 12:50:33 -0600
Message-Id: <A328AC89-450E-40BD-85E4-EBA3B5776B89@kernel.crashing.org>
References: <1320941653-29797-1-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-2-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-3-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-4-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-5-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-6-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-7-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-8-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-9-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-10-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-11-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-12-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-13-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-14-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-15-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-16-git-send-email-galak! @kernel.crashing.org>
 <CAOZdJXXh571mgF2rFWqfWOVDBLyS10TdKt9Gk86FhwObaiXjOw@mail.gmail.com>
To: Tabi Timur-B04825 <B04825@freescale.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 10, 2011, at 11:30 AM, Tabi Timur-B04825 wrote:

> On Thu, Nov 10, 2011 at 10:13 AM, Kumar Gala =
<galak@kernel.crashing.org> wrote:
>>=20
>>  arch/powerpc/boot/dts/fsl/p1022si-post.dtsi |  235 +++++++++++++++
>>  arch/powerpc/boot/dts/fsl/p1022si-pre.dtsi  |   68 +++++
>>  arch/powerpc/boot/dts/p1022ds.dts           |  431 =
+--------------------------
>>  3 files changed, 318 insertions(+), 416 deletions(-)
>>  create mode 100644 arch/powerpc/boot/dts/fsl/p1022si-post.dtsi
>>  create mode 100644 arch/powerpc/boot/dts/fsl/p1022si-pre.dtsi
>=20
> I understand the value of removing duplication of DTS contents, so
> that we don't copy-paste the same nodes over and over again, but now
> that you've added pre- and post- dtsi files, I wonder if you're not
> jumping out of the frying pan and into the flame.  It seems that the
> DTS files are more fragile than ever, and it's more difficult now to
> figure out which files go where.

I hope that is not true, as the template is the same.

BOARD.dts:

include "fsl/SOCsi-pre.dtsi"

=85

include "fsl/SOCsi-post.dtsi"

[ some boards may do more complicated things like we do on MPC8572DS to =
deal with 32-bit vs 36-bit addr maps, or CAMP use examples ]

All BOARD dts's should follow this pattern given the knowledge of which =
SoC you are utilizing.  For a board port, you should NEVER have to touch =
anything in the 'fsl/' directory.  That assumes, we've done a good job =
with the .dts struct in general.  =46rom time to time I'm sure we'll =
find some pattern or IP block we need to fix.

> Another concern I have is whether this will force all Pxxxx boards to
> have the same CCSR address.  I don't think so, because I didn't see
> it, but I just want to make sure.


Nope, we can have as many boards for the same SoC w/different address =
maps and share the same SOC.dtsi files

- k=

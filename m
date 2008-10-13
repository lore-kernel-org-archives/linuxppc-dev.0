Return-Path: <jesse.brandeburg@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by ozlabs.org (Postfix) with ESMTP id 3262FDE5A0
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 05:15:49 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: [BUILD_FAILURE] 2.6.27-git2 - allyesconfig on powerpc
	selectsCONFIG_INTEL_IOATDMA=y
Date: Mon, 13 Oct 2008 11:05:43 -0700
Message-ID: <36D9DB17C6DE9E40B059440DB8D95F52066E2EAE@orsmsx418.amr.corp.intel.com>
In-Reply-To: <20081013112631.GD29938@cs181140183.pp.htv.fi>
References: <20081013101559.GA14372@linux.vnet.ibm.com>
	<20081013112631.GD29938@cs181140183.pp.htv.fi>
From: "Brandeburg, Jesse" <jesse.brandeburg@intel.com>
To: "Adrian Bunk" <bunk@kernel.org>,
	"Kamalesh Babulal" <kamalesh@linux.vnet.ibm.com>,
	"Brice Goglin" <brice@myri.com>, "Jeff Garzik" <jgarzik@redhat.com>,
	"Kirsher, Jeffrey T" <jeffrey.t.kirsher@intel.com>
Cc: e1000-devel@lists.sourceforge.net, netdev@vger.kernel.org, "Sosnowski,
	Maciej" <maciej.sosnowski@intel.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, sam@ravnborg.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Adrian Bunk wrote:
> On Mon, Oct 13, 2008 at 03:45:59PM +0530, Kamalesh Babulal wrote:
>> Hi,
>>=20
>>    2.6.27-git2 kernel build fails, while building the kernel with

from subject, on PPC.

>> allyesconfig option. The allyesconfig selects =
CONFIG_INTEL_IOATDMA=3Dy
>>=20
>> CC   drivers/dma/ioat_dca.o
>> drivers/dma/ioat_dca.c: In function =
=E2=80=98dca_enabled_in_bios=E2=80=99:
>> drivers/dma/ioat_dca.c:81: error: implicit declaration of function
>> =E2=80=98cpuid_eax=E2=80=99 drivers/dma/ioat_dca.c: In function
>> =E2=80=98system_has_dca_enabled=E2=80=99:=20
>> drivers/dma/ioat_dca.c:91: error: implicit declaration of function
>> =E2=80=98boot_cpu_has=E2=80=99 drivers/dma/ioat_dca.c:91: error:
>> =E2=80=98X86_FEATURE_DCA=E2=80=99 undeclared (first use in this =
function)
>> drivers/dma/ioat_dca.c:91: error: (Each undeclared identifier is
>> reported only once drivers/dma/ioat_dca.c:91: error: for each
>> function it appears in.) =20
>> drivers/dma/ioat_dca.c: In function =
=E2=80=98ioat_dca_get_tag=E2=80=99:
>> drivers/dma/ioat_dca.c:190: error: implicit declaration of function
>> =E2=80=98cpu_physical_id=E2=80=99 make[2]: *** =
[drivers/dma/ioat_dca.o] Error 1
>> make[1]: *** [drivers/dma] Error 2
>> make: *** [drivers] Error 2
>> ...
>=20
> Thanks for the report, the MYRI10GE and IXGBE commits that introduced
> the select's are really broken.

it fixed an obvious bug with CONFIG_IXGBE=3Dy and =
CONFIG_INTEL_IOATDMA=3Dm, unfortunate that it is so difficult to use =
Kconfig for the uninitiated.
=20
> For fixing it I need to know the intended semantics.
>=20
> Brian, Jesse, is it OK to limit the drivers to m with
> CONFIG_INTEL_IOATDMA=3Dm ?

why is the IOATDMA driver not depending on x86?  x86 hardware (32 and 64 =
bit) are the only machines that will have ioatdma support, since the =
ioatdma (and dca) device is only in Intel server chipsets since S5000 =
(aka S5000, S5400, S7400 and derivatives/followons)

What we want, is myri10ge and ixgbe drivers that can build whether or =
not CONFIG_INTEL_IOATDMA is enabled.  IF CONFIG_INTEL_IOATDMA *is* =
enabled (which it should not be on PPC) then there are several cases we =
want to work:
CONFIG_INTEL_IOATDMA=3Dm  ---> CONFIG_IXGBE=3D[m|n]
CONFIG_INTEL_IOATDMA=3Dy  ---> CONFIG_IXGBE=3D[m|y|n]
CONFIG_INTEL_IOATDMA=3Dn  ---> CONFIG_IXGBE=3D[m|y|n]
CONFIG_INTEL_IOATDMA depends on X86

same for myri10ge I think.  I hope that cleared something up, we can =
seriously use some help from the experts to get Kconfig correct for =
this.

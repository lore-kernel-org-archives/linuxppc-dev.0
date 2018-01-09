Return-Path: <michael@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zGSnF6KKYzF0PM
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jan 2018 10:21:05 +1100 (AEDT)
Date: Wed, 10 Jan 2018 10:21:01 +1100
In-Reply-To: <c61dd248-4564-5290-d803-4131278f9383@linux.vnet.ibm.com>
References: <cover.1513608243.git.fbarrat@linux.vnet.ibm.com>
 <ddc10e7f73d714bb02bcac4958fc22ab10f7e129.1513608243.git.fbarrat@linux.vnet.ibm.com>
 <9cf29972-8995-949f-1435-70f0e11071cf@au1.ibm.com>
 <c61dd248-4564-5290-d803-4131278f9383@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Subject: Re: [PATCH 10/13] ocxl: Add Makefile and Kconfig
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
CC: arnd@arndb.de, gregkh@linuxfoundation.org, mpe@ellerman.id.au,
 alastair@au1.ibm.com
From: Michael Ellerman <michael@ellerman.id.au>
Message-ID: <7365AFB0-6D6F-4A8D-9C50-8B662CC72227@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 10 January 2018 2:45:56 am AEDT, Frederic Barrat <fbarrat@linux=2Evnet=
=2Eibm=2Ecom> wrote:
>
>
>Le 03/01/2018 =C3=A0 06:48, Andrew Donnellan a =C3=A9crit=C2=A0:
>> On 19/12/17 02:21, Frederic Barrat wrote:
>>> OCXL_BASE triggers the platform support needed by the driver=2E
>>>
>>> Signed-off-by: Frederic Barrat <fbarrat@linux=2Evnet=2Eibm=2Ecom>
>>> ---
>>> =C2=A0 drivers/misc/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 1 +
>>> =C2=A0 drivers/misc/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
>>> =C2=A0 drivers/misc/ocxl/Kconfig=C2=A0 | 25 +++++++++++++++++++++++++
>>> =C2=A0 drivers/misc/ocxl/Makefile | 10 ++++++++++
>>> =C2=A0 4 files changed, 37 insertions(+)
>>> =C2=A0 create mode 100644 drivers/misc/ocxl/Kconfig
>>> =C2=A0 create mode 100644 drivers/misc/ocxl/Makefile
>>>
>>> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
>>> index f1a5c2357b14=2E=2E0534f338c84a 100644
>>> --- a/drivers/misc/Kconfig
>>> +++ b/drivers/misc/Kconfig
>>> @@ -508,4 +508,5 @@ source "drivers/misc/mic/Kconfig"
>>> =C2=A0 source "drivers/misc/genwqe/Kconfig"
>>> =C2=A0 source "drivers/misc/echo/Kconfig"
>>> =C2=A0 source "drivers/misc/cxl/Kconfig"
>>> +source "drivers/misc/ocxl/Kconfig"
>>> =C2=A0 endmenu
>>> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
>>> index 5ca5f64df478=2E=2E73326d54e246 100644
>>> --- a/drivers/misc/Makefile
>>> +++ b/drivers/misc/Makefile
>>> @@ -55,6 +55,7 @@ obj-$(CONFIG_CXL_BASE)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 +=3D cxl/
>>> =C2=A0 obj-$(CONFIG_ASPEED_LPC_CTRL)=C2=A0=C2=A0=C2=A0 +=3D aspeed-lpc=
-ctrl=2Eo
>>> =C2=A0 obj-$(CONFIG_ASPEED_LPC_SNOOP)=C2=A0=C2=A0=C2=A0 +=3D aspeed-lp=
c-snoop=2Eo
>>> =C2=A0 obj-$(CONFIG_PCI_ENDPOINT_TEST)=C2=A0=C2=A0=C2=A0 +=3D pci_endp=
oint_test=2Eo
>>> +obj-$(CONFIG_OCXL)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +=3D ocx=
l/
>>>
>>> =C2=A0 lkdtm-$(CONFIG_LKDTM)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 +=3D lkdtm_core=2Eo
>>> =C2=A0 lkdtm-$(CONFIG_LKDTM)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 +=3D lkdtm_bugs=2Eo
>>> diff --git a/drivers/misc/ocxl/Kconfig b/drivers/misc/ocxl/Kconfig
>>> new file mode 100644
>>> index 000000000000=2E=2E4496b61f48db
>>> --- /dev/null
>>> +++ b/drivers/misc/ocxl/Kconfig
>>> @@ -0,0 +1,25 @@
>>> +#
>>> +# Open Coherent Accelerator (OCXL) compatible devices
>>> +#
>>> +
>>> +config OCXL_BASE
>>> +=C2=A0=C2=A0=C2=A0 bool
>>> +=C2=A0=C2=A0=C2=A0 default n
>>> +=C2=A0=C2=A0=C2=A0 select PPC_COPRO_BASE
>>> +
>>> +config OCXL
>>> +=C2=A0=C2=A0=C2=A0 tristate "Support for Open Coherent Accelerators (=
OCXL)"
>>> +=C2=A0=C2=A0=C2=A0 depends on PPC_POWERNV && PCI && EEH
>>> +=C2=A0=C2=A0=C2=A0 select OCXL_BASE
>>> +=C2=A0=C2=A0=C2=A0 default m
>>> +=C2=A0=C2=A0=C2=A0 help
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Select this option to enable driver su=
pport for Open
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Coherent Accelerators (OCXL)=2E=C2=A0 =
OCXL is otherwise known as
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Open Coherent Accelerator Processor In=
terface (OCAPI)=2E
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 OCAPI allows accelerators in FPGAs to =
be coherently attached
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 to a CPU through a Open CAPI link=2E=
=C2=A0 This driver enables
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 userspace programs to access these acc=
elerators through
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devices found in /dev/ocxl/
>>=20
>> I'd prefer more consistency in how we refer to OpenCAPI=2E "ocxl" is a=
=20
>> driver name that we have purely for historical reasons, it's not
>really=20
>> the name of anything else=2E I know throughout the various specs and
>code,=20
>> we use "OCAPI" a lot, but that's not really an abbreviation that
>should=20
>> be "user-facing"=2E
>>=20
>> Something like:
>>=20
>> config OCXL
>>  =C2=A0=C2=A0=C2=A0=C2=A0 tristate "OpenCAPI coherent accelerator suppo=
rt"
>>  =C2=A0=C2=A0=C2=A0=C2=A0 help
>>=20
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Select this option to enable the =
ocxl driver for Open
>Coherent
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Accelerator Processor Interface (=
OpenCAPI) devices=2E
>>=20
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 OpenCAPI allows FPGA and ASIC acc=
elerators to be coherently
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 attached to a CPU over an OpenCAP=
I link=2E
>>=20
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 The ocxl driver enables userspace=
 programs to access these
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 accelerators through devices in /=
dev/ocxl/=2E
>>=20
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 For more information, see http://=
opencapi=2Eorg=2E
>>=20
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 If unsure, say N=2E
>>=20
>
>Agreed, and stolen=2E

Would also be great to add something describing the relationship to CAPI a=
nd cxl=2E Otherwise people will be confused about whether they need this on=
e or the other one or both=2E

cheers
--=20
Sent from my Android phone with K-9 Mail=2E Please excuse my brevity=2E

Return-Path: <vgallardo@apm.com>
Received: from exprod5og108.obsmtp.com (exprod5og108.obsmtp.com [64.18.0.186])
	by ozlabs.org (Postfix) with SMTP id 299C8100815
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  9 Oct 2010 04:37:07 +1100 (EST)
Received: by qwd6 with SMTP id 6so684165qwd.20
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 08 Oct 2010 10:37:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20101008133511.GA10590@zod.rchland.ibm.com>
References: <1286478436-9942-1-git-send-email-vgallardo@apm.com>
	<20101008133511.GA10590@zod.rchland.ibm.com>
Date: Fri, 8 Oct 2010 10:30:10 -0700
Message-ID: <AANLkTikyLrzoyt20Y7Ek2wrmBggGohbds6DAvhCm_ftS@mail.gmail.com>
Subject: Re: [PATCH 1/3] Powerpc/4xx: Add suspend and idle support
From: Victor Gallardo <vgallardo@apm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Josh,


On Fri, Oct 8, 2010 at 6:35 AM, Josh Boyer <jwboyer@linux.vnet.ibm.com> wro=
te:
> On Thu, Oct 07, 2010 at 12:07:16PM -0700, Victor Gallardo wrote:
>>Add suspend/resume support for all 4xx compatible CPUs.
>>See /sys/power/state for available power states configured in.
>>
>>Add two different idle states (idle-wait and idle-doze)
>>controlled via sysfs. Default is idle-wait.
>> =A0 =A0 =A0 cat /sys/devices/system/cpu/cpu0/idle
>> =A0 =A0 =A0 [wait] doze
>>
>>To save additional power, use idle-doze.
>> =A0 =A0 =A0 echo doze > /sys/devices/system/cpu/cpu0/idle
>> =A0 =A0 =A0 cat /sys/devices/system/cpu/cpu0/idle
>> =A0 =A0 =A0 wait [doze]
>>
>>Signed-off-by: Victor Gallardo <vgallardo@apm.com>
>>---
>> Documentation/powerpc/dts-bindings/4xx/cpm.txt | =A0 43 +++
>> arch/powerpc/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | =A0 13 +-
>> arch/powerpc/platforms/44x/Makefile =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A05 +-
>> arch/powerpc/sysdev/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =
=A01 +
>> arch/powerpc/sysdev/ppc4xx_cpm.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0339 ++=
++++++++++++++++++++++
>> 5 files changed, 397 insertions(+), 4 deletions(-)
>> create mode 100644 Documentation/powerpc/dts-bindings/4xx/cpm.txt
>> create mode 100644 arch/powerpc/sysdev/ppc4xx_cpm.c
>>
>>diff --git a/Documentation/powerpc/dts-bindings/4xx/cpm.txt b/Documentati=
on/powerpc/dts-bindings/4xx/cpm.txt
>>new file mode 100644
>>index 0000000..9635df8
>>--- /dev/null
>>+++ b/Documentation/powerpc/dts-bindings/4xx/cpm.txt
>>@@ -0,0 +1,43 @@
>>+PPC4xx Clock Power Management (CPM) node
>>+
>>+Required properties:
>>+ =A0 =A0 =A0- compatible =A0 =A0 =A0 =A0 =A0 =A0: compatible list, curre=
ntly only "ibm,cpm"
>>+ =A0 =A0 =A0- dcr-access-method =A0 =A0 : "native"
>>+ =A0 =A0 =A0- dcr-reg =A0 =A0 =A0 =A0 =A0 =A0 =A0 : < DCR register range=
 >
>>+
>>+Optional properties:
>>+ =A0 =A0 =A0- er-offset =A0 =A0 =A0 =A0 =A0 =A0 : All 4xx SoCs with a CP=
M controller have
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0one of t=
wo different order for the CPM
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0register=
s. Some have the CPM registers
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0in the f=
ollowing order (ER,FR,SR). The
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0others h=
ave them in the following order
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(SR,ER,F=
R). For the second case set
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0er-offse=
t =3D <1>.
>>+ =A0 =A0 =A0- unused-units =A0 =A0 =A0 =A0 =A0: specifier consist of one=
 cell. For each
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bit in t=
he cell, the corresponding bit
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0in CPM w=
ill be set to turn off unused
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0devices.
>>+ =A0 =A0 =A0- idle-doze =A0 =A0 =A0 =A0 =A0 =A0 : specifier consist of o=
ne cell. For each
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bit in t=
he cell, the corresponding bit
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0in CPM w=
ill be set to turn off unused
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0devices.=
 This is usually just CPM[CPU].
>>+ =A0 =A0 =A0- standby =A0 =A0 =A0 =A0 =A0 =A0 =A0 : specifier consist of=
 one cell. For each
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bit in t=
he cell, the corresponding bit
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0in CPM w=
ill be set on standby and
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0restored=
 on resume.
>>+ =A0 =A0 =A0- suspend =A0 =A0 =A0 =A0 =A0 =A0 =A0 : specifier consist of=
 one cell. For each
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bit in t=
he cell, the corresponding bit
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0in CPM w=
ill be set on suspend (mem) and
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0restored=
 on resume.
>
> So the difference, from what I can tell, between standby and suspend is
> really only what devices are turned off. =A0I don't see any code to put
> the DRAM into self-refresh mode, etc. =A0If that is the case, perhaps we
> could add a bit of description as to the different kinds of devices that
> may be disabled in one mode but not the other.

You are correct for this patch. I will introduce putting DDR in
self-refresh in a following patch for specific processors.
>
>>+
>>+Example:
>>+ =A0 =A0 =A0 =A0CPM0: cpm {
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "ibm,cpm";
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dcr-access-method =3D "native";
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dcr-reg =3D <0x160 0x003>;
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0er-offset =3D <0>;
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unused-units =3D <0x00000100>;
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0idle-doze =3D <0x02000000>;
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0standby =3D <0xfeff0000>;
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0standby =3D <0xfeff791d>;
>
> One of these two should be illustrating suspend.

Yes,  you are correct. I will fix that.

-Victor Gallardo

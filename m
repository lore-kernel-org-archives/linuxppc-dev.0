Return-Path: <larry_chen@agilent.com>
Received: from msgbas1x.cos.agilent.com (msgbas1x.cos.agilent.com
	[192.25.240.36]) by ozlabs.org (Postfix) with ESMTP id 3C78A67B68
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 15 Apr 2005 07:28:29 +1000 (EST)
Received: from relcos1.cos.agilent.com (relcos1.cos.agilent.com
	[130.29.152.239])
	by msgbas1x.cos.agilent.com (Postfix) with ESMTP id 45DA82047D
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Apr 2005 15:09:50 -0600 (MDT)
Received: from wcosvs02.cos.agilent.com (wcosvs02.cos.agilent.com
	[130.29.152.188])
	by relcos1.cos.agilent.com (Postfix) with ESMTP id 0F2F962A
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Apr 2005 15:09:50 -0600 (MDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Thu, 14 Apr 2005 15:09:48 -0600
Message-ID: <26F517960E0A454BAC0748B5C33D5DEA18A724@wcosmb05.cos.agilent.com>
From: <larry_chen@agilent.com>
To: <wd@denx.de>, <larry_chen@agilent.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: ELDK 3.1.1 support for x86_64 host architecture 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Wolfgang,

I have tried both an install and a build from scratch of v3.1.1;
both fail due to various scripting problems having to due with
unsupported HOST_ARCH of x86_64.

Below is a cut and paste of the install failure. I don't have
the build from scratch failure at the moment (but the initial failures =
were
in ELDK_BUILD and build.sh scripts; search ELDK_BUILD and
build.sh for uname -m and HOST_ARCH. You'll see what I mean :)

[larrchen@rslab46 opt]$ ls -l
total 24
drwxr-xr-x  2 larrchen root 4096 Apr 14 13:46 eldk2
[larrchen@rslab46 opt]$ cd /media/cdrom
[larrchen@rslab46 cdrom]$ ls
brandelf       ELDK_MAKEDEV  install    ppc_6xx   ppc_8xx      sys
common         etc           ppc_4xx    ppc_74xx  README.html  tools
ELDK_FIXOWNER  icons         ppc_4xxFP  ppc_85xx  RPMS         version
[larrchen@rslab46 cdrom]$ ./install -d /opt/eldk2


Do you really want to install into /opt/eldk2 directory[y/n]?: y

Creating directories
Done
Installing cross RPMs

Preparing...                ########################################### =
[100%]
        package rpm-4.1.1-1.8xa_10 is intended for a i386 architecture
can't change dir: No such file or directory
[larrchen@rslab46 cdrom]$

Also, here is soem info on my host machine.

[root@rslab46 cdrom]# cat /etc/issue
Fedora Core release 3 (Heidelberg)
Kernel \r on an \m

[larrchen@rslab46 opt]$ ls -l
[larrchen@rslab46 ~]$ uname -m
x86_64
[larrchen@rslab46 ~]$ uname -a
Linux rslab46.scs.agilent.com 2.6.11-1.14_FC3smp #1 SMP Thu Apr 7 =
19:36:23 EDT 2005 x86_64 x86_64 x86_64 GNU/Linux
[larrchen@rslab46 ~]$ cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 4
model name      :                   Intel(R) Xeon(TM) CPU 2.80GHz
stepping        : 1
cpu MHz         : 2800.205
cache size      : 1024 KB
physical id     : 0
siblings        : 2
fpu             : yes
fpu_exception   : yes
cpuid level     : 5
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge =
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm syscall =
lm pni monitor ds_cpl cid cx16 xtpr
bogomips        : 5521.40
clflush size    : 64
cache_alignment : 128
address sizes   : 36 bits physical, 48 bits virtual
power management:


processor       : 1
vendor_id       : GenuineIntel
cpu family      : 15
model           : 4
model name      :                   Intel(R) Xeon(TM) CPU 2.80GHz
stepping        : 1
cpu MHz         : 2800.205
cache size      : 1024 KB
physical id     : 0
siblings        : 2
fpu             : yes
fpu_exception   : yes
cpuid level     : 5
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge =
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm syscall =
lm pni monitor ds_cpl cid cx16 xtpr
bogomips        : 5586.94
clflush size    : 64
cache_alignment : 128
address sizes   : 36 bits physical, 48 bits virtual
power management:

Thanks for your help in this matter.

Best Regards,
Larry Chen

-----Original Message-----
From: wd@denx.de [mailto:wd@denx.de]
Sent: Wednesday, April 13, 2005 10:49 PM
To: larry_chen@agilent.com
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: ELDK 3.1.1 support for x86_64 host architecture=20


In message =
<26F517960E0A454BAC0748B5C33D5DEA18A722@wcosmb05.cos.agilent.com> you =
wrote:
>=20
> I've noticed that the ELDK build and install scripts do NOT
> support x86_64 host architecture.

Which sort of host system is this (Processor(s), RAM, Linux =
distribution) ?

> What support for x86_64 host architecture ever attempted
> by anyone?

It works fine here on several Athlon / Opteron systems running Fedora
Core 2 and Fedora Core 3; for example:

-> cat /etc/issue
Fedora Core release 2 (Tettnang)
Kernel \r on an \m

-> uname -a
Linux pollux 2.6.10-1.770_FC2smp #1 SMP Sat Feb 26 19:46:59 EST 2005 =
x86_64 x86_64 x86_64 GNU/Linux
-> cat /proc/cpuinfo=20
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 5
model name      : AMD Opteron(tm) Processor 246
stepping        : 10
cpu MHz         : 2004.596
cache size      : 1024 KB
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge =
mca cmov pat pse36 clflush mmx fxsr sse sse2 pni syscall nx mmxext lm =
3dnowext 3dnow
bogomips        : 3940.35
TLB size        : 1088 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp

processor       : 1
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 5
model name      : AMD Opteron(tm) Processor 246
stepping        : 10
cpu MHz         : 2004.596
cache size      : 1024 KB
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge =
mca cmov pat pse36 clflush mmx fxsr sse sse2 pni syscall nx mmxext lm =
3dnowext 3dnow
bogomips        : 4005.88
TLB size        : 1088 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp

-> type ppc_8xx-gcc
ppc_8xx-gcc is /opt/eldk/usr/bin/ppc_8xx-gcc
-> ppc_8xx-gcc -v
Reading specs from =
/opt/eldk-3.1.1/usr/bin/../lib/gcc-lib/ppc-linux/3.3.3/specs
Configured with: ../configure --prefix=3D/usr --mandir=3D/usr/share/man =
--infodir=3D/usr/share/info --enable-shared --enable-threads=3Dposix =
--disable-checking --with-system-zlib --enable-__cxa_atexit =
--with-newlib --enable-languages=3Dc,c++ --disable-libgcj =
--host=3Di386-redhat-linux --target=3Dppc-linux
Thread model: posix
gcc version 3.3.3 (DENX ELDK 3.1.1 3.3.3-9)


Best regards,

Wolfgang Denk

--=20
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Neckties strangle clear thinking.                       -- Lin Yutang

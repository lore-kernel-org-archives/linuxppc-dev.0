Return-Path: <mike@it-loops.com>
Received: from mail-ee0-x236.google.com (mail-ee0-x236.google.com
 [IPv6:2a00:1450:4013:c00::236])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3B80B2C0307
 for <linuxppc-dev@lists.ozlabs.org.>; Sun,  9 Jun 2013 03:31:04 +1000 (EST)
Received: by mail-ee0-f54.google.com with SMTP id t10so1966794eei.41
 for <linuxppc-dev@lists.ozlabs.org.>; Sat, 08 Jun 2013 10:30:58 -0700 (PDT)
Sender: Michael Guntsche <michael.guntsche@it-loops.com>
Date: Sat, 8 Jun 2013 19:30:56 +0200
From: Michael Guntsche <mike@it-loops.com>
To: linux-kernel@vger.kernel.org
Message-ID: <9DDDB307CA5247829231E16ED534DF3E@it-loops.com>
Subject: [BUG] PCI related panic on powerpc based board with 3.10-rcX
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="51b36a50_51ead36b_5f38"
Cc: linuxppc-dev@lists.ozlabs.org.
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--51b36a50_51ead36b_5f38
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Good evening, 

I recently tested the latest 3.10-rc release (rc4) on my powerpc based routerboard which is currently running very stable on a 3.9 release.
During boot I immediately got a kernel panic.

I was able to get a log of the trace with the serial console.

[    0.039522] PCI: Probing PCI hardware
[    0.043159] PCI: Memory resource 0 not set for host bridge /pci@e0008500 (domain 0)
[    0.050778] PCI: Memory resource 0 not set for host bridge /pci@e0008500 (domain 0)
[    0.058855] PCI host bridge to bus 0000:00
[    0.062938] pci_bus 0000:00: root bus resource [io  0x0000-0xffffff]
[    0.069255] pci_bus 0000:00: root bus resource [mem 0x80000000-0x9fffffff]
[    0.076131] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.081639] Unable to handle kernel paging request for data at address 0x00000f14
[    0.089068] Faulting instruction address: 0xc0014d40
[    0.094031] Oops: Kernel access of bad area, sig: 11 [#1]
[    0.099420] MikroTik RouterBOARD 600 series
[    0.103597] Modules linked in:
[    0.106651] CPU: 0 PID: 1 Comm: swapper Not tainted 3.10.0-rc1+ #15
[    0.112910] task: c782e000 ti: c7834000 task.ti: c7834000
[    0.118303] NIP: c0014d40 LR: c0014dd8 CTR: c0014e10
[    0.123262] REGS: c7835b40 TRAP: 0300   Not tainted  (3.10.0-rc1+)
[    0.129435] MSR: 00001032 <ME,IR,DR,RI>  CR: 22000084  XER: 20000000
[    0.135788] DAR: 00000f14, DSISR: 20000000
[    0.139875]
GPR00: c0014e40 c7835bf0 c782e000 c0417000 00000000 00000000 00000004 00000000
GPR08: 00000000 00000000 00000000 00000037 22000084 00000000 c0003e90 00000000
GPR16: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000045
GPR24: c0400000 c03f0000 c036134c c782de00 00000000 0000ea60 c782de00 c0417000
[    0.169567] NIP [c0014d40] fsl_pcie_check_link.part.4+0x8/0x2c
[    0.175380] LR [c0014dd8] fsl_pcie_check_link+0x74/0xac
[    0.180591] Call Trace:
[    0.183033] [c7835bf0] [00000025] 0x25 (unreliable)
[    0.187909] [c7835d80] [c0014e40] fsl_indirect_read_config+0x30/0x8c
[    0.194270] [c7835da0] [c019c108] pci_bus_read_config_dword+0x60/0x80
[    0.200703] [c7835dc0] [c019df3c] pci_bus_read_dev_vendor_id+0x34/0x108
[    0.207321] [c7835df0] [c022d394] pci_scan_single_device+0x58/0xc8
[    0.213488] [c7835e20] [c019f068] pci_scan_slot+0x54/0x110
[    0.218969] [c7835e40] [c019fc40] pci_scan_child_bus+0x28/0xdc
[    0.224811] [c7835e60] [c0010aa4] pcibios_scan_phb+0x19c/0x210
[    0.230640] [c7835e90] [c03b4658] pcibios_init+0x7c/0x114
[    0.236025] [c7835ec0] [c00039a4] do_one_initcall+0x150/0x1a4
[    0.241763] [c7835ef0] [c03b1888] kernel_init_freeable+0x114/0x1bc
[    0.247938] [c7835f30] [c0003ea8] kernel_init+0x18/0x110
[    0.253247] [c7835f40] [c000e098] ret_from_kernel_thread+0x64/0x6c
[    0.259417] --- Exception: 0 at   (null)
[    0.259417]     LR =   (null)
[    0.266287] Instruction dump:
[    0.269246] 3d400006 614a0400 915f0028 3d40c040 912afc88 80010024 83e1001c 38210020
[    0.276988] 7c0803a6 4e800020 812300ec 7c0004ac <80690f14> 0c030000 4c00012c 5463f6be
[    0.284945] ---[ end trace 074b946a523243d5 ]---


Compare this to booting with 3.9

[    0.039088] PCI: Probing PCI hardware
[    0.043151] PCI host bridge to bus 0000:00
[    0.047232] pci_bus 0000:00: root bus resource [io  0x0000-0xffffff]
[    0.053546] pci_bus 0000:00: root bus resource [mem 0x80000000-0x9fffffff]
[    0.060419] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.068080] pci 0000:00:0d.0: BAR 0: assigned [mem 0x80000000-0x8000ffff]
[    0.074854] pci 0000:00:0b.0: BAR 0: assigned [io  0x1000-0x10ff]
[    0.080908] pci 0000:00:0b.0: BAR 1: assigned [mem 0x80010000-0x800100ff]
[    0.103986] bio: create slab <bio-0> at 0
[    0.108589] Freescale Elo / Elo Plus DMA driver
[    0.115166] SCSI subsystem initialized


Especially I do not understand why this message shows up now
 
PCI: Memory resource 0 not set for host bridge

Does someone have an idea what's happening here?
I tested this also on rc1 and got the same panic there.
Please CC me on any replies since I am not subscribed to the list.

Thank you very much in advance,
Michael Guntsche
 


--51b36a50_51ead36b_5f38
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


                <div>Good evening,
                </div><div><br></div><div>I recently tested the latest 3.=
10-rc release (rc4) on my powerpc based routerboard which is currently ru=
nning very stable on a 3.9 release.</div><div>During boot I immediately g=
ot a kernel panic.</div><div><br></div><div>I was able to get a log of th=
e trace with the serial console.</div><div><br></div><div><div>=5B &nbsp;=
 &nbsp;0.039522=5D PCI: Probing PCI hardware</div><div>=5B &nbsp; &nbsp;0=
.043159=5D PCI: Memory resource 0 not set for host bridge /pci=40e0008500=
 (domain 0)</div><div>=5B &nbsp; &nbsp;0.050778=5D PCI: Memory resource 0=
 not set for host bridge /pci=40e0008500 (domain 0)</div><div>=5B &nbsp; =
&nbsp;0.058855=5D PCI host bridge to bus 0000:00</div><div>=5B &nbsp; &nb=
sp;0.062938=5D pci=5Fbus 0000:00: root bus resource =5Bio &nbsp;0x0000-0x=
ffffff=5D</div><div>=5B &nbsp; &nbsp;0.069255=5D pci=5Fbus 0000:00: root =
bus resource =5Bmem 0x80000000-0x9fffffff=5D</div><div>=5B &nbsp; &nbsp;0=
.076131=5D pci=5Fbus 0000:00: root bus resource =5Bbus 00-ff=5D</div><div=
>=5B &nbsp; &nbsp;0.081639=5D Unable to handle kernel paging request for =
data at address 0x00000f14</div><div>=5B &nbsp; &nbsp;0.089068=5D =46ault=
ing instruction address: 0xc0014d40</div><div>=5B &nbsp; &nbsp;0.094031=5D=
 Oops: Kernel access of bad area, sig: 11 =5B=231=5D</div><div>=5B &nbsp;=
 &nbsp;0.099420=5D MikroTik RouterBOARD 600 series</div><div>=5B &nbsp; &=
nbsp;0.103597=5D Modules linked in:</div><div>=5B &nbsp; &nbsp;0.106651=5D=
 CPU: 0 PID: 1 Comm: swapper Not tainted 3.10.0-rc1+ =2315</div><div>=5B =
&nbsp; &nbsp;0.112910=5D task: c782e000 ti: c7834000 task.ti: c7834000</d=
iv><div>=5B &nbsp; &nbsp;0.118303=5D NIP: c0014d40 LR: c0014dd8 CTR: c001=
4e10</div><div>=5B &nbsp; &nbsp;0.123262=5D REGS: c7835b40 TRAP: 0300 &nb=
sp; Not tainted &nbsp;(3.10.0-rc1+)</div><div>=5B &nbsp; &nbsp;0.129435=5D=
 MSR: 00001032 &lt;ME,IR,DR,RI&gt; &nbsp;CR: 22000084 &nbsp;XER: 20000000=
</div><div>=5B &nbsp; &nbsp;0.135788=5D DAR: 00000f14, DSISR: 20000000</d=
iv><div>=5B &nbsp; &nbsp;0.139875=5D</div><div>GPR00: c0014e40 c7835bf0 c=
782e000 c0417000 00000000 00000000 00000004 00000000</div><div>GPR08: 000=
00000 00000000 00000000 00000037 22000084 00000000 c0003e90 00000000</div=
><div>GPR16: 00000000 00000000 00000000 00000000 00000000 00000000 000000=
00 00000045</div><div>GPR24: c0400000 c03f0000 c036134c c782de00 00000000=
 0000ea60 c782de00 c0417000</div><div>=5B &nbsp; &nbsp;0.169567=5D NIP =5B=
c0014d40=5D fsl=5Fpcie=5Fcheck=5Flink.part.4+0x8/0x2c</div><div>=5B &nbsp=
; &nbsp;0.175380=5D LR =5Bc0014dd8=5D fsl=5Fpcie=5Fcheck=5Flink+0x74/0xac=
</div><div>=5B &nbsp; &nbsp;0.180591=5D Call Trace:</div><div>=5B &nbsp; =
&nbsp;0.183033=5D =5Bc7835bf0=5D =5B00000025=5D 0x25 (unreliable)</div><d=
iv>=5B &nbsp; &nbsp;0.187909=5D =5Bc7835d80=5D =5Bc0014e40=5D fsl=5Findir=
ect=5Fread=5Fconfig+0x30/0x8c</div><div>=5B &nbsp; &nbsp;0.194270=5D =5Bc=
7835da0=5D =5Bc019c108=5D pci=5Fbus=5Fread=5Fconfig=5Fdword+0x60/0x80</di=
v><div>=5B &nbsp; &nbsp;0.200703=5D =5Bc7835dc0=5D =5Bc019df3c=5D pci=5Fb=
us=5Fread=5Fdev=5Fvendor=5Fid+0x34/0x108</div><div>=5B &nbsp; &nbsp;0.207=
321=5D =5Bc7835df0=5D =5Bc022d394=5D pci=5Fscan=5Fsingle=5Fdevice+0x58/0x=
c8</div><div>=5B &nbsp; &nbsp;0.213488=5D =5Bc7835e20=5D =5Bc019f068=5D p=
ci=5Fscan=5Fslot+0x54/0x110</div><div>=5B &nbsp; &nbsp;0.218969=5D =5Bc78=
35e40=5D =5Bc019fc40=5D pci=5Fscan=5Fchild=5Fbus+0x28/0xdc</div><div>=5B =
&nbsp; &nbsp;0.224811=5D =5Bc7835e60=5D =5Bc0010aa4=5D pcibios=5Fscan=5Fp=
hb+0x19c/0x210</div><div>=5B &nbsp; &nbsp;0.230640=5D =5Bc7835e90=5D =5Bc=
03b4658=5D pcibios=5Finit+0x7c/0x114</div><div>=5B &nbsp; &nbsp;0.236025=5D=
 =5Bc7835ec0=5D =5Bc00039a4=5D do=5Fone=5Finitcall+0x150/0x1a4</div><div>=
=5B &nbsp; &nbsp;0.241763=5D =5Bc7835ef0=5D =5Bc03b1888=5D kernel=5Finit=5F=
freeable+0x114/0x1bc</div><div>=5B &nbsp; &nbsp;0.247938=5D =5Bc7835f30=5D=
 =5Bc0003ea8=5D kernel=5Finit+0x18/0x110</div><div>=5B &nbsp; &nbsp;0.253=
247=5D =5Bc7835f40=5D =5Bc000e098=5D ret=5Ffrom=5Fkernel=5Fthread+0x64/0x=
6c</div><div>=5B &nbsp; &nbsp;0.259417=5D --- Exception: 0 at &nbsp; (nul=
l)</div><div>=5B &nbsp; &nbsp;0.259417=5D &nbsp; &nbsp; LR =3D &nbsp; (nu=
ll)</div><div>=5B &nbsp; &nbsp;0.266287=5D Instruction dump:</div><div>=5B=
 &nbsp; &nbsp;0.269246=5D 3d400006 614a0400 915f0028 3d40c040 912afc88 80=
010024 83e1001c 38210020</div><div>=5B &nbsp; &nbsp;0.276988=5D 7c0803a6 =
4e800020 812300ec 7c0004ac &lt;80690f14&gt; 0c030000 4c00012c 5463f6be</d=
iv><div>=5B &nbsp; &nbsp;0.284945=5D ---=5B end trace 074b946a523243d5 =5D=
---</div></div><div><br></div><div>Compare this to booting with 3.9</div>=
<div><br></div><div><div>=5B &nbsp; &nbsp;0.039088=5D PCI: Probing PCI ha=
rdware</div><div>=5B &nbsp; &nbsp;0.043151=5D PCI host bridge to bus 0000=
:00</div><div>=5B &nbsp; &nbsp;0.047232=5D pci=5Fbus 0000:00: root bus re=
source =5Bio &nbsp;0x0000-0xffffff=5D</div><div>=5B &nbsp; &nbsp;0.053546=
=5D pci=5Fbus 0000:00: root bus resource =5Bmem 0x80000000-0x9fffffff=5D<=
/div><div>=5B &nbsp; &nbsp;0.060419=5D pci=5Fbus 0000:00: root bus resour=
ce =5Bbus 00-ff=5D</div><div>=5B &nbsp; &nbsp;0.068080=5D pci 0000:00:0d.=
0: BAR 0: assigned =5Bmem 0x80000000-0x8000ffff=5D</div><div>=5B &nbsp; &=
nbsp;0.074854=5D pci 0000:00:0b.0: BAR 0: assigned =5Bio &nbsp;0x1000-0x1=
0ff=5D</div><div>=5B &nbsp; &nbsp;0.080908=5D pci 0000:00:0b.0: BAR 1: as=
signed =5Bmem 0x80010000-0x800100ff=5D</div><div>=5B &nbsp; &nbsp;0.10398=
6=5D bio: create slab &lt;bio-0&gt; at 0</div><div>=5B &nbsp; &nbsp;0.108=
589=5D =46reescale Elo / Elo Plus DMA driver</div><div>=5B &nbsp; &nbsp;0=
.115166=5D SCSI subsystem initialized</div></div><div><br></div><div>Espe=
cially I do not understand why this message shows up now</div><div>&nbsp;=
</div><div>PCI: Memory resource 0 not set for host bridge</div><div><br><=
/div><div>Does someone have an idea what's happening here=3F</div><div>I =
tested this also on rc1 and got the same panic there.</div><div>Please CC=
 me on any replies since I am not subscribed to the list.</div><div><br><=
/div><div>Thank you very much in advance,</div><div>Michael Guntsche</div=
><div>&nbsp;</div>
                <div></div>
            
--51b36a50_51ead36b_5f38--

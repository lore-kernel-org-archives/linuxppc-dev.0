Return-Path: <tmarri@amcc.com>
Received: from sdcmail02.amcc.com (sdcmail02.amcc.com [198.137.200.73])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "Messaging Gateway Appliance Demo Cert",
	Issuer "Messaging Gateway Appliance Demo Cert" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 88005DDE1D
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Mar 2009 03:22:03 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: sata device failed to IDENTIFY...
Date: Fri, 27 Mar 2009 09:21:58 -0700
Message-ID: <AC5E1C3367E37D44970B81A6ADD1DA2C071F4271@SDCEXCHANGE01.ad.amcc.com>
In-Reply-To: <22722574.post@talk.nabble.com>
References: <22655709.post@talk.nabble.com> <22722574.post@talk.nabble.com>
From: "Tirumala Reddy Marri" <tmarri@amcc.com>
To: "rizwan ahmad" <rizwanamu@gmail.com>,
	<linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

What PCI Sata card  is this ? Is you device tree entrees are correct for
PCI ?  Especially the interrupt numbers etc ?  Also check your ioremap()
function in the SATA driver. Make sure that data type of physical
address in the driver using is "unsigned long long" instead of "unsigned
long"



-----Original Message-----
From: linuxppc-dev-bounces+tmarri=3Damcc.com@ozlabs.org
[mailto:linuxppc-dev-bounces+tmarri=3Damcc.com@ozlabs.org] On Behalf Of
rizwan ahmad
Sent: Thursday, March 26, 2009 6:57 AM
To: linuxppc-dev@ozlabs.org
Subject: Re: sata device failed to IDENTIFY...




output of lspci -vv

-bash-3.2# lspci -vv
00:0c.0 Class 0c03: Unknown device 1106:3038 (rev 62)
        Subsystem: Unknown device 1106:3038
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr-
Ste-        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium
>TAbort-
<TAbor-        Latency: 128
        Interrupt: pin A routed to IRQ 25
        Region 4: I/O ports at ffe0 [size=3D32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA
PME(D0+,D1+,D2+,D3)                Status: D0 PME-Enable- DSel=3D0
DScale=3D0
PME-

00:0c.1 Class 0c03: Unknown device 1106:3038 (rev 62)
        Subsystem: Unknown device 1106:3038
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr-
Ste-        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium
>TAbort-
<TAbor-        Latency: 128
        Interrupt: pin B routed to IRQ 25
        Region 4: I/O ports at ffc0 [size=3D32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA
PME(D0+,D1+,D2+,D3)                Status: D0 PME-Enable- DSel=3D0
DScale=3D0
PME-

00:0c.2 Class 0c03: Unknown device 1106:3104 (rev 65) (prog-if 20)
        Subsystem: Unknown device 1106:3104
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr-
Ste-        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium
>TAbort-
<TAbor-        Latency: 128
        Interrupt: pin C routed to IRQ 25
        Region 0: Memory at afffff00 (32-bit, non-prefetchable)
[size=3D256]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA
PME(D0+,D1+,D2+,D3)                Status: D0 PME-Enable- DSel=3D0
DScale=3D0
PME-

00:0c.3 Class 0104: Unknown device 1106:3249 (rev 50)
        Subsystem: Unknown device 1106:3249
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr-
Ste-        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium
>TAbort-
<TAbor-        Latency: 128
        Interrupt: pin A routed to IRQ 25
        Region 0: I/O ports at ffb0 [size=3D16]
        Region 1: I/O ports at ffa0 [size=3D16]
        Region 2: I/O ports at ff90 [size=3D16]
        Region 3: I/O ports at ff80 [size=3D16]
        Region 4: I/O ports at ff60 [size=3D32]
        Region 5: I/O ports at fe00 [size=3D256]
        Expansion ROM at <ignored> [disabled]
        Capabilities: [e0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3ho)                Status: D0 PME-Enable- DSel=3D0
DScale=3D0
PME-

-bash-3.2#



--=20
View this message in context:
http://www.nabble.com/sata-device-failed-to-IDENTIFY...-tp22655709p22722
574.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.

_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-dev

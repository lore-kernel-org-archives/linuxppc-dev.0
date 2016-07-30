Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p04-ob.smtp.rzone.de (mo6-p04-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5304::7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s20g76CZjzDrDx
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 Jul 2016 08:30:59 +1000 (AEST)
Subject: [pasemi] problem with i2c-pasemi
To: Wolfram Sang <wsa@the-dreams.de>, Darren Stevens
 <darren@stevens-zone.net>, Olof Johansson <olof@lixom.net>,
 linuxppc-dev@lists.ozlabs.org
References: <7072d7cf-4d73-d424-af20-f5e94c8b399e@xenosoft.de>
 <816DC2B4-5B33-4C5E-A09A-F5BF7C7BF1FD@xenosoft.de>
 <aed83bc1-e574-1a9f-de58-480c9164865c@xenosoft.de>
 <2d94a278-d1d8-b484-e9ca-aedf18051e1a@xenosoft.de>
 <a84c2b93-4dac-9148-9ae2-0824491d1f50@xenosoft.de>
 <ae855392-570c-e125-b71f-2d5bf0c33eef@xenosoft.de>
 <d869fc32-ba80-529e-06dd-481ecf533642@xenosoft.de>
 <8b0682d3-866a-31dd-f01b-3510f84307dc@xenosoft.de>
 <2847029a-e3a4-8099-b72f-89d5731baaed@xenosoft.de>
 <6ebc8c6f-ffee-ab4e-1ce1-bc29bf08569d@xenosoft.de>
 <20160730182012.GA1608@katana>
Cc: luigi burdo <intermediadc@hotmail.com>,
 Julian Margetson <runaway@candw.ms>, Steven Jeffery <sajeffer@gmail.com>,
 "R.T.Dickinson" <rtd@a-eon.com>, "R.T.Dickinson" <rtd2@xtra.co.nz>,
 Pat Wall <pjwall@mac.com>, Pat Wall <pjwall@me.com>,
 "contact@a-eon.com" <contact@a-eon.com>,
 "matthew@a-eon.biz" <matthew@a-eon.biz>, Kevin Saunders <kfs1971@gmail.com>,
 Lyle Hazelwood <lylehaze@gmail.com>, EntwicklerX <mail@entwickler-x.de>,
 "xray@relec.ch" <xray@relec.ch>, Steve-David Marguet <steve@esdeem.ch>,
 George Sokianos <walkero@gmail.com>, =?UTF-8?Q?Sinan_G=c3=bcrkan?=
 <sinan.amigaone@gmail.com>, Mike <michael.heltne@gmail.com>,
 Thomas Ferreira <macsociety@me.com>, Christian Zigotzky <info@xenosoft.de>,
 "pjs@pjsa.net" <pjs@pjsa.net>, Ben Cato Malkenes <ben.cato@gmail.com>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <ae704d42-5b75-29c4-ac64-0302435c2f35@xenosoft.de>
Date: Sun, 31 Jul 2016 00:18:36 +0200
MIME-Version: 1.0
In-Reply-To: <20160730182012.GA1608@katana>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Information about our I2C/SMBus busses:

     00:1c.0 SMBus: PA Semi, Inc PWRficient SMBus Controller (rev 01)
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Interrupt: pin A routed to IRQ 70
        Region 0: I/O ports at 7f0200 [size=64]

     00:1c.1 SMBus: PA Semi, Inc PWRficient SMBus Controller (rev 01)
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Interrupt: pin A routed to IRQ 71
        Region 0: I/O ports at 7f0240 [size=64]

     00:1c.2 SMBus: PA Semi, Inc PWRficient SMBus Controller (rev 01)
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Interrupt: pin A routed to IRQ 72
        Region 0: I/O ports at 7f0280 [size=64]

SMbus Controllers
The CPU provides 3 SMbus controllers, and these are used to connect up 
various SMbus and I2C devices. The number of SMbusses is expanded to 7 
via a 1:4 multiplexer on SMbus 1.

SMbus 0 is connected to the 4 DIMM sockets to support Serial Presence 
Detect (SPD). It is also connected to a standard 24LC128 EEPROM, and a 
temperature sensor (Texas Instruments TMP423). This sensor is connected 
to the CPU on-die temperature diodes for the 2 cores and SOC (main logic).

Cheers,

Christian


On 30 July 2016 at 8:20 PM, Wolfram Sang wrote:
>
> Which I2C busses do you have on your board and how are they described?
> Can you post that?
>
> Thanks,
>
>     Wolfram
>

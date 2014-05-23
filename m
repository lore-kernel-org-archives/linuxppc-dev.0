Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::5])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CF05D1A007D
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 May 2014 07:29:36 +1000 (EST)
Received: from christians-pro.lan (ppp-93-104-65-236.dynamic.mnet-online.de
 [93.104.65.236]) by smtp.strato.de (RZmta 34.2 DYNA|AUTH)
 with ESMTPSA id R07940q4NLTT32C
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 for <linuxppc-dev@lists.ozlabs.org>;
 Fri, 23 May 2014 23:29:29 +0200 (CEST)
Message-ID: <537FBDB8.6050202@xenosoft.de>
Date: Fri, 23 May 2014 23:29:28 +0200
From: Christian Zigotzky <chzigotzky@xenosoft.de>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: PASEMI: Kernel 3.15.0-rc6 doesn't boot with a PA6T cpu
References: <1388264507-5100-1-git-send-email-olof@lixom.net>
 <CAOesGMhHw-G-T7ZfNsVU92ftOucCNe9shNJtA7SWzqX=dQBQng@mail.gmail.com>
 <CAOesGMgsY0R6KBXXH_ibTBYb1i_auWESwnoDkvi-esb58Pc+2A@mail.gmail.com>
 <20140103081219.GA10233@quad.lixom.net> <1389154189.2076.5.camel@concordia>
 <1389154706.4672.21.camel@pasglop> <20140108174828.GA16830@quad.lixom.net>
 <52CDC12F.5030407@xenosoft.de> <52D6E829.1050504@xenosoft.de>
 <52D6E89C.7010407@xenosoft.de> <52D6E928.7050307@xenosoft.de>
 <52DF9AEF.30900@xenosoft.de>
In-Reply-To: <52DF9AEF.30900@xenosoft.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi All,

My PA6T system doesn't boot since patch 
9000c17dc0f9c910267d2661225c9d33a227b27e from 08/04/14 (powerpc/powernv: 
Fix endian issues with sensor code One OPAL call and one device tree 
property needed byte swapping).

Experimental protocol:

git checkout -f 01d8885785a60ae8f4c37b0ed75bdc96d0fc6a44; git clean -fdx
(from 02/04/14) -> Kernel boots
git checkout -f f1553174a207f68a4ec19d436003097e0a4dc405; git clean -fdx
(from 03/04/14) -> Kernel boots
git checkout -f d40326f4b9f9617cdfd30f83a2db57d47e9c5bac; git clean -fdx
(from 04/04/14) -> Kernel boots
git checkout -f 930b440cd8256f3861bdb0a59d26efaadac7941a; git clean -fdx
(from 05/04/14) -> doesn't boot (rtc error)
git checkout -f 2b3a8fd735f86ebeb2b9d061054003000c36b654; git clean -fdx
(from 06/04/14) -> doesn't boot (rtc error)
git checkout -f 26c12d93348f0bda0756aff83f4867d9ae58a5a6; git clean -fdx
(from 07/04/14) -> doesn't boot (rtc error)
git checkout -f a6c8aff022d4d06e4b41455ae9b2a5d3d503bf76; git clean -fdx
(from 08/04/14) -> Kernel boots
git checkout -f 035328c202d26a824b8632fd3b00635db5aee5a2; git clean -fdx
(from 08/04/14) -> Kernel boots
git checkout -f 9000c17dc0f9c910267d2661225c9d33a227b27e; git clean -fdx
(from 08/04/14) powerpc/powernv: Fix endian issues with sensor code
One OPAL call and one device tree property needed byte swapping. ->
doesn't boot (prom_init)
git checkout -f d3d35d957a9d0733dc51f14b5abc0bff5d3c5f3a; git clean -fdx
(from 08/04/14) -> doesn't boot (prom_init)
git checkout -f c4586256f0c440bc2bdb29d2cbb915f0ca785d26; git clean -fdx
(from 09/04/14) -> doesn't boot (prom_init)

And the RC 6 doesn't boot, either. Have you changed the ppc boot part of 
the kernel? Kernel 3.14 and 3.13 boot without any problems.

Rgds,

Christian

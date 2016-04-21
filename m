Return-Path: <chunkeey@googlemail.com>
Received: from mail-wm0-x244.google.com (mail-wm0-x244.google.com
 [IPv6:2a00:1450:400c:c09::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qrVcZ2MsRzDqdJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 06:25:34 +1000 (AEST)
Received: by mail-wm0-x244.google.com with SMTP id e201so19929387wme.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 13:25:34 -0700 (PDT)
From: Christian Lamparter <chunkeey@googlemail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>,
 Julian Margetson <runaway@candw.ms>
Subject: Re: [PATCH v1 00/23] ata: sata_dwc_460ex: make it working again
Date: Thu, 21 Apr 2016 22:25:25 +0200
Message-ID: <1939944.iP9HDO4haS@debian64>
In-Reply-To: <1461262544-115408-1-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1461262544-115408-1-git-send-email-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday, April 21, 2016 09:15:21 PM Andy Shevchenko wrote:
> The last approach in the commit 8b3444852a2b ("sata_dwc_460ex: move t=
o generic
> DMA driver") to switch to generic DMA engine API wasn't tested on bar=
e metal.
> Besides that we expecting new board support coming with the same SATA=
 IP but
> with different DMA.
>=20
> This series is targetting the following things:
> - a few bug fixes to the original driver
> - a part to fix the DMA engine usage and in particularly dw_dmac driv=
er
> - move driver to use generic PHY and "dmas" property which leads to u=
pdate in DTS
>=20
> The driver has been tested myself on Sam460ex and WD MyBookLive (apol=
lo3g)
> boards. In any case I ask Christian, M=E5ns, and Julian to independen=
tly test and
> provide Tested-by tag or error report.
I did a test run on my WD MyBook Live. I applied all the patches in
this series on top of the topic/dw branch of Vinod Koul:
<https://git.kernel.org/cgit/linux/kernel/git/vkoul/slave-dma.git/>

Tested-by: Christian Lamparter <chunkeey@googlemail.com>
---
results for my old ST3808110AS HDD. filesystem is ext4.

# hdparm -t /dev/sda

/dev/sda:
 Timing buffered disk reads: 204 MB in  3.02 seconds =3D  67.51 MB/sec

# bonnie++ -u mbl
Using uid:1000, gid:1000.
Writing a byte at a time...done
Writing intelligently...done
Rewriting...done
Reading a byte at a time...done
Reading intelligently...done
start 'em...done...done...done...done...done...
Create files in sequential order...done.
Stat files in sequential order...done.
Delete files in sequential order...done.
Create files in random order...done.
Stat files in random order...done.
Delete files in random order...done.
Version  1.97       ------Sequential Output------ --Sequential Input- -=
-Random-
Concurrency   1     -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- -=
-Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  =
/sec %CP
mbl            496M    98  99 26011  21 17589  20   538  99 80138  39 2=
08.9   8
Latency             95267us    1409ms     295ms   26947us    9644us    =
1787ms
Version  1.97       ------Sequential Create------ --------Random Create=
--------
mbl                 -Create-- --Read--- -Delete-- -Create-- --Read--- -=
Delete--
              files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  =
/sec %CP
                 16  6959  78 +++++ +++  5197  40  7250  79 +++++ +++  =
4718  37
Latency               149ms    6742us     212ms     177ms     767us    =
 217ms
1.97,1.97,mbl,1,1461269771,496M,,98,99,26011,21,17589,20,538,99,80138,3=
9,208.9,8,16,,,,,6959,78,+++++,+++,5197,40,7250,79,+++++,+++,4718,37,95=
267us,1409ms,295ms,26947us,9644us,1787ms,149ms,6742us,212ms,177ms,767us=
,217ms

Return-Path: <yur@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4AC63DDDDB
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Nov 2008 16:21:49 +1100 (EST)
Date: Fri, 14 Nov 2008 08:21:15 +0300
From: Yuri Tikhonov <yur@emcraft.com>
Message-ID: <314426140.20081114082115@emcraft.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re[2]: [PATCH] katmai.dts: extend DMA ranges; add dma/sysace nodes
In-Reply-To: <20081113064533.77eccc1b@zod.rchland.ibm.com>
References: <200811131149.14715.yur@emcraft.com>
	<20081113064533.77eccc1b@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Cc: linuxppc-dev@ozlabs.org, Detlev Zundel <dzu@denx.de>,
	Wolfgang Denk <wd@denx.de>, Ilya Yanok <yanok@emcraft.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=0D=0A Hello Josh,

On Thursday, November 13, 2008 you wrote:

[snip]

> You have no compatible property in these 3 nodes.  How are drivers
> supposed to bind to them?

> You also have no reg or dcr-reg properties.  What exactly are these
> nodes for?

 Probably we (me and Ilya) overdone with posting katmai.dts-related=20
changes to ML, and duplicated the same patches in different posts.=20
Sorry for the confusion. These nodes are necessary for the ppc440spe=20
ADMA driver:

http://www.nabble.com/-PATCH-11-11--ppc440spe-adma:-ADMA-driver-for-PPC440S=
P(e)-td20488049.html

>> +             sysacecf@4fe000000 {
>> +                     compatible =3D "xlnx,opb-sysace-1.00.b";

> Odd.  This isn't a xilinx board by any means.  This should probably
> look something like:

>         compatible =3D "amcc,sysace-440spe", "xlnx,opb-sysace-1.00.b";

> Though I'm curious about it in general.  The xilinx bindings have the
> versioning numbers on them to match particular bit-streams in the FPGAs
> if I remember correctly.  Does that really apply here?

 No, we just selected the description which looked more appropriate=20
for our case: SysAce is connected to the External Bus Controller of=20
440SPe, which in turns is attached as a slave to OPB (on-chip=20
peripheral).

 Regards, Yuri

 --
 Yuri Tikhonov, Senior Software Engineer
 Emcraft Systems, www.emcraft.com

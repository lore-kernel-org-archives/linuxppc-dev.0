Return-Path: <tmorrison@empirix.com>
Received: from empbedex1.empirix.com (empbedex1.empirix.com [12.38.203.54])
	by ozlabs.org (Postfix) with ESMTP id 997CFDE2B1
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Aug 2008 07:48:30 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Does Dev Tree WORK with soc@y_xxxx_0000 <#address/size> = <2/1>
Date: Mon, 11 Aug 2008 17:37:09 -0400
Message-ID: <BD261180E6D35F4D9D32F3E44FD3D9010DF4EB31@EMPBEDEX.empirix.com>
In-Reply-To: <mailman.1745.1218472641.19168.linuxppc-dev@ozlabs.org>
References: <mailman.1745.1218472641.19168.linuxppc-dev@ozlabs.org>
From: "Morrison, Tom" <tmorrison@empirix.com>
To: <linuxppc-dev@ozlabs.org>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I am sorry, but I've butted my head against a tree for over a=20
week and some things just aren't making sense...especially how
the prom parse code is working to exact / resolve physical=20
addresses to then ioremap...

a) Setup, I have a working MPC8548E board using 2.6.23.8 (ARCH=3Dppc)
   with PHYS/PTE_64BIT enabled (with the proper patches)).

b) Goal: we want to move our board to a generic 2.6.23 version that=20
   Freescale has produced to support the MPC8572DS (and eventually=20
   use that kernel to build our BSP for our next board).

c) I have successfully gotten to work a pure '32-bit' dev tree=20
   (PHYS/PTE_64BIT not defined - and the CCSRBAR @ 0xE000_0000)
    The #address/#size <1/1> is '1' (as well as the #size is '1')

d) I have modified this dev tree to support the 36bit mode addressing
   (with the CCSRBAR and PCIExpress defined to in the last 4Gig (instead
    of the default first 4Gig - e.g.: 0xC_E000_0000)...

e) I then set the soc to have #address-cells to '2' (#size-cells is '1')
   (and added the additional values accordingly to the ranges...=09

f) The prom_parse code has a problem with translating these addresses

The main question is: has anyone ever tested this with soc #address/size
being <2/1> in this fashion?

I am more than happy to send my text dev tree - but I don't want to clog
up the group with this info - if there are some fundamental questions=20
to be answered before then...

Thanks in advance!

Sincerely,


Tom Morrison
Principal Software Engineer
email: tmorrison@empirix.com=20
www.empirix.com

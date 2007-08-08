Return-Path: <akostop@inaccessnetworks.com>
Received: from inaccessnetworks.com (node3.inaccessnetworks.com
	[212.205.200.118]) by ozlabs.org (Postfix) with ESMTP id 8B585DDE99
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Aug 2007 00:21:16 +1000 (EST)
Date: Wed, 08 Aug 2007 17:21:05 +0300
To: "Scott Wood" <scottwood@freescale.com>
Subject: Re: pci in arch/powerpc vs arch/ppc
From: "Alexandros Kostopoulos" <akostop@inaccessnetworks.com>
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-7
MIME-Version: 1.0
References: <op.twhnwi18nhx3hy@phoenix>
	<20070803201036.GA18229@ld0162-tx32.am.freescale.net>
	<F081E320-CFF9-497C-87D5-50E2E5C15A24@kernel.crashing.org>
	<op.twol4cixnhx3hy@phoenix> <46B88DAC.70005@freescale.com>
	<op.twqn4vtsnhx3hy@phoenix>
Message-ID: <op.twqvg3i0nhx3hy@phoenix>
In-Reply-To: <op.twqn4vtsnhx3hy@phoenix>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,

I've noticed the following: In function pci_process_bridge_OF_ranges, wh=
en  =

parsing the ranges for MEM and I/O space, the res->start for mem is  =

correctly set to ranges[na+2], which is the cpu address in the ranges  =

property. However, in I/O related code, res->start is set to ranges[2], =
 =

which is in the PCI address field of the ranges property (and in my case=
  =

is 0, as is also for the mpc8272ads case as well). Thus, the res->start =
of  =

the I/O of the bridge is 0, which leads to the first device with I/O spa=
ce  =

(a davicom ethernet device) been also assigned a I/O region starting at =
0.  =

Finally, the dmfe (davicom ethernet driver over PCI) fails with "dmfe: I=
/O  =

base is zero". So, is the implementation of pci_process_bridge_OF_ranges=
  =

correct ? shouldn't res->start =3D ranges[na+2] for I/O as well?

thank you

Alex

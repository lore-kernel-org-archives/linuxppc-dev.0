Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [194.2.40.7])
	by ozlabs.org (Postfix) with ESMTP id 43A39B70A7
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  7 Sep 2010 19:17:27 +1000 (EST)
Message-ID: <4C86031D.5080804@c-s.fr>
Date: Tue, 07 Sep 2010 11:17:17 +0200
From: LEROY Christophe <christophe.leroy@c-s.fr>
MIME-Version: 1.0
To: Kumar Gala <kumar.gala@freescale.com>
Subject: Small issue at init with spi_mpc8xxx.c with CPM1
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

  Dear Kumar,

I have a small issue in the init of spi_mpc8xxx.c with MPC866 (CPM1)

Unlike cpm_uart that maps the parameter ram directly using 
of_iomap(np,1), spi_mpc8xxx.c uses cpm_muram_alloc_fixed().

This has two impacts in the .dts file:
* The driver must be declared with pram at 1d80 instead of 3d80 whereas 
it is not a child of muram@2000 but a child of cpm@9c0
* muram@2000/data@0 must be declared with reg = <0x0 0x2000>   whereas 
is should be reg=<0x0 0x1c00> to avoid cpm_muram_alloc() to allocate 
space from parameters ram.

Maybe I misunderstood something ?

Regards
Christophe Leroy

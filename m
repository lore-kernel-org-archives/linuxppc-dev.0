Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id DB4C1DDDFF
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Jul 2007 07:00:28 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [2.6 patch] arch/powerpc/Kconfig: fix the EMBEDDED6xx dependencies
Date: Sun, 29 Jul 2007 21:31:37 +0200
References: <20061201115410.GV11084@stusta.de>
	<17779.37050.4039.942954@cargo.ozlabs.ibm.com>
	<20070728152704.GA30976@stusta.de>
In-Reply-To: <20070728152704.GA30976@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200707292131.38348.arnd@arndb.de>
Cc: Andrew Morton <akpm@osdl.org>, Paul Mackerras <paulus@samba.org>,
	linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Saturday 28 July 2007, Adrian Bunk wrote:
> On Mon, Dec 04, 2006 at 02:06:34PM +1100, Paul Mackerras wrote:
> > Adrian Bunk writes:
> > 
> > > This patch changes the EMBEDDED6xx dependencies to the equivalent 
> > > dependency that seems to have been intended.
> > 
> > Nack - CONFIG_EMBEDDED6xx is going away entirely, soon.
> 
> Still there - and still with this strange dependency.

The last time I sent my patch to clean up CONFIG_EMBEDDED6xx and a few
other Kconfig options I still left it intact, but it becomes unnecessary
after that.

I still think that having high-level options like

* embedded6xx
  * MPC7448HPC2
  * holly
  * linkstation
* PPC_83xx
  * MPC8313_RDB
  * MPC832x_MDS
  * MPC832x_RDB

helps keep the platform selection more structured and readable, but the
dependency on !SMP should probably go into the individual platforms that
are actually broken, if any, not into the high-level option.

	Arnd <><

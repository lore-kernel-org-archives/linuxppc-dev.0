Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id BB92DDDFD2
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Feb 2008 03:32:10 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Kernel oops while duming user core.
Date: Thu, 31 Jan 2008 10:26:47 -0600
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B03EE46B8@ismail.innsys.innovsys.com>
In-Reply-To: <20080131161527.GT14201@localdomain>
References: <DCEAAC0833DD314AB0B58112AD99B93B03EE44A5@ismail.innsys.innovsys.com>
	<20080131161527.GT14201@localdomain>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Nathan Lynch" <ntl@pobox.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Nathan Lynch wrote:
> Hmm, this is the second report of 2.6.24 crashing in
> __flush_dcache_icache during a core dump; see:
> http://ozlabs.org/pipermail/linuxppc-dev/2007-December/048662.html
>=20
> Is this easily recreatable?

Yes. I have a binary that will do this every time it is started (on this
particular system),=20
only takes about 10 seconds before it dumps.

I was going to test HEAD of powerpc.git to see if it is still there.
I cannot test any earlier versions as our board port was done on 2.6.24.

Our older kernel port is 2.6.18 on arch/ppc, and it works just fine.


One potential clue:
> Unable to handle kernel paging request for data at address 0x48024000

this adddress is beyond our physical memory. We have 1GB of mem=20
(CONFIG_HIGH_MEM enabled) so 0x3fff_ffff is the last valid address.
0x4000_0000 to 0x7fff_ffff are unused, 0x8000_0000 to 0x9fff_ffff is
used by PCI.

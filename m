Return-Path: <clasu@luukku.com>
Received: from pato.luukku.com (pato.luukku.com [194.215.205.55])
	by ozlabs.org (Postfix) with ESMTP id 97D9F67A6C
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 24 Apr 2005 01:28:00 +1000 (EST)
Received: from localhost (mta2-o.i.luukku.com [10.0.1.122])
	by mta2-o.i.luukku.com (Postfix) with ESMTP id 0548110806A
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 23 Apr 2005 18:07:20 +0300 (EEST)
Received: from lippu (www5.i.luukku.com [10.0.1.35])
	by mta2-g.i.luukku.com (Postfix) with ESMTP id EA3FB8800E
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 23 Apr 2005 18:07:19 +0300 (EEST)
Message-ID: <1114268839955.clasu.41340._Jq1rpPPGxteNPNX4EzpwA@luukku.com>
Date: Sat, 23 Apr 2005 18:07:19 +0300 (EEST)
From: clasu@luukku.com
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: ioremap problem with kernel 2.6.11 on mpc8270
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi there,

I'm porting kernel version 2.6.11 to a custom board with an MPC8270 control=
ler.
The kernel is booting and when it runs the init routine of a custom nand dr=
iver it
generates a machine check exception.

The call to ioremap(0x40000000, 0x2000000) returns an address of
0xe1000000 and the exception is caused by an iowrite8() call to the address
returned by ioremap(). The same happens if the memory address is read.

In further investigations I have found out that the writes and reads are no=
t
mapped to the physical address 0x40000000. ioremap() returned 0xe1000000
and that is also the physical address where the writes and reads are mapped=
 to.
(=3Dno mapping).

The same driver (minor changes to struct names) works on the same board in
a linux kernel 2.6.7-rc1. In this kernel ioremap returns the same address
(0xe1000000) as in version 2.6.11 but all accesses are mapped to 0x40000000
as they should be.

I use the same board and same u-boot (1.1.2) to start both kernels.

It seems to me that the ioremap call fails somehow in 2.6.11 and that the p=
age
tables are not updated correctly.

I have not been able to find out what causes this but it would make may day=
 if
someone could help me a bit.

Best regards,

-Claus-

...................................................................
Luukku Plus paketilla p=E4=E4set eroon tila- ja turvallisuusongelmista.
Hanki Luukku Plus ja helpotat el=E4m=E4=E4si. http://www.mtv3.fi/luukku

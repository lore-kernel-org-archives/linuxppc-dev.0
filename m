Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3FA4F3B2.6050106@iti.fi>
Date: Sun, 02 Nov 2003 14:08:18 +0200
From: Kate Alhola <kate@iti.fi>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: linuxppc_2_4_mpc5200 / 5200lite zImage
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I just got Motorola5200 lite board and tried complie
linuxppc_2_4_mpc5200 from
denx to it.  When i say make bzImage it complains that __res is undefined

ppc_82xx-ld -T ../ld.script -Ttext 0x00800000 -Bstatic -o zvmlinux head.o
../common/relocate.o  ../common/misc-simple.o ../common/bootinfo.o
../common/misc-common.o ../common/string.o ../common/util.o
../common/serial_stub.o mgt5100_tty.o  image.o ../lib/zlib.a
mgt5100_tty.o: In function `serial_init':
mgt5100_tty.o(.text+0x2): undefined reference to `__res'
mgt5100_tty.o(.text+0xa): undefined reference to `__res'

__res is pointer to external scc buffer descriptors . Least it looks a
like that it is
defined in arch/ppc/platforms/icecube.c but this code looks a like complete
board initialization code so i am not sure is it right module to add
defining __res

In this setup board is running original motorola debugger, no u-boot and
this
reason i try make zimage where is uncompressinng headers included.

So, any suggestions or experiencies with 5200lite ?

Also i got Macraigor wiggler but  saddly noticed that ocd-cmdr does not
yet work with mpc5200. Any expreincies/suggestions with LOW COST
OCD debugger for 5200 that can be used loading initial code to empty
flash on my own board.

Kate

--
+==================================================================+
! Kate Marika Alhola  Internet Technologies International Oy       !
! kate@iti.fi         Phone +358 400 740701 Fax   +358 9 8138715   !
! kate@iki.fi	      http://www.iti.fi    http://www.iki.fi/kate  !
+==================================================================+


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

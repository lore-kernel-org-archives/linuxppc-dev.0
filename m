Return-Path: <colin@colino.net>
Received: from paperstreet.colino.net (colino.net [213.41.131.56])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5466A2BC0F
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Oct 2004 01:32:08 +1000 (EST)
Received: from pirandello (asap.atchik.net [195.167.234.210])
	by paperstreet.colino.net (Postfix) with ESMTP id 9E12073E9
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Oct 2004 17:30:55 +0200 (CEST)
Date: Fri, 22 Oct 2004 17:30:46 +0200
From: Colin Leroy <colin@colino.net>
To: Linux PPC Dev <linuxppc-dev@ozlabs.org>
Message-ID: <20041022173046.003bf2ea.colin@colino.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: hda errors on iBook G4
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I noticed hda status errors in my iBook G4's dmesg quite a long time
ago, but never looked any more... Today I just ran tests with hdparm and
this looks like really reproduceable:

Results are different whether I try it only or more, see below.

Any hint about where I should look at, and what kind of bug may cause
this error?

# hdparm -X69 /dev/hda
 
/dev/hda:
 setting xfermode to 69 (UltraDMA mode5)
# dmesg -c
hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }
 
ide: failed opcode was: unknown
hda: drive not ready for command

# hdparm -X68 /dev/hda
 
/dev/hda:
 setting xfermode to 68 (UltraDMA mode4)
# dmesg -c
hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }
 
ide: failed opcode was: unknown
hda: drive not ready for command
hda: status timeout: status=0xd0 { Busy }
 
ide: failed opcode was: unknown
hda: DMA disabled
hda: drive not ready for command
ide0: reset: success
# hdparm -X68 /dev/hda
 
/dev/hda:
 setting xfermode to 68 (UltraDMA mode4)
[hangs for about 30 seconds]
# dmesg -c
hda: lost interrupt
hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }
 
ide: failed opcode was: unknown
hda: drive not ready for command
hda: lost interrupt
hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }
 
ide: failed opcode was: unknown
hda: drive not ready for command
hda: lost interrupt
hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }
 
ide: failed opcode was: unknown
hda: drive not ready for command
hda: lost interrupt
hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }
 
ide: failed opcode was: unknown
hda: drive not ready for command
ide0: reset: success

-- 
Colin

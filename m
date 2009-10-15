Return-Path: <nvbolhuis@aimvalley.nl>
Received: from smtp-vbr7.xs4all.nl (smtp-vbr7.xs4all.nl [194.109.24.27])
	by ozlabs.org (Postfix) with ESMTP id C6640B7B68
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Oct 2009 21:01:30 +1100 (EST)
Message-ID: <4AD6F172.6030407@aimvalley.nl>
Date: Thu, 15 Oct 2009 11:54:58 +0200
From: Norbert van Bolhuis <nvbolhuis@aimvalley.nl>
MIME-Version: 1.0
To: Felix Radensky <felix@embedded-sol.com>
Subject: Re: UBIFS problem on MPC8536DS
References: <4AD5ADC9.30503@embedded-sol.com>
In-Reply-To: <4AD5ADC9.30503@embedded-sol.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Felix,

do you have CONFIG_NO_HZ defined ?

I've seen similar problems with powerpc + CONFIG_NO_HZ. In my case the low-level
do_write_buffer (cfi_cmdset_0002.c) timed out too early. See
http://lkml.org/lkml/2009/9/3/84

Maybe in your case it's the do_erase_chip timing out too early.

---
NvBolhuis.





Felix Radensky wrote:
> Hi,
> 
> I have a strange problem in linux-2.6.31 running on MPC8536DS board.
> It is 100% reproducible, by opening a 350MB tar file into ubifs volume
> on NAND flash, and starting erase of NOR flash partition right after that.
> 
> If I don't start  NOR erase, everything works fine. Also, If I run sync 
> after
> tar, no problem occurs.  The NOR flash is 32MB  Spansion, NAND is
> 4GB Samsung.
> 
> The error messages are as follows:
> 
> UBI error: ubi_io_write: error -5 while writing 2048 bytes to PEB 
> 5812:12288, written 0 bytes
> UBI warning: ubi_eba_write_leb: failed to write data to PEB 5812
> UBI: recover PEB 5812, move data to PEB 19400
> UBI error: ubi_io_read: error -74 while reading 512 bytes from PEB 
> 5812:512, read 512 bytes
> UBI error: ubi_io_write: error -5 while writing 512 bytes to PEB 
> 19400:512, written 0 bytes
> UBI warning: recover_peb: failed to write to PEB 19400
> UBI: try again
> UBI: recover PEB 5812, move data to PEB 19401
> UBI: run torture test for PEB 19400
> UBI error: ubi_io_write: error -5 while writing 512 bytes to PEB 
> 19401:512, written 0 bytes
> UBI warning: recover_peb: failed to write to PEB 19401
> UBI: try again
> UBI: recover PEB 5812, move data to PEB 19402
> UBI error: ubi_io_write: error -5 while writing 512 bytes to PEB 
> 19402:512, written 0 bytes
> UBI warning: recover_peb: failed to write to PEB 19402
> UBI: try again
> UBI: recover PEB 5812, move data to PEB 19403
> UBI error: ubi_io_write: error -5 while writing 512 bytes to PEB 
> 19403:512, written 0 bytes
> UBI warning: recover_peb: failed to write to PEB 19403
> UBI warning: ubi_ro_mode: switch to read-only mode
> UBIFS error (pid 1149): ubifs_wbuf_write_nolock: cannot write 2522 bytes 
> to LEB 389:10240, error -5
> UBIFS warning (pid 1149): ubifs_ro_mode: switched to read-only mode, 
> error -5
> UBIFS error (pid 1149): do_writepage: cannot write page 0 of inode 
> 30708, error -5
> UBIFS error (pid 1149): make_reservation: cannot reserve 858 bytes in 
> jhead 2, error -30
> UBIFS error (pid 1149): do_writepage: cannot write page 2 of inode 
> 29486, error -30
> UBIFS error (pid 1149): make_reservation: cannot reserve 721 bytes in 
> jhead 2, error -30
> UBIFS error (pid 1149): do_writepage: cannot write page 1 of inode 
> 30070, error -30
> UBI error: ubi_io_write: error -5 while writing 2048 bytes to PEB 
> 5022:88064, written 0 bytes
> UBI warning: ubi_eba_write_leb: failed to write data to PEB 5022
> UBI: recover PEB 5022, move data to PEB 19404
> UBI error: ubi_io_read: error -74 while reading 512 bytes from PEB 
> 5022:512, read 512 bytes
> UBI error: ubi_io_write: read-only mode
> UBI warning: recover_peb: failed to write to PEB 19404
> UBI: try again
> UBI: recover PEB 5022, move data to PEB 19405
> UBI error: ubi_io_write: read-only mode
> UBI warning: recover_peb: failed to write to PEB 19405
> UBI: try again
> UBI: recover PEB 5022, move data to PEB 19406
> UBI error: ubi_io_write: read-only mode
> UBI warning: recover_peb: failed to write to PEB 19406
> UBI: try again
> UBI: recover PEB 5022, move data to PEB 19407
> UBI error: ubi_io_write: read-only mode
> UBI warning: recover_peb: failed to write to PEB 19407
> UBIFS error (pid 1044): ubifs_wbuf_sync_nolock: cannot write 2048 bytes 
> to LEB 788:86016
> UBIFS error (pid 1044): ubifs_bg_wbufs_sync: cannot sync write-buffer, 
> error -30
> UBIFS warning (pid 1044): ubifs_ro_mode: switched to read-only mode, 
> error -30
> UBI error: ubi_io_write: error -5 while writing 2048 bytes to PEB 
> 5817:26624, written 0 bytes
> UBI warning: ubi_eba_write_leb: failed to write data to PEB 5817
> UBI: recover PEB 5817, move data to PEB 19408
> UBI error: ubi_io_read: error -74 while reading 512 bytes from PEB 
> 5817:512, read 512 bytes
> UBI error: ubi_io_write: read-only mode
> UBI warning: recover_peb: failed to write to PEB 19408
> UBI: try again
> UBI: recover PEB 5817, move data to PEB 19409
> UBI error: ubi_io_write: read-only mode
> UBI warning: recover_peb: failed to write to PEB 19409
> UBI: try again
> UBI: recover PEB 5817, move data to PEB 19410
> UBI error: ubi_io_write: read-only mode
> UBI warning: recover_peb: failed to write to PEB 19410
> UBI: try again
> UBI: recover PEB 5817, move data to PEB 19411
> UBI error: ubi_io_write: read-only mode
> UBI warning: recover_peb: failed to write to PEB 19411
> UBIFS error (pid 1047): ubifs_wbuf_sync_nolock: cannot write 2048 bytes 
> to LEB 385:24576
> UBIFS error (pid 1047): ubifs_bg_wbufs_sync: cannot sync write-buffer, 
> error -30
> UBIFS error (pid 1149): make_reservation: cannot reserve 160 bytes in 
> jhead 1, error -30
> UBIFS error (pid 1149): ubifs_write_inode: can't write inode 30709, 
> error -30
> UBIFS error (pid 1149): make_reservation: cannot reserve 160 bytes in 
> jhead 1, error -30
> UBIFS error (pid 1149): ubifs_write_inode: can't write inode 30710, 
> error -30
> UBIFS error (pid 1149): make_reservation: cannot reserve 160 bytes in 
> jhead 1, error -30
> UBIFS error (pid 1149): ubifs_write_inode: can't write inode 30698, 
> error -30
> UBIFS error (pid 1149): make_reservation: cannot reserve 160 bytes in 
> jhead 1, error -30
> UBIFS error (pid 1149): ubifs_write_inode: can't write inode 30711, 
> error -30
> 
> I'd appreciate any hints on what can cause this. Is it a hardware 
> problem, mtd layer problem
> or UBI problem ?
> 
> Thanks a lot in advance.
> 
> Felix.
> 
> 
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 

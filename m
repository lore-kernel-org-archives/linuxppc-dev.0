Return-Path: <masterzorag@gmail.com>
Received: from mail-wi0-f179.google.com (mail-wi0-f179.google.com
 [209.85.212.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8987DB6F6E
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 May 2012 03:07:07 +1000 (EST)
Received: by wibhj19 with SMTP id hj19so633198wib.14
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 May 2012 10:07:03 -0700 (PDT)
Message-ID: <4FA80054.9070901@gmail.com>
Date: Mon, 07 May 2012 19:03:16 +0200
From: masterzorag <masterzorag@gmail.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: spufs: possible circular locking dependency detected
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I'm running my test program, it uses all available spus to compute via 
OpenCL
kernel 3.4-rc1 on a ps3
even on testing spu directly, it crashes


======================================================
  [ INFO: possible circular locking dependency detected ]
  3.4.0-rc1 #2 Not tainted
  -------------------------------------------------------
  test/964 is trying to acquire lock:
  (&mm->mmap_sem){++++++}, at: [<d0000000005ff430>] 
.spufs_ps_fault+0x160/0x210 [spufs]

  but task is already holding lock:
  (&ctx->state_mutex){+.+...}, at: [<d0000000005ff404>] 
.spufs_ps_fault+0x134/0x210 [spufs]

  which lock already depends on the new lock.


  the existing dependency chain (in reverse order) is:

  -> #1 (&ctx->state_mutex){+.+...}:
        [<c00000000033974c>] .mutex_lock_interruptible_nested+0x70/0x4a0
        [<d000000000600d2c>] .spufs_mem_mmap_fault+0xb0/0x160 [spufs]
        [<c0000000000c23f0>] .__do_fault+0x108/0x554
        [<c0000000000254d8>] .do_page_fault+0x3c0/0x5b0
        [<c0000000000058e8>] handle_page_fault+0x10/0x30

  -> #0 (&mm->mmap_sem){++++++}:
        [<c000000000084cc8>] .lock_acquire+0x98/0xcc
        [<c00000000033ab58>] .down_read+0x34/0x78
        [<d0000000005ff430>] .spufs_ps_fault+0x160/0x210 [spufs]
        [<c0000000000c23f0>] .__do_fault+0x108/0x554
        [<c0000000000254d8>] .do_page_fault+0x3c0/0x5b0
        [<c0000000000058e8>] handle_page_fault+0x10/0x30

  other info that might help us debug this:

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(&ctx->state_mutex);
                                lock(&mm->mmap_sem);
                                lock(&ctx->state_mutex);
   lock(&mm->mmap_sem);

  *** DEADLOCK ***

  1 lock held by test/964:
  #0:  (&ctx->state_mutex){+.+...}, at: [<d0000000005ff404>] 
.spufs_ps_fault+0x134/0x210 [spufs]

  stack backtrace:
  Call Trace:
  [c000000006f6b790] [c000000000010278] .show_stack+0x6c/0x16c (unreliable)
  [c000000006f6b840] [c000000000082974] .print_circular_bug+0x2f8/0x330
  [c000000006f6b8f0] [c0000000000844f0] .__lock_acquire+0x131c/0x1a5c
  [c000000006f6ba40] [c000000000084cc8] .lock_acquire+0x98/0xcc
  [c000000006f6bb10] [c00000000033ab58] .down_read+0x34/0x78
  [c000000006f6bb90] [d0000000005ff430] .spufs_ps_fault+0x160/0x210 [spufs]
  [c000000006f6bc70] [c0000000000c23f0] .__do_fault+0x108/0x554
  [c000000006f6bd70] [c0000000000254d8] .do_page_fault+0x3c0/0x5b0
  [c000000006f6be30] [c0000000000058e8] handle_page_fault+0x10/0x30

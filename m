Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vZSR26hr3zDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Mar 2017 22:59:42 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Abdul Haleem <abdhalee@linux.vnet.ibm.com>, linux-xfs@vger.kernel.org
Cc: sachinp@linux.vnet.ibm.com, mpe@ellerman.id, linuxppc-dev@lists.ozlabs.org,
 aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [PowerPC] XFS : Metadata corruption detected at
 0x60000000382100b0, xfs_agf block
In-Reply-To: <1488531850.5962.22.camel@abdul-ThinkPad-T450>
References: <1488531850.5962.22.camel@abdul-ThinkPad-T450>
Date: Fri, 03 Mar 2017 22:59:39 +1100
Message-ID: <87efyer2ok.fsf@concordia>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Abdul Haleem <abdhalee@linux.vnet.ibm.com> writes:

> Hi,
>
> Reboot fails for PowerPC machine running RHEL7.3 (3.10.0-514.el7)
> following these messages:
>
> SGI XFS with ACLs, security attributes, no debug enabled
> XFS (dm-0): Mounting V5 Filesystem
> FS (dm-0): Starting recovery (logdev: internal)
> XFS (dm-0): Metadata corruption detected at 0x60000000382100b0, xfs_agf
> block 0x4b00001
> XFS (dm-0): Unmount and run xfs_repair
> XFS (dm-0): First 64 bytes of corrupted metadata buffer:
> c0000000f06b7200: 58 41 47 46 00 00 00 01 00 00 00 03 00 32 00 00
> XAGF.........2..
> c0000000f06b7210: 00 00 00 01 00 00 00 02 00 00 00 00 00 00 00
> 01  ................
> c0000000f06b7220: 00 00 00 01 00 00 00 00 00 00 00 76 00 00 00
> 02  ...........v....
> c0000000f06b7230: 00 00 00 04 00 2d 0c c7 00 2a 14 62 00 00 00
> 00  .....-...*.b....
> XFS (dm-0): metadata I/O error: block 0x4b00001
> ("xfs_trans_read_buf_map") error 117 numblks 1
> Failed to mount /sysroot.
>
> Steps to recreate:
> Run some file system test (ltp or xfs/086) on 4.10.0 upstream kernel
> built on the PowerVM LPAR after the test completes, reboot the machine
> back to base kernel, boot falls to dracut mode with above messages,
> every time it requires a xfs_repair to recover the file system.

Can you work on a better repro case?

What if you mount an XFS filesystem in the guest, run the test against
it, unmount it and then remount it. Do you see the bug then? Or does it
require a reboot to trigger?

cheers

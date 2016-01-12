Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DB4E01A06BB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 14:44:53 +1100 (AEDT)
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Mon, 11 Jan 2016 20:44:51 -0700
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id A1E713E40041
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jan 2016 20:44:47 -0700 (MST)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0C3ilk729032544
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jan 2016 20:44:47 -0700
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0C3ilAj030975
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jan 2016 20:44:47 -0700
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Russell Currey <ruscur@russell.cc>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [V3] powerpc/powernv: Add a kmsg_dumper that flushes console
 output on panic
In-Reply-To: <20160111091402.BDBAB1402DE@ozlabs.org>
References: <20160111091402.BDBAB1402DE@ozlabs.org>
Date: Tue, 12 Jan 2016 14:44:36 +1100
Message-ID: <87wprfea1n.fsf@linux.vnet.ibm.com>
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

Michael Ellerman <mpe@ellerman.id.au> writes:
> On Fri, 2015-27-11 at 06:23:07 UTC, Russell Currey wrote:
>> On BMC machines, console output is controlled by the OPAL firmware and is
>> only flushed when its pollers are called.  When the kernel is in a panic
>> state, it no longer calls these pollers and thus console output does not
>> completely flush, causing some output from the panic to be lost.
>> 
>> Output is only actually lost when the kernel is configured to not power off
>> or reboot after panic (i.e. CONFIG_PANIC_TIMEOUT is set to 0) since OPAL
>> flushes the console buffer as part of its power down routines.  Before this
>> patch, however, only partial output would be printed during the timeout wait.
>> 
>> This patch adds a new kmsg_dumper which gets called at panic time to ensure
>> panic output is not lost.  It accomplishes this by calling OPAL_CONSOLE_FLUSH
>> in the OPAL API, and if that is not available, the pollers are called enough
>> times to (hopefully) completely flush the buffer.
>> 
>> The flushing mechanism will only affect output printed at and before the
>> kmsg_dump call in kernel/panic.c:panic().  As such, the "end Kernel panic"
>> message may still be truncated as follows:
>> 
>> >Call Trace:
>> >[c000000f1f603b00] [c0000000008e9458] dump_stack+0x90/0xbc (unreliable)
>> >[c000000f1f603b30] [c0000000008e7e78] panic+0xf8/0x2c4
>> >[c000000f1f603bc0] [c000000000be4860] mount_block_root+0x288/0x33c
>> >[c000000f1f603c80] [c000000000be4d14] prepare_namespace+0x1f4/0x254
>> >[c000000f1f603d00] [c000000000be43e8] kernel_init_freeable+0x318/0x350
>> >[c000000f1f603dc0] [c00000000000bd74] kernel_init+0x24/0x130
>> >[c000000f1f603e30] [c0000000000095b0] ret_from_kernel_thread+0x5c/0xac
>> >---[ end Kernel panic - not
>> 
>> This functionality is implemented as a kmsg_dumper as it seems to be the
>> most sensible way to introduce platform-specific functionality to the
>> panic function.
>> 
>> Signed-off-by: Russell Currey <ruscur@russell.cc>
>> Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
>
> Applied to powerpc next, thanks.
>
> https://git.kernel.org/powerpc/c/affddff69c55eb68969448f35f

The firmware interface changed slightly since this kernel patch[1], it
added a parameter to OPAL_CONSOLE_FLUSH which accepted the terminal
number to flush, theoretically allowing this to be plumbed into TTY
layer or something too.

So, we'll either have to update this patch or replace it with an updated
one.

[1] i'm pushing the accepted skiboot patch now.

-- 
Stewart Smith
OPAL Architect, IBM.

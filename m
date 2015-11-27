Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A961D1A013E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2015 16:13:24 +1100 (AEDT)
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Fri, 27 Nov 2015 15:13:23 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id B8F292CE8050
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2015 16:13:21 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tAR5DD8C23724200
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2015 16:13:21 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tAR5Cnb2017578
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2015 16:12:49 +1100
Message-ID: <5657E639.8050405@au1.ibm.com>
Date: Fri, 27 Nov 2015 16:12:25 +1100
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
MIME-Version: 1.0
To: Russell Currey <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V2] powerpc/powernv: Add a kmsg_dumper that flushes console
 output on panic
References: <1448421962-6174-1-git-send-email-ruscur@russell.cc>
In-Reply-To: <1448421962-6174-1-git-send-email-ruscur@russell.cc>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 25/11/15 14:26, Russell Currey wrote:
> On BMC machines, console output is controlled by the OPAL firmware and is
> only flushed when its pollers are called.  When the kernel is in a panic
> state, it no longer calls these pollers and thus console output does not
> completely flush, causing some output from the panic to be lost.
>
> This patch adds a new kmsg_dumper which gets called at panic time to ensure
> panic output is not lost.  It accomplishes this by calling OPAL_CONSOLE_FLUSH
> in the OPAL API, and if that is not available, the pollers are called enough
> times to (hopefully) completely flush the buffer.

As per our off-list discussions, the commit message should explain that 
the console is already flushed upon reboot, and thus this patch fixes a 
problem in the case where the kernel is not set to reboot on panic, or 
will only reboot after an extended delay. Additionally, you could still 
miss messages printed in panic() after the dumpers are called, i.e. the 
"end kernel panic" message.

>
> Signed-off-by: Russell Currey <ruscur@russell.cc>

The code looks reasonable.

With the changes I've mentioned above:

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

-- 
Andrew Donnellan              Software Engineer, OzLabs
andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
+61 2 6201 8874 (work)        IBM Australia Limited

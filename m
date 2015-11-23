Return-Path: <dougmill@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1EBA71A0404
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 02:01:41 +1100 (AEDT)
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <dougmill@linux.vnet.ibm.com>;
 Mon, 23 Nov 2015 08:01:38 -0700
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 1C9CE19D8026
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 07:49:43 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id tANF1aoG19660942
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 08:01:36 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tANF1ZDh031421
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 08:01:35 -0700
Received: from oc5780617838.ibm.com ([9.80.96.161])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 tANF1V3I030737
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 08:01:31 -0700
From: Douglas Miller <dougmill@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: powerpc/xmon: Add xmon command to dump process/task similar to ps(1)
Date: Mon, 23 Nov 2015 09:01:14 -0600
Message-Id: <1448290875-20896-1-git-send-email-dougmill@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

    Add 'P' command with optional task_struct address to dump all/one task's
    information: task pointer, kernel stack pointer, PID, PPID, state
    (interpreted), CPU where (last) running, and command.
    
    Introduce XMON_PROTECT macro to standardize memory-access-fault
    protection (setjmp). Initially used only by the 'P' command.

Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D8EFE1A075F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2015 11:52:19 +1000 (AEST)
Received: from /spool/local
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Thu, 16 Jul 2015 21:52:16 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 72CA438C8052
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2015 21:52:13 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6H1qDZN58261606
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2015 01:52:13 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6H1qCnm009426
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2015 21:52:13 -0400
Date: Thu, 16 Jul 2015 18:51:04 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Zumeng Chen <zumeng.chen@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
 paulus@samba.org, imunsie@au1.ibm.com, linuxppc-dev@lists.ozlabs.org,
 romeo.cane.ext@coriant.com
Subject: Re: BUG: perf error on syscalls for powerpc64.
Message-ID: <20150717015104.GA25558@us.ibm.com>
References: <CA+Y31wfLFe11nh9AVs2JgKrxpMc6qxxDyCfey52HT23S7RJ_zw@mail.gmail.com>
 <1437037461.15828.2.camel@ellerman.id.au>
 <CA+Y31wf16voXS6psDUDpNjMFTD8HTMwrdn=sDXC_B1=n7m=1FQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CA+Y31wf16voXS6psDUDpNjMFTD8HTMwrdn=sDXC_B1=n7m=1FQ@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Zumeng Chen [zumeng.chen@gmail.com] wrote:
| 3. What I have seen in 3.14.x kernel,
| ======================
| And so far, no more difference to 4.x kernel from me about this part if
| I'm right.
| 
| *) With 1028ccf5
| 
| perf list|grep -i syscall got me nothing.
| 
| 
| *) Without 1028ccf5
| root@localhost:~# perf list|grep -i syscall
|    syscalls:sys_enter_socket                          [Tracepoint event]
|    syscalls:sys_exit_socket                           [Tracepoint event]
|    syscalls:sys_enter_socketpair                      [Tracepoint event]
|    syscalls:sys_exit_socketpair                       [Tracepoint event]
|    syscalls:sys_enter_bind                            [Tracepoint event]
|    syscalls:sys_exit_bind                             [Tracepoint event]
|    syscalls:sys_enter_listen                          [Tracepoint event]
|    syscalls:sys_exit_listen                           [Tracepoint event]
|    ... ...

Are you seeing this on big-endian or little-endian system?

IIRC, I saw the opposite behavior on an LE system a few months ago.
i.e. without 1028ccf5, 'perf listf|grep syscall' failed.

Applying 1028ccf5, seemed to fix it.

Sukadev

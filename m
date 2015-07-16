Return-Path: <zumeng.chen@gmail.com>
Received: from mail-wg0-x22c.google.com (mail-wg0-x22c.google.com
 [IPv6:2a00:1450:400c:c00::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6B5D91A0163
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2015 15:57:21 +1000 (AEST)
Received: by wgmn9 with SMTP id n9so49463580wgm.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2015 22:57:17 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 16 Jul 2015 13:57:17 +0800
Message-ID: <CA+Y31wfLFe11nh9AVs2JgKrxpMc6qxxDyCfey52HT23S7RJ_zw@mail.gmail.com>
Subject: BUG: perf error on syscalls for powerpc64.
From: Zumeng Chen <zumeng.chen@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, romeo.cane.ext@coriant.com,
 imunsie@au1.ibm.com, mpe@ellerman.id.au, paulus@samba.org,
 benh@kernel.crashing.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi All,

1028ccf5 did a change for sys_call_table from a pointer to an array of
unsigned long, I think it's not proper, here is my reason:

sys_call_table defined as a label in assembler should be pointer array
rather than an array as described in 1028ccf5. If we defined it as an
array, then arch_syscall_addr will return the address of sys_call_table[],
actually the content of sys_call_table[] is demanded by arch_syscall_addr.
so 'perf list' will ignore all syscalls since find_syscall_meta will
return null
in init_ftrace_syscalls because of the wrong arch_syscall_addr.

Did I miss something, or Gcc compiler has done something newer ?

Cheers,
Zumeng

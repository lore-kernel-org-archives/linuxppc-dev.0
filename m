Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id D2EFA1A0C1A
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Feb 2015 03:35:14 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 730A31C8075
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Feb 2015 17:35:12 +0100 (CET)
Received: from mailhub1.si.c-s.fr ([192.168.12.234])
 by localhost (mailhub1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cwBgLECF4kPC for <linuxppc-dev@lists.ozlabs.org>;
 Tue,  3 Feb 2015 17:35:12 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 59D1B1C8069
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Feb 2015 17:35:12 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 4062CC73C5
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Feb 2015 17:35:12 +0100 (CET)
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id LEmEd_9qnaKU for <linuxppc-dev@lists.ozlabs.org>;
 Tue,  3 Feb 2015 17:35:12 +0100 (CET)
Received: from [127.0.0.1] (unknown [172.25.231.75])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 1C985C73C4
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Feb 2015 17:35:12 +0100 (CET)
Message-ID: <54D0F8BF.5020008@c-s.fr>
Date: Tue, 03 Feb 2015 17:35:11 +0100
From: leroy christophe <christophe.leroy@c-s.fr>
MIME-Version: 1.0
To: LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>
Subject: cacheable_memcpy() versus memcpy() ==> 8% improvment on FTP throughput
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In powerpc32 architecture we have a function called cacheable_memcpy() 
which does same thing as memcpy() but using dcbz/dcbt instructions for 
an optimised copy (just like __copy_tofrom_user())
What seems strange is that it is almost nowhere used (only used in 
drivers/net/ethernet/ibm/emac/core.c)

I replaced all memcpy() in include/linux/skbuff.h and net/core/skbuff.c 
by cacheable_memcpy() and I get around 8% improvement on FTP throughput 
on MPC885.

What could be done to generalise the use of cacheable_memcpy() instead 
of memcpy() whenever possible ?
Indeed, in order to use cacheable_memcpy(), we need
* The destination to be cacheable
* The source and destination to not overlap on the same cachelines

Could we check, when calling memcpy(), whether the destination is 
cacheable or not, and if yes redirect the call to cacheable_memcpy() ?
How can we check that ?

Christophe

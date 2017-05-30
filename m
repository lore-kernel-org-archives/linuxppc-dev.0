Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wcY5P0T2qzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 22:36:56 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 3wcY562tYhz9ttCN
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 14:36:42 +0200 (CEST)
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id kInp-8vlfOYu for <linuxppc-dev@lists.ozlabs.org>;
 Tue, 30 May 2017 14:36:42 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 3wcY562C4cz9ttCJ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 14:36:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 116F98B876
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 14:36:53 +0200 (CEST)
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id fJKoLKJOphpX for <linuxppc-dev@lists.ozlabs.org>;
 Tue, 30 May 2017 14:36:53 +0200 (CEST)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.23])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id CC33E8B874
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 14:36:52 +0200 (CEST)
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Subject: usercopy in PPC64
Message-ID: <d25be832-2030-4bc8-dbc5-4baebb759279@c-s.fr>
Date: Tue, 30 May 2017 14:36:39 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all powerpc64 experts,

While looking at the usercopy efficiency for PPC32, I noticed something 
which looks strange.

In asm/uaccess.h, raw_copy_from_user() and raw_copy_to_user() implements 
a fast path using get_user() and put_user() for copies of constant size < 8.

But INLINE_COPY_FROM_USER and INLINE_COPY_TO_USER are only defined for 
PPC32, so PPC64 will call __copy_tofrom_user() even for small constant 
size copies. Is that wanted ?

Regards
Christophe

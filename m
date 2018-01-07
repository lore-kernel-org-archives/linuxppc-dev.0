Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zF3cF3twVzF0RH
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Jan 2018 03:23:24 +1100 (AEDT)
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 Scott Wood <scottwood@freescale.com>,
 Joakim Tjernlund <joakim.tjernlund@transmode.se>,
 Segher Boessenkool <segher@kernel.crashing.org>
From: christophe leroy <christophe.leroy@c-s.fr>
Subject: Time to get rid of CPU6 ERRATA on powerpc/8xx ?
Message-ID: <26b73379-141c-a705-a552-6ee2b94f4961@c-s.fr>
Date: Sun, 7 Jan 2018 17:23:13 +0100
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

Today, Linux kernel includes a workaround for CPU6 ERRATA on the 8xx 
powerpc.

This ERRATA exists on the 801, the 823, the 855/860 before revision C.0
It doesn't concern any modern versions of the 8xx, neither the 860 past 
and including rev C.0, nor the 866 nor the 885

This workaround complicates the TLBmiss and TLBerror handlers and make 
the code more and more unreadable.

Since this workaround addresses very old versions of the 8xx, I'd like 
to get rid of it. Do you see any good reason to keep it today ? If not I 
will come with a cleanup patch in the coming weeks.

Another alternative would be to keep that workaround separated from the 
rest of the code (ie using different registers to avoid/limit code 
nesting), it would add a few cycles but would increase readability while 
keeping the ERRATA in, allthought my preference goes to a complete 
removal of the workaround.

So, thanks to let me know your opinion on that.

Christophe

---
L'absence de virus dans ce courrier =C3=A9lectronique a =C3=A9t=C3=A9 v=C3=
=A9rifi=C3=A9e par le logiciel antivirus Avast.
https://www.avast.com/antivirus

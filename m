Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tyMBd3zYCzDqLw
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2017 17:12:41 +1100 (AEDT)
Subject: Re: bootx_init.c:88: undefined reference to `__stack_chk_fail_local'
To: benh@au1.ibm.com, Christian Kujau <lists@nerdbynature.de>
References: <alpine.DEB.2.20.99.1701030715390.31470@trent.utfs.org>
 <81ef821b-8af2-0ee5-ab35-58639548dab7@c-s.fr>
 <alpine.DEB.2.20.99.1701040957380.31470@trent.utfs.org>
 <alpine.DEB.2.20.999.1701091739320.5450@trent.utfs.org>
 <1484022722.21117.8.camel@au1.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <f407f60c-2ba5-a324-da92-136524603921@c-s.fr>
Date: Tue, 10 Jan 2017 07:12:33 +0100
MIME-Version: 1.0
In-Reply-To: <1484022722.21117.8.camel@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 10/01/2017 à 05:32, Benjamin Herrenschmidt a écrit :
> On Mon, 2017-01-09 at 18:11 -0800, Christian Kujau wrote:
>> So, with -fno-stack-protector my GCC 4.9.2 compiles with
>> CC_STACKPROTECTOR_STRONG=y but panics during boot:
>
> How can it make any sense to have -fno-stack-protector and
> CC_STACKPROTECTOR_STRONG=y at the same time ?
>

As far as I understand, Christian means no stack protector on file 
bootx_init.o, see below

Christophe

diff --git a/arch/powerpc/platforms/powermac/Makefile 
b/arch/powerpc/platforms/powermac/Makefile
index 1eb7b45..c7dcab9 100644
--- a/arch/powerpc/platforms/powermac/Makefile
+++ b/arch/powerpc/platforms/powermac/Makefile
@@ -1,4 +1,4 @@
-CFLAGS_bootx_init.o  		+= -fPIC
+CFLAGS_bootx_init.o  		+= -fPIC -fno-stack-protector

  ifdef CONFIG_FUNCTION_TRACER
  # Do not trace early boot code

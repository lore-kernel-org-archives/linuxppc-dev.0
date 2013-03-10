Return-Path: <phileas-fogg@mail.ru>
Received: from smtp20.mail.ru (smtp20.mail.ru [94.100.176.173])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 6FBA42C030D
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Mar 2013 21:54:54 +1100 (EST)
Message-ID: <513C6641.2010308@mail.ru>
Date: Sun, 10 Mar 2013 11:53:53 +0100
From: Phileas Fogg <phileas-fogg@mail.ru>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Linux kernel 3.x problems on PowerMac G5
References: <51320F53.9040000@mail.ru>
 <20130302141352.GG22941@blackmetal.musicnaut.iki.fi>
 <5132198C.8050300__15885.293405927$1362234296$gmane$org@mail.ru>
 <m2txotzs8y.fsf@igel.home> <1362288663.2969.15.camel@pasglop>
 <CAHj3AVni2t1-Hrn-jAKjsqo=0oFkVjkQ0KApNQk52buNTruDqQ@mail.gmail.com>
 <1362303524.2969.16.camel@pasglop> <51333F1C.4080605@mail.ru>
 <1362337429.2969.17.camel@pasglop> <5133A180.2040908@mail.ru>
 <1362338657.2969.20.camel@pasglop> <5138F3AB.5040401@mail.ru>
 <1362687724.6977.1.camel@pasglop> <513BD33B.7020305@mail.ru>
 <1362876308.6977.42.camel@pasglop>
In-Reply-To: <1362876308.6977.42.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Andreas Schwab <schwab@linux-m68k.org>, Denis Kirjanov <kirjanov@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Aaro Koskinen <aaro.koskinen@iki.fi>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Good news :) I found the bug.
MMU features were not set properly for PPC970MP DD1.0 which,
unfortunately, my machine has.
Damn, one line fix but one week searching.
Linux 3.8.2 boots without problems now :)


Here is my patch:

--- arch/powerpc/kernel/cputable.c.old	2013-03-10 11:48:56.559480758 +0100
+++ arch/powerpc/kernel/cputable.c	2013-03-10 11:41:07.522786804 +0100
@@ -275,7 +275,7 @@
  		.cpu_features		= CPU_FTRS_PPC970,
  		.cpu_user_features	= COMMON_USER_POWER4 |
  			PPC_FEATURE_HAS_ALTIVEC_COMP,
-		.mmu_features		= MMU_FTR_HPTE_TABLE,
+		.mmu_features		= MMU_FTRS_PPC970,
  		.icache_bsize		= 128,
  		.dcache_bsize		= 128,
  		.num_pmcs		= 8,



Regards

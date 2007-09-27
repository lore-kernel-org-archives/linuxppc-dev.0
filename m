Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2FC13DDE17
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Sep 2007 08:37:16 +1000 (EST)
Subject: Re: [PATCH 1/7] PowerPC64: Not to insert EA=0 entry at
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
In-Reply-To: <1190931617.6158.29.camel@pasglop>
References: <20070927.202207.-1300525707.kouish@swc.toshiba.co.jp>
	<1190931617.6158.29.camel@pasglop>
Content-Type: text/plain
Date: Fri, 28 Sep 2007 08:37:09 +1000
Message-Id: <1190932629.6158.37.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, arnd@arndb.de
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> It should have been set in setup_64.c, in setup_paca() (which is called
> twice) in that statement:
> 
> 	local_paca = &paca[cpu];
> 
> As local_paca is defined as being a variable held in register r13. Maybe
> something bad's happening with the compiler ?

Can you check early_setup disassembly, see if r13 is assigned (it should
be in two spots) and if it's clobbered by the compiler somewhere ?

Also, you may want to try adding --ffixed-r13 to the CFLAGS in the
makefile and let us know if it makes a difference... r13 is marked
reserved by the ABI but segher seems to imply that gcc may decide to ues
it anyway (ouch !)

Ben.
 

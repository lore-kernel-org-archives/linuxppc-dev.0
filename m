Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C646367B7F
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Jul 2006 02:18:28 +1000 (EST)
Subject: Re: Kexec initial registers
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jimi Xenidis <jimix@watson.ibm.com>
In-Reply-To: <1153065556.5905.4.camel@localhost.localdomain>
References: <4CE0FC89-084F-42E8-8E3B-8D2C41AC06F2@watson.ibm.com>
	<1152911297.23037.109.camel@localhost.localdomain>
	<28C15305-BE9F-4EE7-93A2-437EAEA7B886@watson.ibm.com>
	<1153065556.5905.4.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sun, 16 Jul 2006 12:18:06 -0400
Message-Id: <1153066686.5905.15.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > I think everyone else (ot just the sane ones) just sets all GPRS to 0
> 
> Then we have a bug and we need to initialize local_paca before we call
> early_setup...

Ah ok, I see that things have changed a bit there ... well, we do have a
setup_paca(0) after the first DBG() so that should work.

Really, it's the kernel job to setup r13 before it has any use for it.
The kexec interface only specifies what is in r3..r5, everything else
can be 0xDEADBEEF as far as I'm concerned

Ben.

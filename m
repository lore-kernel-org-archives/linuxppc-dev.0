Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D39DDDDF8F
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Aug 2008 21:31:20 +1000 (EST)
Subject: Re: PS3 early lock-up
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <1217932117.24157.185.camel@pasglop>
References: <Pine.LNX.4.64.0808041640220.31424@vixen.sonytel.be>
	<1217886287.24157.87.camel@pasglop> <1217886777.24157.91.camel@pasglop>
	<48979F6F.1050507@am.sony.com> <1217900430.24157.142.camel@pasglop>
	<Pine.LNX.4.64.0808051142160.18419@vixen.sonytel.be>
	<1217932117.24157.185.camel@pasglop>
Content-Type: text/plain
Date: Tue, 05 Aug 2008 21:31:09 +1000
Message-Id: <1217935869.24157.187.camel@pasglop>
Mime-Version: 1.0
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> You could do that by adding:
> 
> 	if (!(pteflags & (_PAGE_USER | _PAGE_RW)))
> 		rflags |= (1 << 1) | (1 << 63);
> 
> Dbl check that the resulting mapping isn't accessible to user space though.

Make these 1UL << x, and a proper patch would have to also test
that the CPU supports the 3rd PP bit. We probably need to add
a CPU feature bit for that.

Ben.

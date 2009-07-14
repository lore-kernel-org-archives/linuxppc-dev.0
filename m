Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id F028EB7086
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 14 Jul 2009 17:07:20 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 526D0DDDB6
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Jul 2009 17:07:19 +1000 (EST)
Subject: Re: [patch 1/3] powerpc: Move 64bit VDSO to improve context switch
	performance
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Anton Blanchard <anton@samba.org>
In-Reply-To: <20090714065425.301516312@samba.org>
References: <20090714065350.659537380@samba.org>
	<20090714065425.301516312@samba.org>
Content-Type: text/plain
Date: Tue, 14 Jul 2009 17:07:13 +1000
Message-Id: <1247555233.29462.86.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2009-07-14 at 16:53 +1000, Anton Blanchard wrote:
> plain text document attachment (move_vdso_v2)
> On 64bit applications the VDSO is the only thing in segment 0. Since the VDSO
> is position independent we can remove the hint and let get_unmapped_area pick
> an area. This will mean the vdso will be near other mmaps and will share
> an SLB entry:

Don't we lose randomization ? Or do we randomize the whole mem map
nowadays ?

Cheers,
Ben.

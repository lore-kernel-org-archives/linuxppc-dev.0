Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2B82BB7B94
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Oct 2009 17:44:55 +1100 (EST)
Subject: Re: [PATCH 0/6] PowerPc 8xx TLB/MMU fixes
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
In-Reply-To: <OFDFE80DD9.19502D87-ONC1257647.0022C31E-C1257647.00235079@transmode.se>
References: <1254744999-3158-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<20091005220420.GA27923@compile2.chatsunix.int.mrv.com>
	<OF9AD6CA21.DCD59A1B-ONC1257646.007AE622-C1257646.007BB767@transmode.se>
	<20091005224218.GA5273@compile2.chatsunix.int.mrv.com>
	<OFDFE80DD9.19502D87-ONC1257647.0022C31E-C1257647.00235079@transmode.se>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 06 Oct 2009 17:44:46 +1100
Message-Id: <1254811486.6035.2.camel@pasglop>
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Rex Feany <RFeany@mrv.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> > I assumed it was NIP because ... I'm not sure why. TRAP() above
> > dereferences regs, and that didn't fail, but I didn't see that until
> > now.
> 
> Yes, it is a bit strange though that the kernel isn't allowed to read from
> NULL. Is that expected?

Yes, that's absolutely expected :-) You really want any NULL deref to
blow up asap.

0 is actually part of the address space assigned to user processes. By
default they don't have anything there neither though, but if the
current process do have something mapped there, then the kernel would
read that when doing a NULL deref.

Cheers,
Ben.

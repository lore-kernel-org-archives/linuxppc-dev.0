Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6011BB7B65
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Oct 2009 07:44:28 +1100 (EST)
Subject: Re: [PATCH 3/6] 8xx: invalidate non present TLBs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
In-Reply-To: <OFB570D3CC.F2AE189F-ONC1257649.0070C808-C1257649.00714D8A@transmode.se>
References: <1254948364-30074-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<1254948364-30074-2-git-send-email-Joakim.Tjernlund@transmode.se>
	<1254948364-30074-3-git-send-email-Joakim.Tjernlund@transmode.se>
	<1254948364-30074-4-git-send-email-Joakim.Tjernlund@transmode.se>
	<1254950285.2409.10.camel@pasglop>
	<OF44C1983F.1C42E290-ONC1257649.0069CAF3-C1257649.006A78D1@transmode.se>
	<7A3C6D4C-E92B-434D-AF68-7AEEDE6DAD45@embeddedalley.com>
	<OFB570D3CC.F2AE189F-ONC1257649.0070C808-C1257649.00714D8A@transmode.se>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 09 Oct 2009 07:44:13 +1100
Message-Id: <1255034653.2146.22.camel@pasglop>
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


> One could try clearing the store bit in the page fault handler, but then
> that might cause a loop.
> Not sure it has any practical meaning though.
> 
> Anyhow, you are welcome to have a look at the patches I have been tossing out.

The store bit in do_page_fault() is -very- important (and the only DSISR
bit that is as I wrote earlier). The generic code must know if a fault
is caused by a load or a store since the later is what will cause
copy_on_write to happen for example, or dirty to be set, etc..

Ben.

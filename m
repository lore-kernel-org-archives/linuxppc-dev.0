Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 17318B7B6F
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Oct 2009 07:28:35 +1100 (EST)
Subject: Re: [PATCH 3/6] 8xx: invalidate non present TLBs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dan Malek <dan@embeddedalley.com>
In-Reply-To: <7A3C6D4C-E92B-434D-AF68-7AEEDE6DAD45@embeddedalley.com>
References: <1254948364-30074-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<1254948364-30074-2-git-send-email-Joakim.Tjernlund@transmode.se>
	<1254948364-30074-3-git-send-email-Joakim.Tjernlund@transmode.se>
	<1254948364-30074-4-git-send-email-Joakim.Tjernlund@transmode.se>
	<1254950285.2409.10.camel@pasglop>
	<OF44C1983F.1C42E290-ONC1257649.0069CAF3-C1257649.006A78D1@transmode.se>
	<7A3C6D4C-E92B-434D-AF68-7AEEDE6DAD45@embeddedalley.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 09 Oct 2009 07:28:25 +1100
Message-Id: <1255033705.2146.17.camel@pasglop>
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

Hoy Dan !

While you are around ... I have a question :-)

Do you happen to remember what the story is with the invalidation of
"unpopulated" (aka invalid) entries ?

IE. We create those in the 8xx TLB miss when the PTE is !present (or the
PMD is absent). Those then cause a TLB error on the next access which
allows us to process the page fault. But when/how are those invalid
entries supposed to be invalidated ?

The doco seems to hint that at least in the case of an entry with the
wrong C bit (store to an entry with C=0), the HW automatically
invalidates it before taking the TLB Error but that's all I found.

Is there a general HW policy on 8xx to invalidate TLB entries that cause
TLB errors ? Or is the kernel expected to do it most of the time ?

Cheers,
Ben.

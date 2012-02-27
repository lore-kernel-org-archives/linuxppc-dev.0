Return-Path: <Paul.Gortmaker@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A5685B6EEC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2012 07:49:50 +1100 (EST)
Date: Mon, 27 Feb 2012 15:49:42 -0500
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next] ibm emac: delete module references; phy.c only
 supported as built-in
Message-ID: <20120227204941.GA29529@windriver.com>
References: <1330372024-30974-1-git-send-email-paul.gortmaker@windriver.com>
 <20120227.145753.1111293673513137413.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20120227.145753.1111293673513137413.davem@davemloft.net>
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[Re: [PATCH net-next] ibm emac: delete module references; phy.c only supported as built-in] On 27/02/2012 (Mon 14:57) David Miller wrote:

> From: Paul Gortmaker <paul.gortmaker@windriver.com>
> Date: Mon, 27 Feb 2012 14:47:04 -0500
> 
> > The Makefile has it as "ibm_emac-y := mal.o core.o phy.o" so there is
> > no way this can be built modular, so remove all references to module
> > support.
> 
> That doesn't mean it's only buildable statically.
> 
> "ibm_emacs-y :=" is merely a way to tell make what objects go into ibm_emac.{o,ko}
> 
> IBM_EMAC is tristate

Argh, yes.  Sorry for the noise.  Since phy.c doesn't call any modular
functionality directly, the patch "worked" and I didn't catch the
error in my reasoning.

Paul.

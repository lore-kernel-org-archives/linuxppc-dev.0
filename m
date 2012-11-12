Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D604B2C0081
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Nov 2012 09:19:37 +1100 (EST)
Message-ID: <1352758767.23412.10.camel@pasglop>
Subject: Re: hoo boy, interrupt Handling on BGQ
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jimi Xenidis <jimix@pobox.com>
Date: Tue, 13 Nov 2012 09:19:27 +1100
In-Reply-To: <9FB7F97D-D988-495B-93C8-746963DFF15C@pobox.com>
References: <9FB7F97D-D988-495B-93C8-746963DFF15C@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Kumar Gala <kumar.gala@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2012-11-12 at 15:33 -0600, Jimi Xenidis wrote:
> So interrupts need to go to FW before Linux, please let not talk about how silly that is.
> Lets talk about something far more silly...
> In order to get to the Linux exception handlers, we have to tell FW where the interrupt page is, and then it _copies_ it.
> 
> IFAICT, this means that each vectors on the "copied" page must:
> 1) construct an 64-bit absolute address to a per vector stub
> 2) leap at the (with bctr or blr)
> 3) restore CTR or LR and anything else that (1) messed up
> 4) normal branch to the actual vector
> 
> This is what I'll be working on, but I'd love to hear any other ideas.

Replace the firmware with something sane ?

Cheers,
Ben.

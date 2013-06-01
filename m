Return-Path: <tkil@scrye.com>
Received: from mail.scrye.com (unknown [75.148.32.185])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client CN "mail.scrye.com", Issuer "mail.scrye.com" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EB9B12C009F
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Jun 2013 14:24:35 +1000 (EST)
To: Xie Shaohui-B21989 <B21989@freescale.com>
Subject: Re: SATA hang on 8315E triggered by heavy flash write?
From: Anthony Foiani <tkil@scrye.com>
References: <1369172643.1374.15@scott-Lenovo-G560>
 <gppwj3ayu.fsf@dworkin.scrye.com>
 <ED492CCEAF882048BC2237DE806547C90B1DFA93@039-SN2MPN1-013.039d.mgd.msft.net>
 <g8v362qg8.fsf@dworkin.scrye.com>
 <ED492CCEAF882048BC2237DE806547C90B1E0FFA@039-SN2MPN1-013.039d.mgd.msft.net>
 <g4ndt3f5q.fsf@dworkin.scrye.com>
 <ED492CCEAF882048BC2237DE806547C90B1E567D@039-SN2MPN1-013.039d.mgd.msft.net>
 <g7gik2bga.fsf@dworkin.scrye.com>
 <ED492CCEAF882048BC2237DE806547C90B1E8E68@039-SN2MPN1-013.039d.mgd.msft.net>
Date: Fri, 31 May 2013 22:24:31 -0600
In-Reply-To: <ED492CCEAF882048BC2237DE806547C90B1E8E68@039-SN2MPN1-013.039d.mgd.msft.net>
 (Xie Shaohui-B's message of "Thu\, 30 May 2013 07\:32\:10 +0000")
Message-ID: <g4ndie9vk.fsf@dworkin.scrye.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Reply-To: Anthony Foiani <tkil@scrye.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Shaohui, greetings --

Xie Shaohui-B21989 <B21989@freescale.com> writes:

> I found a MPC8315ERDB rev1.0 board and did some tests.

I bet that was fun.  :) Thanks for going the extra mile and finding
that hardware.  Were you able to unearth a 8315DS of any sort?

> First there is no limit speed issue on the board, so it seems it may
> only happen on the MPC8315DS board.

To be clear, the board we're using does boot and run just fine at
3Gbps most of the time; the CONFIG_MPC8315DS fix was one suggested by
our vendor, but even then, I suspect it was basically prophylactic.

Or, perhaps, it was conflated with the NOR / SATA issue -- see below.

> Second, the SATA can work well with NOR write operation on the ERDB
> board. So the two issues happened to you should be board issues.

Very possibly!

Our vendor has identified at least one possible error with the wiring
/ routing on this board, and have suggested a hardware modification.
Their fix makes sense, but any hardware modification introduces the
risk of breaking one of the few prototype boards.

Since we're very close to software delivery, and we have a workaround
in hand -- namely, don't write the disk during flash operations -- my
team has decided that we'll go with the software workaround until
initial delivery.

We should be able to do this modification and associated testing in
mid-July; at that point, I'll report back with our findings.

Thanks again for all your help; you and Scott have been extremely
helpful and have provided excellent support.  Apologies if it turns
out that it was all due to a wiring error.  :(

Best regards,
Anthony Foiani

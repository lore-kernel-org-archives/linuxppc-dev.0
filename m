Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 19D0C1A0851
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Dec 2015 08:02:29 +1100 (AEDT)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6B0F71402B4
 for <linuxppc-dev@ozlabs.org>; Tue,  8 Dec 2015 08:02:28 +1100 (AEDT)
Message-ID: <1449522135.21036.11.camel@kernel.crashing.org>
Subject: Re: [PATCH 2/2] powerpc: tracing: don't trace hcalls on offline CPUs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Steven Rostedt <rostedt@goodmis.org>, Denis Kirjanov
 <kda@linux-powerpc.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org,
 linux-kernel@vger.kernel.org
Date: Tue, 08 Dec 2015 08:02:15 +1100
In-Reply-To: <20151207155224.2a8d71dd@gandalf.local.home>
References: <1448389419-5296-1-git-send-email-kda@linux-powerpc.org>
 <1448389419-5296-2-git-send-email-kda@linux-powerpc.org>
 <20151207155224.2a8d71dd@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-12-07 at 15:52 -0500, Steven Rostedt wrote:
> > +     TP_CONDITION(cpu_online(smp_processor_id())),
> > +

This should probably be some kind of __raw version though, hcalls can
be called in contexts where the debug stuff in smp_processor_id() isn't
safe (or preempt enabled).

Cheers,
Ben.

Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E9926B7B77
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Oct 2009 20:10:33 +1100 (EST)
Subject: Re: [FTRACE] Enabling function_graph causes OOPS
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sachin Sant <sachinp@in.ibm.com>
In-Reply-To: <4ACC57C4.5010002@in.ibm.com>
References: <4A5C5D65.3030906@in.ibm.com>
	<alpine.DEB.2.00.0907141844540.32740@gandalf.stny.rr.com>
	<4A76BE81.4080707@in.ibm.com>
	<1252458303.20985.10.camel@gandalf.stny.rr.com>
	<4AA74AE2.5090001@in.ibm.com>
	<1252814877.26049.93.camel@gandalf.stny.rr.com>
	<1252816650.8375.70.camel@pasglop>
	<1252848060.26049.647.camel@gandalf.stny.rr.com>
	<1252873548.8375.73.camel@pasglop> <1252915227.8375.118.camel@pasglop>
	<1254749155.13160.6.camel@gandalf.stny.rr.com>
	<1254774039.7122.35.camel@pasglop>
	<1254775073.13160.13.camel@gandalf.stny.rr.com>
	<4ACC57C4.5010002@in.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 07 Oct 2009 20:10:21 +1100
Message-Id: <1254906621.2409.1.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, rostedt@goodmis.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-10-07 at 14:26 +0530, Sachin Sant wrote:

> As Ben suggested, i changed LOAD_REG_IMMEDIATE() to LOAD_REG_ADDR()
> as follows.
> 
> -       LOAD_REG_IMMEDIATE(r4,ftrace_return_to_handler)
> +       LOAD_REG_ADDR(r4,ftrace_return_to_handler)
> 
> With this change compile time warnings about bad relocations
> related to ftrace are gone.

You also need to make sure r2 is properly loaded with the kernel TOC
pointer, something like ld r2,PACAKTOC(r13) before the LOAD_REG_ADDR.

Cheers,
Ben.

Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4CD7CB7BD2
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Oct 2009 07:20:50 +1100 (EST)
Subject: Re: [FTRACE] Enabling function_graph causes OOPS
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: rostedt@goodmis.org
In-Reply-To: <1254749155.13160.6.camel@gandalf.stny.rr.com>
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
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 06 Oct 2009 07:20:39 +1100
Message-Id: <1254774039.7122.35.camel@pasglop>
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

On Mon, 2009-10-05 at 09:25 -0400, Steven Rostedt wrote:
> > > Sachin, can you give me more details on how you built that kernel ? (or
> > > give them again in case I missed them the first time around :-), ie,
> > > what toolchain, options, etc... or even better, give me remote access to
> > > the build host ?
> > 
> > Ok, got access and had a quick look... seems to be a toolchain problem
> > to me. I'll investigate more tomorrow.
> 
> Hi Ben,
> 
> Any more word on this issue? 

Didn't you fix it using a TOC access ?

Unless I'm confusing things, I think the problem is the usage
of LOAD_REG_IMMEDIATE which generates relocs that we don't support
when CONFIG_RELOCATABLE is set.

I've merged a patch that post-processes the kernel now, to check
for such relocs so at least you should be warned at build time.

Cheers,
Ben.

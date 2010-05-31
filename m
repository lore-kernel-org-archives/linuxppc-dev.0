Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9EBFBB7D52
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 31 May 2010 20:24:15 +1000 (EST)
Subject: Re: [PATCH] powerpc: Don't export cvt_fd & _df when CONFIG_PPC_FPU
	is not set
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alexander Graf <agraf@suse.de>
In-Reply-To: <FAE73713-EE73-4FA6-B1C6-88D38E230F01@suse.de>
References: <1275270628.1931.540.camel@pasglop>
	<1275271231.1931.547.camel@pasglop>
	<FAE73713-EE73-4FA6-B1C6-88D38E230F01@suse.de>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 31 May 2010 20:24:06 +1000
Message-ID: <1275301446.1931.596.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2010-05-31 at 11:33 +0200, Alexander Graf wrote:
> > Alex, this is just a temporary fix to remove the build breakage for
> 40x
> > etc... but please, update KVM to just build-in its own.
> 
> What's the bad part in reusing the existing code?

I'm not saying we should dup the code, but I'm sure we can find a better
way for that sort of stuff, along with other base support bits like you
normally find in libgcc, to be linked directly with all modules.

calling out of modules symbols sucks for perf too anyways.

> > Don't we have .o's that are always built into modules nowadays ?
> 
> I don't think I understand what you mean.

Ben.

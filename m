Return-Path: <anton@ozlabs.org>
Date: Fri, 6 Aug 2010 15:56:40 +1000
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: inline ppc64_runlatch_off
Message-ID: <20100806055640.GS29316@kryten>
References: <20100806045315.GR29316@kryten> <1281071865.2168.28.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1281071865.2168.28.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi Ben,

> > I'm sick of seeing ppc64_runlatch_off in our profiles, so inline the
> > heavily used part of it into the callers. To avoid a mess of circular
> > includes I didn't add it as an inline function.
> 
> Considering that it's just an asm instruction or two, should we make it
> inline asm and have it NOPed out instead using the feature sections ?

Unfortunately we still need to prevent continual writes to it with a per thread
flag because on some CPUs a write to the SPR in low priority mode will stall
another SMT thread. So we could get rid of the cpu feature comparison but
we would still need the thread bit check (or perhaps replace it with a per cpu
variable).

Anton

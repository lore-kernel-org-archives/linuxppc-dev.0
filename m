Return-Path: <sam@ravnborg.org>
Received: from pfepa.post.tele.dk (pfepa.post.tele.dk [195.41.46.235])
	by ozlabs.org (Postfix) with ESMTP id 3AF98DDD0B
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Feb 2009 16:45:15 +1100 (EST)
Date: Wed, 25 Feb 2009 06:47:07 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Kyle McMartin <kyle@infradead.org>
Subject: Re: [PATCH/RFC] powerpc: avoid generating .eh_frame sections with
	gcc-4.4
Message-ID: <20090225054707.GA20364@uranus.ravnborg.org>
References: <20090224065112.GA6690@bombadil.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090224065112.GA6690@bombadil.infradead.org>
Cc: linuxppc-dev@ozlabs.org, aoliva@redhat.com, linux-kernel@vger.kernel.org,
	roland@redhat.com, kyle@redhat.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Feb 24, 2009 at 01:51:12AM -0500, Kyle McMartin wrote:
> From: Kyle McMartin <kyle@redhat.com>
> 
> On ppc64 (at least) gcc-4.4 is defaulting to generating .eh_frame
> sections, which are, for the kernel, fairly pointless. Additionally, on
> ppc64 this generates a relocation format which the kernel module loader
> does not currently support (R_PPC64_REL32.)
> 
> Alexandre Oliva verifies that -fno-dwarf2-cfi-asm prevents this
> .eh_frame section from being generated.
> 
> These seem to be used for unwinding, but it doesn't look like we
> currently use them anywhere. (In fact, we explicitly dump them in the
> x86_64 linker script.)
> 
> If these .eh_frame sections are eventually used, adding a per-arch
> CONFIG_WANT_UNWIND check would be trivial.
> 
> (This was reported against Fedora, which appears to be the only distro
> doing any building against gcc-4.4 at present: RH bz#486545.)
> 
> Signed-off-by: Kyle McMartin <kyle@redhat.com>
> Cc: roland@redhat.com
> Cc: aoliva@redhat.com

Kyle - can you resend wit an updated changelog reflecting the comments
from Roland and Alexandre.

I got it wrong when reading the above - so chances are others does too.

Thanks,
	Sam

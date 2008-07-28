Return-Path: <hugh@veritas.com>
Date: Mon, 28 Jul 2008 15:54:30 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: CONFIG_FRAME_POINTER [was [PATCH] x86: BUILD_IRQ say .text]
In-Reply-To: <20080728144133.GH18144@elte.hu>
Message-ID: <Pine.LNX.4.64.0807281550260.25371@blonde.site>
References: <Pine.LNX.4.64.0807211828470.26173@blonde.site>
	<20080724104459.GI28817@elte.hu>
	<Pine.LNX.4.64.0807251839190.20617@blonde.site>
	<20080728144133.GH18144@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: the arch/x86 maintainers <x86@kernel.org>, linux-kernel@vger.kernel.org,
	Mike Travis <travis@sgi.com>, Linuxppc-dev@ozlabs.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Arjan van de Ven <arjan@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 28 Jul 2008, Ingo Molnar wrote:
> * Hugh Dickins <hugh@veritas.com> wrote:
> 
> > I rather think CONFIG_FRAME_POINTER shouldn't exist at all (or be a 
> > private, config-user-invisible, specific-to-a-few-arches thing): what 
> > one wants to configure is how far to sacrifice cpu performance and 
> > kernel smallness to getting a good stacktrace.  Frame pointer is just 
> > an implementation detail on that, appropriate to some arches. Perhaps 
> > three settings: no stacktrace, fair stacktrace, best stacktrace.
> 
> actually, we consciously use and rely on frame pointers on x86. The 
> runtime cost on 64-bit is miniscule and the improved backtrace output in 
> recent kernels makes backtraces _much_ easier to interpret:

Just to clarify, no way was I criticizing the use of frame pointers
on x86.  What I don't care for is that CONFIG_FRAME_POINTER is used
by common code (e.g. top level Makefile, and various debug Kconfigs),
when I see it as an arch-specific technique for getting best stacktrace.

Hugh

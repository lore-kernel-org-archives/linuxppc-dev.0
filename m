Return-Path: <w@1wt.eu>
Date: Sat, 16 Feb 2008 18:33:16 +0100
From: Willy Tarreau <w@1wt.eu>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH 1/3] Fix Unlikely(x) == y
Message-ID: <20080216173315.GU8953@1wt.eu>
References: <47B70A61.9030306@tiscali.nl>
	<20080216092552.325e5726@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080216092552.325e5726@laptopd505.fenrus.org>
Cc: linuxppc-dev@ozlabs.org, Roel Kluin <12o3l@tiscali.nl>,
	cbe-oss-dev@ozlabs.org, lkml <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Feb 16, 2008 at 09:25:52AM -0800, Arjan van de Ven wrote:
> On Sat, 16 Feb 2008 17:08:01 +0100
> Roel Kluin <12o3l@tiscali.nl> wrote:
> 
> > The patch below was not yet tested. If it's correct as it is, please
> > comment. ---
> > Fix Unlikely(x) == y
> > 
> 
> you found a great set of bugs..
> but to be honest... I suspect it's just best to remove unlikely altogether for these cases;
> unlikely() is almost a go-faster-stripes thing, and if you don't know how to use it you shouldn't
> be using it... so just removing it for all wrong cases is actually the best thing to do imo.

Well, eventhough the author may not know how to use it, "unlikely" at
least indicates the intention of the author, or his knowledge of what
should happen here. I'd suggest leaving it where it is because the
authot of this code is in best position to know that this branch is
unlikely to happen, eventhough he does not correctly use the macro.

Willy

Return-Path: <SRS0+974f8591537a7899356a+1637+infradead.org+arjan@pentafluge.srs.infradead.org>
Date: Sat, 16 Feb 2008 10:29:57 -0800
From: Arjan van de Ven <arjan@infradead.org>
To: Willy Tarreau <w@1wt.eu>
Subject: Re: [PATCH 1/3] Fix Unlikely(x) == y
Message-ID: <20080216102957.56986e03@laptopd505.fenrus.org>
In-Reply-To: <20080216175849.GA25636@1wt.eu>
References: <47B70A61.9030306@tiscali.nl>
	<20080216092552.325e5726@laptopd505.fenrus.org>
	<20080216173315.GU8953@1wt.eu>
	<20080216094226.1e8eede1@laptopd505.fenrus.org>
	<20080216175849.GA25636@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Sat, 16 Feb 2008 18:58:49 +0100
> > If you think unlikely() means something else, we should fix what it
> > maps to towards gcc ;) (to.. be empty ;)
> 
> eventhough the gcc docs say it's just a hint to help the compiler
> optimize the branch it takes by default, I too have noticed that it
> more often does bad than good. Code gets completely reordered and
> even sometimes partially duplicated (especially when the branch is a
> return).
> 
> Last but not least, gcc 4 tends to emit stupid checks, to the point
> that I have replaced unlikely(x) with (x) in my code when gcc >= 4 is
> detected. What I observe is that the following code :
> 
>     if (unlikely(p == NULL)) ...

this is pure bad since GCC already assumes that NULL checks are unlikely,
and with the unlikely() code needing to normalize stuff... it will generate 
worse code for sure yes.

> 
> often gets coded like this :
> 
>     reg1 = (p == NULL)
>     if (reg1 != 0) ...
> 
> ... which clobbers reg1 for nothing and performs a double test.
> 
> But yes, I assumed that the author considered its use to be
> legitimate (I've not looked at the code). Maybe you're right and it
> should be removed, but in this case we would need a large audit of
> the abuses of unlikely()...

no argument.. how about we start with all the cases where the author just got it 
entirely wrong ... like the ones from this patch ;)


-- 
If you want to reach me at my work email, use arjan@linux.intel.com
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org

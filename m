Return-Path: <mgreer@mvista.com>
Date: Mon, 18 Sep 2006 17:45:03 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 1/6] bootwrapper: arch/powerpc/boot code reorg
Message-ID: <20060919004503.GA920@mag.az.mvista.com>
References: <20060719230014.GB3887@mag.az.mvista.com>
	<20060908033508.GA5203@mag.az.mvista.com>
	<17674.32333.958250.868794@cargo.ozlabs.ibm.com>
	<20060915180129.GE1884@mag.az.mvista.com>
	<17675.30508.252375.59449@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17675.30508.252375.59449@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Sep 16, 2006 at 02:01:48PM +1000, Paul Mackerras wrote:

Hi Paul,

> Mark A. Greer writes:
> 
> > Yes.  Whether you pass the NULL or not hinges on whether its flat tree
> > or not so I made it a dt_op.  What are you thinking?
> 
> There's basically only two cases: if we have a builtin flat tree, we
> pass that and NULL in r5; if we don't, and we have OF, we pass NULL in
> r3 and the OF entry point in r5.  I think that could be handled in
> main.c.

Okay.

> We also lost the "enforce minimum address only for 64-bit" thing in
> the translation, too.

You mean the "if (claim_base < PROG_START)" if stmt, right?  
Would adding an "#if defined(__powerpc64__) && defined(PROG_START)" be
sufficient?

I should change simple_alloc to _ALIGN_UP only 4K while I'm at it.

> I believe that just patch 1/6 on its own won't give us a working
> zImage, so we'll have to split up the changes differently when it
> comes time to check this stuff in to git.

You're right.  I'll fix that up.

Mark

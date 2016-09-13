Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sY9xt1ghfzDrp3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Sep 2016 14:02:58 +1000 (AEST)
Date: Tue, 13 Sep 2016 14:02:57 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michal Marek <mmarek@suse.cz>
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-next@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
 linux-arch@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, Michael
 Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, PowerPC <linuxppc-dev@lists.ozlabs.org>
Subject: Re: linux-next: manual merge of the kbuild tree with Linus' tree
Message-ID: <20160913140257.6d2de178@canb.auug.org.au>
In-Reply-To: <20160913093945.521a28b4@canb.auug.org.au>
References: <20160912113224.792b24f0@canb.auug.org.au>
 <20160912125341.0596ed9f@roar.ozlabs.ibm.com>
 <e1cd32fd-6db2-0dc7-43c4-f678582326ad@suse.cz>
 <20160913093945.521a28b4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michal,

[For the new cc's, we are discussing the "thin archives" and "link dead
code/data elimination" patches in the kbuild tree.]

On Tue, 13 Sep 2016 09:39:45 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> On Mon, 12 Sep 2016 11:03:08 +0200 Michal Marek <mmarek@suse.cz> wrote:
> >
> > On 2016-09-12 04:53, Nicholas Piggin wrote:  
> > > Question, what is the best way to merge dependent patches? Considering
> > > they will need a good amount of architecture testing, I think they will
> > > have to go via arch trees. But it also does not make sense to merge these
> > > kbuild changes upstream first, without having tested them.    
> > 
> > I think it makes sense to merge the kbuild changes via kbuild.git, even
> > if they are unused and untested. Any follow-up fixes required to enable
> > the first architecture can go through the respective architecture tree.
> > Does that sound OK?  
> 
> And if you guarantee not to rebase the kbuild tree (or at least the
> subset containing these patches), then each of the architecture trees
> can just merge your tree (or a tag?) and then implement any necessary
> arch dependent changes.  I fixes are necessary, they can also be merged
> into the architecture trees.

Except, of course, the kbuild tree still has the asm EXPORT_SYMBOL
patches that produce warnings on PowerPC :-( (And I am still reverting
the PowerPC specific one of those patches).

-- 
Cheers,
Stephen Rothwell

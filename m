Return-Path: <hughd@google.com>
Received: from smtp-out.google.com (smtp-out.google.com [74.125.121.67])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BFD04B6FBA
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 14 Jun 2011 22:19:14 +1000 (EST)
Received: from kpbe20.cbf.corp.google.com (kpbe20.cbf.corp.google.com
	[172.25.105.84]) by smtp-out.google.com with ESMTP id p5ECJ8ZI007610
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2011 05:19:09 -0700
Received: from pwj4 (pwj4.prod.google.com [10.241.219.68])
	by kpbe20.cbf.corp.google.com with ESMTP id p5ECJ6s0019443
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2011 05:19:07 -0700
Received: by pwj4 with SMTP id 4so3697393pwj.16
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 14 Jun 2011 05:19:06 -0700 (PDT)
Date: Tue, 14 Jun 2011 05:18:46 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Pekka Enberg <penberg@kernel.org>
Subject: Re: [PATCH] slub: fix kernel BUG at mm/slub.c:1950!
In-Reply-To: <1308027078.2874.1005.camel@pasglop>
Message-ID: <alpine.LSU.2.00.1106140515470.30002@sister.anvils>
References: <alpine.LSU.2.00.1106121842250.31463@sister.anvils>
	<alpine.DEB.2.00.1106131258300.3108@router.home>
	<1307990048.11288.3.camel@jaguar>
	<alpine.DEB.2.00.1106131428560.5601@router.home>
	<BANLkTi=RYq0Dd210VC+NeTXWWuFbz7cxeg@mail.gmail.com>
	<BANLkTik-KGtuoVFKvy_rk7voBRAxSsR9FRg0fhb0k3NCSg-fWQ@mail.gmail.com>
	<1308027078.2874.1005.camel@pasglop>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Christoph Lameter <cl@linux.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	linux-kernel <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 14 Jun 2011, Benjamin Herrenschmidt wrote:
> On Mon, 2011-06-13 at 14:00 -0700, Hugh Dickins wrote:
> > On Mon, Jun 13, 2011 at 1:34 PM, Pekka Enberg <penberg@kernel.org> wrote:
> > > On Mon, Jun 13, 2011 at 10:29 PM, Christoph Lameter <cl@linux.com> wrote:
> > >> On Mon, 13 Jun 2011, Pekka Enberg wrote:
> > >>
> > >>> > Hmmm.. The allocpercpu in alloc_kmem_cache_cpus should take care of the
> > >>> > alignment. Uhh.. I see that a patch that removes the #ifdef CMPXCHG_LOCAL
> > >>> > was not applied? Pekka?
> > >>>
> > >>> This patch?
> > >>>
> > >>> http://git.kernel.org/?p=linux/kernel/git/penberg/slab-2.6.git;a=commitdiff;h=d4d84fef6d0366b585b7de13527a0faeca84d9ce
> > >>>
> > >>> It's queued and will be sent to Linus soon.
> > >>
> > >> Ok it will also fix Hugh's problem then.
> > >
> > > It's in Linus' tree now. Hugh, can you please confirm it fixes your machine too?
> > 
> > I expect it to, thanks: I'll confirm tonight.
> 
> From report to resolution before I got to read the thread, that's how I
> like them ! Thanks guys :-)

Confirmed: fixed in 3.0-rc3 - thank you!

Hugh

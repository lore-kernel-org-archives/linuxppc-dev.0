Return-Path: <akpm@osdl.org>
Date: Fri, 15 Dec 2006 11:45:36 -0800
From: Andrew Morton <akpm@osdl.org>
To: Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [PATCH] Fix sparsemem on Cell
Message-Id: <20061215114536.dc5c93af.akpm@osdl.org>
In-Reply-To: <1166203440.8105.22.camel@localhost.localdomain>
References: <20061215165335.61D9F775@localhost.localdomain>
	<4582D756.7090702@shadowen.org>
	<1166203440.8105.22.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Keith Mannthey <kmannth@us.ibm.com>,
	linux-kernel@vger.kernel.org, hch@infradead.org,
	linux-mm@kvack.org, paulus@samba.org, mkravetz@us.ibm.com,
	gone@us.ibm.com, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 15 Dec 2006 09:24:00 -0800
Dave Hansen <haveblue@us.ibm.com> wrote:

> 
> ...
>
> I think the comments added say it pretty well, but I'll repeat it here.
> 
> This fix is pretty similar in concept to the one that Arnd posted
> as a temporary workaround, but I've added a few comments explaining
> what the actual assumptions are, and improved it a wee little bit.
> 
> The end goal here is to simply avoid calling the early_*() functions
> when it is _not_ early.  Those functions stop working as soon as
> free_initmem() is called.  system_state is set to SYSTEM_RUNNING
> just after free_initmem() is called, so it seems appropriate to use
> here.

Would really prefer not to do this.  system_state is evil.  Its semantics
are poorly-defined and if someone changes them a bit, or changes memory
initialisation order, you get whacked.

I think an mm-private flag with /*documented*/ semantics would be better. 
It's only a byte.

> +static int __meminit can_online_pfn_into_nid(unsigned long pfn, int nid)

I spent some time trying to work out what "can_online_pfn_into_nid" can
possibly mean and failed.  "We can bring a pfn online then turn it into a
NID"?  Don't think so.  "We can bring this page online and allocate it to
this node"?  Maybe.

Perhaps if the function's role in the world was commented it would be clearer.

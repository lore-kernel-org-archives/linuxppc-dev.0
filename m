Date: Wed, 5 Jun 2002 13:22:41 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Dan Malek <dan@embeddededge.com>,
	Paul Mackerras <paulus@samba.org>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: More details on the telnet with CONFIG_PIN_TLB problems
Message-ID: <20020605032241.GD2630@zax>
References: <3CFCF31B.50103@embeddededge.com> <20020604164344.26329@smtp.wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020604164344.26329@smtp.wanadoo.fr>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Jun 04, 2002 at 06:43:44PM +0200, Benjamin Herrenschmidt wrote:
>
> >> Looks like Ben and I have found the problem;
> >
> >Cool.  I know this works OK on 8xx, I just haven't finished a working
> >tlb miss handler that will work regardless of the page size.
>
> >From my understanding, it seems the problem on 4xx is that the
> shadow TLBs aren't keeping the PID. Thus the following scenario
> would break (entirely in kernel, no rfi, no interrupt) :
>
>    - copy_tofrom_user
>    - context switch
>    - copy_tofrom_user

That situation looks consistent with the sorts of corruption we were
seeing.

> In that case, the PID is changed, but stale DLB entries are still
> around, thus screwing up the second copy_tofrom_user.
>
> The isync;sync I added fixes it by clearing the shadow DTLB.
> I haven't yet tested without the sync, the 405 doc is unclear about
> what instruction flush the shadow DTLB, unlike it does for the shadow
> ITLB. The isync may be enough.

I've committed a patch to use 'sync' before changing the PID (to flush
any loads/stores through the MMU before we change the context) and
'isync' afterwards to flush the shadow TLBs.  I'm guessing that isync
flushes both shadow TLBs, not just the ITLB, and that the missing
infomation is a documentation error.  I've sent some email to the IBM
PPC support people to check.

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

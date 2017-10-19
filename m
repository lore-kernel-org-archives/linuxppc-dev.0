Return-Path: <dan.carpenter@oracle.com>
Received: from aserp1050.oracle.com (aserp1050.oracle.com [141.146.126.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHsXn0SydzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Oct 2017 01:59:52 +1100 (AEDT)
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 by aserp1050.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id
 v9JExoKl008718
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 14:59:50 GMT
Date: Thu, 19 Oct 2017 17:59:36 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Cc: SF Markus Elfring <elfring@users.sourceforge.net>,
 linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] char/tpm: Less checks in tpm_ibmvtpm_probe() after
 error detection
Message-ID: <20171019145936.4tygxazuuawzs3pa@mwanda>
References: <1d3516a2-a8e6-9e95-d438-f115fac84c7f@users.sourceforge.net>
 <09a2c3a1-1b10-507d-a866-258b570f6da1@users.sourceforge.net>
 <20171019135632.4af42743@kitsune.suse.cz>
 <20171019133646.gu7qv2tywfk4tcxj@mwanda>
 <20171019161637.7eaba6e4@kitsune.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20171019161637.7eaba6e4@kitsune.suse.cz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 19, 2017 at 04:16:37PM +0200, Michal Suchánek wrote:
> On Thu, 19 Oct 2017 16:36:46 +0300
> Dan Carpenter <dan.carpenter@oracle.com> wrote:
> 
> > On Thu, Oct 19, 2017 at 01:56:32PM +0200, Michal Suchánek wrote:
> > > 
> > > I think a single cleanup section is better than many labels that
> > > just avoid a single null check.
> > >  
> > 
> > I am not a big advocate of churn, but one err style error handling is
> > really bug prone.
> > 
> > I'm dealing with static analysis so most of the bugs I see are error
> > handling bugs.  
> 
> But it looks like you do not deal much with actual code development
> because then you would know that some of the changes proposed by the
> static analysis lead to errors later when the code dynamically changes.
> 

This is silly...  Anyway, my record is there in git.  I mostly send
bugfixes, and not cleanups.  In terms of patches that are merged, I
probably have introduced one or two runtime bugs per year over the past
decade.

> > That's because error handling is hard to test but easy
> > for static analysis.  One err style error handling is the worst
> > because you get things like:
> > 
> > fail:
> > 	kfree(foo->bar);
> > 	kfree(foo);
> > 
> > Oops, foo->bar is a NULL dereference.  And generally, it's a bad thing
> > to free things that haven't been allocated so, for example, I see
> > refcounting bugs in error handling paths as well where we decrement
> > something that wasn't incremented.  Freeing everything is more
> > complicated than just freeing one specific thing the way standard
> > kernel error handling works.
> 
> It depends on the function in question. If it only allocates memory
> which is not reference-counted and kfree() checks for the null in most
> cases it is easier to do just one big cleanup.
> 

No.  Just always do it standard way.  If there is only one error
condition just free it directly:

	if (invalid) {
		free(foo);
		return -EINVAL;
	}

But once you add a second error condition then use gotos.  There is no
reason to deviate from the standard.

> If it is more complex more labels are preferable.
> 
> > 
> > > As long as you can tell easily which resources were already
> > > allocated and need to be freed it is saner to keep only one cleanup
> > > section. 
> > 
> > Sure, if the function is simple and short then the error handling is
> > normally simple and short.  This is true for any style of error
> > handling.
> > 
> > > If the code doing the allocation is changed in the future the single
> > > cleanup can stay whereas multiple labels have to be rewritten
> > > again.  
> > 
> > No, they don't unless you choose bad label names.  
> 
> You obviously miss the fact that resource allocation is not always
> added at the end of the function.
> 

No, in my example, the new allocation was added to the *start* not the
end.  It doesn't matter though, standard error handling works the same
either way.

> You may need to reorder the code and hence the order of allocation or
> add allocation at the start. Both of these cases break multiple labels
> and special cases but work with one big cleanup just fine.

No, You don't need to re-order the labels or change them.  The label
name says what is freed.  The order is the reverse order from how they
were allocated.  It's very simple.  You just have to keep track of the
most recently allocated thing:

	foo = alloc();
	if (!foo)
		return -ENOMEM;

	bar = alloc();
	if (!bar)
		goto free_foo;

	baz = alloc();
	if (!baz)
		goto free_bar;

You can tell this code doesn't leak just from looking at the label
names.

regards,
dan carpenter

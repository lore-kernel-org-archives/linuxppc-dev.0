Message-ID: <3C855BA4.2020003@embeddededge.com>
Date: Tue, 05 Mar 2002 18:58:28 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: David Ashley <dash@xdr.com>
Cc: bcrl@redhat.com, linuxppc-embedded@lists.linuxppc.org
Subject: Re: mmap wrapping around to 0 revisited
References: <200203060006.g2606g123689@xdr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David Ashley wrote:

> .... The do_mmap itself is broken, the check
> for overflow is like this:
> 	if ((offset + PAGE_ALIGN(len)) < offset)
> 		goto out;
>
> It should be:
> 	if ((offset + PAGE_ALIGN(len)-1) < offset)
> 		goto out;


This has been fixed and broken over and over more times than
anything else in the kernel.  Anytime someone makes a generic VM
change you can bet this will be broken again.  The only people that
seem to care are those that want to map the last 4K page at the top
of the physical address space from a user application using mmap().
There aren't many of those people :-).


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

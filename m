Message-ID: <3CFC0D3F.9030901@embeddededge.com>
Date: Mon, 03 Jun 2002 20:43:43 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-embedded@lists.linuxppc.org,
	Paul Mackerras <paulus@samba.org>
Subject: Re: First cut at large page support on 40x
References: <20020531042153.GD16537@zax>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David Gibson wrote:

> The only large-page PTEs used are created in mapin_ram() for the
> kernel mapping of system RAM.

I did a similar thing for 8xx, except I didn't change any of the existing
mapping code.  At the end of the kernel initialization, I added a function
to scan the page tables looking for areas we could coalesce into larger
pages.  I would then update the PMD entry to indicate the size of the pages
(4M or 8M in the case of 8xx) it could use to cover this space.  This way
I could also get any I/O mapping that was done and I didn't have to complicate
any of the existing mapin_ram() or other code with processor specific changes.
Also, iopa() and any page lookup functions should work since the only change
was to add control bits to the least significant part of pmd entry.

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

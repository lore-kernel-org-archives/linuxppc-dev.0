Message-ID: <3BF53B55.90900@embeddededge.com>
Date: Fri, 16 Nov 2001 11:14:13 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Adrian Cox <adrian@humboldt.co.uk>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] Allow small areas in io_block_mapping
References: <3BF52F0C.7020608@humboldt.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Adrian Cox wrote:

> The attached patch stops io_block_mapping() from attempting to use BATs
> for areas too small to fit in a BAT.

Hmmmm....Is io_block_mapping() supposed to be a replacement for ioremap()?
If so, it doesn't do anything I want.  What you are asking for is already
done by ioremap.  If someone has already wired BATs, you get them, and
if not then single PTEs will be allocated.  In this case, just don't allocate
BATs for I/O in the space you want individual pages when you do the board
initialization, and call ioremap().

I think we still need to define a better set of functions here.  I want to:

	1.) Control the virt->phys mapping when necessary by forcing both
		virtual and physical addresses (kind like io_block_mapping now)

	2.) Cover a very large space with a single BAT or large page entry

	3.) Have an ioremap()-like function that will use the physical address
		to either match in 1 or 2 above, or allocate single PTEs if
		no match.

The functions used to set up 1 and 2 above are performed very early during
memory management initialization and are not subject to change once we
start using these mapped spaces.

Thanks.


	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

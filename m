Message-ID: <3CFEEBB7.3080804@embeddededge.com>
Date: Thu, 06 Jun 2002 00:57:27 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-embedded@lists.linuxppc.org,
	Paul Mackerras <paulus@samba.org>
Subject: Re: First cut at large page support on 40x
References: <20020531042153.GD16537@zax> <3CFC0D3F.9030901@embeddededge.com> <20020604035947.GH2762@zax> <3CFCFC20.80101@embeddededge.com> <20020605001034.GB17752@zax> <3CFE49A1.7080105@embeddededge.com> <20020606013535.GP2630@zax>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David Gibson wrote:

> Ok, which PTE do you use to load the RPN for the large page entry?

The PMD plus the PTE, both loaded into the 8xx MMU registers, provide
the information for page size and the real address.

> The first one in the page directory, or the one corresponding to the
> actual address you're looking up?

The one corresponding to the offset lookup.  The LS bits are masked.

> I don't know about 8xx, but on 4xx the low bits in the RPN when
> putting a large page entry into the TLB *must* be zeroed, or general
> wierdness may occur.

Doesn't seem to be that way on 8xx, so I guess I'm lucky :-)

> ...  So using the PTE corresponding to the actual
> address would mean an extra branch in the large-page case and clearing
> some bits.

Or, just generic code to clear bits based upon the page size.

> The fact that our implementation works now, and yours is still
> unstable, does not encourage me to take this approach.

I just haven't had time to finish it and verify it works.  I still
intend to continue to use the page tables as they exist and let
the PMD contain additional page size information, even if I have to
add some code to the tlbmiss exception.  There are more processors
coming in the future that will benefit from this rather than continuing
to make processor specific hacks in the generic MM code.

> We already must test to see if the PMD is present in the normal case.
> In our implementation large page PMDs show up as not present.  So it's
> only in the uncommon case (not present) that we test for a large page
> PMD entry.

OK.



	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

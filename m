From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Joseph P. Garcia" <jpgarcia@execpc.com>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.4.10-ben0 doesn't see ide1
Date: Sun, 30 Sep 2001 19:51:48 +0200
Message-Id: <20010930175148.29787@smtp.wanadoo.fr>
In-Reply-To: <20010930122211.2cf9b2f7.jpgarcia@execpc.com>
References: <20010930122211.2cf9b2f7.jpgarcia@execpc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Rack this up as an OF bug on some systems I think.  I got it too
>(Wallstreet2/300).  The OF IDE nodes request what look like twice memory
>as much as they need.  Linux doesn't even use most of it anyway.
>
>The two ide busses in my system have resources 0x10000 apart, while they
>both reserve a size of 0x20000 (IIRC).  Since BenH's recent kernels
>reserve space based on OF, and then request it realistically, in this
>situation, it will fail on half of the resource allocation.  Even though
>we don't use the overlapping area...
>
>Quick fix? halve all the resource sizes of the ide nodes. (DMA's space
>also does this).  I don't know what the long term fix would be.

Ok, thanks for figuring out what was breaking request_OF_node on
those machines, I didn't yet had a chance to look at it in more
details ;)

A "good" fix would probably be to fixup OF ranges early during
boot, but for now, I think just limiting how much memory is
requested will be enough.

BTW. Once that's fixed, does media bay works on lombard & wallstreet
machines with my new kernel ? I rewrote the media bay driver but
didn't yet have a chance to test it on anything but Pismo.

Also, Joseph, did you notice similar problem with other OF resources
ranges or is this specific to IDE ?

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Message-ID: <396E0FD1.B43AC724@embeddededge.com>
Date: Thu, 13 Jul 2000 14:52:01 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: daniel.marmier@lightning.ch
CC: Dan Malek <dan@netx4.com>, linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Help with string.S
References: <3967B1E3.80CAC746@embeddededge.com> <396969E1.A7256E4A@lightning.ch> <396A5162.411F49EF@embeddededge.com> <396AB595.DC926132@lightning.ch>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Daniel Marmier wrote:
>
> Dan Malek wrote:
> > These are becoming a pain in the ass instructions.

> I have seen this happen on cacheable memory with copyback enabled.
> The dcbz-memcpy caused the destination to be zeroed, IIRC.


OK, I think I am bailing out here.  For some reason, if I remove
the 'dcbz' instructions on the MPC8xx processor the world is just
a better place.  I don't know why, maybe because of some of the
TLB mapping, but I can't find a reason.

I am going to put #ifdef CONFIG_8xx around the dcbz instructions,
and where they are actually used to zero-fill memory I will use
store operations.  The other option is to make the changes at a
higher level (like make 'clear_page' call 'memset' with 0), but I
think the direct assembly changes are preferable.  Suggestions welcome.

I'll keep looking for a better solution, but I can't hold up others
trying to use this kernel.

Thanks.


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

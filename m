Date: Mon, 7 Jun 2004 09:46:16 +0200 (CEST)
From: Marius Groeger <mgroeger@sysgo.com>
To: Eugene Surovegin <ebs@ebshome.net>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [RFC] Simple ioremap cache
In-Reply-To: <20040605002915.GA17603@gate.ebshome.net>
Message-ID: <Pine.LNX.4.56.0406070931180.3147@mag.sysgo.com>
References: <20040605002915.GA17603@gate.ebshome.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello Eugene,

On Fri, 4 Jun 2004, Eugene Surovegin wrote:

> I'd like to present simple optimization I have been using for a
> while in my PPC 4xx tree.
...
> As you can see we could save a lot of TLB misses by using just one
> mapping for _all_ 440GP peripherals (440GP has a 64-entry
> software-managed TLB).

This sounds very interesting. We have also thought about such an
optimization a while ago.

I'm not sure, however, whether your current patch actually saves _TLB_
misses. Have you counted them to prove it? To do this, I think you also need
to flag a bigger virtual page size to the MMU, eg. program a different
PAGESZ_* value (see include/asm-ppc/mmu.h). If you don't, the MMU has to
manage diffent chunks all the same, they just happen to be virtually
contiguous. Along this line, I think not all PPC MMUs allow for variable
page sizes the way 4xx CPUs do, so this optimization may only be reasonable
for those.

So I think what you're saving right now is just mapping entries (which also
is a valid thing to gain).

What do you think? Have I missed somthing?

Regards,
Marius

--
Marius Groeger <mgroeger@sysgo.com>           Project Manager
SYSGO AG                      Embedded and Real-Time Software
Voice: +49 6136 9948 0                  FAX: +49 6136 9948 10
www.sysgo.com | www.elinos.com | www.osek.de | www.imerva.com


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

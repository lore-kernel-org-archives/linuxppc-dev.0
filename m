Mime-Version: 1.0
Message-Id: <v04220802b500d91f6693@[10.0.0.42]>
In-Reply-To: <200003231922.UAA00358@piglet.grunz.lu>
References: <200003231922.UAA00358@piglet.grunz.lu>
Date: Fri, 24 Mar 2000 00:49:02 -0800
To: mlan@cpu.lu, bh40@calva.net
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: LongTrail PCI resource assignment
Cc: linuxppc-dev@lists.linuxppc.org, geert@linux-m68k.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 8:22 PM +0100 3/23/00, Michel Lanners wrote:

>That's obviously an issue. I think we should decide once and for all
>whether the OF tree is supposed to be up-to-date once the system is
>running. If so, then all fixups (also changing base address) need to be
>re-sync'ed into the OF tree, which is not done now... Or we just leave
>the OF tree alone and work only with the PCI_dev list.

It's not up to me, because I don't understand the code well enough to
contribute directly, but I'll offer these points in favor of not
updating OF:


1. Duplication of information across multiple data structures is
evil.  It should be avoided at all costs.

If there was a really, really good reason to keep OF up to date
(like, say, if we could break back into the OF console like you can
on Sparcs), then it would be OK.  Otherwise it is most likely
unnecessary bloat, and leads to potential confusion (and bugs).  Is
there any such reason on ppc?


2. Most arch types obviously don't have an OF tree at all.
Presumably they just do everything with the pci_dev list.  Therefore,
ppc should too -- it's a bad idea to be different in an unnecessary
way.

   Tim Seufert

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

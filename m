Message-Id: <200006240632.IAA00722@piglet.grunz.lu>
Date: Sat, 24 Jun 2000 08:32:04 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: Accessing IO space via resources
To: linuxppc-dev@lists.linuxppc.org
cc: mj@suse.cz
In-Reply-To: <200006231224.OAA00765@piglet.grunz.lu>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

On  23 Jun, this message from To: linuxppc-dev@lists.linuxppc.org echoed through cyberspace:
> Now, in the latest 2.4.0-ac kernels, ioremap() returns different
> addresses, not 1:1 the original address anymore. And of course this
> breaks the above scheme. (I've not looked into why this is so... I
> suppose it's not a bug?)

After investigating this, it turns out that early in the boot process,
before the mm system is up, ioremap returns virt == phys for
addresses >= ioremap_base. ioremap_base got changed from 0xf8000000 to
0xf0000000 in recent kernels. Anybody kow why this got changed?

Obviously, the PCI IO space was above ioremap_base before, but is below
now...

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dave Ray <g4tinker@yahoo.com>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: idebus=133 ?
Date: Mon, 22 Oct 2001 21:29:39 +0200
Message-Id: <20011022192939.26005@smtp.wanadoo.fr>
In-Reply-To: <20011022181106.29532.qmail@web13107.mail.yahoo.com>
References: <20011022181106.29532.qmail@web13107.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>Thanks for the replies. The reason I ask is that when
>I use "idebus=66" in the boot argument, the syslog
>shows bootup message "using 66MHz bus speed.." rather
>than "assuming 33MHz bus speed..". So I assumed the
>inclusion of the boot argument sped up the computer.
>Are the appearances of these messages in the syslog
>fictitious? Or should I simply not go over 66?

Actually, it's a bit more annoying than what I though,
as some drivers will use the speed. It's used by those
drivers to calc. some timings, and so should be properly
defined to the speed of the bus those controllers are
connected to.

The Apple controllers don't need it, they already know
the bus timings of the various revision of Apple chips.
However, the CMD 6xx, aec, and maybe other drivers
use that informations.

For now, those are PCI based exclusively and Apple's
PCI bus connectors are always 33Mhz. But we should
keep an eye on that.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

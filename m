Date: Sun, 5 Jan 2003 21:10:07 -0700
From: Matt Porter <porter@cox.net>
To: Vishwanath <vishwanath@mistralsoftware.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: ioremap64 and remap_page_range in 440GP
Message-ID: <20030105211007.C22675@home.com>
References: <001801c2b161$5fa973c0$faffa8c0@VISHWANATH>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <001801c2b161$5fa973c0$faffa8c0@VISHWANATH>; from vishwanath@mistralsoftware.com on Wed, Jan 01, 2003 at 12:15:29PM +0530
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Jan 01, 2003 at 12:15:29PM +0530, Vishwanath wrote:
>
> Hi All,
>
> In PPC Linux, to bring a particular IO page onto Linux addressing space, we
> use ioremap64(). Is my understanding correct? If I want to map this remapped

Yes.

> address on user space, I have to use  remap_page_range() of kernel in my
> driver.  remap_page_range() takes a 32-bit physical address as argument. But
> in 440GP, all addresses are 36-bit with respect to processor. Is there any
> 64-bit equivalent of remap_page_range(). If it exists, how to use it?

There's a patch to make remap_page_range() use a phys_addr_t and to use
the same bigphys fixups that ioremap() on 440gp uses.  Part of it is
a bit of hack which is why it's not being commited.  See the changeset
description in linuxppc_2_4_devel or linuxppc-2.5 for a pointer to
pick up the patch.

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Date: Wed, 17 Nov 1999 11:01:16 -0800
From: "David N. Welton" <davidw@linuxcare.com>
To: Linux -Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: again 2.3.28
Message-ID: <19991117110116.B4281@bassano.linuxcare.com>
References: <3832F9AD.9CD1B9E5@pop.agri.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3832F9AD.9CD1B9E5@pop.agri.ch>; from Andreas Tobler on Wed, Nov 17, 1999 at 07:53:34PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Nov 17, 1999 at 07:53:34PM +0100, Andreas Tobler wrote:

> my investigation brought me to the point, where I think the break
> must be between prom_init (in prom.c called from Head.S) and
> identify_machine (in setup.c called from Head.S) This is my
> interpretation of the code in Head.S? I certainly could be
> wrong.....  Any ideas?

Not really... I have the same problem, and no one seems to have any
idea what is causing it:-( I traced it to the same place, but the
problem is that you can't really even print anything, (at least not
with my limited knowledge), because of the following in head.S:

/*
 * Use the first pair of BAT registers to map the 1st 16MB
 * of RAM to KERNELBASE.  From this point on we can't safely
 * call OF any more.
 */
 lis	r11,KERNELBASE@h
.
.
.

So, we can't use prom_print to print checkpoints and we can't use
printk yet.

Ciao,
-- 
David N. Welton, Developer, Linuxcare, Inc.
415.354.4878 x241 tel, 415.701.7457 fax
davidw@linuxcare.com, http://www.linuxcare.com/
Linuxcare. At the center of Linux.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

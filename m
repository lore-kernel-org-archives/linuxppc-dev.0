Date: Mon, 25 Mar 2002 20:21:32 -0700
From: Val Henson <val@nmt.edu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: EV-64260-BP & GT64260 bi_recs
Message-ID: <20020325202132.M24258@boardwalk>
References: <20020322210103.C3363@boardwalk> <20020324122048.8670@smtp.wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020324122048.8670@smtp.wanadoo.fr>; from benh@kernel.crashing.org on Sun, Mar 24, 2002 at 01:20:48PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Mar 24, 2002 at 01:20:48PM +0100, Benjamin Herrenschmidt wrote:
>
> What I now want to do is to keep the exising scheme for most
> informations (that is a flat list of bi_recs), with only one
> exception that doesn't affect the current parsing code, only
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
I like this part!

<A bunch of stuff about various ways to identify driver specific
bi_recs>

> What do you think ?

I like the general idea - have a bunch of bi_recs that the kernel
ignores, and then define a driver interface to easily get that
information.

I would like a simpler, more generic interface between drivers and
bi_recs.  The model is this: Firmware creates a top-level bi_rec and
puts something in it.  When the driver wants to get the information,
it calls:

  my_bi_rec = bi_find_id(NULL, BI_SOME_ID);

This gives it a pointer to the top-level bi_rec containing its info.
If the firmware put more bi_recs inside that bi_rec, the driver calls:

  my_other_bi_rec = bi_find_id(&(my_bi_rec->data), BI_SOME_OTHER_ID);

Basically, don't create special cases, just treat the generic case of
a driver and a bootloader and some information you want to pass
between them.  I don't like BI_DEVICE, I do like BI_NOT_FOR_THE_KERNEL
or something shorter but equivalent. :)

I'm happy to hear reasons for why a more complicated interface is a
good idea.

-VAL

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Return-Path: <owner-linuxppc-dev@lists.linuxppc.org>
To: Val Henson <val@nmt.edu>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: EV-64260-BP & GT64260 bi_recs 
In-Reply-To: Message from Val Henson <val@nmt.edu>
   of "Sun, 24 Mar 2002 12:09:30 PDT." <20020324120930.A14640@boardwalk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 25 Mar 2002 11:44:10 +1100
Message-ID: <16802.1017017050@msa.cmst.csiro.au>
From: Murray Jensen <Murray.Jensen@cmst.csiro.au>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 24 Mar 2002 12:09:30 -0700, Val Henson <val@nmt.edu> writes:
>How about one BI_IGNORE type, and driver writers and firmware authors
>can put whatever they feel like inside that bi_rec?

The kernel should simply ignore any bi_rec it doesn't know about. You don't
need a special record tag for this. Any bi_recs within bi_recs are all ignored
in one fell swoop, since the outer record tag is unknown.

>It should be a way of passing
>information that only a bootloader can know, such as the location of a
>ramdisk, or the command line that the user typed into the bootloader.

Why only that? Why not use it to pass anything that the bootloader knows
so that you don't have to duplicate effort in the Linux kernel?

And anticipating the obvious answer, if a boot loader does not support bi_recs
and/or cannot provide some required information, then you need a piggy back
loader in arch/ppc/boot. Cheers!
								Murray...
--
Murray Jensen, CSIRO Manufacturing Sci & Tech,         Phone: +61 3 9662 7763
Locked Bag No. 9, Preston, Vic, 3072, Australia.         Fax: +61 3 9662 7853
Internet: Murray.Jensen@csiro.au

Hymod project: http://www.msa.cmst.csiro.au/projects/Hymod/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

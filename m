From: Paul Mackerras <paulus@linuxcare.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14798.33329.669922.961935@argo.linuxcare.com.au>
Date: Mon, 25 Sep 2000 09:37:37 +1100 (EST)
To: rmf@cs.columbia.edu
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Compile errors on kernel source from ppc.samba.org::linux-pmac-stable
In-Reply-To: <200009230310.XAA08258@asgard.cs.columbia.edu>
References: <200009230310.XAA08258@asgard.cs.columbia.edu>
Reply-To: paulus@linuxcare.com.au
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Robert M. Fuhrer writes:

> I rsync'ed twice from ppc.samba.org, and although it clearly got many
> files (the first time around), the source wouldn't compile.  The first of
> many batches of errors cropped up in
>
>   drivers/block/ll_rw_blk.c
>
> which sees no definition of the type 'elevator_t', as well as a few other
> "elevator"-related types.
>
> Granted, I rsync'ed on top of an existing 2.2.15pre9 source tree, but I
> gave rsync the "--delete" and "-u" flags, which I thought should have
> given me a fairly clean and up-to-date tree.  No?

Do it without -u.  What happens is that the linux Makefiles touch the
header files.  If a.h includes b.h and b.h is newer than a.h, make
will touch a.h so that anything that includes a.h will get
recompiled.  This means that if you have compiled in the tree recently
your local copy of a.h could well have a newer date than the a.h in
the rsync tree, even if the a.h in the rsync tree is actually a more
up-to-date version.

--
Paul Mackerras, Senior Open Source Researcher, Linuxcare, Inc.
+61 2 6262 8990 tel, +61 2 6262 8991 fax
paulus@linuxcare.com.au, http://www.linuxcare.com.au/
Linuxcare.  Support for the revolution.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

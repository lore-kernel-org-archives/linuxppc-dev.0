From: Paul Mackerras <paulus@linuxcare.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14827.56089.260884.298273@argo.linuxcare.com.au>
Date: Tue, 17 Oct 2000 15:52:41 +1100 (EST)
To: Tilmann Bitterberg <tibit-ibm@bitterberg.de>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: HIGHMEM now working
In-Reply-To: <Pine.LNX.4.21.0010161220230.1783-200000@karl.rchland.ibm.com>
References: <Pine.LNX.4.21.0010161220230.1783-200000@karl.rchland.ibm.com>
Reply-To: paulus@linuxcare.com.au
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tilmann Bitterberg writes:

> I saw that you recently did some fixes for HIGHMEM on CHRP, but
> they did not work. Actually, I can't get the kernel to boot on a

Where did you get the version you tried?  I recently got a kernel
going with highmem on a 44p/170 but I haven't pushed all the changes
into bk.  I had to make several changes to the python code as well as
arch/ppc/mm/init.c and my changes are somewhat different to what is
being done in the linuxppc_2_5 tree.  My changes are available in the
rsync tree at ppc.samba.org::linux-pmac-devel but that is
unfortunately almost unusable because of bandwidth restrictions on
that machine.  I am trying to get a ppc.linuxcare.com machine set up
in California but that is proving to be a slow process.

> Why not just lower PKMAP_BASE to 0xf6000000, will this break
> someone?

Everyone, potentially. :-)  You're lucky it worked.

The way the code is at the moment, we divide up the space between the
end of RAM and the end of the address space (0xffffffff) like this:

    end of RAM ... end of RAM + VMALLOC_OFFSET:	    not used
    end of RAM + VMALLOC_OFFSET ... ioremap_bot:    vmalloc & ioremap
    ioremap_bot ... ioremap_base:		    early ioremaps
    ioremap_base ... 0xffffffff:		    ioremap virt = phys

In other words all of the address space from end of RAM +
VMALLOC_OFFSET is potentially used by ioremap (which is a bit greedy
of it really).  I personally think that the code in ioremap which
assigns virt = phys for phys >= ioremap_base should go away.  For now
I have added an extra check in the highmem case so that it only uses
virt = phys for ioremap_base <= phys <= PKMAP_BASE.  This shows up one
or two missing ioremaps in the chrp code which I have fixed in my
version.

Paul.

--
Paul Mackerras, Senior Open Source Researcher, Linuxcare, Inc.
+61 2 6262 8990 tel, +61 2 6262 8991 fax
paulus@linuxcare.com.au, http://www.linuxcare.com.au/
Linuxcare.  Support for the revolution.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

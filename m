From: Paul Mackerras <paulus@linuxcare.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14977.59792.690809.161215@diego.linuxcare.com.au>
Date: Thu, 8 Feb 2001 11:34:24 +1100 (EST)
To: Gabriel Paubert <paubert@iram.es>
Cc: Roman Zippel <zippel@fh-brandenburg.de>, Dan Malek <dan@mvista.com>,
        tom_gall@vnet.ibm.com, linuxppc-commit@hq.fsmlabs.com,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: context overflow
In-Reply-To: <Pine.HPX.4.10.10102072117240.15523-100000@gra-ux1.iram.es>
References: <Pine.GSO.4.10.10102071921140.14928-100000@zeus.fh-brandenburg.de>
	<Pine.HPX.4.10.10102072117240.15523-100000@gra-ux1.iram.es>
Reply-To: paulus@linuxcare.com.au
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Gabriel Paubert writes:

> > CONFIG_HIGHMEM has little to do with the kernel virtual space. The main
> > purpose is to get the memory into user space, where user programs can use
> > them. I really don't understand, what problem you're trying to solve. The
> > kernel only wants to manage high memory and rarely access it (and uses
> > kmap for this), most of the time these pages should be in the user virtual
> > address space only.
>
> Confused. If you have up to 64 Gb or RAM (the 7450 has 36 address lines)
> and can use not even use one gigabyte for cache, you end up with a
> seriously unbalanced system. Depending on what you do of course.

The highmem pages are used mainly as page-cache pages and anonymous
user pages.  At the moment the kernel uses bounce buffers for doing
I/O to/from highmem pages but that is on the list of things to be
fixed. :)

Paul.

--
Paul Mackerras, Open Source Research Fellow, Linuxcare, Inc.
+61 2 6262 8990 tel, +61 2 6262 8991 fax
paulus@linuxcare.com.au, http://www.linuxcare.com.au/
Linuxcare.  Putting open source to work.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

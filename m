Message-ID: <40DA06BE.204@mvista.com>
Date: Wed, 23 Jun 2004 15:39:58 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Dieu Morales <dieumorales@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org,
	Brian Waite <waite@skycomputers.com>
Subject: Re: GT64260_eth (Ethernet) Driver
References: <20040620202719.25741.qmail@web60407.mail.yahoo.com>
In-Reply-To: <20040620202719.25741.qmail@web60407.mail.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dieu Morales wrote:

>Greetings, I am working with the latest 2.6.7 kernel
>source on a ppc radstone PPC7A board and was curious
>if anyone was in the process or planned on porting the
>gt64260_eth driver to support the 2.6.x kernel.
>
>Not being familiar with the gt64260 Ethernet device or
>code, I plan to take it line by line. I have attempted
>to use the driver from the ppc.bkbits.net 2.4
>development tree and currently have only changed the
>dev = init_etherdev(dev, sizeof (gt_eth_priv));
>to
>dev = alloc_etherdev(sizeof (gt_eth_priv_struct ));
>Shortly after, when attempting to allocate the Tx and
>Rx page buffers, I get an exception in the
>uncachedPages function.  I have traced the problem to
>the pmd_presentò(*pmd) function in va_to_pte(addr)
>returning 0.  I dumped the values of pmd, init_mm, and
>pmd in the va_to_pte() and the values seemed O.K., so
>I commented out the pmd_presentò(*pmd) check but was
>once again stopped by the pte_present(*pte) check.  I
>have seen the driver operate under 2.4.26 dev tree
>from ppc.bkbits.net where this problem does not occur.
>One difference I have noticed is that during
>initialization of the 2.6.7 kernel, I do not get the
>following output.
>Buffer-cache hash table entries:
>Page-cache hash table entries:
>The filemap.c, where the "Page-cache " printk resides
>in 2.4, looks heavily reworked, so I don't suspect
>this is an issue?
>
>
Dieu,

You should sync up with Brian Waite (look at CC: list) who has been
looking at writing a new enet driver for the 2.6 kernel using the latest
bridge support code.  You can get a look at the latest support code by
cloning bk://source.mvista.com/linux-2.5-marvell.  Note the the mpsc
driver that's there still isn't working correctly.

Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

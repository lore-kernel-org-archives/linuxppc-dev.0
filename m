From: Paul Mackerras <paulus@linuxcare.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14730.9953.112006.773228@argo.linuxcare.com.au>
Date: Fri, 4 Aug 2000 12:13:53 +1000 (EST)
To: Ronald Wahl <rwa@peppercon.de>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: iounmap
In-Reply-To: <Pine.LNX.4.21.0008030950020.1647-100000@goliath.issistance.de>
References: <Pine.LNX.4.21.0008030950020.1647-100000@goliath.issistance.de>
Reply-To: paulus@linuxcare.com.au
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Ronald Wahl writes:

> I'm currently writing a device driver for an pci controller and have to
> map very large amounts of pci memory and i/o ranges via ioremap. The
> problem is that there is no iounmap and ioremap returns NULL after some
> insmod/rmmod cycles. When gets this implemented?

This should do the trick:

void iounmap(void *addr)
{
	if (addr > high_memory && (unsigned long) addr < ioremap_bot)
		vfree((void *) (PAGE_MASK & (unsigned long) addr));
}

Could you replace the null iounmap in arch/ppc/mm/init.c with that,
test it, and let me know if it works?

Paul.

--
Paul Mackerras, Senior Open Source Researcher, Linuxcare, Inc.
+61 2 6262 8990 tel, +61 2 6262 8991 fax
paulus@linuxcare.com.au, http://www.linuxcare.com.au/
Linuxcare.  Support for the revolution.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

From: Paul Mackerras <paulus@linuxcare.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14829.14063.44449.96097@argo.linuxcare.com.au>
Date: Wed, 18 Oct 2000 16:36:47 +1100 (EST)
To: Dan Malek <dan@mvista.com>
Cc: Tilmann Bitterberg <tibit-ibm@bitterberg.de>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: HIGHMEM now working
In-Reply-To: <39EBE0E7.B9313EEE@mvista.com>
References: <Pine.LNX.4.21.0010161220230.1783-200000@karl.rchland.ibm.com>
	<14827.56089.260884.298273@argo.linuxcare.com.au>
	<39EBE0E7.B9313EEE@mvista.com>
Reply-To: paulus@linuxcare.com.au
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dan Malek writes:

> Right, but that is just the most recent implementation for something
> we have to admit exists and we integrate into your HIGHMEM and other
> changes.  We have to allow, somehow, mapping of board control registers
> or other resources that must be used prior to page tables or other
> VM initialization.  Right now we map things in BATs or large TLB

OK, that means you need to access these things in the bootloader, or
inside identify_machine() (which calls m8xx_init in your case) or
MMU_init().  Once we get into setup_arch (and then m8xx_setup_arch) we
can just ioremap as normal.

What do you have to initialize that can't wait until m8xx_setup_arch?
Can you give me an example of what sorts of physical addresses you
need to access?

Thanks,
Paul.

--
Paul Mackerras, Senior Open Source Researcher, Linuxcare, Inc.
+61 2 6262 8990 tel, +61 2 6262 8991 fax
paulus@linuxcare.com.au, http://www.linuxcare.com.au/
Linuxcare.  Support for the revolution.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

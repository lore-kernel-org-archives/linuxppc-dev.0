Return-Path: <jwboyer@gmail.com>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.28])
	by ozlabs.org (Postfix) with ESMTP id 26365DDEEC
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Sep 2008 11:30:40 +1000 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so1371794yxg.39
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 09 Sep 2008 18:30:38 -0700 (PDT)
Date: Tue, 9 Sep 2008 21:29:53 -0400
From: Josh Boyer <jwboyer@gmail.com>
To: Henry Bausley <hbausley@deltatau.com>
Subject: Re: PPC460EX - Machine check in kernel mode - when accessing I/O
	in user space
Message-ID: <20080910012953.GB21620@yoda.jdub.homelinux.org>
References: <1221003247.5414.20.camel@lt-linuxhenry>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1221003247.5414.20.camel@lt-linuxhenry>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Sep 09, 2008 at 04:34:07PM -0700, Henry Bausley wrote:
>I am trying to give user space application access to I/O.   Previously I
>used 2.6.14 with RT Linux and made a kernel device driver with a mmap
>routine on a 440EP.
>
>I am converting to a PPC460Ex with 2.6.26-2 with Xenomai the same code
>results in a Machine Check in Kernel mode when I attempt to use the code
>in user space.
>
>
>The io memory is in the device tree and with ioremap and I can read and
>write to it in kernel mode with
>
>of_address_to_resource(np,0,&res)
>piom = (unsigned *) ioremap( res.start, RTL_SHIOM_SIZE);
> 
>
>
>In addition I tried  
>
>	void *map_base, * virtAddr;
>	off_t target = ((unsigned int)addr) & ~MAP_MASK;
>	int fd;
>
>	if ((fd = open("/dev/mem", O_RDWR | O_SYNC)) == -1) {
>		printf("/dev/mem could not be opened.\n");
>		exit(1);
>	}
>
>	/* Map one page */
>	map_base = mmap((void *)target, length, PROT_READ | PROT_WRITE,
>			MAP_SHARED, fd, target);

You want mmap2 here.  The I/O on 440EPx is above 4GiB.

josh

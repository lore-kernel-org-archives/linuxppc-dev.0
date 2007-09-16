Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.179])
	by ozlabs.org (Postfix) with ESMTP id A149CDDDFC
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 16 Sep 2007 13:09:08 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so1600805wag
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 15 Sep 2007 20:09:07 -0700 (PDT)
Message-ID: <fa686aa40709152009k2b27ffc9kfb3fd0848f6b16d@mail.gmail.com>
Date: Sat, 15 Sep 2007 21:09:07 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Junqiang Hu" <jqhu936@yahoo.com>
Subject: Re: Linux booting problem on Xilinx ppc
In-Reply-To: <12694083.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <12694083.post@talk.nabble.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 9/15/07, Junqiang Hu <jqhu936@yahoo.com> wrote:
>
>
> Dear friends,
>
>    I'm trying to run Linux in AvNet (Memec) Xilinx-XC2VP50-EVKT-FF1152
>  board.  The Linux version I'm using is 2.4; the cross-compiler is
> gcc-4.1.0, glibc 2.3.6.  When booting the kernel, it shows:
>       loaded at:     00400000 004B51E4
>       board data at: 00000000 00000018
>       relocated to:  0040526C 00405284
>       zimage at:     00405B2B 004B177C
>       avail ram:     004B6000 60000000

I strongly recommend moving to a 2.6 kernel.  Recent mainline has
support for the Xilinx ppc built in.
>
>       Linux/PPC load: console=ttyS0,9600 root=/dev/xsysace/disc0/part3 rw
>       Uncompressing Linux...done.
>       Now booting the kernel
>
> Then it hangs. First it seems to me that the "avail ram" is not correct,
> since I configured only 32MB SDRAM.  Moreover, if it's first powered on, the
> end address of "avail ram" would be FFD9FBED. Then I tried to investigate
> the problem using xmd.  When  launched, it says:

(If you're using u-boot) You might have a mismatch between the board
info structure used by u-boot and the one used by Linux.

Also, you should use your debugger to inspect the __log_buf memory of
the kernel.  A common problem is the kernel starts booting, but the
console is setup incorrectly and so you see nothing.  But, you can
read the console output directly from memory if you look at the
__log_buf region (find the address in the System.map file; you might
need to subtract 0xC0000000 from the address to view the memory)

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195

Return-Path: <kunalarya@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.237])
	by ozlabs.org (Postfix) with ESMTP id 88EBEDDF32
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 Mar 2007 14:31:50 +1100 (EST)
Received: by wr-out-0506.google.com with SMTP id i4so1729742wra
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 19 Mar 2007 20:31:49 -0700 (PDT)
Message-ID: <68ee5ad90703192031rf1802cy26f096e3cc7ecd1b@mail.gmail.com>
Date: Mon, 19 Mar 2007 19:31:48 -0800
From: "Kunal Arya" <kunalarya@gmail.com>
To: "Mike Dyer" <michaelidyer@gmail.com>
Subject: Re: Kernel locked at "Now booting the kernel", Xilinx ML310 PPC405GP
In-Reply-To: <45F558AC.9060205@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <68ee5ad90703091309s64018616v3ba2b25033e84844@mail.gmail.com>
	<45F558AC.9060205@gmail.com>
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

It looks like it was a linker problem. I rolled back to GCC 4.0.2, and
it got past the initial kernel panic.

It's now panicking on a PCI transaction, but at least it gets to the
kernel's main code.

I'm avoiding the 2.6 kernel because it lacks Xilinx IP driver support
(at least on a production level).

On 3/12/07, Mike Dyer <michaelidyer@gmail.com> wrote:
> Hi Kunal,
>
> Apologies if I post this twice - our mail server is unreliable atm...
> > <snip>
> > I used crosstool with gcc 4.1.1 w/glibc 2.3.6. My xparameters_ml300.h
> > and .config files are pasted below.
> >
> > The problem:
> > The kernel panics after printing out the message "Now booting the
> > kernel" The exact output is this:
> >
> > loaded at:     00400000 0089C1E4
> > board data at: 00000000 00000018
> > relocated to:  00405238 00405250
> > zimage at:     00405BD3 004AFDF5
> > initrd at:     004B0000 00898382
> > avail ram:     0089D000 55555555
> >
> > Linux/PPC load: root=/dev/ram
> > Uncompressing Linux...done.
> > Now booting the kernel
> >
> >
> >
> I had the exact same problem for a different board, using the PPC in a
> Virtex 4 FX12, using the 2.6 kernel.  I fixed this by rolling the
> compiler back to version 4.0.2.  Didn't do a lot of thinking about why
> it worked, but I think it has something to do with the linker and your
> board data (it randomly changed location every time I tried to boot).  I
> believe it should be in the 0x00400000 range as well (not 0x00 as it is
> in your capture).
>
> As a side note: Are there any known issues using GCC 4.1.1?
>
> Cheers,
> Mike
>
>
>

Return-Path: <michaelidyer@gmail.com>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.228])
	by ozlabs.org (Postfix) with ESMTP id D5167DDDE6
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 13 Mar 2007 00:42:08 +1100 (EST)
Received: by wx-out-0506.google.com with SMTP id i31so1626700wxd
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 12 Mar 2007 06:42:07 -0700 (PDT)
Message-ID: <45F558AC.9060205@gmail.com>
Date: Mon, 12 Mar 2007 13:42:04 +0000
From: Mike Dyer <michaelidyer@gmail.com>
MIME-Version: 1.0
To: Kunal Arya <kunalarya@gmail.com>
Subject: Re: Kernel locked at "Now booting the kernel", Xilinx ML310 PPC405GP
References: <68ee5ad90703091309s64018616v3ba2b25033e84844@mail.gmail.com>
In-Reply-To: <68ee5ad90703091309s64018616v3ba2b25033e84844@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Hi Kunal,

Apologies if I post this twice - our mail server is unreliable atm...
> <snip>
> I used crosstool with gcc 4.1.1 w/glibc 2.3.6. My xparameters_ml300.h
> and .config files are pasted below.
>
> The problem:
> The kernel panics after printing out the message "Now booting the
> kernel" The exact output is this:
>
> loaded at:     00400000 0089C1E4
> board data at: 00000000 00000018
> relocated to:  00405238 00405250
> zimage at:     00405BD3 004AFDF5
> initrd at:     004B0000 00898382
> avail ram:     0089D000 55555555
>
> Linux/PPC load: root=/dev/ram
> Uncompressing Linux...done.
> Now booting the kernel
>
>
>   
I had the exact same problem for a different board, using the PPC in a 
Virtex 4 FX12, using the 2.6 kernel.  I fixed this by rolling the 
compiler back to version 4.0.2.  Didn't do a lot of thinking about why 
it worked, but I think it has something to do with the linker and your 
board data (it randomly changed location every time I tried to boot).  I 
believe it should be in the 0x00400000 range as well (not 0x00 as it is 
in your capture).

As a side note: Are there any known issues using GCC 4.1.1?

Cheers,
Mike

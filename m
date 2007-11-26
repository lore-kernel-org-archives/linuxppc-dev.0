Return-Path: <dhlii@picocomputing.net>
Received: from outbound-mail-56.bluehost.com (outbound-mail-56.bluehost.com
	[69.89.20.36]) by ozlabs.org (Postfix) with SMTP id 18F04DDE9B
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 27 Nov 2007 06:21:27 +1100 (EST)
Message-ID: <474B1B23.40404@picocomputing.net>
Date: Mon, 26 Nov 2007 14:14:43 -0500
From: "David H. Lynch Jr." <dhlii@picocomputing.net>
MIME-Version: 1.0
To: fabien <fabien.fb@gmail.com>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: initramfs and busybox kernel oops
References: <f8f856500711260716m6bd6a89and056f9e196d9d1bf@mail.gmail.com>
In-Reply-To: <f8f856500711260716m6bd6a89and056f9e196d9d1bf@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

fabien wrote:
> hi all,
>
> I'm trying to get busybox working on my custom board mpc855t and linux
> kernel 2.6.19 (from eldk 4.1 uclibc). I've built an initramfs that i
> link directly in kernel. To verify whether the kernel is able to lauch
> the init process i've compiled a small hello world program. But no
> when i try with busybox 1.8.1 staticaly linked i got an Oops error
> kernel access to bad area. I don't know why the former work fine but
> no the latter.
> If someone have some ideas for where to look for ?
>
> In my initramfs there is :
> in /dev :
> crw-r--r--   1 root   root   5, 1 nov 22 13:32 console
> crw-rw-rw-   1 root   root   1, 3 nov 26 10:10 null
> crw-------   1 root   root   4, 1 nov 26 10:11 tty1
> in /bin :
> lrwxrwxrwx   1 root   root        7 nov 26 10:17 ash -> busybox*
> -rwxr-xr-x   1 root   root   793804 nov 26 13:57 busybox*
> lrwxrwxrwx   1 root   root        7 nov 26 10:17 cat -> busybox*
> (and others links)
> My init script file (/init) :
> #!/bin/sh
> /bin/ash
>   
It took me a while to get initramfs running. But after I did I have been
very happy with it.

It is possible you need more in /dev.
My initramfs has much more than yours - though it is still quite small.
I sort of stole it from somewhere. I think I took an initrd from
somewhere expanded it an culled out what iI did not want.
Busybox is still the bulk by volume, but that got me all the /dev /etc/
... stuff I needed

You can pull mine from http://www.picocomputing.net/files/initramfs/

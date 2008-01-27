Return-Path: <dhbaird@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.176])
	by ozlabs.org (Postfix) with ESMTP id 7B2DEDDE03
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 28 Jan 2008 05:29:42 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so2543679wag.13
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 27 Jan 2008 10:29:41 -0800 (PST)
Message-ID: <440abda90801271029q2f833a46v72c4d29acdacf8fa@mail.gmail.com>
Date: Sun, 27 Jan 2008 11:29:41 -0700
From: "David Baird" <dhbaird@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Linux boot on a ppc 405
In-Reply-To: <479CAF56.30306@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <479CAF56.30306@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Jan 27, 2008 9:20 AM, Ricardo Severo <severo.ricardo@gmail.com> wrote:
> Hi all,
>
> I am working with a Xilinx Virtex II Pro  evaluation board, wich has two
> PowerPC 405 and I'm trying to boot a vanilla linux kernel 2.6.23.14.
> Until now I've manged to make it uncompress the kernel, but it doesn't boot.
> My question is how the initial execution (the one who uncompresses the
> kernel image) transfers the processor to the kernel itself. I've looked
> in the arch/ppc/boot/simple/relocate.S code and it jumps to the position
> 0x0 after uncompressing, is it right? The kernel is uncompressed at that
> position?
>
> Thanks,

It should branch to the beginning of arch/ppc/kernel/head_4xx.S, which
I think was 0x0.

Some things to check are:

- Comment/remove the weak embed_config in arch/ppc/boot/simple/misc-embedded.c
- Did you use ttyUL0 or ttyS0 as your console?

If that fails, you can use XMD to set a breakpoint at 0x0 and then
read the memory to see if it matches up with an objdump of vmlinux.

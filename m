Return-Path: <alan@akb.net>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.237])
	by ozlabs.org (Postfix) with ESMTP id 25B92DDE37
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Sep 2007 02:46:43 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id 71so546027wri
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Sep 2007 09:46:42 -0700 (PDT)
Message-ID: <bfa0697f0709240946i341739b3n8d5541b30bca8cb@mail.gmail.com>
Date: Mon, 24 Sep 2007 10:46:41 -0600
From: "Alan Bennett" <alan@akb.net>
To: "Manil Gaouar" <mgaouar@solacom.com>
Subject: Re: Problems compiling Linux for MPC8272ADS
In-Reply-To: <9A1468054ED2FD40907CC3B2C1871D400106CC90@hermes.versatel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9A1468054ED2FD40907CC3B2C1871D400106CC90@hermes.versatel.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I added this to my boot/Makefile near the other mcpu=440 lines.  I
believe there may be a fix coming?

$(obj)/treeboot-walnut.o: BOOTCFLAGS += -mcpu=440
$(obj)/4xx.o: BOOTCFLAGS += -mcpu=440
$(obj)/ebony.o: BOOTCFLAGS += -mcpu=440


On 9/24/07, Manil Gaouar <mgaouar@solacom.com> wrote:
> Hi there,
>
> I am trying to compile the latest Linux from the git repos: git clone
> git://www.denx.de/git/linux-2.6-denx.git linux-2.6-denx, I checked out
> the code a few weeks ago and was able to build my uImage no problems. I
> did a git pull this morning and I can not compile anymore, here is the
> error message I have:
>
>   BOOTCC  arch/powerpc/boot/ps3.o
>   BOOTCC  arch/powerpc/boot/treeboot-bamboo.o
>   BOOTCC  arch/powerpc/boot/cuboot-sequoia.o
>   BOOTCC  arch/powerpc/boot/treeboot-walnut.o
> {standard input}: Assembler messages:
> {standard input}:184: Error: Unrecognized opcode: `mfdcr'
> {standard input}:185: Error: Unrecognized opcode: `mfdcr'
> {standard input}:186: Error: Unrecognized opcode: `mfdcr'
> {standard input}:217: Error: Unrecognized opcode: `mtdcr'
> make[1]: *** [arch/powerpc/boot/treeboot-walnut.o] Error 1
> make: *** [uImage] Error 2
>
> here are the commands I am using:
>
> make mrproper
> make ARCH=powerpc CROSS_COMPILE=ppc_6xx- mpc8272_ads_defconfig
> make ARCH=powerpc CROSS_COMPILE=ppc_6xx- uImage
>
> Do you have any ideas, or I should check out the 2.6.22 stable release
> instead and try again???
>
> Thx
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>

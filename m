Return-Path: <tehn.yit.chin@gmail.com>
Received: from ti-out-0910.google.com (ti-out-0910.google.com [209.85.142.191])
	by ozlabs.org (Postfix) with ESMTP id 6205ADDDF4
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 21 Jul 2008 09:22:20 +1000 (EST)
Received: by ti-out-0910.google.com with SMTP id w7so691942tib.13
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 20 Jul 2008 16:22:18 -0700 (PDT)
Message-ID: <bf04f99c0807201622p5508af06q62afacb6158671ad@mail.gmail.com>
Date: Mon, 21 Jul 2008 09:22:18 +1000
From: "Tehn Yit Chin" <tehn.yit.chin@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: jumping to code in RAM in a MPC55xx
In-Reply-To: <bf04f99c0807172329m7ec94580n194e02b708bf7597@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <bf04f99c0807172329m7ec94580n194e02b708bf7597@mail.gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I am just going to answer my own questions for future reference.

I did some searching on the internet and came across this note on the
the usenet comp.sys.powerpc.tech

http://newsgroups.derkeiler.com/Archive/Comp/comp.sys.powerpc.tech/2005-11/msg00015.html

In summary, it performs a indirect jump to code via the CTR register.
The following code snippet show how it is done.

	lis	9,0xFC00 /* Function is at 0xFC000000 */
	mtctr	9
	bctrl


On Fri, Jul 18, 2008 at 4:29 PM, Tehn Yit Chin <tehn.yit.chin@gmail.com> wrote:
>
> Hi,
>
> This question is not directly related to linux, but a question on how to execute code from.
>
> My test code is as follows..
>
> void ram(unsigned int cat) __attribute__ ((section(".ram_code")));
> void ram1(void) __attribute__ ((section(".ram_code")));
> void flash(void) __attribute__ ((section(".text")));
> void flash1(unsigned int y) __attribute__ ((section(".text")));
>
> void ram(unsigned int cat)
> {
>     unsigned int abc;
>
>     abc += 12;
>     abc += cat;
> }
>
> void ram1(void)
> {
>     ram(123);
> }
>
>
> void flash1(unsigned int y)
> {
>     unsigned int x;
>
>     x = x + y;
>
> }
>
> void flash(void)
> {
>     unsigned int def;
>
>     def += 12;
>
>     asm (" bel ram1\n\t");
> }
>
> I have the section .ram_code mapped into the internal SRAM of the MPC55xx, which starts at 0x40000000. Code in .text are mapped into MPC55xx's internal FLASH, starting at 0x00000000.
>
> When I attempt to link the code together,  I get the error
>
> U:\src\applications\comms/fatdog.c(35,1): relocation truncated to fit: R_PPC_REL24 against symbol `ram1' defined in .ram_code section in U:\src\applications\comms\fatdog.o
>
> I googled the error and I think it means that the ram1() is too far away and the branch address has been truncated to fit into the binary.
>
> Other than assembler bel instruction, I have also tried bl, b and bea and all of them gave the same link error.
>
> I was wondering if anyone can give some insight on how I can get the MPC55xx to branch between FLASH and SRAM?
>
> Many thanks,
> Tehn Yit Chin
>

Message-ID: <3D5D3D2F.5090900@dslextreme.com>
Date: Fri, 16 Aug 2002 10:58:07 -0700
From: akuster <akuster@dslextreme.com>
Reply-To: akuster@dslextreme.com
MIME-Version: 1.0
To: Pete Smithers <petesmithers@mail.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: redwood5
References: <20020816171017.28307.qmail@mail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Pete Smithers wrote:
> hi
>
> i am trying to build a kernel from linuxppc_2_4_devel for the redwood5 board.
> there seems to have been some restructuring in that tree after which nobody probably compiled a kernel for that board. at least, when i select gpio, onchip ethernet, onchip ide or sicc serial port i get a bunch of errors, like
> ibm_ocp_gpio.c:124: `DCRN_CHCR0' undeclared (first use in this function) etc.
>
> from a naive point of view, the fix, at least  for this particular error would be to #include asm/ibm403.h and above that one of the headers in arch/ppc/platforms that #define DCRN_CHCR_BASE, depending on the selected processor.
>
> but i don't think ibm_ocp_gpio.c should care about the selected processor, there must be some other way, to do that in a more generic way, so the other files that currently fail to compile won't fail anymore as well :)
>
> i am just too new to the ppc stuff, so i am asking you gurus what you would preferably do to fix the problem...
>
>
> Greets,
> Pete
>
>
>

Pete,


Please use the redwood5_config to start with( make redwood5_config).
The stb04xxx does not have a ocp ethernet.  The gpio driver will not
work on any stbxxxx processors since most of the other devices such as
video, sound and other drivers you get from IBM use many gpio pins so
having a generic gpio driver make no sense.  If you want to use the gpio
driver then you will need to update some of the ibmstb4.x files and the
driver.


Armin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

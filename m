Subject: Re: linux ppc boot parameters R3, R5
From: Gary Thomas <gary@mlbassoc.com>
To: ramanathan G A <ramanathan_ga@rediffmail.com>
Cc: linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <20030514143624.358.qmail@webmail31.rediffmail.com>
References: <20030514143624.358.qmail@webmail31.rediffmail.com>
Content-Type: text/plain
Message-Id: <1052923901.18521.7699.camel@hermes>
Mime-Version: 1.0
Date: 14 May 2003 08:51:42 -0600
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, 2003-05-14 at 08:36, ramanathan G A wrote:
> Hi All,
>
> I am trying to boot an MPC8260 board with Linux 2.4.4. I cross
> compiled the kernel for PPC using GCC 3.2 and prepared a
> 'zImage.initrd'. Since the board has a working bootloader for
> pSOS, I decide to use the same with minimum modifications to suite
> for loading the linux image.
>
> Going through the literature, I could understand that the linux
> image is expecting TWO arguments; in registers R3 and R5.
> R3 - Pointer to board information structure
> R5 - Open Firmware Data. (??)
>
> Now, I have to modify my boot loader in order to boot linux
> image.
> The boot loader is supposed to do the basic initialization of the
> processor, load the image on to the RAM from flash and give
> control to the image entry point.
>
> Could some one help me giving pointers to what is meant by this R5
> parameter (Open Firmware Data)? What is the significance? Can I
> avoid this parameter and proceed?
> (I am stuck at this point.)
>
> Any suggestions to improve the situation is welcome.
>

That pointer is only important for systems which utilize Open Firmware
booting (like the Apple boxes).  It's not used [AFAIK] on embedded
devices like an 8260.

Also, the bootstrap on many platforms does not provide the board data.
In this case, you can just "hardwire" the parameters.  Look at the
code in "arch/ppc/boot/simple/embed_config.c" to see how it's done.

--
Gary Thomas <gary@mlbassoc.com>
MLB Associates


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

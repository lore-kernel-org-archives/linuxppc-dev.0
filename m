In-Reply-To: <001301c489f8$82f426b0$5201a8c0@GEG2400>
References: <001301c489f8$82f426b0$5201a8c0@GEG2400>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <853DF87E-F5F7-11D8-B036-000393DBC2E8@freescale.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
From: Kumar Gala <kumar.gala@freescale.com>
Subject: Re: MPC8560 util.S compilation error with E500 core support
Date: Tue, 24 Aug 2004 13:00:44 -0500
To: =?ISO-8859-1?Q?G=E9rard_Gu=E9vel?= <gguevel@interfaceconcept.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Most of the boards that use 85xx use u-boot as their bootloader.  This
code does not get built for kernel images loaded by u-boot, and this
does not currently build for e500.

The issue is that mtsrin is 'classic' ppc instruction that does not
exist on e500.  If you want to use the common boot code you will need
to go through the effort of making it work for e500 and 85xx.

- kumar

On Aug 24, 2004, at 11:36 AM, Gérard Guével wrote:

>
> Hi,
>
> I first download a 2.6.7 Linux kernel to port it to a custom 8560
> board.
> The ./arch/ppc/boot/common/util.S compiles fine.
>
> Then I download a 2.6.8 kernel. The same file util.S does not
> compile any more because of "mtsrin" instruction not found with E500.
>
> Between the 2 kernels, the -me500 option is distributed all over the
> ./arch/ppc directory. So the ./arch/ppc/boot is compiled with this
> option
> and fails.
>
> What is the right solution ?
> Compile the boot whitout -me500 option or change util.S code ?
>
> Thanks for any idea.
> Gérard Guével
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

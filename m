Subject: RE: Problem debugging ppc kernel with DDD/GDB/BDI2000 on a custom MPC8260 board 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Fri, 10 Oct 2003 15:24:15 +0100
Message-ID: <DEF39A0710293E489D45B10E06645CBD0243B254@dub-msx1.spectelcorp.com>
From: "Joao Vicente" <joao.vicente@spectel.com>
To: "Wolfgang Denk" <wd@denx.de>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


OK

Does that mean that I cannot debug the source until after the MMU is turned on?

-----Original Message-----
From: Wolfgang Denk [mailto:wd@denx.de]
Sent: Friday, October 10, 2003 2:01 PM
To: Joao Vicente
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Problem debugging ppc kernel with DDD/GDB/BDI2000 on a
custom MPC8260 board


Dear Joao,

in message <DEF39A0710293E489D45B10E06645CBD0243B232@dub-msx1.spectelcorp.com> you wrote:
>
> Once inside gdb, I am typing 'target remote 10.121.10.22:2001' after
> which I am obtaing the following output:
> 0x00000000 in ?? ()

OK.

> One thing I cant get my head around is that if the  system.map file
> shows _start address at 0xc000000, how can the gdb relate the symbols on
> vmlinux, assuming they are are expected to be at 0xc0000000?

0xC....... is a kernel virtual address which will be valid as soon as
Linux  turns  on  the  MMU  (which   it   does   very   early   durin
initialization).

> I have also tried to load the symbol file at 0x00000000 with the
> 'add-symbol-file vmlinux 0x00000000' followed by 'target remote
> 10.121.10.22:2001'. Does this make any sense if the code is not
> relocatable ?

No, this makes no sense.

> My intention here is not to have this build to work with my board, but
> to just be able to display the symbols and trace the flow of the kernel,
> so that I can then start customising it for the custom hardware.

Ummm... In my experience a better approach would be to figure out the
necessary changes _before_ even attempting to boot the kernel. Inter-
preting the effects of a misconfigured kernel it not exactly easy  as
funny things might happen.

> In order to customise the build for my board, what would be your
> sugestion. Should I modify config.in in order to launch an independent

Yes. Create a new configuration option for your board.

> config on the build, or use one of the given ones and hard code a
> XXX_CONFIG specific for my board onto include/linux/autoconf.h or some

Modifying include/linux/autoconf.h makes no  sense.  This  file  gets
automagically created dureing the kernel config & build steps.

> For instance, I have noticed that there is specific CONFIG_ADS8260
> #ifdefs throughout the ppc arch source, but no standard configuration is
> available from 'make menuconfig'. Is this because this board's port is
> not complete, or should a default config be selected on menuconfig, and
> the CONFIG_ADS8260 added into a top header file ?

My guess is that this port was only completed in more recent versions
of the (linuxppc_2_4_devel) kernel tree.

> The u-boot README file is an excellent source of documentation for
> porting the u-boot for custom boards, which has been extremelly helpful
> on my exercise on porting u-boot (along with your kind guiding help).
> Do you know of any similar documentation as far as customising the
> kernel for a custom board ?

Except for the source code, no.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Philosophy is a game with objectives and no rules.
Mathematics is a game with rules and no objectives.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

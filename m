To: Eli Brin <elib@rokonet.co.il>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Access u-boot environment variables from Linux 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 14 Jul 2003 11:05:47 +0200."
             <75DF04AC5ED4D511A9810090273CB4163F5DE0@rokonet-e.rokonet.co.il>
Date: Mon, 14 Jul 2003 10:41:30 +0200
Message-Id: <20030714084135.CF046C6D82@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Eli,

in message <75DF04AC5ED4D511A9810090273CB4163F5DE0@rokonet-e.rokonet.co.il> you wrote:
>
> I will start at the beginning, as I should have...

Thanks :-)

> I would like the manufacturing to burn the H/W configuration and MAC
> to the flash, and the TQ860L probably at 0x3ff00. They will also burn
> u-boot,

With "burn ... the TQ860L ... at 0x3ff00" you  mean  the  TQ-specific
Hardware   Information   Block  which  can  be  installed  at  offset
0x0003FFC0 in the first flash bank?

> I would like u-boot to read this data (H/W configuration and MAC) and
> put it into environment variables. I would like to read and modify
> those variables from Linux user space.

The first part, the initialization of some vendor dependend  environ-
ment variables (i. e. serial# and ethaddr) has already been implemen-
ted for the TQM8xx modules: see board/tqm8xx/load_sernum_ethaddr.c

For the second part, reading and modifying environment variables from
Linux, see the tools I mentioned before (in tools/env).

> We use MTD for updating the kernel, ramdisk, jffs2. But, I can not (or
> don't know how) the get access to the u-boot environment variables
> with MTD. I have an MTD patch from Nye (Zuma networks) to do exactly
> that, but I did not test it yet on kernel 2.4.4.

I answered this already in my previous  message.  Use  the  tools/env
stuff.

> So I thought to use MTD for remote update and jffs2, and your patch to
> busybox to get access to u-boot variables.

This stuff has been obsoleted by  the  solution  in  tools/env  which
allows for easy configuration to different boards / setups.

> I find it easier to use SELF. We use ELDK for development and tests,
> but for creating the final target images, SELF is great.

Yes, but it makes little sense to always  recompile  everything  from
scratch  when  the  same tools are ready available as binaries in the
ELDK.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
The C-shell doesn't parse. It adhoculates.
    - Casper.Dik@Holland.Sun.COM in <3ol96k$b2j@engnews2.Eng.Sun.COM>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

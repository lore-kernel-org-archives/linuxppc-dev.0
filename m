Subject: Re: CONFIG_SERIAL_TEXT_DEBUG causes exception
From: "Gary D. Thomas" <gary.thomas@mind.be>
To: jwalden@digitalatlantic.com
Cc: linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <EGEGIJHKDKJGAJMGIDPNEEMMCJAA.jwalden@digitalatlantic.com>
References: <EGEGIJHKDKJGAJMGIDPNEEMMCJAA.jwalden@digitalatlantic.com>
Content-Type: text/plain
Date: 19 Mar 2003 10:54:15 -0700
Message-Id: <1048096456.7462.5411.camel@hermes.chez-thomas.org>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, 2003-03-19 at 10:47, Jerry Walden wrote:
>
> Hello:
>
> I have a custom PPC405GPr board that I have successfully ported u-boot to.
>
> I am now at the stage of trying to bring Linux up on the board.
>
> I have CONFIG_SERIAL_TEXT_DEBUG defined for the kernel that I am trying to
> bring up.  I would like to have this option so I can trace through the
> kernel.
> The comments in ppc4xx_setup.c in the function serial_putc indicate that as
> long
> as the firmware (in my case u-boot) has been initialized properly, then this
> function
> should work.  I have verified the addresses that the function is trying to
> write to
> and they are correct.  However, when serial_putc calls the first readb, I
> get an
> exception.
>
> Can someone please provide some pointers as to what might be wrong?

You need to make sure that the serial registers are mapped at
that point.  I don't know the details of your U-boot implementation,
but the kernel will most certainly not have this region mapped
unless you make it happen explicitly.  Look at some other embedded
boards and you'll find code to set this up, typically using a BAT or
some other special mapping.

--
.--------------------------------------------------------.
|       Mind: Embedded Linux and eCos Development        |
|--------------------------------------------------------|
| Gary Thomas              email:  gary.thomas@mind.be   |
| Mind ( http://mind.be )  tel:    +1 (970) 229-1963     |
| gpg: http://www.chez-thomas.org/gary/gpg_key.asc       |
'--------------------------------------------------------'


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

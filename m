Date: Thu, 22 Feb 2001 08:30:31 -0700
From: Matt Porter <mporter@mvista.com>
To: "tsombakos, mark" <tsombakos_mark@emc.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Booting Sandpoint 8240??
Message-ID: <20010222083031.A21599@cx258813-a.chnd1.az.home.com>
References: <276737EB1EC5D311AB950090273BEFDD01F4DB3F@elway.lss.emc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <276737EB1EC5D311AB950090273BEFDD01F4DB3F@elway.lss.emc.com>; from tsombakos_mark@emc.com on Thu, Feb 22, 2001 at 01:26:06PM -0500
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Feb 22, 2001 at 01:26:06PM -0500, tsombakos, mark wrote:
>
>   Well, I got the thing to boot, though now I don't quite understand it.
>   I ended up changing the address used in zsrec and the "go" address
>   to "0x90000" instead of "0x900000".  I saw the memory map in the
>   DINK32 manual that the "Start of user memory" is at 0x90000.  I figured
>   it was a typo in the HHL CDK manual. So, life was good.  Until
>   I realized the bootloader relocates to 0x80000. Now I'm confused again.

DINK32 loads the linear array of bits that comprise the zImage at 0x90000
(576KB).  The standard bootloader always relocates to 0x800000 (8MB) and
continues running.  The bootloader then uncompresses the included
vmlinux.gz and places it at the start of RAM (0MB).

> DINK32_MAX >>go 90000
> loaded at:     00090000 000A4E20
> relocated to:  00800000 00814E20
> zimage at:     0009B000 0011B486
> relocated to:  00815000 00895486
>
> avail ram:     00400000 00800000
>
>
> Since "avail ram" is 400000-800000, should I run srec -s (something <
> 800000)?
> I know I read that it should be higher than the relocated image ...

You don't need to do a thing, all is well. :)

--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

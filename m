Message-ID: <3B8BB9AB.570AE813@mvista.com>
Date: Tue, 28 Aug 2001 08:32:59 -0700
From: Scott Anderson <scott_anderson@mvista.com>
MIME-Version: 1.0
To: Mark Pilon <mark.pilon@minolta-qms.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: how to dump other regs via abatron-bdi / gdb ?
References: <3B8AB925.D2DB3E90@minolta-qms.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Mark Pilon wrote:
>
> I'm accustomed to printing general purpose registers: print $r0
> and the like --
>
> bringing up a board (before establishing an exception vector table)
> I'm getting some unknown exception -- how do I print the ESR (and
> other SPRs for that matter ) ??

If all is configured correctly, you can just do:
  BDI>rd esr
  esr : 0x00000000  0
If not, but you know the SPR number, you can just do:
  BDI>rdspr 0x3d4
  SPR  980 : 0x00000000            0

> I suspect the problem is an incomplete bdi board config file,
> but it'd help to be able to figure out what's missing ...

The BDI came with a file called reg405gp.def.  This file contains the
mappings from names to spr/dcr numbers.  Make sure it is in your tftp
directory and then make sure you have something like:
  [REGS]
  IDCR1	0x010	0x011	;MEMCFGADR and MEMCFGDATA
  IDCR2	0x012	0x013	;EBCCFGADR and EBCCFGDATA
  IDCR3	0x014	0x015	;KIAR and KIDR
  FILE	reg405gp.def
in your config file.  BOOT your BDI and you should then be set.

    Scott Anderson
    scott_anderson@mvista.com   MontaVista Software Inc.
    (408)328-9214               1237 East Arques Ave.
    http://www.mvista.com       Sunnyvale, CA  94085

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

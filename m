Message-Id: <200006290602.IAA01677@piglet.grunz.lu>
Date: Thu, 29 Jun 2000 08:02:17 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: ide_delay_50ms() freezing on PPC?
To: bh40@calva.net
cc: linuxppc-dev@lists.linuxppc.org, andre@linux-ide.org
In-Reply-To: <20000627083003.23370@mailhost.mipsys.com>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

On  27 Jun, this message from Benjamin Herrenschmidt echoed through cyberspace:
> Can you check the generated code for the loop ? Does it actually re-dead
> jiffies from memory or not ? (Did the compiler wrongly tried to optimise
> it ?).

Here is the code as it appears in vmlinux:

c00ba91c <ide_delay_50ms>:
c00ba91c:       3d 20 c0 21     lis     r9,-16351
c00ba920:       81 69 c1 ec     lwz     r11,-15892(r9)
c00ba924:       39 6b 00 06     addi    r11,r11,6
c00ba928:       80 09 c1 ec     lwz     r0,-15892(r9)
c00ba92c:       7d 40 58 51     subf.   r10,r0,r11
c00ba930:       41 81 ff f8     bgt     c00ba928 <ide_delay_50ms+0xc>
c00ba934:       4e 80 00 20     blr

I suppose r9 points to a symbol table somewhere, and the lwz loads a
specific symbol in there, which in this case should be the value of
jiffies. AFAICS, the jiffies value is thus correctly reloaded at
c00ba928. Looks OK to me, no?

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

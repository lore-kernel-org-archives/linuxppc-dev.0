To: "Jack Liu" <Jack_liu@usish.com>
Cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: ELDK help 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 18 May 2004 09:49:43 +0800."
             <200405180149.i4I1niRV001354@ms.usish.com>
Date: Tue, 18 May 2004 09:31:35 +0200
Message-Id: <20040518073140.8D9B5C109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <200405180149.i4I1niRV001354@ms.usish.com> you wrote:
>
>      ELDK worked for me greatly before. Just a few days ago,I found that
> when I not use make clean, things work ok. However when I make clean and
> make uImage, the following error message appears:

What host system are you running? Are you sure your  native  compiler
is working?

Which kernel tree is this? How did you configure the kernel? What  is
the _exact_ sequence of commands you are using?

> make[3]: Entering directory `/root/new/4.1/drivers/char'
> gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -I/root/new/4.1/arch/ppc -o conmakehash conmakehash.c
> /tmp/cck3aG7b.s: Assembler messages:
> /tmp/cck3aG7b.s:2: Warning: Unrecognized .section attribute: want a,m,s,w,x
> /tmp/cck3aG7b.s:2: Warning: Unrecognized .section attribute: want a,m,s,w,x
> /tmp/cck3aG7b.s:155: Warning: Unrecognized .section attribute: want a,m,s,w,x
> /tmp/cck3aG7b.s:155: Warning: Unrecognized .section attribute: want a,m,s,w,x
> /usr/local/bin/ld: unrecognized option '--eh-frame-hdr'
> /usr/local/bin/ld: use the --help option for usage information
...

>   It seems that the toolchain is broken since it used gcc instead of
> ppc_82xx-gcc which caused error happen. I reinstalled the ELDK and not

You are wrong. This is one of the source files  which  gets  compiled
using the host's native compiler; the Makefile has this rule for it:

	conmakehash: conmakehash.c
		$(HOSTCC) $(HOSTCFLAGS) -o conmakehash conmakehash.c

> help. So what could be the problem? Some configuration changes?

Obviously your hostcompiler (gcc) and/or  you  host's  binutils  have
some problems. This is not a problem with the ELDK.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Wait!  You have not been prepared!
	-- Mr. Atoz, "Tomorrow is Yesterday", stardate 3113.2

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

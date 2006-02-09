Return-Path: <s.egbert@sbcglobal.net>
Received: from smtp107.sbc.mail.mud.yahoo.com (smtp107.sbc.mail.mud.yahoo.com
	[68.142.198.206]) by ozlabs.org (Postfix) with SMTP id 1D4E0679E1
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  9 Feb 2006 18:34:16 +1100 (EST)
Message-ID: <43EAF0B2.2070902@sbcglobal.net>
Date: Wed, 08 Feb 2006 23:35:14 -0800
From: "S. Egbert" <s.egbert@sbcglobal.net>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: eldk bug?how to fix 
References: 43B459C5.1060206@chello.nl
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> In message <43B459C5.1060206 at chello.nl> you wrote:
> >
> > I've seen these messages before. They were gone when I compiled > using
> > ppc_8xx-gcc compiler of a different ELDK version.
> > What version of ELDK are you using? Which gcc version?
>
> This has nothing to do with ELDK versions,  or  any  other  toolchain
> issues.
>
> > >[root at localhost atmlz]# ppc_6xx-gcc -c -o temp atm_aalx.c
> > >atm_aalx.c: In function `main':
> > >atm_aalx.c:201: warning: return type of `main' is not `int'
> > >/tmp/cciJlehe.s: Assembler messages:
> > >/tmp/cciJlehe.s:916: Error: unsupported relocation against r3
> ...
> > >         mfmsr r3
> > >         ori r3,r3,0x8000
> > >         andi. r3,r3,0xffbf
> > >         mtmsr r3
>
> It's a user only problem (using symbolic names like  "r3"  in  inline
> assember  statements  without  incuding  the  proper  header files to
> resolve thise names).

I had that exact same problem, ESPECIALLY when pulling in a fresh kernel
tree from kernel.org.

Fixed it by defining the CROSS_COMPILE environment variable or modifying
the Makefile's CROSS_COMPILE to the correct file prefix name, in your
case, it is probaly either

    # export CROSS_COMPILE=ppc_8xx-  (DENK gcc 3.3.3)
or
    # export CROSS_COMPILE=powerpc-linux-  (GNU gcc)

Check your PATH... make sure its picking up the right version...

  # whereis ppc_8xx-gcc

  # ppc_8xx-gcc --version
or
  # powerpc-linux-gcc --version


S. Egbert

To: =?iso-8859-1?Q?Andr=E9_L=E4mmer?= <alaemmer@fh-konstanz.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Compiling Kernel 2.6 for ppc32 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 09 Sep 2003 18:17:58 +0200."
             <000001c376ed$eef95430$0f21258d@fhkonstanz.de>
Date: Tue, 09 Sep 2003 19:30:49 +0200
Message-Id: <20030909173054.72C37C59E4@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <000001c376ed$eef95430$0f21258d@fhkonstanz.de> you wrote:
>
> I tried to compile the kernel 2.6. test 4 for PowerPC. I used the cross
> compile tool chain ELDK V2.1 from Denx http://www.denx.de/. I am not
> able to make the kernel, because I get the following error.
>
> In file included from include/asm/system.h:8,
>                  from include/linux/list.h:8,
>                  from include/linux/signal.h:4,
>                  from arch/ppc/kernel/asm-offsets.c:12:
> include/linux/kernel.h:10: stdarg.h: Datei oder Verzeichnis nicht
> gefunden In file included from include/asm/system.h:8,
...


In the top level Makefile, change the line

kbuild_2_4_nostdinc     := -nostdinc -iwithprefix include

into:

kbuild_2_4_nostdinc     := -nostdinc $(shell $(CC) -print-search-dirs | \
				sed -ne 's/install: \(.*\)/-I \1include/gp')


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Good manners are the settled  medium  of  social,  as  specie  is  of
commercial, life; returns are equally expected for both.
           - Lord Chesterfield _Letters to his Son_, 25 December 1753

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

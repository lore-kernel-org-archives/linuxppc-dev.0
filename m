From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Romain Dolbeau <dolbeau@irisa.fr>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: Trouble compiling 2.5.30 on old powermac
Date: Tue, 6 Aug 2002 14:45:42 +0200
Message-Id: <20020806124542.24275@192.168.4.1>
In-Reply-To: <3D4FBE55.71B00BF7@irisa.fr>
References: <3D4FBE55.71B00BF7@irisa.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>Hello all,
>
>first of all, a big thanks to all hackers for the 2.4.x
>releases that have been fine for me for a looong time :-)
>
>But to be able to port the "pm3fb" driver to 2.5, I need
>a 2.5.x kernel. None of those I tried compiled.
>Michel Dänzer suggested posting my problems here, so here
>it is.
>
>The box is an old 7500 upgraded with a 192Mhz 604e, running
>Debian (used to be "woody", now it's "sarge"). binutils come
>from Debian "sid" as I need the newer binutils for 2.5.
>Additional hardware include an old mac-flashed Matrox
>Millenium, and a Formac Proformance III video card (the one
>that need pm3fb).
>
>Source tree is linuxppc-2.5 from source.mvista.com,
>through rsync.
>
>1) at least 3 non-essential drivers cannot compile:
>   the mac serial port, the mac floppy drive, and the
>   external SCSI bus (53C94, MESH compiles). I can
>   provide the errors if they're needed.

Yup, I fixed MESH, Cuda, via-pmu, adb, but not macserial nor
swim3 nor 53c94 yet, those are on my todo list. As far as macserial
is concerned, I need to look into the new serial driver framework
made by Russel King and figure out enough of it to port the driver.

>2) arch/ppc/kernel/process.c fails with:
>#####
>  gcc -Wp,-MD,./.process.o.d -D__KERNEL__ -I/usr/src/linuxppc-2.5/include
>-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-
>strict-aliasing -fno-common -I/usr/src/linuxppc-2.5/arch/ppc -msoft-float
>-pipe -ffixed-r2
>-Wno-uninitialized -mmultiple -mstring -nostdinc -iwithprefix include
>-DKBUILD_BASENAME=process   -c -o process.o process.c
>process.c: In function `set_fpexc_mode':
>process.c:426: `PR_FP_EXC_PRECISE' undeclared (first use in this function)
>process.c:426: (Each undeclared identifier is reported only once
>process.c:426: for each function it appears in.)
>make[2]: *** [process.o] Error 1
>make[2]: Leaving directory `/usr/src/linuxppc-2.5/arch/ppc/kernel'
>#####

That's a new one. Paulus ? Incorrect merge ? Missing include ?

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

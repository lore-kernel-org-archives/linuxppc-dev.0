Return-Path: <rredondo@indra.es>
Received: from mailhost1.indra.es (unknown [213.170.46.108])
	by ozlabs.org (Postfix) with ESMTP id AB631689E0
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jan 2006 21:37:05 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: back trace when a SIGSEGV
Date: Tue, 17 Jan 2006 11:29:50 +0100
Message-ID: <6A28467355D2AD478D1F51C479415AE79BFAD4@MADTORMAIL.indra.es>
From: "Redondo Garcia, Roberto" <rredondo@indra.es>
Cc: "linuxppc-dev" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

my final solution has been to capture signal SIGSEGV in my own program
with a signal handler: =20

signal(SIGSEGV, to segv_handler; =20

and after generate backtrace in my program with the functions
"backtrace()" and "backtrace_symbols()" and write it to file. =20

Thanks

example to generate backtrace: =20
http://www.delorie.com/gnu/docs/glibc/libc_665.html=20

-----Mensaje original-----
De: Dustin Lang [mailto:dalang@cs.ubc.ca]=20
Enviado el: viernes, 02 de diciembre de 2005 15:28
Para: Redondo Garcia, Roberto
CC: linuxppc-dev
Asunto: Re: back trace when a SIGSEGV


Hi,

SIGSEGV (also known as a "segmentation fault" or "segfault") usually
means your program is doing something wrong like trying to dereference a
null pointer.  (ie, int* x =3D NULL; *x =3D 42;).  To track this down, yo=
u
can use "gdb" (the gnu debugger) - gnu.org.  Another option is
"valgrind" - valgrind.org - there is a PowerPC port (thanks, Paul!).

However, this mailing list is for _development_ of the linux _kernel_ on
PowerPC.  Your question is not about kernel development so it doesn't
belong here.  (Unless you are sure that your program is correct and
somehow the kernel is unfairly giving you a segfault - which doesn't
seem to be the case, based on your message.)  Find a mailing list or
message board about userspace programming and ask your question there.

Also, you should learn how to write a bug report.  Go to google.com,
type in "how to write a bug report", and read the first ten results.
(For
example: What program are you running?  Something you wrote?  What OS
are you using?  Why do you think the SIGSEGV is something caused by
someone else's code and not your own?  Why does it matter how long the
program runs before it crashes?  Why didn't you type "debug" into google
and see what came up?  (GDB is number 6!  Come on, get with it!))

Happy debugging!
dustin.

> hello,
> I have a program that when it has been several hours running, it has a

> problem and falls and it produces a SIGSEGV.  I would like to know to=20=

> how debug this error, because I do not have ulimit for generate core=20=

> dump o examine a back trace.
>
> thanks
-------------------------------------------------------------------------=
------------------------------------------
Este correo electr=F3nico y, en su caso, cualquier fichero anexo al mismo=
, contiene informaci=F3n de car=E1cter confidencial exclusivamente dirigi=
da a su destinatario o destinatarios. Queda prohibida su divulgaci=F3n, c=
opia o distribuci=F3n a terceros sin la previa autorizaci=F3n escrita de =
Indra. En el caso de haber recibido este correo electr=F3nico por error, =
se ruega notificar inmediatamente esta circunstancia mediante reenv=EDo a=
 la direcci=F3n electr=F3nica del remitente. POR FAVOR, ANTES DE IMPRIMIR=
 ESTE CORREO ELECTR=D3NICO CONSIDERE SU APORTACI=D3N A LA CONSERVACI=D3N =
DEL MEDIO AMBIENTE POR LA REDUCCI=D3N DE CONSUMO DE PAPEL.

The information in this e-mail and in any attachments is confidential and=
 solely for the attention and use of the named addressee(s). You are here=
by notified that any dissemination, distribution or copy of this communic=
ation is prohibited without the prior written consent of Indra. If you ha=
ve received this communication in error, please, notify the sender by rep=
ly e-mail. PLEASE CONSIDER YOUR ENVIRONMENTAL RESPONSIBILITY BEFORE PRINT=
ING THIS E-MAIL.

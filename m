Date: Thu, 15 Apr 1999 18:54:13 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Franz Sirl <Franz.Sirl@munich.netsurf.de>
cc: costabel@wanadoo.fr, Tom Rini <tmrini@ntplx.net>,
        linuxppc-dev@lists.linuxppc.org, bug-gnuplot@dartmouth.edu
Subject: Re: [Patch] linuxppc gnuplot segfaults in save
In-Reply-To: <4.2.0.32.19990415155955.03c13080@mail.lauterbach.com>
Message-ID: <Pine.HPP.3.96.990415183406.1720B-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Thu, 15 Apr 1999, Franz Sirl wrote:

> Hmm, there was a change long ago I think. AFAIR it was due to ABI issues, 
> but this has probably nothing to do with the bug in question here, which is 
> a clear compiler bug. While setting up the function prologue it uses a 
> variable which is not yet setup at this time. The net effect is that the 
> prologue uses different offsets from the SP than the rest of the function :-(.

Quite bad :-(

> BTW, Gabriel, the latest gas snapshots (990413/14) contain a PPC related 
> patch from you. Do you consider your patch a bugfix or an extension? I 
> currently use the 990403 snapshot for R5 and don't wanna upgrade again 
> before R5 release, unless it's a bugfix.

IMHO there was a bug and I fixed it: my copy if the SYSV ABI claims that
relocation type R_PPC_SECTOFF (value 33) is 16 bit wide and not 32.  I
needed it for some glue assembly code compiled with -mrelocatable option.
You may consider it as an obscure case: it was considered as 32 bit and
nobody noticed, AFAIK the compiler never generates this kind of relocation
(and when I upgrade to R5 I shall keep my copy of binutils around).

	Gabriel.


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]

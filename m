Date: Sat, 29 Jul 2000 17:59:30 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Gong Zhuo <gongzhuo@163.net>
cc: Linux PPC Mailing List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Can I debug interrupt under PPCbug?
In-Reply-To: <007101bff8fa$5c713a20$4607a8c0@LocalHost>
Message-ID: <Pine.HPX.4.10.10007291751001.9070-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Sat, 29 Jul 2000, Gong Zhuo wrote:

>
> Hi:
>   I'm debugging my program on MVME2600 using PPCBug. I have mapped all the
> memory which will be used by PPCBug 1:1 using PTE . Normal program can be
> debugged now. But can I debug my interrupt processing program such as
> Decrementer Exception?
>   It seems that 'rfi' instruction can't be used under PPCbug. Am I right?

Yes, rfi is impossible to debug unless you build a complete PPC virtual
machine. The reason is that PPCBUG itself uses SRR0/SRR1 (and some SPRG
registers but this is unrelated) and issues an rfi instruction every
time it executes th client program. Breakpoints/single step exceptions
also save the state in SRR0/SRR1. The net effect is that a move to
srr0/srr1 before an rfi is overwritten by the processor or the debugger
itself.

The only solution (AFAICT) is to set a breakpoint at the address pointed
to by srr0 and to avoid single stepping all the innstructions between
mtsrr0 or mtsrr1 (whichever comes first) and rfi. These are usually only
very few instructions but there is no simple way of debugging them.

I suspect you have a 604 or 750 processor, since there is no way to make
PPCBUG work with PTE on a 603 (the TLB software reload handlers that
you install will not be entered).

	Regards,
	Gabriel.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

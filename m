Date: Fri, 11 Feb 2000 18:30:06 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Benjamin Herrenschmidt <bh40@calva.net>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
        linuxppc-bk@fsmlabs.com
Subject: Re: Latest OpenPic changes
In-Reply-To: <Pine.LNX.4.05.10002111816100.356-100000@callisto.of.borg>
Message-ID: <Pine.HPX.4.10.10002111826230.1866-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Fri, 11 Feb 2000, Geert Uytterhoeven wrote:

> On Fri, 11 Feb 2000, Gabriel Paubert wrote:
> > On Fri, 11 Feb 2000, Geert Uytterhoeven wrote:
> > > After two days of hacking I finally found out what went wrong. Your changes to
> > > the OpenPIC code cause my machine to hang in openpic_enable_irq(). I added a
> > > timeout to the do { ... } while (...) loop:
> >
> > Please use ISU[irq - open_pic_irq_offset] everywhere. You are not reading
>
> Doh! I overlooked that one...

Note that there are still problems, some functions use check_arg_irq(irq)
and then use irq while othre use irq-open_pic_irq_offset after the same
check. I'm still trying to understand how it should work since I suspect
something is wrong given the behaviour of my nfsroot machines :-(

Oh and BTW there is a typo in the kernel.org sources:

		if ( !(_machine && (_MACH_gemini|_MACH_Pmac)) )

				^^
should be & otherwise the cascade interrupt will never be requested.

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

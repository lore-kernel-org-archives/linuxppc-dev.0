Return-Path: <dhbaird@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.182])
	by ozlabs.org (Postfix) with ESMTP id ECEB1DDF35
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  9 Jul 2008 03:12:09 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id n7so1569225wag.13
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 08 Jul 2008 10:12:08 -0700 (PDT)
Message-ID: <440abda90807081012g576f66e4p5fac6ae03470e7c8@mail.gmail.com>
Date: Tue, 8 Jul 2008 11:12:08 -0600
From: "David Baird" <dhbaird@gmail.com>
To: "Lorenzo T. Flores" <lorenzo@alphagolf.com>
Subject: Re: booting an ML405
In-Reply-To: <4872C4D0.4060006@alphagolf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <486D774A.7000102@alphagolf.com>
	<440abda90807031902u766eb4dby932e8741e947488e@mail.gmail.com>
	<4872C4D0.4060006@alphagolf.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, Jul 7, 2008 at 7:37 PM, Lorenzo T. Flores <lorenzo@alphagolf.com> wrote:
> If I stop the processor after it hangs:
>
> XMD% mrd 0xc0259fa4 10
> C0259FA4:   3C353E5B
> C0259FA8:   20202020
> C0259FAC:   302E3030
> C0259FB0:   30303030
> C0259FB4:   5D204C69
> C0259FB8:   6E757820
> C0259FBC:   76657273
> C0259FC0:   696F6E20
> C0259FC4:   322E362E
> C0259FC8:   32352D72

Since XMD is also a Tcl shell, you can easily download __log_buf like this:

    set fd [open xmd.log w]
    puts $fd [mrd  0xc0259fa4 10]

Then, with a little tweaking, you could use xxd or some other tool to
convert it to ASCII.

> If I cut off the 0xc0000000:
>
> XMD% mrd 0x259fa4 10
>  259FA4:   FFFFFFFF
>  259FA8:   FFFFFFFF
>  259FAC:   FFFFFFFF
>  259FB0:   FFFFFFFF
>  259FB4:   FFFFFFFF
>  259FB8:   FFFFFFFF
>  259FBC:   FFFFFFFF
>  259FC0:   FFFFFFFF
>  259FC4:   FFFFFFFF
>  259FC8:   FFFFFFFF

My guess is that if you issue a rst (reset) command, I think this will
take the processor out of virtual mode and then you can strip of the
0xc0000000.  But looks like you got what you need anyways, so no need
for this :-)

-David

Return-Path: <jcrigby@gmail.com>
Received: from xproxy.gmail.com (xproxy.gmail.com [66.249.82.194])
	by ozlabs.org (Postfix) with ESMTP id 57BC068AA8
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 Jan 2006 08:29:21 +1100 (EST)
Received: by xproxy.gmail.com with SMTP id s15so263161wxc
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 26 Jan 2006 13:29:20 -0800 (PST)
Message-ID: <4b73d43f0601261329n73971003n9217374a1cc2db6f@mail.gmail.com>
Date: Thu, 26 Jan 2006 14:29:18 -0700
From: John Rigby <jcrigby@gmail.com>
To: Sylvain Munaut <tnt@246tnt.com>
Subject: Re: [PATCH] Add support for lite5200b board.
In-Reply-To: <43D807E0.1090206@246tNt.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_29116_2405.1138310958960"
References: <43D65FE3.6080501@freescale.com> <43D66F54.8000404@246tNt.com>
	<43D751F8.9060204@aotek.es> <43D807E0.1090206@246tNt.com>
Cc: Txema Lopez <tlopez@aotek.es>, John Rigby <jrigby@freescale.com>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_29116_2405.1138310958960
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 1/25/06, Sylvain Munaut <tnt@246tnt.com> wrote:
>
>
>
> Should apply fine on vanilla. My suggestion for now is take vanilla,
> apply this patch, then the 2-3 patch from Andrey for BestComm and stuff.


I was working on getting bestcomm and fec working, but forward porting
my old 2.6.10 code to current is turning out to be more difficult than I
expected.
If you already have working code then I'll stop working on them.

Where are these patches?  I'm new to this list so I don't have much history=
.
Would I find these patches in the archive?


I haven't gotten around setup a git tree ... anyone know a good tutorial
> not only on how to checkout stuff but how to well manage a remote
> repository for publishing ?
>
>
> >> Looks good. But two comments :
> >>
> >> * Isn't a modif to the arch/ppc/platform/Makefile missing ?
> >> * What's the "cs-1" you turn on there :
> >>
> >>
> >>
> >>>
> >>> +#ifdef CONFIG_LITE5200B
> >>> +    /* turn on cs1 */
> >>> +    port_config |=3D 0x80000000;
> >>> +#endif
> >>>
> > What fix this ?
>
> It's to activate the second bank of DDR-SDRAM. However, I find that's
> the job of the bootloader. Fully initializing the memory subsystem is
> one of the few things the kernel expects, so I probably won't include
> this.



I agree completely.

My politics (at least for the 5200 stuff) is the boot loader should :
> * Init memory stuff like it wants (at least boot flash & all dynamic
> mem). The init of some static chipselect could be done in platform init.
> * Put the pin muxes & stuff to the "safest" mode (that is for example
> GPIO Input) execpt for what it requires for boot (like a console PSC and
> ethernet). All other pin mux (defnitive one) should be done in platform
> init depending on the board.
>
>
> >>     I couldn't find the schema / real-doc of the Lite5200b,
> >> is this available somewhere on-line ?
> >>
> > Sylvain, I don't know if there are some Lite5200b doc on line, but I
> > have the schematics and could send to you or to anyone who want it.
>
> Yes, please, I'd appreciate an early copy.
> John sent the link to the User Manual but the latter hasn't the full
> schematic.
>
>
>
> Sylvain
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>

------=_Part_29116_2405.1138310958960
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<br><br><div><span class=3D"gmail_quote">On 1/25/06, <b class=3D"gmail_send=
ername">Sylvain Munaut</b> &lt;<a href=3D"mailto:tnt@246tnt.com">tnt@246tnt=
.com</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" style=3D"border=
-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-lef=
t: 1ex;">
<br><br>Should apply fine on vanilla. My suggestion for now is take vanilla=
,<br>apply this patch, then the 2-3 patch from Andrey for BestComm and stuf=
f.</blockquote><div><br>I was working on getting bestcomm and fec working, =
but forward porting
<br>my old 2.6.10 code to current is turning out to be more difficult than =
I expected.<br>If you already have working code then I'll stop working on t=
hem.<br><br>Where are these patches?&nbsp; I'm new to this list so I don't =
have much history.
<br>Would I find these patches in the archive?<br>&nbsp;</div><br><blockquo=
te class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204)=
; margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">I haven't gotten around se=
tup a git tree ... anyone know a good tutorial
<br>not only on how to checkout stuff but how to well manage a remote<br>re=
pository for publishing ?<br><br><br>&gt;&gt; Looks good. But two comments =
:<br>&gt;&gt;<br>&gt;&gt; * Isn't a modif to the arch/ppc/platform/Makefile=
 missing ?
<br>&gt;&gt; * What's the &quot;cs-1&quot; you turn on there :<br>&gt;&gt;<=
br>&gt;&gt;<br>&gt;&gt;<br>&gt;&gt;&gt;<br>&gt;&gt;&gt; +#ifdef CONFIG_LITE=
5200B<br>&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;/* turn on cs1 */<br>&gt;&gt=
;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;port_config |=3D 0x80000000;
<br>&gt;&gt;&gt; +#endif<br>&gt;&gt;&gt;<br>&gt; What fix this ?<br><br>It'=
s to activate the second bank of DDR-SDRAM. However, I find that's<br>the j=
ob of the bootloader. Fully initializing the memory subsystem is<br>one of =
the few things the kernel expects, so I probably won't include this.
</blockquote><div><br><br>I agree completely. <br></div><br><blockquote cla=
ss=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); marg=
in: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">My politics (at least for the 52=
00 stuff) is the boot loader should :
<br> * Init memory stuff like it wants (at least boot flash &amp; all dynam=
ic<br>mem). The init of some static chipselect could be done in platform in=
it.<br> * Put the pin muxes &amp; stuff to the &quot;safest&quot; mode (tha=
t is for example
<br>GPIO Input) execpt for what it requires for boot (like a console PSC an=
d<br>ethernet). All other pin mux (defnitive one) should be done in platfor=
m<br>init depending on the board.<br><br><br>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbs=
p; I couldn't find the schema / real-doc of the Lite5200b,
<br>&gt;&gt; is this available somewhere on-line ?<br>&gt;&gt;<br>&gt; Sylv=
ain, I don't know if there are some Lite5200b doc on line, but I<br>&gt; ha=
ve the schematics and could send to you or to anyone who want it.<br><br>
Yes, please, I'd appreciate an early copy.<br>John sent the link to the Use=
r Manual but the latter hasn't the full<br>schematic.<br><br><br><br>Sylvai=
n<br>_______________________________________________<br>Linuxppc-embedded m=
ailing list
<br><a href=3D"mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlab=
s.org</a><br><a href=3D"https://ozlabs.org/mailman/listinfo/linuxppc-embedd=
ed">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a><br></blockquo=
te>
</div><br>

------=_Part_29116_2405.1138310958960--

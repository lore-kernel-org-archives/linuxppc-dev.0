Return-Path: <stephen.neuendorffer@gmail.com>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179]) by ozlabs.org (Postfix) with ESMTP id 3D48EB70B8
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 29 Nov 2010 14:35:46 +1100 (EST)
Received: by iwn6 with SMTP id 6so275599iwn.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 28 Nov 2010 19:35:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1290991094.32570.213.camel@pasglop>
References: <1283964082-30133-1-git-send-email-iws@ovro.caltech.edu>
	<1283964082-30133-4-git-send-email-iws@ovro.caltech.edu>
	<1290991094.32570.213.camel@pasglop>
Date: Sun, 28 Nov 2010 19:35:43 -0800
Message-ID: <AANLkTimTpJSsP=LM4MA_+uqtDj0-7a3b+xAb-r8ktuTF@mail.gmail.com>
Subject: Re: [PATCH 3/5] fpga: add basic CARMA board support
From: Stephen Neuendorffer <stephen.neuendorffer@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: multipart/alternative; boundary=0022152d622d5b9cf9049628c492
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	"Ira W. Snyder" <iws@ovro.caltech.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0022152d622d5b9cf9049628c492
Content-Type: text/plain; charset=ISO-8859-1

On Sun, Nov 28, 2010 at 4:38 PM, Benjamin Herrenschmidt <
benh@kernel.crashing.org> wrote:

> On Wed, 2010-09-08 at 09:41 -0700, Ira W. Snyder wrote:
> > This adds basic support for the system controller FPGA on the OVRO CARMA
> > board. This patch only adds infrastructure that will be used by later
> > drivers.
>
> Oh and another comment ...
>
> I'm not sure about drivers/fpga ... in the end, one would expect such a
> directory to contain stuff to manipulate FPGAs in the sense of
> downloading bitfiles, instanciating devices (device-tree manipulation ?)
> etc...
>
> From what I see in your code, the fact that these are FPGAs is almost
> irrelevant, you are providing support for "carma" devices, and such are
> no different than some other platform device, they just happen to be
> implemented as FPGAs. Or am I missing something ?
>
> Cheers,
> Ben.
>
>
Generally, I agree with this: There doesn't seem to be anything generic
about
the FPGA support you are adding, it seems very specific to the CARMA
hardware.

I'm generally not opposed to drivers/fpga: I think that colocating drivers
for things
that are basically FPGA compute platforms isn't necessarily a bad idea, but
I think it would be better if those devices were colocated because they
shared
some FPGA-oriented infrastructure, which this doesn't seem to do.
Currently,
generic infrastructure has been going into drivers/char, and drivers
themselves have
been going wherever they seem best.  Really what you have is 2 character
devices: one
for configuration, and one for access.

Steve

--0022152d622d5b9cf9049628c492
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Sun, Nov 28, 2010 at 4:38 PM, Benjami=
n Herrenschmidt <span dir=3D"ltr">&lt;<a href=3D"mailto:benh@kernel.crashin=
g.org">benh@kernel.crashing.org</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex;">
<div class=3D"im">On Wed, 2010-09-08 at 09:41 -0700, Ira W. Snyder wrote:<b=
r>
</div><div class=3D"im">&gt; This adds basic support for the system control=
ler FPGA on the OVRO CARMA<br>
&gt; board. This patch only adds infrastructure that will be used by later<=
br>
&gt; drivers.<br>
<br>
</div>Oh and another comment ...<br>
<br>
I&#39;m not sure about drivers/fpga ... in the end, one would expect such a=
<br>
directory to contain stuff to manipulate FPGAs in the sense of<br>
downloading bitfiles, instanciating devices (device-tree manipulation ?)<br=
>
etc...<br>
<br>
>From what I see in your code, the fact that these are FPGAs is almost<br>
irrelevant, you are providing support for &quot;carma&quot; devices, and su=
ch are<br>
no different than some other platform device, they just happen to be<br>
implemented as FPGAs. Or am I missing something ?<br>
<br>
Cheers,<br>
Ben.<br>
<div><div></div><div class=3D"h5"><br></div></div></blockquote><div>=A0</di=
v><div>Generally, I agree with this: There doesn&#39;t seem to be anything =
generic about</div><div>the FPGA support you are adding, it seems very spec=
ific to the CARMA hardware.</div>
<div><br></div><div>I&#39;m generally not opposed to drivers/fpga: I think =
that colocating drivers for things</div><div>that are basically FPGA comput=
e platforms isn&#39;t necessarily a bad idea, but</div><div>I think it woul=
d be better if those devices were colocated because they shared</div>
<div>some FPGA-oriented infrastructure, which this doesn&#39;t seem to do. =
=A0 Currently,</div><div>generic infrastructure has been going into drivers=
/char, and drivers themselves have</div><div>been going wherever they seem =
best. =A0Really what you have is 2 character devices: one</div>
<div>for configuration, and one for access.</div><div><br></div><div>Steve<=
/div></div>

--0022152d622d5b9cf9049628c492--

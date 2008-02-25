Return-Path: <m.louvel@gmail.com>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.231])
	by ozlabs.org (Postfix) with ESMTP id C25EEDDDF2
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 25 Feb 2008 21:42:58 +1100 (EST)
Received: by wx-out-0506.google.com with SMTP id h27so1545072wxd.15
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 25 Feb 2008 02:42:56 -0800 (PST)
Message-ID: <dda529d0802250242n228e3cc3sec9343285da057fd@mail.gmail.com>
Date: Mon, 25 Feb 2008 10:42:56 +0000
From: "maxime louvel" <m.louvel@gmail.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Subject: Re: 2.6.24 for mpc8458amc
In-Reply-To: <A0EDC255-48E2-4CDC-B768-C41D8274FFA0@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_8993_18918835.1203936176230"
References: <OF5ABF0D8A.75A05AE1-ONC12573F4.00426B12-C12573F4.0043B5F0@abengoa.com>
	<7CDED5EA-D72B-4D9F-A547-AC3B6A59F174@kernel.crashing.org>
	<dda529d0802200500k7cadc8afm4f9e8f04358aea0b@mail.gmail.com>
	<A0EDC255-48E2-4CDC-B768-C41D8274FFA0@kernel.crashing.org>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_8993_18918835.1203936176230
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I have updated the uboot on the cards and get the same result

AMC=> bootm 0x1000000
## Booting image at 01000000 ...
  Image Name:   Linux-2.6.24
  Image Type:   PowerPC Linux Kernel Image (gzip compressed)
  Data Size:    1802038 Bytes =  1.7 MB
  Load Address: 00000000
  Entry Point:  00000000
  Verifying Checksum ... OK
  Uncompressing Kernel Image ... OK

No further messages...

However I have try to boot an image (2.6.23-rc6 from freescale) which has
been patched for my platform and it works.
Thus the problem is not coming from the uboot anymore, but from something
else.
I can't get the source from freescale to see what they have changed because
their is some other stuff (unrelated with my problem or even my platform)
that are confidential to them...

So what I am looking for here is a hint of where to look, an idea of what I
might have done wrong...

regards,
Maxime

On Wed, Feb 20, 2008 at 1:53 PM, Kumar Gala <galak@kernel.crashing.org>
wrote:

>
> On Feb 20, 2008, at 7:00 AM, maxime louvel wrote:
>
> > Hi,
> >
> > yes It has something like 16550 UART.
> > the compiler version is gcc-3.4.3 with some specific stuff for the
> > platform.
> > I also have a gcc-4.1.2 vanilla which has been compiled with the
> > previous one. The 4.1.2 works if you tell it to emulate the floating
> > point instructions.
> >
> > thanks Scott,
> > without the treeboot-walnut it compiled
> >
> > I have still my first problem though:
> >
> > AMC=> bootm 0x1000000
> > ## Booting image at 01000000 ...
> >   Image Name:   Linux-2.6.24
> >   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
> >   Data Size:    1802038 Bytes =  1.7 MB
> >   Load Address: 00000000
> >   Entry Point:  00000000
> >   Verifying Checksum ... OK
> >   Uncompressing Kernel Image ... OK
> >
> > and nothing else...
> >
> > Any idea ?
> >
> > This may become from the fact that the uboot installed on the cards
> > is old and it apparently doesn't support the newer version of the
> > kernel image... (I have got that from an another mailing list)
>
> Yes, you'll either need to look at updating u-boot and including
> support for the device tree in it or look at the cuImage wrappers in
> arch/powerpc/boot as a mechanism to boot a kernel w/an old fw.
>
> - k
>



-- 
Maxime Louvel
0044 7964 5555 80
43 Allen road
Whitemore reans
WV60AW Wolverhampton
United Kingdom

------=_Part_8993_18918835.1203936176230
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,<br><br>I have updated the uboot on the cards and get the same result <br><br>AMC=&gt; bootm 0x1000000<br>## Booting image at 01000000 ...<br> &nbsp; Image Name: &nbsp; Linux-2.6.24<br> &nbsp; Image Type: &nbsp; PowerPC Linux Kernel Image (gzip compressed)<br>






 &nbsp; Data Size: &nbsp; &nbsp;1802038 Bytes = &nbsp;1.7 MB<br> &nbsp; Load Address: 00000000<br> &nbsp; Entry Point: &nbsp;00000000<br> &nbsp; Verifying Checksum ... OK<br> &nbsp; Uncompressing Kernel Image ... OK<br><br>No further messages...<br><br>However I have try to boot an image (2.6.23-rc6 from freescale) which has been patched for my platform and it works. <br>
Thus the problem is not coming from the uboot anymore, but from something else.<br>I can&#39;t get the source from freescale to see what they have changed because their is some other stuff (unrelated with my problem or even my platform) that are confidential to them...<br>
<br>So what I am looking for here is a hint of where to look, an idea of what I might have done wrong...<br><br>regards,<br>Maxime<br><br><div class="gmail_quote">On Wed, Feb 20, 2008 at 1:53 PM, Kumar Gala &lt;<a href="mailto:galak@kernel.crashing.org">galak@kernel.crashing.org</a>&gt; wrote:<br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div><div></div><div class="Wj3C7c"><br>
On Feb 20, 2008, at 7:00 AM, maxime louvel wrote:<br>
<br>
&gt; Hi,<br>
&gt;<br>
&gt; yes It has something like 16550 UART.<br>
&gt; the compiler version is gcc-3.4.3 with some specific stuff for the<br>
&gt; platform.<br>
&gt; I also have a gcc-4.1.2 vanilla which has been compiled with the<br>
&gt; previous one. The 4.1.2 works if you tell it to emulate the floating<br>
&gt; point instructions.<br>
&gt;<br>
&gt; thanks Scott,<br>
&gt; without the treeboot-walnut it compiled<br>
&gt;<br>
&gt; I have still my first problem though:<br>
&gt;<br>
&gt; AMC=&gt; bootm 0x1000000<br>
&gt; ## Booting image at 01000000 ...<br>
&gt; &nbsp; Image Name: &nbsp; Linux-2.6.24<br>
&gt; &nbsp; Image Type: &nbsp; PowerPC Linux Kernel Image (gzip compressed)<br>
&gt; &nbsp; Data Size: &nbsp; &nbsp;1802038 Bytes = &nbsp;1.7 MB<br>
&gt; &nbsp; Load Address: 00000000<br>
&gt; &nbsp; Entry Point: &nbsp;00000000<br>
&gt; &nbsp; Verifying Checksum ... OK<br>
&gt; &nbsp; Uncompressing Kernel Image ... OK<br>
&gt;<br>
&gt; and nothing else...<br>
&gt;<br>
&gt; Any idea ?<br>
&gt;<br>
&gt; This may become from the fact that the uboot installed on the cards<br>
&gt; is old and it apparently doesn&#39;t support the newer version of the<br>
&gt; kernel image... (I have got that from an another mailing list)<br>
<br>
</div></div>Yes, you&#39;ll either need to look at updating u-boot and including<br>
support for the device tree in it or look at the cuImage wrappers in<br>
arch/powerpc/boot as a mechanism to boot a kernel w/an old fw.<br>
<font color="#888888"><br>
- k<br>
</font></blockquote></div><br><br clear="all"><br>-- <br>Maxime Louvel<br>0044 7964 5555 80<br>43 Allen road<br>Whitemore reans<br>WV60AW Wolverhampton<br>United Kingdom

------=_Part_8993_18918835.1203936176230--

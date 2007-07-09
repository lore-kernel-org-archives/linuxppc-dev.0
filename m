Return-Path: <jcrigby@gmail.com>
Message-ID: <4b73d43f0707082055y2b96fa53td55d6b381b6fb0ef@mail.gmail.com>
Date: Sun, 8 Jul 2007 21:55:20 -0600
From: "John Rigby" <jcrigby@gmail.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [PATCH] Add USB support to mpc8349-mitx board port
In-Reply-To: <fa686aa40707071748g7f00f4c7jb761cceb7d72456d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_169949_27742325.1183953320935"
References: <20070706222909.19943.39455.stgit@trillian.secretlab.ca>
	<200707070148.20526.arnd@arndb.de>
	<fa686aa40707062246j71a347acje8559b7b6be9d38b@mail.gmail.com>
	<4b73d43f0707071734yeedd7e6g53101d45fbec899e@mail.gmail.com>
	<fa686aa40707071748g7f00f4c7jb761cceb7d72456d@mail.gmail.com>
Cc: Linuxppc-embedded <Linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_169949_27742325.1183953320935
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I see your point, I agree the two layers of glue is bad.  But this means
the double code is spread across many drivers instead of being in one
place (fsl_soc.c).

On 7/7/07, Grant Likely <grant.likely@secretlab.ca> wrote:
>
> On 7/7/07, John Rigby <jcrigby@gmail.com> wrote:
> > > This same comment probably goes for the other arch_initcall functions
> > > in fsl_soc.c which do exactly the same thing for other devices.
> >
> > This depends,  some devices in fsl_soc.c may exist on non-powerpc SoCs
> > that do not have OF.  The USB core in 8349 for example also is in the
> > arm based mx27 and mx31.  These devices should remain platform devices
> > and the glue in fls_soc.c will continure to be needed.
>
> I disagree; the current method is "glue for the glue".  There is no
> reason why the driver cannot have two bindings; one for
> platform_device and one for of_platform_device.  It's about the same
> amount of code, but uses less indirection for the device tree case.
>
> Cheers,
> g.
>
>
> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
> grant.likely@secretlab.ca
> (403) 399-0195
>

------=_Part_169949_27742325.1183953320935
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I see your point, I agree the two layers of glue is bad.&nbsp; But this means<br>the double code is spread across many drivers instead of being in one<br>place (fsl_soc.c).<br><br><div><span class="gmail_quote">On 7/7/07, <b class="gmail_sendername">
Grant Likely</b> &lt;<a href="mailto:grant.likely@secretlab.ca">grant.likely@secretlab.ca</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
On 7/7/07, John Rigby &lt;<a href="mailto:jcrigby@gmail.com">jcrigby@gmail.com</a>&gt; wrote:<br>&gt; &gt; This same comment probably goes for the other arch_initcall functions<br>&gt; &gt; in fsl_soc.c which do exactly the same thing for other devices.
<br>&gt;<br>&gt; This depends,&nbsp;&nbsp;some devices in fsl_soc.c may exist on non-powerpc SoCs<br>&gt; that do not have OF.&nbsp;&nbsp;The USB core in 8349 for example also is in the<br>&gt; arm based mx27 and mx31.&nbsp;&nbsp;These devices should remain platform devices
<br>&gt; and the glue in fls_soc.c will continure to be needed.<br><br>I disagree; the current method is &quot;glue for the glue&quot;.&nbsp;&nbsp;There is no<br>reason why the driver cannot have two bindings; one for<br>platform_device and one for of_platform_device.&nbsp;&nbsp;It&#39;s about the same
<br>amount of code, but uses less indirection for the device tree case.<br><br>Cheers,<br>g.<br><br><br>--<br>Grant Likely, B.Sc., P.Eng.<br>Secret Lab Technologies Ltd.<br><a href="mailto:grant.likely@secretlab.ca">grant.likely@secretlab.ca
</a><br>(403) 399-0195<br></blockquote></div><br>

------=_Part_169949_27742325.1183953320935--

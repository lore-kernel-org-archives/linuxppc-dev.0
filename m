Return-Path: <ralph.blach@gmail.com>
Received: from wx-out-0102.google.com (wx-out-0102.google.com [66.249.82.201])
	by ozlabs.org (Postfix) with ESMTP id 2E1E1679E6
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  8 May 2006 22:43:48 +1000 (EST)
Received: by wx-out-0102.google.com with SMTP id h29so788963wxd
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 08 May 2006 05:43:47 -0700 (PDT)
Message-ID: <b06339d40605080536u2b68eedya42531ad9761dc30@mail.gmail.com>
Date: Mon, 8 May 2006 08:36:43 -0400
From: "Ralph Blach" <ralph.blach@gmail.com>
To: "moris dong" <moris_dong@hotmail.com>
Subject: Re: Large Page Support, 2.6 kernel , PPC440
In-Reply-To: <BAY19-F90D433E50C500C4EF93CBF8B10@phx.gbl>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_38490_32197939.1147091803918"
References: <BAY19-F90D433E50C500C4EF93CBF8B10@phx.gbl>
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

------=_Part_38490_32197939.1147091803918
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Morris,

A long time ago, I did this for a 405 and it involves much more than just
changing the page shift.

>From my memory, I will give you what I think you have to do.
1)you must go into tlb handling code and change it.  That is in the
header file 44x.S i beleive.
2)You have to change the pte directory sizes
3)You have to chage the linker script.
4)You have to change the size of the zero page.
5)you have to chage dcache flush routines, to cover the new page size.
You have to find where 4096/4095 is hard coded as the page size and change
it.

This  is no small job, and what you come up with will be very unsupported.
I beleive If you pin the kerel TLB you might get
the performance you need and this should be in the kernel config scripts.

Good luck,

Chip

On 5/1/06, moris dong <moris_dong@hotmail.com> wrote:
>
> Friends,
> My PPC440 (32bit) MMU supports multiple page sizes.
> For the default 4K pages, my 2.6.11 kernel compiles and boots just fine.
> I want to re-build it with large pages, to improve my application
> performance.
> I tried modifying PAGE_SHIFT in "page.h" to 13 (8K pages) and re-build my
> kernel.
> Compilation worked out fine, but my kernel does NOT boot, nor it prints
> anything to the console.
>
> Has anyone successfully compiled & booted a 2.6 kernel with pages larger
> than 4K ?
> What am I doing wrong ?
>
> Thanks a lot.
>
> _________________________________________________________________
> Express yourself instantly with MSN Messenger! Download today it's FREE!
> http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>

------=_Part_38490_32197939.1147091803918
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Morris,<br><br>A long time ago, I did this for a 405 and it involves much m=
ore than just changing the page shift.<br><br>From my memory, I will give y=
ou what I think you have to do.<br>1)you must go into tlb handling code and=
 change it.&nbsp; That is in the=20
<br>header file 44x.S i beleive.<br>2)You have to change the pte directory =
sizes<br>3)You have to chage the linker script.<br>4)You have to change the=
 size of the zero page.<br>5)you have to chage dcache flush routines, to co=
ver the new page size.
<br>You have to find where 4096/4095 is hard coded as the page size and cha=
nge it.<br><br>This&nbsp; is no small job, and what you come up with will b=
e very unsupported.<br>I beleive If you pin the kerel TLB you might get <br=
>
the performance you need and this should be in the kernel config scripts.<b=
r><br>Good luck, <br><br>Chip<br><br><div><span class=3D"gmail_quote">On 5/=
1/06, <b class=3D"gmail_sendername">moris dong</b> &lt;<a href=3D"mailto:mo=
ris_dong@hotmail.com">
moris_dong@hotmail.com</a>&gt; wrote:</span><blockquote class=3D"gmail_quot=
e" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt =
0.8ex; padding-left: 1ex;">Friends,<br>My PPC440 (32bit) MMU supports multi=
ple page sizes.
<br>For the default 4K pages, my 2.6.11 kernel compiles and boots just fine=
.<br>I want to re-build it with large pages, to improve my application<br>p=
erformance.<br>I tried modifying PAGE_SHIFT in &quot;page.h&quot; to 13 (8K=
 pages) and re-build my
<br>kernel.<br>Compilation worked out fine, but my kernel does NOT boot, no=
r it prints<br>anything to the console.<br><br>Has anyone successfully comp=
iled &amp; booted a 2.6 kernel with pages larger<br>than 4K ?<br>What am I =
doing wrong ?
<br><br>Thanks a lot.<br><br>______________________________________________=
___________________<br>Express yourself instantly with MSN Messenger! Downl=
oad today it's FREE!<br><a href=3D"http://messenger.msn.click-url.com/go/on=
m00200471ave/direct/01/">
http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/</a><br><br>=
_______________________________________________<br>Linuxppc-embedded mailin=
g list<br><a href=3D"mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded=
@ozlabs.org
</a><br><a href=3D"https://ozlabs.org/mailman/listinfo/linuxppc-embedded">h=
ttps://ozlabs.org/mailman/listinfo/linuxppc-embedded</a><br></blockquote></=
div><br>

------=_Part_38490_32197939.1147091803918--

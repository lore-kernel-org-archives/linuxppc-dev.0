Return-Path: <skrishnakar@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id B4D74B7087
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 24 Jul 2009 06:31:43 +1000 (EST)
MIME-Version: 1.0
In-Reply-To: <13B0CDE8-B974-4CFA-A4B9-8AC4374B4694@kernel.crashing.org>
References: <6213bc560907210233l17aa3e75pcb7c20e3faa24195@mail.gmail.com>
	<2A0DDADE-5C3C-43F2-9487-98A8A735DC8D@kernel.crashing.org>
	<6213bc560907220838h49e5c273qa543e538bb37923a@mail.gmail.com>
	<578FBC09-589D-4691-82FF-985FCFE8ADC9@kernel.crashing.org>
	<6213bc560907220932u3b771af2q743ae55dda5a2198@mail.gmail.com>
	<13B0CDE8-B974-4CFA-A4B9-8AC4374B4694@kernel.crashing.org>
Date: Fri, 24 Jul 2009 02:01:40 +0530
Message-ID: <6213bc560907231331p188a7b32q7287e9fe777eaf18@mail.gmail.com>
Subject: Re: [LTP] msgctl10 fails on Powerpc Linux-2.6.29.6
From: srikanth krishnakar <skrishnakar@gmail.com>
To: Kumar Gala <galak@kernel.crashing.org>
Content-Type: multipart/alternative; boundary=000e0cd304700f327b046f65601a
Cc: Linuxppc-dev@ozlabs.org, Ltp-list@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--000e0cd304700f327b046f65601a
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On Thu, Jul 23, 2009 at 6:33 AM, Kumar Gala <galak@kernel.crashing.org>wrote:

>
> On Jul 22, 2009, at 11:32 AM, srikanth krishnakar wrote:
>
>
>>
>> On Wed, Jul 22, 2009 at 9:14 PM, Kumar Gala <galak@kernel.crashing.org>
>> wrote:
>>
>> On Jul 22, 2009, at 10:38 AM, srikanth krishnakar wrote:
>>
>>
>>
>> On Wed, Jul 22, 2009 at 8:52 PM, Kumar Gala <galak@kernel.crashing.org>
>> wrote:
>> I'm not seeing any BUG* in traps.c @ line 904.
>>
>>
>> On Jul 21, 2009, at 4:33 AM, srikanth krishnakar wrote:
>>
>> The LTP test case msgctl10.c fails on linux-2.6.29.6 for PowerPC
>> architecture (ppc440)
>>
>>
>> msgctl10    1  B------------[ cut here ]------------
>> kernel BUG at arch/powerpc/kernel/traps.c:904!
>> Oops: Exception in kernel mode, sig: 5 [#9]
>>
>> I'm not seeing any BUG* in traps.c @ line 904.  Do you have some other
>> patches on top of 2.6.29.6?
>>
>> - k
>>
>>
>> I have LTTng patches on top of linux-2.6.29.6.
>>
>> Does it modify traps.c?  Can you see what the code around line 904 looks
>> like and post that.
>>
>> - k
>>  896
>>  897 #if defined(CONFIG_XILINX_VIRTEX_5_FXT) && defined(CONFIG_PPC_FPU)
>>  898         if (reason & REASON_ILLEGAL) {
>>  899                 if (excep_state < 1) {
>>  900                         excep_state++;
>>  901                         return;
>>  902                 }
>>  903                 /* should never get here */
>>  904                 BUG();
>>  905         }
>>  906 #endif
>>  907
>>  908         /* Try to emulate it if we should. */
>>
>>
> Are you sure this is coming from the LTTng patches?  Which actual patch
> makes this change?
>
> - k
>
Thanks kumar,

I've got the patch out which fixes the issues. But now.. seems there is some
generic issue in PPC440 targets, I am observing that
*remap_file_pages01* and *remap_file_pages02  *test cases from LTP are
failing since *Linux-2.6.24* kernel to *Linux-2.6.30*. If you can give some
pointers that would be greatly appreciated ! Or if you have results for this
on any PPC44x would be helpful.

Arch : PowerPC
Target : Xilinx PowerPC440 virtex5

I've tried to test the cause for this but found that kernel throws error
message of "segmentation fault".

Thanks in Advance.

-Srikant



-- 
"The Good You Do, The Best You GET"

Regards
Srikanth Krishnakar
**********************

--000e0cd304700f327b046f65601a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Thu, Jul 23, 2009 at 6:33 AM, Kumar G=
ala <span dir=3D"ltr">&lt;<a href=3D"mailto:galak@kernel.crashing.org">gala=
k@kernel.crashing.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x;">
<div><div class=3D"h5"><br>
On Jul 22, 2009, at 11:32 AM, srikanth krishnakar wrote:<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<br>
<br>
On Wed, Jul 22, 2009 at 9:14 PM, Kumar Gala &lt;<a href=3D"mailto:galak@ker=
nel.crashing.org" target=3D"_blank">galak@kernel.crashing.org</a>&gt; wrote=
:<br>
<br>
On Jul 22, 2009, at 10:38 AM, srikanth krishnakar wrote:<br>
<br>
<br>
<br>
On Wed, Jul 22, 2009 at 8:52 PM, Kumar Gala &lt;<a href=3D"mailto:galak@ker=
nel.crashing.org" target=3D"_blank">galak@kernel.crashing.org</a>&gt; wrote=
:<br>
I&#39;m not seeing any BUG* in traps.c @ line 904.<br>
<br>
<br>
On Jul 21, 2009, at 4:33 AM, srikanth krishnakar wrote:<br>
<br>
The LTP test case msgctl10.c fails on linux-2.6.29.6 for PowerPC architectu=
re (ppc440)<br>
<br>
<br>
msgctl10 =A0 =A01 =A0B------------[ cut here ]------------<br>
kernel BUG at arch/powerpc/kernel/traps.c:904!<br>
Oops: Exception in kernel mode, sig: 5 [#9]<br>
<br>
I&#39;m not seeing any BUG* in traps.c @ line 904. =A0Do you have some othe=
r patches on top of 2.6.29.6?<br>
<br>
- k<br>
<br>
<br>
I have LTTng patches on top of linux-2.6.29.6.<br>
<br>
Does it modify traps.c? =A0Can you see what the code around line 904 looks =
like and post that.<br>
<br>
- k<br>
=A0896<br>
=A0897 #if defined(CONFIG_XILINX_VIRTEX_5_FXT) &amp;&amp; defined(CONFIG_PP=
C_FPU)<br>
=A0898 =A0 =A0 =A0 =A0 if (reason &amp; REASON_ILLEGAL) {<br>
=A0899 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (excep_state &lt; 1) {<br>
=A0900 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 excep_state++;<br>
=A0901 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;<br>
=A0902 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
=A0903 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* should never get here */<br>
=A0904 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 BUG();<br>
=A0905 =A0 =A0 =A0 =A0 }<br>
=A0906 #endif<br>
=A0907<br>
=A0908 =A0 =A0 =A0 =A0 /* Try to emulate it if we should. */<br>
<br>
</blockquote>
<br></div></div>
Are you sure this is coming from the LTTng patches? =A0Which actual patch m=
akes this change?<br><font color=3D"#888888">
<br>
- k<br>
</font></blockquote></div><div>Thanks kumar,<br></div><div><br></div><div>I=
&#39;ve got the patch out which fixes the issues. But now.. seems there is =
some generic issue in PPC440 targets, I am observing that=A0</div><div><str=
ong><font color=3D"#000000"><span style=3D"background-color: #ffff33;">rema=
p_file_pages01</span></font></strong> and <strong><span style=3D"background=
-color: #ffff00;">remap_file_pages02=A0<span style=3D"background-color: #ff=
ffff;">=A0</span></span></strong><span style=3D"background-color: #ffff00;"=
><span style=3D"background-color: #ffffff;">test cases from LTP are failing=
 since <strong>Linux-2.6.24</strong> kernel to <strong>Linux-2.6.30</strong=
>. If you can give some pointers that would be greatly appreciated ! Or if =
you have results for this on any PPC44x would be helpful.</span></span></di=
v>
<div><span style=3D"background-color: #ffff00;"><span style=3D"background-c=
olor: #ffffff;"><br></span></span></div><div><span style=3D"background-colo=
r: #ffff00;"><span style=3D"background-color: #ffffff;">Arch : PowerPC<br><=
/span></span></div>
<div><span style=3D"background-color: #ffff00;"><span style=3D"background-c=
olor: #ffffff;">Target : Xilinx PowerPC440 virtex5<br></span></span></div><=
div><span style=3D"background-color: #ffff00;"><span style=3D"background-co=
lor: #ffffff;"><br>
</span></span></div><div><span style=3D"background-color: #ffff00;"><span s=
tyle=3D"background-color: #ffffff;">I&#39;ve tried to test the cause for th=
is but found that kernel throws error message of &quot;segmentation fault&q=
uot;.<br>
</span></span></div><div><span style=3D"background-color: #ffff00;"><span s=
tyle=3D"background-color: #ffffff;"><br></span></span></div><div><span styl=
e=3D"background-color: #ffff00;"><span style=3D"background-color: #ffffff;"=
>Thanks in Advance.<br>
</span></span></div><div><span style=3D"background-color: #ffff00;"><span s=
tyle=3D"background-color: #ffffff;"><br></span></span></div><div><span styl=
e=3D"background-color: #ffff00;"><span style=3D"background-color: #ffffff;"=
>-Srikant<br>
</span></span></div><div><span style=3D"background-color: #ffff00;"><span s=
tyle=3D"background-color: #ffffff;"><br></span></span></div><br clear=3D"al=
l"><br>-- <br>&quot;The Good You Do, The Best You GET&quot;<br><br>Regards<=
br>
Srikanth Krishnakar<br>**********************<br>

--000e0cd304700f327b046f65601a--

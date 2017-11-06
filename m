Return-Path: <srs0=qcoh=ce=google.com=wak@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yVhjZ0FJdzDr8P
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Nov 2017 17:00:01 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3yVhjY4LC6z8sw8
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Nov 2017 17:00:01 +1100 (AEDT)
Received: from mail-pf0-x22f.google.com (mail-pf0-x22f.google.com
 [IPv6:2607:f8b0:400e:c00::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3yVhjX2hs1z9s7p
 for <linuxppc-dev@ozlabs.org>; Mon,  6 Nov 2017 16:59:59 +1100 (AEDT)
Received: by mail-pf0-x22f.google.com with SMTP id n89so6971628pfk.11
 for <linuxppc-dev@ozlabs.org>; Sun, 05 Nov 2017 21:59:59 -0800 (PST)
From: William Kennington <wak@google.com>
Message-Id: <4D745AF9-BB04-49BB-B743-B66F680992F1@google.com>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_81CFBCC3-74B3-4CF0-97BE-FA7FFB7D03C5"
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] powerpc/opal: Fix EBUSY bug in acquiring tokens
Date: Sun, 5 Nov 2017 21:59:06 -0800
In-Reply-To: <87zi825rsu.fsf@concordia.ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org,
 rlippert@google.com
To: Michael Ellerman <mpe@ellerman.id.au>
References: <20170922235800.19348-1-wak@google.com>
 <87zi825rsu.fsf@concordia.ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--Apple-Mail=_81CFBCC3-74B3-4CF0-97BE-FA7FFB7D03C5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On Nov 4, 2017, at 2:14 AM, Michael Ellerman <mpe@ellerman.id.au =
<mailto:mpe@ellerman.id.au>> wrote:
>=20
> "William A. Kennington III" <wak@google.com <mailto:wak@google.com>> =
writes:
>=20
>> The current code checks the completion map to look for the first =
token
>> that is complete. In some cases, a completion can come in but the =
token
>> can still be on lease to the caller processing the completion. If =
this
>> completed but unreleased token is the first token found in the bitmap =
by
>> another tasks trying to acquire a token, then the __test_and_set_bit
>> call will fail since the token will still be on lease. The =
acquisition
>> will then fail with an EBUSY.
>>=20
>> This patch reorganizes the acquisition code to look at the
>> opal_async_token_map for an unleased token. If the token has no lease =
it
>> must have no outstanding completions so we should never see an EBUSY,
>> unless we have leased out too many tokens. Since
>> opal_async_get_token_inrerruptible is protected by a semaphore, we =
will
>> practically never see EBUSY anymore.
>>=20
>> Signed-off-by: William A. Kennington III <wak@google.com =
<mailto:wak@google.com>>
>> ---
>> arch/powerpc/platforms/powernv/opal-async.c | 6 +++---
>> 1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> I think this is superseeded by Cyrils rework (which he's finally
> posted):
>=20
>  http://patchwork.ozlabs.org/patch/833630/ =
<http://patchwork.ozlabs.org/patch/833630/>
>=20
>=20
> If not please let us know.
>=20
> cheers

Yeah, I think Cyril=E2=80=99s rework fixes this. I wasn=E2=80=99t sure =
how long it would take for master to receive his changes so I figured we =
could use something in the interim to fix the locking failures. If his =
changes will be mailed into the next merge window then we should have =
the issue fixed in master. I understand that rework probably won=E2=80=99t=
 make it into stable kernels? If not then we should probably send this =
along to stable kernel maintainers.

- William=

--Apple-Mail=_81CFBCC3-74B3-4CF0-97BE-FA7FFB7D03C5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dutf-8"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;" =
class=3D""><div dir=3D"auto" style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;" =
class=3D""><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dutf-8" class=3D""><div style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;" =
class=3D""><br class=3D""><div class=3D""><blockquote type=3D"cite" =
class=3D""><div class=3D"">On Nov 4, 2017, at 2:14 AM, Michael Ellerman =
&lt;<a href=3D"mailto:mpe@ellerman.id.au" =
class=3D"">mpe@ellerman.id.au</a>&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">"William A. Kennington III" =
&lt;</span><a href=3D"mailto:wak@google.com" style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-size-adjust: auto; =
-webkit-text-stroke-width: 0px;" class=3D"">wak@google.com</a><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">&gt; writes:</span><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><br=
 style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""><blockquote type=3D"cite" style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-size-adjust: auto; =
-webkit-text-stroke-width: 0px;" class=3D"">The current code checks the =
completion map to look for the first token<br class=3D"">that is =
complete. In some cases, a completion can come in but the token<br =
class=3D"">can still be on lease to the caller processing the =
completion. If this<br class=3D"">completed but unreleased token is the =
first token found in the bitmap by<br class=3D"">another tasks trying to =
acquire a token, then the __test_and_set_bit<br class=3D"">call will =
fail since the token will still be on lease. The acquisition<br =
class=3D"">will then fail with an EBUSY.<br class=3D""><br class=3D"">This=
 patch reorganizes the acquisition code to look at the<br =
class=3D"">opal_async_token_map for an unleased token. If the token has =
no lease it<br class=3D"">must have no outstanding completions so we =
should never see an EBUSY,<br class=3D"">unless we have leased out too =
many tokens. Since<br class=3D"">opal_async_get_token_inrerruptible is =
protected by a semaphore, we will<br class=3D"">practically never see =
EBUSY anymore.<br class=3D""><br class=3D"">Signed-off-by: William A. =
Kennington III &lt;<a href=3D"mailto:wak@google.com" =
class=3D"">wak@google.com</a>&gt;<br class=3D"">---<br =
class=3D"">arch/powerpc/platforms/powernv/opal-async.c | 6 +++---<br =
class=3D"">1 file changed, 3 insertions(+), 3 deletions(-)<br =
class=3D""></blockquote><br style=3D"font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""><span style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; display: =
inline !important;" class=3D"">I think this is superseeded by Cyrils =
rework (which he's finally</span><br style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">posted):</span><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><br=
 style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""><span style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; float: none; display: inline =
!important;" class=3D"">&nbsp;</span><a =
href=3D"http://patchwork.ozlabs.org/patch/833630/" style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-size-adjust: auto; =
-webkit-text-stroke-width: 0px;" =
class=3D"">http://patchwork.ozlabs.org/patch/833630/</a><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><br=
 style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><br=
 style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""><span style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; float: none; display: inline =
!important;" class=3D"">If not please let us know.</span><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><br=
 style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""><span style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; float: none; display: inline =
!important;" class=3D"">cheers</span></div></blockquote></div><br =
class=3D""><div class=3D"">Yeah, I think Cyril=E2=80=99s rework fixes =
this. I wasn=E2=80=99t sure how long it would take for master to receive =
his changes so I figured we could use something in the interim to fix =
the locking failures. If his changes will be mailed into the next merge =
window then we should have the issue fixed in master. I understand that =
rework probably won=E2=80=99t make it into stable kernels? If not then =
we should probably send this along to stable kernel =
maintainers.</div><div class=3D""><br class=3D""></div><div class=3D"">- =
William</div></div></div></body></html>=

--Apple-Mail=_81CFBCC3-74B3-4CF0-97BE-FA7FFB7D03C5--

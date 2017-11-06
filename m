Return-Path: <srs0=qcoh=ce=google.com=wak@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yVhjp2j0FzDr8P
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Nov 2017 17:00:14 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3yVhjp2GLDz8v72
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Nov 2017 17:00:14 +1100 (AEDT)
Received: from mail-pf0-x234.google.com (mail-pf0-x234.google.com
 [IPv6:2607:f8b0:400e:c00::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3yVhjn5Qwpz9s7m
 for <linuxppc-dev@ozlabs.org>; Mon,  6 Nov 2017 17:00:13 +1100 (AEDT)
Received: by mail-pf0-x234.google.com with SMTP id e64so6970244pfk.9
 for <linuxppc-dev@ozlabs.org>; Sun, 05 Nov 2017 22:00:13 -0800 (PST)
Subject: Re: [PATCH] powerpc/opal: Fix EBUSY bug in acquiring tokens
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Content-Type: text/html; charset=utf-8
From: William Kennington <wak@google.com>
In-Reply-To: <87zi825rsu.fsf@concordia.ellerman.id.au>
Date: Sun, 5 Nov 2017 21:56:34 -0800
Cc: linuxppc-dev@ozlabs.org,
 rlippert@google.com
Message-Id: <4B427FF8-BC97-4BE2-8DC9-3BB47F0E3189@google.com>
References: <20170922235800.19348-1-wak@google.com>
 <87zi825rsu.fsf@concordia.ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

<html><head></head><body dir=3D"auto" style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;"><meta =
http-equiv=3D"Content-Type" content=3D"text/html charset=3Dutf-8"><div =
style=3D"word-wrap: break-word; -webkit-nbsp-mode: space; =
-webkit-line-break: after-white-space;" class=3D""><br =
class=3D""><div><blockquote type=3D"cite" class=3D""><div class=3D"">On =
Nov 4, 2017, at 2:14 AM, Michael Ellerman &lt;<a =
href=3D"mailto:mpe@ellerman.id.au" class=3D"">mpe@ellerman.id.au</a>&gt; =
wrote:</div><br class=3D"Apple-interchange-newline"><div class=3D""><span =
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
William</div></div></body></html>=

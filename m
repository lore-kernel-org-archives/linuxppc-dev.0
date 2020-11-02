Return-Path: <SRS0=b2NF=EI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B14D5C00A89
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2020 20:47:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B49CB204EC
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2020 20:47:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=storix-com.20150623.gappssmtp.com header.i=@storix-com.20150623.gappssmtp.com header.b="iE3QjFoD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B49CB204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=storix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CQ4jD1vQBzDqWZ
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Nov 2020 07:47:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=storix.com (client-ip=2607:f8b0:4864:20::d2d;
 helo=mail-io1-xd2d.google.com; envelope-from=cjacobsen@storix.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=storix.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=storix-com.20150623.gappssmtp.com
 header.i=@storix-com.20150623.gappssmtp.com header.a=rsa-sha256
 header.s=20150623 header.b=iE3QjFoD; dkim-atps=neutral
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CQ3zq2ZNMzDqQX
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Nov 2020 07:14:42 +1100 (AEDT)
Received: by mail-io1-xd2d.google.com with SMTP id s10so1912767ioe.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Nov 2020 12:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=storix-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:from:date:message-id:subject:to;
 bh=H4geEmwXafDDpnbgxnHCJ2fPSuTdmYc8sUKBC0JaHPc=;
 b=iE3QjFoD8T08cmuUh5QzXmLsybOxGyQ35oEmqm/fOHl6qXHabXsQwPnN/btpuxJ5wU
 cp7ZVWU8+JnEBd8lcPmu1HnMybq6+xbrMDYJWoSFNxqXO/H8y1MYFXDWCQPLi/KpxxJT
 JLxk8sNXArOQorhE2Ava88SrEJW0hqZIyNRonyBqSNaUjnJa0vyAFkYNelCCB0nav1hB
 rd8+bCqDR1cTylYvTM6mP+c1RBFIn1ch10UdKKst7cxgpOxJop47sSLz00vKuN9NDKAw
 C3D+MpLlqg3Cq9wiopxaW5aaQVBrag3YUIJZjI/aneoI1xFgoGRLNPzBNzsSVbODa4NK
 YVvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=H4geEmwXafDDpnbgxnHCJ2fPSuTdmYc8sUKBC0JaHPc=;
 b=sTi8iQRCVPgh7DmAgRvLUYstJx6ECYUZJGaT4uHw/C5f34fHtLF5vtklMve2uGOX9d
 blA1SVQMqewx9HKY/Jrki4J06Mxs+O+BRNmFJlPn8++SuAIfWzYos5Ykj0mb8jb2NX/m
 jH1jAk4GfALgby63PofR0SohuhDepVEZJU+YDm+8ihdx9jMy9iJ3mouHwaTPdhV5GF6W
 qEGQ4kBX53rIfWl2tUPzUM7ViTe6rnC+hc/ZMNOtUoiebM4D8Zr25eanjY2miPxQWehB
 Fh5tRozDiTyTar+GxX9JjXNKgqL+DVZxQXxEEz6nPwqWG01XyUZGgVjnYT+zKdb72yMD
 0vRA==
X-Gm-Message-State: AOAM532NrnCElXiO1HilIW/OZJX/PXQ1Rt3HldvG/pvtRtB4UFIu1/Q7
 9YHxJDMrRLcjVK5BsC4lGfm7eIEXhkF5vc0e5KECDul1/0GMwJCe
X-Google-Smtp-Source: ABdhPJznIn2jxL37XeHj14s68u2Sdl/bCgG2OLVAbC9QjNlZJA1HmRZ83lQC85TwiAAsjTmevGgbZAuYM9kzEGdk4J8=
X-Received: by 2002:a5d:9813:: with SMTP id a19mr11996353iol.194.1604348078470; 
 Mon, 02 Nov 2020 12:14:38 -0800 (PST)
MIME-Version: 1.0
From: Carl Jacobsen <cjacobsen@storix.com>
Date: Mon, 2 Nov 2020 12:14:27 -0800
Message-ID: <CAKkwB_S6Bs_+5At2aajbQbJg==WE_4NLdhSK=Bj+td67215Htg@mail.gmail.com>
Subject: Kernel panic from malloc() on SUSE 15.1?
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary="000000000000504a9a05b325656f"
X-Mailman-Approved-At: Tue, 03 Nov 2020 07:37:59 +1100
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

--000000000000504a9a05b325656f
Content-Type: text/plain; charset="UTF-8"

I've got a SUSE 15.1 install (on ppc64le) that kernel panics on a very
simple
test program, built in a slightly unusual way.

I'm compiling on SUSE 12, using gcc 4.8.3. I'm linking to a static
copy of libcrypto.a (from openssl-1.1.1g), built without threads.
I have a 10 line C test program that compiles and runs fine on the
SUSE 12 system. If I compile the same program on SUSE 15.1 (with
gcc 7.4.1), it runs fine on SUSE 15.1.

But, if I run the version that I compiled on SUSE 12, on the SUSE 15.1
system, the call to RAND_status() gets to a malloc() and then panics.
(And, of course, if I just compile a call to malloc(), that runs fine
on both systems.) Here's the test program, it's really just a call to
RAND_status():

    #include <stdio.h>
    #include <openssl/rand.h>

    int main(int argc, char **argv)
    {
        int has_enough_data = RAND_status();
        printf("The PRNG %s been seeded with enough data\n",
               has_enough_data ? "HAS" : "has NOT");
        return 0;
    }

openssl is configured/built with:
    ./config no-shared no-dso no-threads -fPIC -ggdb3 -debug -static
    make

and the test program is compiled with:
    gcc -ggdb3 -o rand_test rand_test.c libcrypto.a

The kernel on SUSE 12 is: 3.12.28-4-default
And glibc is: 2.19

The kernel on SUSE 15.1 is: 4.12.14-197.18-default
And glibc is: 2.26

In a previous iteration it was panicking in pthread_once(), so
I compiled openssl without pthreads support, and now it panics
calling malloc().

If I link to the system-supplied libcrypto.so, it works fine, and
running the same tests on x86_64 works fine, it's only ppc64le
that panics, and only running code from the old system on the
new one.

I'm trying to dig further down into this to come up with a standalone
test case, but I'm wondering if anything here stands out as a known
problem, or if someone can point me in the right direction.

Thanks,
Carl Jacobsen

--000000000000504a9a05b325656f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>I&#39;ve got a SUSE 15.1 install (on ppc64le) that ke=
rnel panics on a very simple<br>test program, built in a slightly unusual w=
ay.<br><br>I&#39;m compiling on SUSE 12, using gcc 4.8.3. I&#39;m linking t=
o a static<br>copy of libcrypto.a (from openssl-1.1.1g), built without thre=
ads.<br>I have a 10 line C test program that compiles and runs fine on the<=
br>SUSE 12 system. If I compile the same program on SUSE 15.1 (with</div><d=
iv>gcc 7.4.1), it runs fine on SUSE 15.1.<br><br>But, if I run the version =
that I compiled on SUSE 12, on the SUSE 15.1<br>system, the call to RAND_st=
atus() gets to a malloc() and then panics.<br>(And, of course, if I just co=
mpile a call to malloc(), that runs fine<br>on both systems.) Here&#39;s th=
e test program, it&#39;s really just a call to<br>RAND_status():<br><br>=C2=
=A0 =C2=A0 #include &lt;stdio.h&gt;<br>=C2=A0 =C2=A0 #include &lt;openssl/r=
and.h&gt;<br><br>=C2=A0 =C2=A0 int main(int argc, char **argv)<br>=C2=A0 =
=C2=A0 {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 int has_enough_data =3D RAND_status=
();<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 printf(&quot;The PRNG %s been seeded wit=
h enough data\n&quot;,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0has_enough_data ? &quot;HAS&quot; : &quot;has NOT&quot;);<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 return 0;<br>=C2=A0 =C2=A0 }<br><br>openssl is configu=
red/built with:<br>=C2=A0 =C2=A0 ./config no-shared no-dso no-threads -fPIC=
 -ggdb3 -debug -static<br>=C2=A0 =C2=A0 make<br><br>and the test program is=
 compiled with:<br>=C2=A0 =C2=A0 gcc -ggdb3 -o rand_test rand_test.c libcry=
pto.a<br><br>The kernel on SUSE 12 is: 3.12.28-4-default<br>And glibc is: 2=
.19<br><br>The kernel on SUSE 15.1 is: 4.12.14-197.18-default<br>And glibc =
is: 2.26<br><br>In a previous iteration it was panicking in pthread_once(),=
 so<br>I compiled openssl without pthreads support, and now it panics<br>ca=
lling malloc().<br><br>If I link to the system-supplied libcrypto.so, it wo=
rks fine, and<br>running the same tests on x86_64 works fine, it&#39;s only=
 ppc64le<br>that panics, and only running code from the old system on the</=
div><div>new one.<br><br>I&#39;m trying to dig further down into this to co=
me up with a standalone<br>test case, but I&#39;m wondering if anything her=
e stands out as a known<br>problem, or if someone can point me in the right=
 direction.<br><br>Thanks,<br>Carl Jacobsen</div></div>

--000000000000504a9a05b325656f--

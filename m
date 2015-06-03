Return-Path: <baolin.wang@linaro.org>
Received: from mail-yk0-f182.google.com (mail-yk0-f182.google.com
 [209.85.160.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2F6E11A005A
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jun 2015 12:13:26 +1000 (AEST)
Received: by ykfl8 with SMTP id l8so59645083ykf.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2015 19:13:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.11.1506022115240.20347@nanos>
References: <1433159093-4548-1-git-send-email-baolin.wang@linaro.org>
 <alpine.DEB.2.11.1506022115240.20347@nanos>
Date: Wed, 3 Jun 2015 10:13:24 +0800
Message-ID: <CAMz4ku+8unOm7EpZyurO+mzUywTJWJng_NFMAfcD8jPMHQAneg@mail.gmail.com>
Subject: Re: [PATCH v4 00/25] Convert the posix_clock_operations and k_clock
 structure to ready for 2038
From: Baolin Wang <baolin.wang@linaro.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>, John Stultz <john.stultz@linaro.org>,
 Heena Sirwani <heenasirwani@gmail.com>, Xunlei Pang <pang.xunlei@linaro.org>,
 peterz@infradead.org,
 rafael.j.wysocki@intel.com, gregkh@linuxfoundation.org,
 Richard Cochran <richardcochran@gmail.com>, benh@kernel.crashing.org,
 paulus@samba.org,
 mpe@ellerman.id.au, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
 linux390@de.ibm.com, rth@twiddle.net, riel@redhat.com, cl@linux.com,
 tj@kernel.org, =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
 Andrew Hunter <ahh@google.com>, Paul Turner <pjt@google.com>,
 linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Serge Hallyn <serge.hallyn@canonical.com>, james.l.morris@oracle.com,
 serge@hallyn.com,
 pmoore@redhat.com, tiwai@suse.de, Jeffrey Vander Stoep <jeffv@google.com>,
 Jeffrey Layton <jlayton@primarydata.com>, Kees Cook <keescook@chromium.org>,
 sds@tycho.nsa.gov,
 mark.d.rustad@intel.com, linux-security-module@vger.kernel.org,
 y2038 Mailman List <y2038@lists.linaro.org>
Content-Type: multipart/alternative; boundary=089e0122f52e8f71d60517939a3b
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--089e0122f52e8f71d60517939a3b
Content-Type: text/plain; charset=UTF-8

On 3 June 2015 at 03:20, Thomas Gleixner <tglx@linutronix.de> wrote:

> On Mon, 1 Jun 2015, Baolin Wang wrote:
>
> > This patch series changes the 32-bit time types (timespec/itimerspec) to
> > the 64-bit types (timespec64/itimerspec64), since 32-bit time types will
> > break in the year 2038.
>
> That's only true for 32bit systems.
>
> All in all the patch series looks rather reasonable now, except for
> the subject lines and the changelogs.
>
> The only technical objection I have is the macro conversion magic in
> patch #6. This can be done in a less cryptic and more efficient way.
>
> See the comments to the various patches and please apply them to all
> of the series.
>
> Thanks,
>
>         tglx
>
>
>
Hi Thomas,

Thanks for your comments, and i'll check and fix these problems.

-- 
Baolin.wang
Best Regards

--089e0122f52e8f71d60517939a3b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On 3 June 2015 at 03:20, Thomas Gleixner <span dir=3D"ltr">&lt;<a href=
=3D"mailto:tglx@linutronix.de" target=3D"_blank">tglx@linutronix.de</a>&gt;=
</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=3D"">On Mon, 1=
 Jun 2015, Baolin Wang wrote:<br>
<br>
</span><span class=3D"">&gt; This patch series changes the 32-bit time type=
s (timespec/itimerspec) to<br>
&gt; the 64-bit types (timespec64/itimerspec64), since 32-bit time types wi=
ll<br>
&gt; break in the year 2038.<br>
<br>
</span>That&#39;s only true for 32bit systems.<br>
<br>
All in all the patch series looks rather reasonable now, except for<br>
the subject lines and the changelogs.<br>
<br>
The only technical objection I have is the macro conversion magic in<br>
patch #6. This can be done in a less cryptic and more efficient way.<br>
<br>
See the comments to the various patches and please apply them to all<br>
of the series.<br>
<br>
Thanks,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 tglx<br>
<br>
<br>
</blockquote></div><br>Hi Thomas,</div><div class=3D"gmail_extra"><br></div=
><div class=3D"gmail_extra">Thanks for your comments, and i&#39;ll check an=
d fix these problems.<br clear=3D"all"><div><br></div>-- <br><div class=3D"=
gmail_signature"><div dir=3D"ltr"><div>Baolin.wang<br></div>Best Regards<br=
></div></div>
</div></div>

--089e0122f52e8f71d60517939a3b--

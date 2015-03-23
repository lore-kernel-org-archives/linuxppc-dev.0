Return-Path: <cusbrar1@gmail.com>
Received: from mail-wi0-x234.google.com (mail-wi0-x234.google.com
 [IPv6:2a00:1450:400c:c05::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43ABE1A2AA5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2015 10:29:34 +1100 (AEDT)
Received: by wixw10 with SMTP id w10so78282731wix.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2015 16:29:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150323230811.GA21966@oracle.com>
References: <20150322192726.GB19474@oracle.com>
 <20150323.122922.887448418154237329.davem@davemloft.net>
 <20150323165406.GG14061@oracle.com>
 <20150323.150508.149509757161802782.davem@davemloft.net>
 <1427149265.4770.238.camel@kernel.crashing.org>
 <20150323230811.GA21966@oracle.com>
Date: Mon, 23 Mar 2015 19:29:31 -0400
Message-ID: <CACwypyNS+U7cu6VKoFujVguHcCygcpbO8mzj5aFS-qkQALtg5Q@mail.gmail.com>
Subject: Re: Generic IOMMU pooled allocator
From: chase rayfield <cusbrar1@gmail.com>
To: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Content-Type: multipart/alternative; boundary=047d7b5d6592bd7c880511fd095c
Cc: aik@au1.ibm.com, aik@ozlabs.ru, anton@au1.ibm.com, paulus@samba.org,
 sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--047d7b5d6592bd7c880511fd095c
Content-Type: text/plain; charset=UTF-8

On Mar 23, 2015 7:13 PM, "Sowmini Varadhan" <sowmini.varadhan@oracle.com>
wrote:
>
> On (03/24/15 09:21), Benjamin Herrenschmidt wrote:
> >
> > So we have two choices here that I can see:
> >
> >  - Keep that old platform use the old/simpler allocator
>
> Problem with that approach is that the base "struct iommu" structure
> for sparc gets a split personality: the older one is used with
> the older allocator, and other ugly things ensue.  (alternatively,
> you end up duplicating a version of the code with the flush_all
> inlined).
>
> >  - Try to regain the bulk of that benefit with the new one
> >
> > Sowmini, I see various options for the second choice. We could stick to
> > 1 pool, and basically do as before, ie, if we fail on the first pass of
> > alloc, it means we wrap around and do a flush, I don't think that will
> > cause a significant degradation from today, do you ? We might have an
> > occasional additional flush but I would expect it to be in the noise.
>
> Isn't this essentially what I have in patch v5 here:
> http://www.spinics.net/lists/sparclinux/msg13534.html
>
> (the ops->reset is the flushall indirection, can be renamed if the
> latter is preferred)
>
> > Dave, what's your feeling there ? Does anybody around still have some
> > HW that we can test with ?
>
> I actually tested this on a V440 and a ultra45 (had a heck of a
> time finding these, since the owners keep them turned off because
> they are too noisy and consume too much power :-).

So we need tests then more than hw?.... I have an ultra1, ultra10 and t2000
I can test on if needed. And I'd appreciate my caches not being flushed
excessively on these boxes :-) too. I'll see if I can't get Gentoo on the
u10 tonight.

Also... It would be more "green" to make the code run faster on these boxes
than otherwise!

--047d7b5d6592bd7c880511fd095c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"><br>
On Mar 23, 2015 7:13 PM, &quot;Sowmini Varadhan&quot; &lt;<a href=3D"mailto=
:sowmini.varadhan@oracle.com">sowmini.varadhan@oracle.com</a>&gt; wrote:<br=
>
&gt;<br>
&gt; On (03/24/15 09:21), Benjamin Herrenschmidt wrote:<br>
&gt; &gt;<br>
&gt; &gt; So we have two choices here that I can see:<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 - Keep that old platform use the old/simpler allocator<br>
&gt;<br>
&gt; Problem with that approach is that the base &quot;struct iommu&quot; s=
tructure<br>
&gt; for sparc gets a split personality: the older one is used with<br>
&gt; the older allocator, and other ugly things ensue.=C2=A0 (alternatively=
,<br>
&gt; you end up duplicating a version of the code with the flush_all<br>
&gt; inlined).<br>
&gt;<br>
&gt; &gt;=C2=A0 - Try to regain the bulk of that benefit with the new one<b=
r>
&gt; &gt;<br>
&gt; &gt; Sowmini, I see various options for the second choice. We could st=
ick to<br>
&gt; &gt; 1 pool, and basically do as before, ie, if we fail on the first p=
ass of<br>
&gt; &gt; alloc, it means we wrap around and do a flush, I don&#39;t think =
that will<br>
&gt; &gt; cause a significant degradation from today, do you ? We might hav=
e an<br>
&gt; &gt; occasional additional flush but I would expect it to be in the no=
ise.<br>
&gt;<br>
&gt; Isn&#39;t this essentially what I have in patch v5 here:<br>
&gt; <a href=3D"http://www.spinics.net/lists/sparclinux/msg13534.html">http=
://www.spinics.net/lists/sparclinux/msg13534.html</a><br>
&gt;<br>
&gt; (the ops-&gt;reset is the flushall indirection, can be renamed if the<=
br>
&gt; latter is preferred)<br>
&gt;<br>
&gt; &gt; Dave, what&#39;s your feeling there ? Does anybody around still h=
ave some<br>
&gt; &gt; HW that we can test with ?<br>
&gt;<br>
&gt; I actually tested this on a V440 and a ultra45 (had a heck of a<br>
&gt; time finding these, since the owners keep them turned off because<br>
&gt; they are too noisy and consume too much power :-).</p>
<p dir=3D"ltr">So we need tests then more than hw?.... I have an ultra1, ul=
tra10 and t2000 I can test on if needed. And I&#39;d appreciate my caches n=
ot being flushed excessively on these boxes :-) too. I&#39;ll see if I can&=
#39;t get Gentoo on the u10 tonight.</p>
<p dir=3D"ltr">Also... It would be more &quot;green&quot; to make the code =
run faster on these boxes than otherwise! </p>

--047d7b5d6592bd7c880511fd095c--

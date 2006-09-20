Return-Path: <manoj.shar@gmail.com>
Received: from nz-out-0102.google.com (nz-out-0102.google.com [64.233.162.199])
	by ozlabs.org (Postfix) with ESMTP id 5D518679FB
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Sep 2006 08:31:56 +1000 (EST)
Received: by nz-out-0102.google.com with SMTP id i1so198702nzh
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Sep 2006 15:31:54 -0700 (PDT)
Message-ID: <d6dada100609201531oefd71ch8557067bbf77484e@mail.gmail.com>
Date: Wed, 20 Sep 2006 15:31:54 -0700
From: "Manoj Sharma" <manoj.shar@gmail.com>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Subject: Re: Hang with isync
In-Reply-To: <1158788111.6002.310.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_173761_18909486.1158791514624"
References: <d6dada100609181828j1804f4f5ic0d1dd8a225980c@mail.gmail.com>
	<d6dada100609191816q75d1455cobeb1e0bd21dab8a8@mail.gmail.com>
	<1158788111.6002.310.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_173761_18909486.1158791514624
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This is the stack trace.

Registers:
GPR00: 00069030 C01F3000 C01F1080 00000000 00048000 C0639F48 C01F1080
FFFFFC18
GPR08: C02203FC 00000020 C0638000 C01F31B0 42FEE022 1056A7F8 00FE502A
00000000
GPR16: 00000000 FFC44232 00000000 00000000 FFC441EC 00080000 00010000
0000000A
GPR24: 00000000 0007CD80 00000CE0 00000000 00000000 C02B0000 00000000
C02B0000

NIP; c0005da4 _<_nmask_and_or_msr+0x18/0x20 [kernel]>
Trace; c0025328 _<check_pgt_cache+0x20/0x30 [kernel]>
Trace; c0004f4c _<idled+0x58/0x70 [kernel]>
Trace; c0004f74 _<cpu_idle+0x10/0x24 [kernel]>
Trace; c00012b0 _<rest_init+0x30/0x40 [kernel]>
Trace; c02a45a4 _<start_kernel+0x168/0x17c [kernel]>
Trace; c0000250 _<skpinv+0x1f8/0x234 [kernel]>


On 9/20/06, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
> On Tue, 2006-09-19 at 18:16 -0700, Manoj Sharma wrote:
> >         Hi,
> >
> >         We use linux kernel 2.4.20 on ppc405 and the system hangs once
> >         in a while when isync gets called in this function:
> >
> >         _GLOBAL(_nmask_and_or_msr)
> >             mfmsr   r0      /* Get current msr */
> >             andc    r0,r0,r3    /* And off the bits set in r3 (first
> >         parm) */`
> >             or  r0,r0,r4    /* Or on the bits in r4 (second parm) */
> >             sync            /* Some chip revs have problems here... */
> >             isync
> >             mtmsr   r0      /* Update machine state */
> >             isync
> >             blr         /* Done */
> >
> >          2.5 onwards, I find that "sync; isync" has been replaced by a
> >         macro SYNC (defined only for 601). I don't find it in any
> >         changelog and reason for the change.
> >
> >         Can someone give some information on this change?
>
> Regardless of the change... on 2.4, _nmask_and_or_msr() was used for a
> number of things. We would need to know where it was called from with
> what values as arguments to have an idea of what's going wrong. It's
> probably not dying on the isync, but rather on the following mtmsr due
> to a problem with the values passed in....
>
> Ben.
>
>
>
>

------=_Part_173761_18909486.1158791514624
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This is the stack trace.<br><br>Registers:<br>GPR00: 00069030 C01F3000 C01F1080 00000000 00048000 C0639F48 C01F1080 FFFFFC18<br>GPR08: C02203FC 00000020 C0638000 C01F31B0 42FEE022 1056A7F8 00FE502A 00000000<br>GPR16: 00000000 FFC44232 00000000 00000000 FFC441EC 00080000 00010000 0000000A
<br>GPR24: 00000000 0007CD80 00000CE0 00000000 00000000 C02B0000 00000000 C02B0000<br><br>NIP; c0005da4 _&lt;_nmask_and_or_msr+0x18/0x20 [kernel]&gt;<br>Trace; c0025328 _&lt;check_pgt_cache+0x20/0x30 [kernel]&gt;<br>Trace; c0004f4c _&lt;idled+0x58/0x70 [kernel]&gt;
<br>Trace; c0004f74 _&lt;cpu_idle+0x10/0x24 [kernel]&gt;<br>Trace; c00012b0 _&lt;rest_init+0x30/0x40 [kernel]&gt;<br>Trace; c02a45a4 _&lt;start_kernel+0x168/0x17c [kernel]&gt;<br>Trace; c0000250 _&lt;skpinv+0x1f8/0x234 [kernel]&gt;
<br><br><br><div><span class="gmail_quote">On 9/20/06, <b class="gmail_sendername">Benjamin Herrenschmidt</b> &lt;<a href="mailto:benh@kernel.crashing.org">benh@kernel.crashing.org</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
On Tue, 2006-09-19 at 18:16 -0700, Manoj Sharma wrote:<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Hi,<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; We use linux kernel 2.4.20 on ppc405 and the system hangs once<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; in a while when isync gets called in this function:
<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; _GLOBAL(_nmask_and_or_msr)<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mfmsr&nbsp;&nbsp; r0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/* Get current msr */<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; andc&nbsp;&nbsp;&nbsp;&nbsp;r0,r0,r3&nbsp;&nbsp;&nbsp;&nbsp;/* And off the bits set in r3 (first<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; parm) */`<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; or&nbsp;&nbsp;r0,r0,r4&nbsp;&nbsp;&nbsp;&nbsp;/* Or on the bits in r4 (second parm) */
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sync&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/* Some chip revs have problems here... */<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; isync<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mtmsr&nbsp;&nbsp; r0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/* Update machine state */<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; isync<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; blr&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Done */
<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2.5 onwards, I find that &quot;sync; isync&quot; has been replaced by a<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; macro SYNC (defined only for 601). I don't find it in any<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; changelog and reason for the change.
<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Can someone give some information on this change?<br><br>Regardless of the change... on 2.4, _nmask_and_or_msr() was used for a<br>number of things. We would need to know where it was called from with
<br>what values as arguments to have an idea of what's going wrong. It's<br>probably not dying on the isync, but rather on the following mtmsr due<br>to a problem with the values passed in....<br><br>Ben.<br><br><br><br></blockquote>
</div><br>

------=_Part_173761_18909486.1158791514624--

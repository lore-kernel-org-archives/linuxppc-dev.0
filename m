Return-Path: <poonamindia@gmail.com>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.189])
	by ozlabs.org (Postfix) with ESMTP id 1B57FDDDFD
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Dec 2007 16:40:57 +1100 (EST)
Received: by rv-out-0910.google.com with SMTP id c27so1632770rvf.9
	for <linuxppc-dev@ozlabs.org>; Sun, 16 Dec 2007 21:40:56 -0800 (PST)
Message-ID: <90547c5e0712162140t339cdc48m8a915786d25d49a4@mail.gmail.com>
Date: Mon, 17 Dec 2007 11:10:56 +0530
From: "Poonam Aggrwal" <poonamindia@gmail.com>
To: "Timur Tabi" <timur@freescale.com>
Subject: Re: [PATCH 2/3] arch/ : Platform changes for UCC TDM driver for
	MPC8323ERDB.Also includes related QE changes.
In-Reply-To: <475D89E1.4040107@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_6894_18347370.1197870056078"
References: <Pine.LNX.4.64.0712101734490.29623@linux121>
	<475D89E1.4040107@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Poonam_Aggrwal-b10812 <b10812@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_6894_18347370.1197870056078
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thanx Tabi for your comments.
Sorry I was on leave for the last week, so could not reply in time.

Shall make the changes you suggested and repost the patch.

Regards
Poonam



On 12/11/07, Timur Tabi <timur@freescale.com> wrote:
>
> Poonam_Aggrwal-b10812 wrote:
>
> > +                     qe = of_find_node_by_type(NULL, "qe");
> > +                     if (qe) {
> > +                             unsigned int size;
> > +                             prop = of_get_property
> > +                                             (qe, "brg-frequency",
> &size);
> > +                             of_node_put(qe);
> > +                             of_node_put(brg);
> > +                             return *prop;
> > +                     }
>
> Only very recent versions of U-Boot set the brg-frequency property, so you
> need
> to check for situations where "*prop" is 0.  If it is, then you need to
> take the
> QE's bus-frequency property and divide it by two.  See my ucc_uart driver
> for an
> example.
>
> And PowerPC-specific patches should not be cross-posted to linux-kernel.
>
> --
> Timur Tabi
> Linux kernel developer at Freescale
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>

------=_Part_6894_18347370.1197870056078
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Thanx Tabi for your comments.</div>
<div>Sorry I was on leave for the last week, so could not reply in time.</div>
<div>&nbsp;</div>
<div>Shall make the changes you suggested and repost the patch.</div>
<div>&nbsp;</div>
<div>Regards</div>
<div>Poonam</div>
<div><br><br>&nbsp;</div>
<div><span class="gmail_quote">On 12/11/07, <b class="gmail_sendername">Timur Tabi</b> &lt;<a href="mailto:timur@freescale.com">timur@freescale.com</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Poonam_Aggrwal-b10812 wrote:<br><br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qe = of_find_node_by_type(NULL, &quot;qe&quot;);
<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (qe) {<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int size;<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prop = of_get_property<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (qe, &quot;brg-frequency&quot;, &amp;size);
<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; of_node_put(qe);<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; of_node_put(brg);<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return *prop;<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br><br>Only very recent versions of U-Boot set the brg-frequency property, so you need
<br>to check for situations where &quot;*prop&quot; is 0.&nbsp;&nbsp;If it is, then you need to take the<br>QE&#39;s bus-frequency property and divide it by two.&nbsp;&nbsp;See my ucc_uart driver for an<br>example.<br><br>And PowerPC-specific patches should not be cross-posted to linux-kernel.
<br><br>--<br>Timur Tabi<br>Linux kernel developer at Freescale<br>_______________________________________________<br>Linuxppc-dev mailing list<br><a href="mailto:Linuxppc-dev@ozlabs.org">Linuxppc-dev@ozlabs.org</a><br><a href="https://ozlabs.org/mailman/listinfo/linuxppc-dev">
https://ozlabs.org/mailman/listinfo/linuxppc-dev</a><br></blockquote></div><br>

------=_Part_6894_18347370.1197870056078--

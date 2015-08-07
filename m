Return-Path: <wschmidt@us.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D4AAD1A0075
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Aug 2015 15:55:46 +1000 (AEST)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <wschmidt@us.ibm.com>;
 Thu, 6 Aug 2015 23:55:44 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 771B119D8042
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Aug 2015 23:46:38 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t775teHX48169070
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Aug 2015 22:55:40 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t775teK4007749
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Aug 2015 23:55:40 -0600
In-Reply-To: <20150805041928.GA32178@gate.crashing.org>
References: <20150805140300.218ef661@kryten>
 <20150805041928.GA32178@gate.crashing.org>
Subject: Re: RFC: Reducing the number of non volatile GPRs in the ppc64 kernel
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Alan Modra <amodra@gmail.com>, Anton Blanchard <anton@samba.org>,
 linuxppc-dev@lists.ozlabs.org, Michael Gschwind <mkg@us.ibm.com>,
 paulus@samba.org, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>
Message-ID: <OFD0811845.CF7950C1-ON86257E9A.002065FB-C1257E9A.00208EE6@us.ibm.com>
From: Bill Schmidt <wschmidt@us.ibm.com>
Date: Fri, 7 Aug 2015 07:55:37 +0200
MIME-Version: 1.0
Content-type: multipart/related;
 Boundary="0__=09BBF409DFB3E36B8f9e8a93df938690918c09BBF409DFB3E36B"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0__=09BBF409DFB3E36B8f9e8a93df938690918c09BBF409DFB3E36B
Content-type: multipart/alternative;
	Boundary="1__=09BBF409DFB3E36B8f9e8a93df938690918c09BBF409DFB3E36B"

--1__=09BBF409DFB3E36B8f9e8a93df938690918c09BBF409DFB3E36B
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: quoted-printable


I agree with Segher.  We already know we have opportunities to do a bet=
ter
job with shrink-wrapping (pushing this kind of useless activity down pa=
st
early exits), so having examples of code to look at to improve this wou=
ld
be useful.

-- Bill

Bill Schmidt, Ph.D.
Linux on Power Toolchain
IBM Linux Technology Center
wschmidt@us.ibm.com   (507) 319-6873




From:	Segher Boessenkool <segher@kernel.crashing.org>
To:	Anton Blanchard <anton@samba.org>
Cc:	linuxppc-dev@lists.ozlabs.org, Michael
            Gschwind/Watson/IBM@IBMUS, Alan Modra <amodra@gmail.com>, B=
ill
            Schmidt/Rochester/IBM@IBMUS, Ulrich Weigand
            <Ulrich.Weigand@de.ibm.com>, paulus@samba.org
Date:	08/05/2015 06:20 AM
Subject:	Re: RFC: Reducing the number of non volatile GPRs in the ppc64=

            kernel



Hi Anton,

On Wed, Aug 05, 2015 at 02:03:00PM +1000, Anton Blanchard wrote:
> While looking at traces of kernel workloads, I noticed places where g=
cc
> used a large number of non volatiles. Some of these functions
> did very little work, and we spent most of our time saving the
> non volatiles to the stack and reading them back.

That is something that should be fixed in GCC -- do you have an example=

of such a function?

> It made me wonder if we have the right ratio of volatile to non
> volatile GPRs. Since the kernel is completely self contained, we coul=
d
> potentially change that ratio.
>
> Attached is a quick hack to gcc and the kernel to decrease the number=

> of non volatile GPRs to 8. I'm not sure if this is a good idea (and i=
f
> the volatile to non volatile ratio is right), but this gives us
> something to play with.

Instead of the GCC hack you can add a bunch of -fcall-used-r14 etc.
options; does that not work for you?


Segher


=

--1__=09BBF409DFB3E36B8f9e8a93df938690918c09BBF409DFB3E36B
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline
Content-transfer-encoding: quoted-printable

<html><body>
<p><font size=3D"2" face=3D"sans-serif">I agree with Segher. &nbsp;We a=
lready know we have opportunities to do a better job with shrink-wrappi=
ng (pushing this kind of useless activity down past early exits), so ha=
ving examples of code to look at to improve this would be useful.<br>
<br>
-- Bill<br>
<br>
Bill Schmidt, Ph.D.<br>
Linux on Power Toolchain<br>
IBM Linux Technology Center<br>
wschmidt@us.ibm.com &nbsp; (507) 319-6873<br>
</font><br>
<br>
<img width=3D"16" height=3D"16" src=3D"cid:1__=3D09BBF409DFB3E36B8f9e8a=
93df938@us.ibm.com" border=3D"0" alt=3D"Inactive hide details for Seghe=
r Boessenkool ---08/05/2015 06:20:02 AM---Hi Anton, On Wed, Aug 05, 201=
5 at 02:03:00PM +1000, An"><font size=3D"2" color=3D"#424282" face=3D"s=
ans-serif">Segher Boessenkool ---08/05/2015 06:20:02 AM---Hi Anton, On =
Wed, Aug 05, 2015 at 02:03:00PM +1000, Anton Blanchard wrote:</font><br=
>
<br>
<font size=3D"1" color=3D"#5F5F5F" face=3D"sans-serif">From:	</font><fo=
nt size=3D"1" face=3D"sans-serif">Segher Boessenkool &lt;segher@kernel.=
crashing.org&gt;</font><br>
<font size=3D"1" color=3D"#5F5F5F" face=3D"sans-serif">To:	</font><font=
 size=3D"1" face=3D"sans-serif">Anton Blanchard &lt;anton@samba.org&gt;=
</font><br>
<font size=3D"1" color=3D"#5F5F5F" face=3D"sans-serif">Cc:	</font><font=
 size=3D"1" face=3D"sans-serif">linuxppc-dev@lists.ozlabs.org, Michael =
Gschwind/Watson/IBM@IBMUS, Alan Modra &lt;amodra@gmail.com&gt;, Bill Sc=
hmidt/Rochester/IBM@IBMUS, Ulrich Weigand &lt;Ulrich.Weigand@de.ibm.com=
&gt;, paulus@samba.org</font><br>
<font size=3D"1" color=3D"#5F5F5F" face=3D"sans-serif">Date:	</font><fo=
nt size=3D"1" face=3D"sans-serif">08/05/2015 06:20 AM</font><br>
<font size=3D"1" color=3D"#5F5F5F" face=3D"sans-serif">Subject:	</font>=
<font size=3D"1" face=3D"sans-serif">Re: RFC: Reducing the number of no=
n volatile GPRs in the ppc64 kernel</font><br>
<hr width=3D"100%" size=3D"2" align=3D"left" noshade style=3D"color:#80=
91A5; "><br>
<br>
<br>
<tt><font size=3D"2">Hi Anton,<br>
<br>
On Wed, Aug 05, 2015 at 02:03:00PM +1000, Anton Blanchard wrote:<br>
&gt; While looking at traces of kernel workloads, I noticed places wher=
e gcc<br>
&gt; used a large number of non volatiles. Some of these functions<br>
&gt; did very little work, and we spent most of our time saving the<br>=

&gt; non volatiles to the stack and reading them back.<br>
<br>
That is something that should be fixed in GCC -- do you have an example=
<br>
of such a function?<br>
<br>
&gt; It made me wonder if we have the right ratio of volatile to non<br=
>
&gt; volatile GPRs. Since the kernel is completely self contained, we c=
ould<br>
&gt; potentially change that ratio.<br>
&gt; <br>
&gt; Attached is a quick hack to gcc and the kernel to decrease the num=
ber<br>
&gt; of non volatile GPRs to 8. I'm not sure if this is a good idea (an=
d if<br>
&gt; the volatile to non volatile ratio is right), but this gives us<br=
>
&gt; something to play with.<br>
<br>
Instead of the GCC hack you can add a bunch of -fcall-used-r14 etc.<br>=

options; does that not work for you?<br>
<br>
<br>
Segher<br>
<br>
</font></tt><br>
<br>
</body></html>=


--1__=09BBF409DFB3E36B8f9e8a93df938690918c09BBF409DFB3E36B--


--0__=09BBF409DFB3E36B8f9e8a93df938690918c09BBF409DFB3E36B
Content-type: image/gif;
	name="graycol.gif"
Content-Disposition: inline; filename="graycol.gif"
Content-ID: <1__=09BBF409DFB3E36B8f9e8a93df938@us.ibm.com>
Content-transfer-encoding: base64

R0lGODlhEAAQAKECAMzMzAAAAP///wAAACH5BAEAAAIALAAAAAAQABAAAAIXlI+py+0PopwxUbpu
ZRfKZ2zgSJbmSRYAIf4fT3B0aW1pemVkIGJ5IFVsZWFkIFNtYXJ0U2F2ZXIhAAA7

--0__=09BBF409DFB3E36B8f9e8a93df938690918c09BBF409DFB3E36B--

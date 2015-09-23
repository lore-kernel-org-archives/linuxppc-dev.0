Return-Path: <sawdey@us.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BF2121A0295
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2015 04:36:41 +1000 (AEST)
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sawdey@us.ibm.com>;
 Wed, 23 Sep 2015 12:36:38 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 46E273E4003F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2015 12:36:35 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8NIZXUx6226276
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2015 11:35:41 -0700
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8NIa25Z026715
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2015 12:36:02 -0600
Received: from d50lp02.ny.us.ibm.com (d50lp02.pok.ibm.com [146.89.104.208])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 t8NIa1JX026103
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2015 12:36:02 -0600
Message-Id: <201509231836.t8NIa1JX026103@d03av01.boulder.ibm.com>
Received: from /spool/local
 by d50lp02.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sawdey@us.ibm.com>;
 Wed, 23 Sep 2015 14:35:52 -0400
Received: from /spool/local
 by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
 for <linuxppc-dev@lists.ozlabs.org> from <sawdey@us.ibm.com>;
 Wed, 23 Sep 2015 18:35:48 -0000
In-Reply-To: <CAOJe8K3x56V1PNjo=TNMthqbPV1q_tKNBK6QvT=yCofR=qyt3g@mail.gmail.com>
Subject: Re: [PATCH] powerpc/vdso: Avoid link stack corruption in
 __get_datapage()
To: Denis Kirjanov <kda@linux-powerpc.org>
Cc: Anton Blanchard <anton@samba.org>, benh <benh@kernel.crashing.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Michael Ellerman
 <michael@ellerman.id.au>, Michael Neuling <mikey@neuling.org>,
 "Steve Munroe" <sjmunroe@us.ibm.com>
From: "Aaron Sawdey" <sawdey@us.ibm.com>
Date: Wed, 23 Sep 2015 13:35:43 -0500
References: <1442988302.31273.81.camel@neuling.org>
 <CAOJe8K3x56V1PNjo=TNMthqbPV1q_tKNBK6QvT=yCofR=qyt3g@mail.gmail.com>
Content-type: multipart/related;
 Boundary="0__=09BBF45ADFF6678E8f9e8a93df938690918c09BBF45ADFF6678E"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0__=09BBF45ADFF6678E8f9e8a93df938690918c09BBF45ADFF6678E
Content-type: multipart/alternative;
	Boundary="1__=09BBF45ADFF6678E8f9e8a93df938690918c09BBF45ADFF6678E"


--1__=09BBF45ADFF6678E8f9e8a93df938690918c09BBF45ADFF6678E
Content-Transfer-Encoding: quoted-printable
Content-type: text/plain; charset=US-ASCII


One thing that occurred to me was that since the =5F=5Fkernel=5Fdatapage=5F=
offset
is located immediately before the function, the offset is small and you
could get rid of the addi and just fold it into the lwz.


Aaron Sawdey, Ph.D.  sawdey@us.ibm.com
050-2/C113  (507) 253-7520 TL: 553-7520 home: 507/263-0782
IBM Linux Technology Center - PPC Toolchain



From:	Denis Kirjanov <kda@linux-powerpc.org>
To:	Michael Neuling <mikey@neuling.org>
Cc:	Michael Ellerman <michael@ellerman.id.au>, benh
            <benh@kernel.crashing.org>, Aaron Sawdey/Rochester/IBM@IBMUS,
            linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Anton Blanchard
            <anton@samba.org>, Steve Munroe/Rochester/IBM@IBMUS
Date:	09/23/2015 01:22 PM
Subject:	Re: [PATCH] powerpc/vdso: Avoid link stack corruption in
            =5F=5Fget=5Fdatapage()



On 9/23/15, Michael Neuling <mikey@neuling.org> wrote:
> The 32 and 64 bit variants of =5F=5Fget=5Fdatapage() use a "bcl; mflr" to
> determine the loaded address of the VDSO. The current version of these
> attempt to use the special bcl variant which avoids pushing to the
> link stack.
>
> Unfortunately it uses bcl+8 rather than the required bcl+4. Hence the
> current code results in link stack corruption and the resulting
> performance degradation (due to branch mis-prediction).
>
> This patch moves us to bcl+4 by moving =5F=5Fkernel=5Fdatapage=5Foffset
> out of =5F=5Fget=5Fdatapage().
>
> With this patch, running the below benchmark we get a bump in
> performance on POWER8 for gettimeofday() (which uses
> =5F=5Fget=5Fdatapage()).
>
> 64bit gets ~4% improvement:
>   Without patch:
>     # ./tb
>     time =3D 0.180321
>   With patch:
>     # ./tb
>     time =3D 0.187408
>
> 32bit gets ~9% improvement:
>   Without patch:
>     # ./tb
>     time =3D 0.276551
>   With patch:
>     # ./tb
>     time =3D 0.252767

I've got the following results on POWER7 64bit
without the patch:
# ./tb
time =3D 0.263337
# ./tb
time =3D 0.251273
# ./tb
time =3D 0.258453
# ./tb
time =3D 0.260189

with the patch:
# ./tb
time =3D 0.241517
# ./tb
time =3D 0.241973
# ./tb
time =3D 0.239365
# ./tb
time =3D 0.240109



>
> Testcase tb.c (stolen from Anton)
>   /* gcc -O2 tb.c -o tb */
>   #include <sys/time.h>
>   #include <stdio.h>
>
>   int main()
>   {
> 		   int i;
>
> 		   struct timeval tv=5Fstart, tv=5Fend;
>
> 		   gettimeofday(&tv=5Fstart, NULL);
>
> 		   for(i =3D 0; i < 10000000; i++) {
> 		 		   gettimeofday(&tv=5Fend, NULL);
> 		   }
>
> 		   printf("time =3D %.6f\n", tv=5Fend.tv=5Fsec - tv=5Fstart.tv=5Fsec +
(tv=5Fend.tv=5Fusec
> - tv=5Fstart.tv=5Fusec) * 1e-6);
>
> 		   return 0;
>   }
>
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> Reported-by: Aaron Sawdey <sawdey@us.ibm.com>
>
> diff --git a/arch/powerpc/kernel/vdso32/datapage.S
> b/arch/powerpc/kernel/vdso32/datapage.S
> index dc21e89..59cf5f4 100644
> --- a/arch/powerpc/kernel/vdso32/datapage.S
> +++ b/arch/powerpc/kernel/vdso32/datapage.S
> @@ -16,6 +16,10 @@
>  #include <asm/vdso.h>
>
>  		 .text
> +		 .global		 =5F=5Fkernel=5Fdatapage=5Foffset;
> +=5F=5Fkernel=5Fdatapage=5Foffset:
> +		 .long		 0
> +
>  V=5FFUNCTION=5FBEGIN(=5F=5Fget=5Fdatapage)
>    .cfi=5Fstartproc
>  		 /* We don't want that exposed or overridable as we want other
objects
> @@ -27,13 +31,11 @@ V=5FFUNCTION=5FBEGIN(=5F=5Fget=5Fdatapage)
>  		 mflr		 r0
>    .cfi=5Fregister lr,r0
>
> -		 bcl		 20,31,1f
> -		 .global		 =5F=5Fkernel=5Fdatapage=5Foffset;
> -=5F=5Fkernel=5Fdatapage=5Foffset:
> -		 .long		 0
> -1:
> +		 bcl		 20,31,data=5Fpage=5Fbranch
> +data=5Fpage=5Fbranch:
>  		 mflr		 r3
>  		 mtlr		 r0
> +		 addi		 r3, r3, =5F=5Fkernel=5Fdatapage=5Foffset-data=5Fpage=5Fbranch
>  		 lwz		 r0,0(r3)
>  		 add		 r3,r0,r3
>  		 blr
> diff --git a/arch/powerpc/kernel/vdso64/datapage.S
> b/arch/powerpc/kernel/vdso64/datapage.S
> index 79796de..2f01c4a 100644
> --- a/arch/powerpc/kernel/vdso64/datapage.S
> +++ b/arch/powerpc/kernel/vdso64/datapage.S
> @@ -16,6 +16,10 @@
>  #include <asm/vdso.h>
>
>  		 .text
> +.global		 =5F=5Fkernel=5Fdatapage=5Foffset;
> +=5F=5Fkernel=5Fdatapage=5Foffset:
> +		 .long		 0
> +
>  V=5FFUNCTION=5FBEGIN(=5F=5Fget=5Fdatapage)
>    .cfi=5Fstartproc
>  		 /* We don't want that exposed or overridable as we want other
objects
> @@ -27,13 +31,11 @@ V=5FFUNCTION=5FBEGIN(=5F=5Fget=5Fdatapage)
>  		 mflr		 r0
>    .cfi=5Fregister lr,r0
>
> -		 bcl		 20,31,1f
> -		 .global		 =5F=5Fkernel=5Fdatapage=5Foffset;
> -=5F=5Fkernel=5Fdatapage=5Foffset:
> -		 .long		 0
> -1:
> +		 bcl		 20,31,data=5Fpage=5Fbranch
> +data=5Fpage=5Fbranch:
>  		 mflr		 r3
>  		 mtlr		 r0
> +		 addi		 r3, r3, =5F=5Fkernel=5Fdatapage=5Foffset-data=5Fpage=5Fbranch
>  		 lwz		 r0,0(r3)
>  		 add		 r3,r0,r3
>  		 blr
>
>
> =5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev




--1__=09BBF45ADFF6678E8f9e8a93df938690918c09BBF45ADFF6678E
Content-Transfer-Encoding: quoted-printable
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline

<html><body><p>One thing that occurred to me was that since the =5F=5Fkerne=
l=5Fdatapage=5Foffset is located immediately before the function, the offse=
t is small and you could get rid of the addi and just fold it into the lwz.=
<br><br><br>Aaron Sawdey, Ph.D.  sawdey@us.ibm.com<br>050-2/C113  (507) 253=
-7520 TL: 553-7520 home: 507/263-0782<br>IBM Linux Technology Center - PPC =
Toolchain<br><br><img width=3D"16" height=3D"16" src=3D"cid:1=5F=5F=3D09BBF=
45ADFF6678E8f9e8a93df938690918c09B@" border=3D"0" alt=3D"Inactive hide deta=
ils for Denis Kirjanov ---09/23/2015 01:22:39 PM---On 9/23/15, Michael Neul=
ing &lt;mikey@neuling.org&gt; wrote: &gt; T"><font color=3D"#424282">Denis =
Kirjanov ---09/23/2015 01:22:39 PM---On 9/23/15, Michael Neuling &lt;mikey@=
neuling.org&gt; wrote: &gt; The 32 and 64 bit variants of =5F=5Fget=5Fdatap=
ag</font><br><br><font size=3D"2" color=3D"#5F5F5F">From:        </font><fo=
nt size=3D"2">Denis Kirjanov &lt;kda@linux-powerpc.org&gt;</font><br><font =
size=3D"2" color=3D"#5F5F5F">To:        </font><font size=3D"2">Michael Neu=
ling &lt;mikey@neuling.org&gt;</font><br><font size=3D"2" color=3D"#5F5F5F"=
>Cc:        </font><font size=3D"2">Michael Ellerman &lt;michael@ellerman.i=
d.au&gt;, benh &lt;benh@kernel.crashing.org&gt;, Aaron Sawdey/Rochester/IBM=
@IBMUS, linuxppc-dev &lt;linuxppc-dev@lists.ozlabs.org&gt;, Anton Blanchard=
 &lt;anton@samba.org&gt;, Steve Munroe/Rochester/IBM@IBMUS</font><br><font =
size=3D"2" color=3D"#5F5F5F">Date:        </font><font size=3D"2">09/23/201=
5 01:22 PM</font><br><font size=3D"2" color=3D"#5F5F5F">Subject:        </f=
ont><font size=3D"2">Re: [PATCH] powerpc/vdso: Avoid link stack corruption =
in =5F=5Fget=5Fdatapage()</font><br><hr width=3D"100%" size=3D"2" align=3D"=
left" noshade style=3D"color:#8091A5; "><br><br><br><tt>On 9/23/15, Michael=
 Neuling &lt;mikey@neuling.org&gt; wrote:<br>&gt; The 32 and 64 bit variant=
s of =5F=5Fget=5Fdatapage() use a &quot;bcl; mflr&quot; to<br>&gt; determin=
e the loaded address of the VDSO. The current version of these<br>&gt; atte=
mpt to use the special bcl variant which avoids pushing to the<br>&gt; link=
 stack.<br>&gt;<br>&gt; Unfortunately it uses bcl+8 rather than the require=
d bcl+4. Hence the<br>&gt; current code results in link stack corruption an=
d the resulting<br>&gt; performance degradation (due to branch mis-predicti=
on).<br>&gt;<br>&gt; This patch moves us to bcl+4 by moving =5F=5Fkernel=5F=
datapage=5Foffset<br>&gt; out of =5F=5Fget=5Fdatapage().<br>&gt;<br>&gt; Wi=
th this patch, running the below benchmark we get a bump in<br>&gt; perform=
ance on POWER8 for gettimeofday() (which uses<br>&gt; =5F=5Fget=5Fdatapage(=
)).<br>&gt;<br>&gt; 64bit gets ~4% improvement:<br>&gt; &nbsp; Without patc=
h:<br>&gt; &nbsp; &nbsp; # ./tb<br>&gt; &nbsp; &nbsp; time =3D 0.180321<br>=
&gt; &nbsp; With patch:<br>&gt; &nbsp; &nbsp; # ./tb<br>&gt; &nbsp; &nbsp; =
time =3D 0.187408<br>&gt;<br>&gt; 32bit gets ~9% improvement:<br>&gt; &nbsp=
; Without patch:<br>&gt; &nbsp; &nbsp; # ./tb<br>&gt; &nbsp; &nbsp; time =
=3D 0.276551<br>&gt; &nbsp; With patch:<br>&gt; &nbsp; &nbsp; # ./tb<br>&gt=
; &nbsp; &nbsp; time =3D 0.252767<br><br>I've got the following results on =
POWER7 64bit<br>without the patch:<br># ./tb<br>time =3D 0.263337<br># ./tb=
<br>time =3D 0.251273<br># ./tb<br>time =3D 0.258453<br># ./tb<br>time =3D =
0.260189<br><br>with the patch:<br># ./tb<br>time =3D 0.241517<br># ./tb<br=
>time =3D 0.241973<br># ./tb<br>time =3D 0.239365<br># ./tb<br>time =3D 0.2=
40109<br><br><br><br>&gt;<br>&gt; Testcase tb.c (stolen from Anton)<br>&gt;=
 &nbsp; /* gcc -O2 tb.c -o tb */<br>&gt; &nbsp; #include &lt;sys/time.h&gt;=
<br>&gt; &nbsp; #include &lt;stdio.h&gt;<br>&gt;<br>&gt; &nbsp; int main()<=
br>&gt; &nbsp; {<br>&gt;                  &nbsp; int i;<br>&gt;<br>&gt;    =
              &nbsp; struct timeval tv=5Fstart, tv=5Fend;<br>&gt;<br>&gt;  =
                &nbsp; gettimeofday(&amp;tv=5Fstart, NULL);<br>&gt;<br>&gt;=
                  &nbsp; for(i =3D 0; i &lt; 10000000; i++) {<br>&gt;      =
                             &nbsp; gettimeofday(&amp;tv=5Fend, NULL);<br>&=
gt;                  &nbsp; }<br>&gt;<br>&gt;                  &nbsp; print=
f(&quot;time =3D %.6f\n&quot;, tv=5Fend.tv=5Fsec - tv=5Fstart.tv=5Fsec + (t=
v=5Fend.tv=5Fusec<br>&gt; - tv=5Fstart.tv=5Fusec) * 1e-6);<br>&gt;<br>&gt; =
                 &nbsp; return 0;<br>&gt; &nbsp; }<br>&gt;<br>&gt; Signed-o=
ff-by: Michael Neuling &lt;mikey@neuling.org&gt;<br>&gt; Reported-by: Aaron=
 Sawdey &lt;sawdey@us.ibm.com&gt;<br>&gt;<br>&gt; diff --git a/arch/powerpc=
/kernel/vdso32/datapage.S<br>&gt; b/arch/powerpc/kernel/vdso32/datapage.S<b=
r>&gt; index dc21e89..59cf5f4 100644<br>&gt; --- a/arch/powerpc/kernel/vdso=
32/datapage.S<br>&gt; +++ b/arch/powerpc/kernel/vdso32/datapage.S<br>&gt; @=
@ -16,6 +16,10 @@<br>&gt; &nbsp;#include &lt;asm/vdso.h&gt;<br>&gt;<br>&gt;=
 &nbsp;                 .text<br>&gt; +                 .global            =
     =5F=5Fkernel=5Fdatapage=5Foffset;<br>&gt; +=5F=5Fkernel=5Fdatapage=5Fo=
ffset:<br>&gt; +                 .long                 0<br>&gt; +<br>&gt; =
&nbsp;V=5FFUNCTION=5FBEGIN(=5F=5Fget=5Fdatapage)<br>&gt; &nbsp; &nbsp;.cfi=
=5Fstartproc<br>&gt; &nbsp;                 /* We don't want that exposed o=
r overridable as we want other objects<br>&gt; @@ -27,13 +31,11 @@ V=5FFUNC=
TION=5FBEGIN(=5F=5Fget=5Fdatapage)<br>&gt; &nbsp;                 mflr     =
            r0<br>&gt; &nbsp; &nbsp;.cfi=5Fregister lr,r0<br>&gt;<br>&gt; -=
                 bcl                 20,31,1f<br>&gt; -                 .gl=
obal                 =5F=5Fkernel=5Fdatapage=5Foffset;<br>&gt; -=5F=5Fkerne=
l=5Fdatapage=5Foffset:<br>&gt; -                 .long                 0<br=
>&gt; -1:<br>&gt; +                 bcl                 20,31,data=5Fpage=
=5Fbranch<br>&gt; +data=5Fpage=5Fbranch:<br>&gt; &nbsp;                 mfl=
r                 r3<br>&gt; &nbsp;                 mtlr                 r0=
<br>&gt; +                 addi                 r3, r3, =5F=5Fkernel=5Fdata=
page=5Foffset-data=5Fpage=5Fbranch<br>&gt; &nbsp;                 lwz      =
           r0,0(r3)<br>&gt; &nbsp;                 add                 r3,r=
0,r3<br>&gt; &nbsp;                 blr<br>&gt; diff --git a/arch/powerpc/k=
ernel/vdso64/datapage.S<br>&gt; b/arch/powerpc/kernel/vdso64/datapage.S<br>=
&gt; index 79796de..2f01c4a 100644<br>&gt; --- a/arch/powerpc/kernel/vdso64=
/datapage.S<br>&gt; +++ b/arch/powerpc/kernel/vdso64/datapage.S<br>&gt; @@ =
-16,6 +16,10 @@<br>&gt; &nbsp;#include &lt;asm/vdso.h&gt;<br>&gt;<br>&gt; &=
nbsp;                 .text<br>&gt; +.global                 =5F=5Fkernel=
=5Fdatapage=5Foffset;<br>&gt; +=5F=5Fkernel=5Fdatapage=5Foffset:<br>&gt; + =
                .long                 0<br>&gt; +<br>&gt; &nbsp;V=5FFUNCTIO=
N=5FBEGIN(=5F=5Fget=5Fdatapage)<br>&gt; &nbsp; &nbsp;.cfi=5Fstartproc<br>&g=
t; &nbsp;                 /* We don't want that exposed or overridable as w=
e want other objects<br>&gt; @@ -27,13 +31,11 @@ V=5FFUNCTION=5FBEGIN(=5F=
=5Fget=5Fdatapage)<br>&gt; &nbsp;                 mflr                 r0<b=
r>&gt; &nbsp; &nbsp;.cfi=5Fregister lr,r0<br>&gt;<br>&gt; -                =
 bcl                 20,31,1f<br>&gt; -                 .global            =
     =5F=5Fkernel=5Fdatapage=5Foffset;<br>&gt; -=5F=5Fkernel=5Fdatapage=5Fo=
ffset:<br>&gt; -                 .long                 0<br>&gt; -1:<br>&gt=
; +                 bcl                 20,31,data=5Fpage=5Fbranch<br>&gt; =
+data=5Fpage=5Fbranch:<br>&gt; &nbsp;                 mflr                 =
r3<br>&gt; &nbsp;                 mtlr                 r0<br>&gt; +        =
         addi                 r3, r3, =5F=5Fkernel=5Fdatapage=5Foffset-data=
=5Fpage=5Fbranch<br>&gt; &nbsp;                 lwz                 r0,0(r3=
)<br>&gt; &nbsp;                 add                 r3,r0,r3<br>&gt; &nbsp=
;                 blr<br>&gt;<br>&gt;<br>&gt; =5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F<br>&gt; Linuxppc-dev mailing list<b=
r>&gt; Linuxppc-dev@lists.ozlabs.org<br>&gt; </tt><tt><a href=3D"https://li=
sts.ozlabs.org/listinfo/linuxppc-dev">https://lists.ozlabs.org/listinfo/lin=
uxppc-dev</a></tt><tt><br><br></tt><br><br><BR>
</body></html>

--1__=09BBF45ADFF6678E8f9e8a93df938690918c09BBF45ADFF6678E--


--0__=09BBF45ADFF6678E8f9e8a93df938690918c09BBF45ADFF6678E
Content-type: image/gif;
	name="graycol.gif"
Content-Disposition: inline; filename="graycol.gif"
Content-ID: <1__=09BBF45ADFF6678E8f9e8a93df938690918c09B@>
Content-Transfer-Encoding: base64

R0lGODlhEAAQAKECAMzMzAAAAP///wAAACH5BAEAAAIALAAAAAAQABAAAAIXlI+py+0PopwxUbpu
ZRfKZ2zgSJbmSRYAIf4fT3B0aW1pemVkIGJ5IFVsZWFkIFNtYXJ0U2F2ZXIhAAA7


--0__=09BBF45ADFF6678E8f9e8a93df938690918c09BBF45ADFF6678E--

Return-Path: <tyrlik@us.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0BE09DDE27
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Sep 2007 05:42:14 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l8LJg9rp006082
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Sep 2007 15:42:09 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l8LJg94g448290
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Sep 2007 13:42:09 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l8LJg840004600
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Sep 2007 13:42:08 -0600
Received: from d03nm126.boulder.ibm.com (d03nm126.boulder.ibm.com
	[9.17.195.152])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	l8LJg8Ho004589
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Sep 2007 13:42:08 -0600
In-Reply-To: <20070921184639.GA23906@ld0162-tx32.am.freescale.net>
Subject: Re: DTC Patch for Cygwin
To: Scott Wood <scottwood@freescale.com>
Message-ID: <OFF6527B59.0D9695D8-ON8525735D.006AC05C-8525735D.006C3903@us.ibm.com>
From: Matt Tyrlik <tyrlik@us.ibm.com>
Date: Fri, 21 Sep 2007 15:42:04 -0400
MIME-Version: 1.0
Content-type: multipart/alternative;
	Boundary="0__=0ABBF9CEDFF946CC8f9e8a93df938690918c0ABBF9CEDFF946CC"
Cc: linuxppc-dev@ozlabs.org, dwg@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--0__=0ABBF9CEDFF946CC8f9e8a93df938690918c0ABBF9CEDFF946CC
Content-type: text/plain; charset=US-ASCII

>Scott Wood <scottwood@freescale.com> wrote on 09/21/2007 02:46:39 PM:
> On Fri, Sep 21, 2007 at 11:26:04AM -0400, Matt Tyrlik wrote:
> >
> > Changes required to compile DTC under Cygwin
> >
> > ===================================================================
> > --- dtc-org.orig/tests/supernode_atdepth_offset.c
> > +++ dtc-org/tests/supernode_atdepth_offset.c
> > @@ -63,8 +63,11 @@ int path_prefix(const char *path, int de
> >                 return 1;
> >
> >         p = path;
> > -       for (i = 0; i < depth; i++)
> > -               p = strchrnul(p+1, '/');
> > +       for (i = 0; i < depth; i++) {
> > +               p = strchr(p+1, '/');
> > +               if (!p)
> > +                       p = path + strlen(path);
> > +       }
> >
> >         return p - path;
> >  }
>
> Maybe we should define strchrnul under #ifndef GLIBC, similar to
> strndupa?
Since this is used only in one place David Gibson suggested that the
change should be done in code.

>
> > Index: dtc-org/tests/testutils.c
> > ===================================================================
> > --- dtc-org.orig/tests/testutils.c
> > +++ dtc-org/tests/testutils.c
> > @@ -52,10 +52,9 @@ static void sigint_handler(int signum, s
> >  void test_init(int argc, char *argv[])
> >  {
> >         int err;
> > -       struct sigaction sa_int = {
> > -               .sa_sigaction = sigint_handler,
> > -       };
> > +       struct sigaction sa_int;
> >
> > +       sa_int.sa_sigaction = sigint_handler,
> >         test_name = argv[0];
>
> What version of GCC does cygwin use?  That doesn't seem like something
> that should break due to OS differences.
>
> -Scott
Currently 3.4.4. The compiler can't handle unnamed union in an
initializer.

Matt
--0__=0ABBF9CEDFF946CC8f9e8a93df938690918c0ABBF9CEDFF946CC
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline

<html><body>
<p><tt>&gt;Scott Wood &lt;scottwood@freescale.com&gt; wrote on 09/21/2007 02:46:39 PM:<br>
&gt; On Fri, Sep 21, 2007 at 11:26:04AM -0400, Matt Tyrlik wrote:<br>
&gt; &gt; <br>
&gt; &gt; Changes required to compile DTC under Cygwin<br>
&gt; &gt; <br>
&gt; &gt; ===================================================================<br>
&gt; &gt; --- dtc-org.orig/tests/supernode_atdepth_offset.c<br>
&gt; &gt; +++ dtc-org/tests/supernode_atdepth_offset.c<br>
&gt; &gt; @@ -63,8 +63,11 @@ int path_prefix(const char *path, int de<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return 1;<br>
&gt; &gt; <br>
&gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; p = path;<br>
&gt; &gt; - &nbsp; &nbsp; &nbsp; for (i = 0; i &lt; depth; i++)<br>
&gt; &gt; - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; p = strchrnul(p+1, '/');<br>
&gt; &gt; + &nbsp; &nbsp; &nbsp; for (i = 0; i &lt; depth; i++) {<br>
&gt; &gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; p = strchr(p+1, '/');<br>
&gt; &gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (!p)<br>
&gt; &gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; p = path + strlen(path);<br>
&gt; &gt; + &nbsp; &nbsp; &nbsp; }<br>
&gt; &gt; <br>
&gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; return p - path;<br>
&gt; &gt; &nbsp;}<br>
&gt; <br>
&gt; Maybe we should define strchrnul under #ifndef GLIBC, similar to<br>
&gt; strndupa?</tt><br>
<tt>Since this is used only in one place David Gibson suggested that the</tt><br>
<tt>change should be done in code.</tt><br>
<tt><br>
&gt; <br>
&gt; &gt; Index: dtc-org/tests/testutils.c<br>
&gt; &gt; ===================================================================<br>
&gt; &gt; --- dtc-org.orig/tests/testutils.c<br>
&gt; &gt; +++ dtc-org/tests/testutils.c<br>
&gt; &gt; @@ -52,10 +52,9 @@ static void sigint_handler(int signum, s<br>
&gt; &gt; &nbsp;void test_init(int argc, char *argv[])<br>
&gt; &gt; &nbsp;{<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; int err;<br>
&gt; &gt; - &nbsp; &nbsp; &nbsp; struct sigaction sa_int = {<br>
&gt; &gt; - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; .sa_sigaction = sigint_handler,<br>
&gt; &gt; - &nbsp; &nbsp; &nbsp; };<br>
&gt; &gt; + &nbsp; &nbsp; &nbsp; struct sigaction sa_int;<br>
&gt; &gt; <br>
&gt; &gt; + &nbsp; &nbsp; &nbsp; sa_int.sa_sigaction = sigint_handler,<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; test_name = argv[0];<br>
&gt; <br>
&gt; What version of GCC does cygwin use? &nbsp;That doesn't seem like something<br>
&gt; that should break due to OS differences.<br>
&gt; <br>
&gt; -Scott<br>
Currently 3.4.4. The compiler can't handle unnamed union in an<br>
initializer.</tt><br>
<br>
<tt>Matt</tt></body></html>
--0__=0ABBF9CEDFF946CC8f9e8a93df938690918c0ABBF9CEDFF946CC--

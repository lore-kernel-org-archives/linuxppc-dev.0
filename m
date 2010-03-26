Return-Path: <csdncannon@gmail.com>
Received: from mail-px0-f202.google.com (mail-px0-f202.google.com
	[209.85.216.202]) by ozlabs.org (Postfix) with ESMTP id 17F5FB7CE7
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Mar 2010 23:14:33 +1100 (EST)
Received: by pxi40 with SMTP id 40so1963655pxi.9
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Mar 2010 05:14:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <51142.84.105.60.153.1269594081.squirrel@gate.crashing.org>
References: <43c137a81003241941p84cba56y3e02e40cb22623e2@mail.gmail.com>
	<1269505301.8599.238.camel@pasglop> <201003251105.10033.arnd@arndb.de>
	<43c137a81003250800n660195c5k42c8516068aeda8d@mail.gmail.com>
	<1269549524.8599.243.camel@pasglop>
	<43c137a81003251811s52ac72eaud921d187e9747098@mail.gmail.com>
	<50253.84.105.60.153.1269566569.squirrel@gate.crashing.org>
	<43c137a81003251901h229b873bh7593c59a5ef66ae9@mail.gmail.com>
	<51131.84.105.60.153.1269593558.squirrel@gate.crashing.org>
	<51142.84.105.60.153.1269594081.squirrel@gate.crashing.org>
Date: Fri, 26 Mar 2010 20:14:32 +0800
Message-ID: <43c137a81003260514o7efaf667h326b4a33069b8a71@mail.gmail.com>
Subject: Re: Continual reading from the PowerPc time base register is not
	stable
From: Csdncannon <csdncannon@gmail.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Content-Type: multipart/alternative; boundary=0016e649c3561b91d60482b31ba8
Cc: Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0016e649c3561b91d60482b31ba8
Content-Type: text/plain; charset=ISO-8859-1

Yes, the missing 64-bit conversion is the key problem, I will try removing
isync later.

Thanks for your support.


2010/3/26 Segher Boessenkool <segher@kernel.crashing.org>

> > Yes indeed.  Could you post the relevant piece if disassembly from
> > your original binary (the one that has the problem)?  Or send me the
> > binary (not to the mailing list), I'll do it then.
>
> Ah scratch that.  I compiled your original code (after fixing the
> compile errors -- there is no such type as "bool" in C).
>
> The problem is that  (upper << 32) | lower  thing.  "upper" is a 32-bit
> type, so shifting it by 32 or more bits is undefined.  GCC compiles this
> to (shortened):
>
> 0: mftbu 9 ; mftbl 11 ; mftbu 0 ; cmpw 0,9 ; bne 0b  # so far so good
>   slwi 0,0,0 ; or 4,0,11 ; li 3,0 ; blr
>
> so it shifts by 0, i.e. it does  upper | lower .
>
> Case closed, no hardware problem :-)
>
>
> Segher
>
>

--0016e649c3561b91d60482b31ba8
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Yes, the missing 64-bit conversion is the key problem, I will try removing =
isync later. <br><br>Thanks for your support.<br><br><br><div class=3D"gmai=
l_quote">2010/3/26 Segher Boessenkool <span dir=3D"ltr">&lt;<a href=3D"mail=
to:segher@kernel.crashing.org">segher@kernel.crashing.org</a>&gt;</span><br=
>
<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;"><div class=3D"im"=
>&gt; Yes indeed. =A0Could you post the relevant piece if disassembly from<=
br>
&gt; your original binary (the one that has the problem)? =A0Or send me the=
<br>
&gt; binary (not to the mailing list), I&#39;ll do it then.<br>
<br>
</div>Ah scratch that. =A0I compiled your original code (after fixing the<b=
r>
compile errors -- there is no such type as &quot;bool&quot; in C).<br>
<br>
The problem is that =A0(upper &lt;&lt; 32) | lower =A0thing. =A0&quot;upper=
&quot; is a 32-bit<br>
type, so shifting it by 32 or more bits is undefined. =A0GCC compiles this<=
br>
to (shortened):<br>
<br>
0: mftbu 9 ; mftbl 11 ; mftbu 0 ; cmpw 0,9 ; bne 0b =A0# so far so good<br>
 =A0 slwi 0,0,0 ; or 4,0,11 ; li 3,0 ; blr<br>
<br>
so it shifts by 0, i.e. it does =A0upper | lower .<br>
<br>
Case closed, no hardware problem :-)<br>
<font color=3D"#888888"><br>
<br>
Segher<br>
<br>
</font></blockquote></div><br>

--0016e649c3561b91d60482b31ba8--

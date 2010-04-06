Return-Path: <csdncannon@gmail.com>
Received: from mail-pv0-f170.google.com (mail-pv0-f170.google.com
	[74.125.83.170]) by ozlabs.org (Postfix) with ESMTP id B6D00B7CF0
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Apr 2010 18:02:41 +1000 (EST)
Received: by pvg6 with SMTP id 6so2228667pvg.15
	for <linuxppc-dev@ozlabs.org>; Tue, 06 Apr 2010 01:02:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <43c137a81003260514o7efaf667h326b4a33069b8a71@mail.gmail.com>
References: <43c137a81003241941p84cba56y3e02e40cb22623e2@mail.gmail.com>
	<201003251105.10033.arnd@arndb.de>
	<43c137a81003250800n660195c5k42c8516068aeda8d@mail.gmail.com>
	<1269549524.8599.243.camel@pasglop>
	<43c137a81003251811s52ac72eaud921d187e9747098@mail.gmail.com>
	<50253.84.105.60.153.1269566569.squirrel@gate.crashing.org>
	<43c137a81003251901h229b873bh7593c59a5ef66ae9@mail.gmail.com>
	<51131.84.105.60.153.1269593558.squirrel@gate.crashing.org>
	<51142.84.105.60.153.1269594081.squirrel@gate.crashing.org>
	<43c137a81003260514o7efaf667h326b4a33069b8a71@mail.gmail.com>
Date: Tue, 6 Apr 2010 16:02:39 +0800
Message-ID: <p2l43c137a81004060102m206cf121y61b120cfccfc790e@mail.gmail.com>
Subject: Re: Continual reading from the PowerPc time base register is not
	stable
From: Csdncannon <csdncannon@gmail.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Content-Type: multipart/mixed; boundary=001636b1467798941c04838cde6a
Cc: Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001636b1467798941c04838cde6a
Content-Type: multipart/alternative; boundary=001636b1467798941104838cde68

--001636b1467798941104838cde68
Content-Type: text/plain; charset=ISO-8859-1

Hi guys
       In fact my problem is gettimeofday cannot return right value
sometimes, and this will bring instability to our system software. You can
find a law from the log that there is a 17592 seconds' shift every time
error occurs.



2010/3/26 Csdncannon <csdncannon@gmail.com>

> Yes, the missing 64-bit conversion is the key problem, I will try removing
> isync later.
>
> Thanks for your support.
>
>
> 2010/3/26 Segher Boessenkool <segher@kernel.crashing.org>
>
>> > Yes indeed.  Could you post the relevant piece if disassembly from
>>
>> > your original binary (the one that has the problem)?  Or send me the
>> > binary (not to the mailing list), I'll do it then.
>>
>> Ah scratch that.  I compiled your original code (after fixing the
>> compile errors -- there is no such type as "bool" in C).
>>
>> The problem is that  (upper << 32) | lower  thing.  "upper" is a 32-bit
>> type, so shifting it by 32 or more bits is undefined.  GCC compiles this
>> to (shortened):
>>
>> 0: mftbu 9 ; mftbl 11 ; mftbu 0 ; cmpw 0,9 ; bne 0b  # so far so good
>>   slwi 0,0,0 ; or 4,0,11 ; li 3,0 ; blr
>>
>> so it shifts by 0, i.e. it does  upper | lower .
>>
>> Case closed, no hardware problem :-)
>>
>>
>> Segher
>>
>>
>

--001636b1467798941104838cde68
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi guys<br>=A0=A0=A0=A0=A0=A0 In fact my problem is gettimeofday cannot ret=
urn right value sometimes, and this will bring instability to our system so=
ftware. You can find a law from the log that there is a 17592 seconds&#39; =
shift every time error occurs.<br>
<br><br><br><div class=3D"gmail_quote">2010/3/26 Csdncannon <span dir=3D"lt=
r">&lt;<a href=3D"mailto:csdncannon@gmail.com">csdncannon@gmail.com</a>&gt;=
</span><br><blockquote class=3D"gmail_quote" style=3D"border-left: 1px soli=
d rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Yes, the missing 64-bit conversion is the key problem, I will try removing =
isync later. <br><br>Thanks for your support.<br><br><br><div class=3D"gmai=
l_quote"><div class=3D"im">2010/3/26 Segher Boessenkool <span dir=3D"ltr">&=
lt;<a href=3D"mailto:segher@kernel.crashing.org" target=3D"_blank">segher@k=
ernel.crashing.org</a>&gt;</span><br>

</div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb=
(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div>&gt; Y=
es indeed. =A0Could you post the relevant piece if disassembly from<div><di=
v>
</div><div class=3D"h5"><br>
&gt; your original binary (the one that has the problem)? =A0Or send me the=
<br>
&gt; binary (not to the mailing list), I&#39;ll do it then.<br>
<br>
</div></div></div><div><div></div><div class=3D"h5">Ah scratch that. =A0I c=
ompiled your original code (after fixing the<br>
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
</font></div></div></blockquote></div><br>
</blockquote></div><br>

--001636b1467798941104838cde68--

--001636b1467798941c04838cde6a
Content-Type: application/octet-stream; name="gettime.c"
Content-Disposition: attachment; filename="gettime.c"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g7of8x0j0

I2luY2x1ZGUgPGlvc3RyZWFtPg0KDQojaW5jbHVkZSA8c3RkbGliLmg+DQoNCiNpbmNsdWRlIDxz
dHJpbmcuaD4NCg0KI2luY2x1ZGUgPHN5cy90aW1lLmg+DQoNCiANCg0KaW50IG1haW4odm9pZCkg
DQoNCnsNCg0KICAgIHN0cnVjdCB0aW1ldmFsIG5vdywgdGltZW91dDsNCg0KICAgIGdldHRpbWVv
ZmRheSggJm5vdywgKHN0cnVjdCB0aW1lem9uZSAqKU5VTEwgKTsNCg0KICAgIGludCBjb3VudCA9
IDA7DQoNCiANCg0KICAgIHdoaWxlKDEpDQoNCiAgICB7DQoNCiAgICAgICAgY291bnQgKys7DQoN
CiAgICAgICAgaWYoZ2V0dGltZW9mZGF5KCAmdGltZW91dCwgKHN0cnVjdCB0aW1lem9uZSAqKU5V
TEwgKSkNCgkJew0KCQkJcHJpbnRmKCJnZXR0aW1lb2ZkYXkgZmFpbGVkMTogdHZfc2VjICVkICwg
dHZfdXNlYyAlZCBcbiIsIHRpbWVvdXQudHZfc2VjLCB0aW1lb3V0LnR2X3VzZWMpOw0KCQl9CQkN
Cg0KICAgICAgICB1c2xlZXAoIDUgKTsNCg0KICAgICAgICBpZihnZXR0aW1lb2ZkYXkoICZub3cs
IChzdHJ1Y3QgdGltZXpvbmUgKilOVUxMICkpDQoJCXsNCgkJCXByaW50ZigiZ2V0dGltZW9mZGF5
IGZhaWxlZDI6IHR2X3NlYyAlZCAsIHR2X3VzZWMgJWQgXG4iLCBub3cudHZfc2VjLCBub3cudHZf
dXNlYyk7DQoJCX07DQoNCiANCg0KICAgICAgICBpZiAoKHRpbWVvdXQudHZfc2VjIC0gbm93LnR2
X3NlYykgPiAxKQ0KDQogICAgICAgIHsNCg0KICAgICAgICAgICAgcHJpbnRmKCJTZXJpb3VzIDog
dGltZW91dCAlZCAsIG5vdyAlZCBcbiIsIHRpbWVvdXQudHZfc2VjLCBub3cudHZfc2VjKTsNCg0K
ICAgICAgICB9DQoJCWVsc2UgaWYoKG5vdy50dl9zZWMgLSB0aW1lb3V0LnR2X3NlYykgPiAxKQ0K
CQl7DQoJCQlwcmludGYoIkZhaWxlZCA6IHRpbWVvdXQgJWQgLCBub3cgJWQgXG4iLCB0aW1lb3V0
LnR2X3NlYywgbm93LnR2X3NlYyk7DQoJCX0NCg0KICAgICAgICBpZihjb3VudCA+IDEwMDAwMDAp
DQoNCiAgICAgICAgew0KDQogICAgICAgICAgICBjb3VudCA9IDA7DQoNCiAgICAgICAgICAgIHBy
aW50ZigiICVkICwgICAlZCBcbiIsIHRpbWVvdXQudHZfc2VjLCBub3cudHZfc2VjKTsNCg0KICAg
ICAgICB9DQoNCiAgICB9DQoNCiANCg0KfQ0KDQo=
--001636b1467798941c04838cde6a
Content-Type: application/octet-stream; name="gettime.log"
Content-Disposition: attachment; filename="gettime.log"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g7of9it31

cm9vdEB0bGFiODM3ODovcm9vdD4gL21udC9zZXJ2ZXIvR2luby9nZXR0aW1lDQogMTI3MDU0MDc0
NCAsICAgMTI3MDU0MDc0NA0KRmFpbGVkIDogdGltZW91dCAxMjcwNTQwNzQ5ICwgbm93IDEyNzA1
NTgzNDENClNlcmlvdXMgOiB0aW1lb3V0IDEyNzA1NTgzNDEgLCBub3cgMTI3MDU0MDc0OQ0KIDEy
NzA1NDA3NTUgLCAgIDEyNzA1NDA3NTUNCiAxMjcwNTQwNzY1ICwgICAxMjcwNTQwNzY1DQpGYWls
ZWQgOiB0aW1lb3V0IDEyNzA1NDA3NzQgLCBub3cgMTI3MDU1ODM2Ng0KU2VyaW91cyA6IHRpbWVv
dXQgMTI3MDU1ODM2NiAsIG5vdyAxMjcwNTQwNzc0DQogMTI3MDU0MDc3NSAsICAgMTI3MDU0MDc3
NQ0KIDEyNzA1NDA3ODYgLCAgIDEyNzA1NDA3ODYNCiAxMjcwNTQwNzk2ICwgICAxMjcwNTQwNzk2
DQpGYWlsZWQgOiB0aW1lb3V0IDEyNzA1NDA4MDIgLCBub3cgMTI3MDU1ODM5NA0KU2VyaW91cyA6
IHRpbWVvdXQgMTI3MDU1ODM5NCAsIG5vdyAxMjcwNTQwODAyDQpGYWlsZWQgOiB0aW1lb3V0IDEy
NzA1NDA4MDMgLCBub3cgMTI3MDU1ODM5NQ0KU2VyaW91cyA6IHRpbWVvdXQgMTI3MDU1ODM5NSAs
IG5vdyAxMjcwNTQwODAzDQogMTI3MDU0MDgwNiAsICAgMTI3MDU0MDgwNg0KRmFpbGVkIDogdGlt
ZW91dCAxMjcwNTQwODE0ICwgbm93IDEyNzA1NTg0MDYNClNlcmlvdXMgOiB0aW1lb3V0IDEyNzA1
NTg0MDYgLCBub3cgMTI3MDU0MDgxNA0KIDEyNzA1NDA4MTYgLCAgIDEyNzA1NDA4MTYNCiAxMjcw
NTQwODI3ICwgICAxMjcwNTQwODI3DQogMTI3MDU0MDgzNyAsICAgMTI3MDU0MDgzNw0KIDEyNzA1
NDA4NDcgLCAgIDEyNzA1NDA4NDcNCkZhaWxlZCA6IHRpbWVvdXQgMTI3MDU0MDg1NSAsIG5vdyAx
MjcwNTU4NDQ3DQpTZXJpb3VzIDogdGltZW91dCAxMjcwNTU4NDQ3ICwgbm93IDEyNzA1NDA4NTUN
CiAxMjcwNTQwODU4ICwgICAxMjcwNTQwODU4
--001636b1467798941c04838cde6a--

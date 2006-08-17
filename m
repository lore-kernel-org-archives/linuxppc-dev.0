Return-Path: <keith.redfern@uk.flextronics.com>
Received: from ducmta01.flextronics.com (ducmta01.flextronics.com
	[217.79.214.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ducmta01.flextronics.com", Issuer "RSA Data Security,
	Inc." (verified OK)) by ozlabs.org (Postfix) with ESMTP id F302B67B86
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Aug 2006 21:29:45 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Problems dynamically linking busybox with ppc libs. 
Date: Thu, 17 Aug 2006 13:29:33 +0200
Message-ID: <367F3B3911959C4DA9991C00166F620C1DE65E@EUDUCEX2.europe.ad.flextronics.com>
From: "Keith Redfern" <keith.redfern@uk.flextronics.com>
To: "Wolfgang Denk" <wd@denx.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I have just realised that I was barking up the wrong tree in regard to=0D=
=0A
this issue. =0D=0A
=0D=0A
My problem turned out not to be a issue with compiling/linking Busybox=0D=
=0A
but that my target was using different libraries to what was specified=0D=
=0A
in my ELDK. I am a newbie to embedded Linux and now understand that this=0D=
=0A
is a fundamental step in getting a working system. =0D=0A
=0D=0A
My confusion came about as my ELDK is not a standard ELDK but came as a=0D=
=0A
BSP from Embedded Planet 852T. Embedded Planet supply a pre-formed=0D=0A
ramdisk image with libraries, Busybox executable, initialisation scripts=0D=
=0A
etc. =0D=0A
=0D=0A
Any executables supplied in this pre-formed ram disk worked fine. An=0D=0A
initial test of the system showed that Busybox worked fine. =0D=0A
=0D=0A
They have scripts that reverse engineer this to a folder and suggest=0D=0A
just making additions/modifications to this folder and then run another=0D=
=0A
script to create a new RAM disk image.=0D=0A
=0D=0A
I didn't see Busybox packaged with the BSP so I downloaded v1.1.3 from=0D=
=0A
the web and started working with it, using the ELDK to build. After this=0D=
=0A
it didn't work. I have now figured out that any new executables built=0D=0A
using the ELDK don't work as they are referencing different versions of=0D=
=0A
the libraries. The pre-formed busybox worked fine as it was built=0D=0A
referencing the libraries in the also pre-formed library directory.=0D=0A
=0D=0A
I don't know why Embedded Planet would have different library versions=0D=
=0A
in the pre-formed library directory and the ELDK! Maybe there to trick=0D=
=0A
newbies!=0D=0A
=0D=0A
Doing a standard Busybox 'make' with no modifications to the make files=0D=
=0A
and aligning the target libraries with that provided as part of the ELDK=0D=
=0A
solved the problem.=0D=0A
=0D=0A
Thanks for help on this ......... Keith.=0D=0A
=0D=0A
-----Original Message-----=0D=0A
From: Wolfgang Denk [mailto:wd@denx.de] =0D=0A
Sent: 17 August 2006 10:48=0D=0A
To: Keith Redfern=0D=0A
Cc: linuxppc-embedded@ozlabs.org=0D=0A
Subject: Re: Problems dynamically linking busybox with ppc libs. =0D=0A
=0D=0A
In message=0D=0A
<367F3B3911959C4DA9991C00166F620C1DE208@EUDUCEX2.europe.ad.flextronics.c=0D=
=0A
om> you wrote:=0D=0A
> =0D=0A
> I am trying to dynamically link busybox with the correct libraries=0D=0A
but> =0D=0A
> run into problems with directory paths and CC/LD flags.=0D=0A
=0D=0A
Maybe you do too much?=0D=0A
=0D=0A
> I am using the toolchain supplied with ELDK and my target board is=0D=0A
> ppc_8xx based. The busybox version that I am using is 1.1.3.=0D=0A
=0D=0A
> I see the following in Rules.mak and have been trying different=0D=0A
variable> =0D=0A
> options but with no success.=0D=0A
=0D=0A
You are not supposed to meddle with Rules.mk. Also, this is not=0D=0A
necessary at all.=0D=0A
=0D=0A
> Is this the correct place to make modifications?=0D=0A
=0D=0A
No. No modifications are necessary.=0D=0A
=0D=0A
Just run a standard configuration  and  make  sure  to  select  cross=0D=0A
compilation with "ppc_8xx-" as Cross Compiler prefix, i. e.:=0D=0A
=0D=0A
-> cd /tmp=0D=0A
-> wget http://busybox.net/downloads/busybox-1.1.3.tar.bz2=0D=0A
-> tar jxf busybox-1.1.3.tar.bz2=0D=0A
-> cd busybox-1.1.3=0D=0A
-> export CROSS_COMPILE=3Dppc_8xx-=0D=0A
-> make config=0D=0A
...=0D=0A
*=0D=0A
* Build Options=0D=0A
*=0D=0A
...=0D=0A
Do you want to build BusyBox with a Cross Compiler?=0D=0A
(USING_CROSS_COMPILER) [N/y/?] (NEW) y=0D=0A
  Cross Compiler prefix (CROSS_COMPILER_PREFIX)=0D=0A
[/usr/i386-linux-uclibc/bin/i386-uclibc-] (NEW) ppc_8xx-=0D=0A
Any extra CFLAGS options for the compiler? (EXTRA_CFLAGS_OPTIONS) []=0D=0A
(NEW)=0D=0A
...=0D=0A
-> make=0D=0A
...=0D=0A
  LINK busybox_unstripped=0D=0A
  STRIP busybox=0D=0A
...=0D=0A
=0D=0A
This is so straightforward that I wonder what you moight have done to=0D=0A
run into problems...=0D=0A
=0D=0A
=0D=0A
> Has anyone already figured the changes required to get this to work=0D=0A
with=0D=0A
> ELDK toolchain?=0D=0A
=0D=0A
Yes. And if had bothered to check how the busybox RPM was build which=0D=0A
comes included with the ELDK (for example by  looking  at  it's  spec=0D=0A
file), then you should have known, too.=0D=0A
=0D=0A
Best regards,=0D=0A
=0D=0A
Wolfgang Denk=0D=0A
=0D=0A
-- =0D=0A
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux=0D=0A
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de=0D=0A
Our business is run on trust.  We trust you will pay in advance.=0D=0A
=0D=0A
Legal Disclaimer:=0A
The information contained in this message may be privileged and confident=
ial. It is intended to be read only by the individual or entity to whom i=
t is addressed or by their designee. If the reader of this message is not=
 the intended recipient, you are on notice that any distribution of this =
message, in any form, is strictly prohibited. If you have received this m=
essage in error, please immediately notify the sender and delete or destr=
oy any copy of this message=0D=0A

Return-Path: <walsh.benj@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.228])
	by ozlabs.org (Postfix) with ESMTP id CA76EDDDDB
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Feb 2009 05:48:13 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so2502859rvb.9
	for <linuxppc-dev@ozlabs.org>; Wed, 04 Feb 2009 10:48:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <02f6bf324a381ee5c2fc5e91313dbca9@bga.com>
References: <cb298a870901231259h6bd1ae2ag2baeb20173219664@mail.gmail.com>
	<02f6bf324a381ee5c2fc5e91313dbca9@bga.com>
Date: Wed, 4 Feb 2009 13:48:11 -0500
Message-ID: <cb298a870902041048v57391b62l7701933465b7f43c@mail.gmail.com>
Subject: Re: Maple PPC970 kexec crash-dump problems
From: Benjamin Walsh <walsh.benj@gmail.com>
To: Milton Miller <miltonm@bga.com>
Content-Type: multipart/alternative; boundary=000e0cd2903ac31f6304621c3a7c
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--000e0cd2903ac31f6304621c3a7c
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi Milton,

I've tracked it down to the device tree passed to the second kernel being
screwed-up when patched by kexec-tools. Namely, it was creating
linux,usable-memory entries that were wrong, and the MMU initialization hung
when it failed allocating for the page tables. I hacked the tool, and got
passed that point in the init sequence, but the very first IO mapped access
fails, so the MMU doesn't seem to be set up correctly.

Anyway, up to my question: is the crash dump (kdump) kernel supposed to use
the memory reserved for it by the first kernel for its working memory ? e.g.
On that board, I have 0->2GB and 4->6GB for a total of 4GB of RAM. Let's say
I reserve 128M@32M, that's 0x2000000->0xa000000. Is the second kernel
supposed to use

(0x2000000+<kernel size>) -> 0xa000000

for its memory pool and leave everything else:

0->0x2000000, 0xa000000 -> 80000000, 0x100000000 -> 0x180000000

as memory that is from the first kernel, used to debug it ?

Basically, I am trying to figure out if I patched the tool correctly.

Thanks,
Ben

On Sat, Jan 24, 2009 at 2:52 AM, Milton Miller <miltonm@bga.com> wrote:

> On Sat Jan 24 at 07:59:47 EST in 2009, Benjamin Walsh wrote:
>
>> I am trying to use kexec with a crash dump kernel on a Maple board
>> (Motorola
>> ATCA6101 to be precise). This board is running a two-CPU PPC970FX. I am
>> running a 2.6.27-10 kernel and have tried both older kexec-tools and the
>> newest ones. I have tried SMP and non-SMP kernels.
>>
>
> Once you start the second cpu it is likly executing instructions somewhere.
>
> Priory to 2.6.27 you had to compile a fixxed offset kerenl to run kdump.
>  With 2.6.27 that option was removed and replaced with teh relocatable
> kerenl.  However, becasue of the way linux interacts with open firmware, the
> kernel will still move itself to 0 unless a specific flag is set.   The
> location of the flag was changed twice during the merge process, and the
> patches for kexec-tools were not made until early this year.
>
>  Using kexec -l to fast boot works correctly. However, loading a crash dump
>> kernel and triggering a crash via echo c > /proc/sysrq-trigger simply
>> hangs
>> the board. I have traced the sequence down to after the call to
>> kexec_copy_flush(), when the CPU returns to real-address mode (bl
>> real_mode). At this point I have no further debugging information.
>>
>
>
>  Two things could help me:
>>
>> - Getting the fix if this is a known issue and a fix exists. I have looked
>> at recent patches and nothing lept to mind, mostly relocatable kernel
>> support.
>>
>
> That is a major change.
>
> That said, I don't know if anyone has tested kexec panic beyond pseries for
> 64 bit powerpc.
>
> I know Paul originally prototyped the relocatable patch on a powermac, but
> I dont' know what if any smp testing he performed.   And you said you are
> actualy on maple not a powermac, so the startup issues are different.
>
>  - Obtaining the address of the serial port @3f8 in real mode. The init
>> sequence with udbg ON says that the physical address of the port is
>> 0xf40003f8; however, setting it up in poll mode and trying to stuff
>> characters in the tx buffer doesn't produce anything.
>>
>
> Ah yes.  In real mode you can only talk to cacheable memory without
> implementation specific assistance.  However, if you look in the kernel for
> the maple early udbg support, you will find the code you need to talk to
> that serial port in real mode.
>
>
>> Has anyone recently tried to use the serial port in real mode ?
>>
>> Thanks for any help.
>>
>> Ben
>>
>
> Hope this gets you started.  I wrote a lot of the kernel code, but I had
> the advantage of external jtag access to the processor to see where it when
> ended up when it went astray.
>
> milton
>
>

--000e0cd2903ac31f6304621c3a7c
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Milton,<br><br>I&#39;ve tracked it down to the device tree passed to the=
 second kernel being screwed-up when patched by kexec-tools. Namely, it was=
 creating linux,usable-memory entries that were wrong, and the MMU initiali=
zation hung when it failed allocating for the page tables. I hacked the too=
l, and got passed that point in the init sequence, but the very first IO ma=
pped access fails, so the MMU doesn&#39;t seem to be set up correctly.<br>
<br>Anyway, up to my question: is the crash dump (kdump) kernel supposed to=
 use the memory reserved for it by the first kernel for its working memory =
? e.g. On that board, I have 0-&gt;2GB and 4-&gt;6GB for a total of 4GB of =
RAM. Let&#39;s say I reserve 128M@32M, that&#39;s 0x2000000-&gt;0xa000000. =
Is the second kernel supposed to use<br>
<br>(0x2000000+&lt;kernel size&gt;) -&gt; 0xa000000<br><br>for its memory p=
ool and leave everything else:<br><br>0-&gt;0x2000000, 0xa000000 -&gt; 8000=
0000, 0x100000000 -&gt; 0x180000000<br><br>as memory that is from the first=
 kernel, used to debug it ?<br>
<br>Basically, I am trying to figure out if I patched the tool correctly.<b=
r><br>Thanks,<br>Ben<br><br><div class=3D"gmail_quote">On Sat, Jan 24, 2009=
 at 2:52 AM, Milton Miller <span dir=3D"ltr">&lt;<a href=3D"mailto:miltonm@=
bga.com">miltonm@bga.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div class=3D"Ih2=
E3d">On Sat Jan 24 at 07:59:47 EST in 2009, Benjamin Walsh wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
I am trying to use kexec with a crash dump kernel on a Maple board (Motorol=
a<br>
ATCA6101 to be precise). This board is running a two-CPU PPC970FX. I am<br>
running a 2.6.27-10 kernel and have tried both older kexec-tools and the<br=
>
newest ones. I have tried SMP and non-SMP kernels.<br>
</blockquote>
<br></div>
Once you start the second cpu it is likly executing instructions somewhere.=
<br>
<br>
Priory to 2.6.27 you had to compile a fixxed offset kerenl to run kdump. &n=
bsp;With 2.6.27 that option was removed and replaced with teh relocatable k=
erenl. &nbsp;However, becasue of the way linux interacts with open firmware=
, the kernel will still move itself to 0 unless a specific flag is set. &nb=
sp; The location of the flag was changed twice during the merge process, an=
d the patches for kexec-tools were not made until early this year.<div clas=
s=3D"Ih2E3d">
<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Using kexec -l to fast boot works correctly. However, loading a crash dump<=
br>
kernel and triggering a crash via echo c &gt; /proc/sysrq-trigger simply ha=
ngs<br>
the board. I have traced the sequence down to after the call to<br>
kexec_copy_flush(), when the CPU returns to real-address mode (bl<br>
real_mode). At this point I have no further debugging information.<br>
</blockquote>
<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Two things could help me:<br>
<br>
- Getting the fix if this is a known issue and a fix exists. I have looked<=
br>
at recent patches and nothing lept to mind, mostly relocatable kernel<br>
support.<br>
</blockquote>
<br></div>
That is a major change.<br>
<br>
That said, I don&#39;t know if anyone has tested kexec panic beyond pseries=
 for 64 bit powerpc.<br>
<br>
I know Paul originally prototyped the relocatable patch on a powermac, but =
I dont&#39; know what if any smp testing he performed. &nbsp; And you said =
you are actualy on maple not a powermac, so the startup issues are differen=
t.<div class=3D"Ih2E3d">
<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
- Obtaining the address of the serial port @3f8 in real mode. The init<br>
sequence with udbg ON says that the physical address of the port is<br>
0xf40003f8; however, setting it up in poll mode and trying to stuff<br>
characters in the tx buffer doesn&#39;t produce anything.<br>
</blockquote>
<br></div>
Ah yes. &nbsp;In real mode you can only talk to cacheable memory without im=
plementation specific assistance. &nbsp;However, if you look in the kernel =
for the maple early udbg support, you will find the code you need to talk t=
o that serial port in real mode.<div class=3D"Ih2E3d">
<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<br>
Has anyone recently tried to use the serial port in real mode ?<br>
<br>
Thanks for any help.<br>
<br>
Ben<br>
</blockquote>
<br></div>
Hope this gets you started. &nbsp;I wrote a lot of the kernel code, but I h=
ad the advantage of external jtag access to the processor to see where it w=
hen ended up when it went astray.<br><font color=3D"#888888">
<br>
milton<br>
<br>
</font></blockquote></div><br>

--000e0cd2903ac31f6304621c3a7c--

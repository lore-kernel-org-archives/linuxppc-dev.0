Return-Path: <oohall@gmail.com>
Received: from mail-qg0-x22d.google.com (mail-qg0-x22d.google.com
 [IPv6:2607:f8b0:400d:c04::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B6201A0174
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jan 2016 16:29:04 +1100 (AEDT)
Received: by mail-qg0-x22d.google.com with SMTP id o11so157155618qge.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jan 2016 21:29:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <56A814B4.9020802@au1.ibm.com>
References: <1453704952-11197-1-git-send-email-oohall@gmail.com>
 <56A814B4.9020802@au1.ibm.com>
Date: Wed, 27 Jan 2016 16:29:01 +1100
Message-ID: <CAOSf1CEh6GjJZLKGXDviVbycPUuPzb6jL05Zq5d0pzBpeiumNA@mail.gmail.com>
Subject: Re: [PATCH] Fix fall-through from case 30 (rld*) to case 31
From: oliver <oohall@gmail.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=001a113a544e5f01e5052a4a14b4
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001a113a544e5f01e5052a4a14b4
Content-Type: text/plain; charset=UTF-8

> The patch summary should probably be something along the lines of
"powerpc/sstep: fix switch fall-through when analysing malformed rld*
instructions" or similar. The rest of the message should have the more
specific details of the bug you're fixing.
>
> In general, we always mention the affected subsystems in the patch
summary line and write both the summary line and the message so that other
developers can get a quick understanding of what the patch does without
actually needing to read the code. Keep in mind that commit messages will
show up in the git logs of every kernel developer, not just powerpc people.

That's fair.

> I had a cursory glance at the code and it's not obvious to me that this
is the correct way to deal with an invalid instruction. What happens when
you break out of the switch? It looks like it just ends up returning 0, the
same as any other instruction that isn't executed directly in the
analyse_instr() stage.
>
>Is there anywhere else in the sstep code that deals well with malformed
instructions?

When you break out of the switch the opcode type is marked as unknown and
when further attempts to parse the instruction fail it returns zero to
indicate failure. Also, many of the instructions handled by the function
are only valid in 64bit mode. For 32bit processors these instructions would
be illegal and the code that handles them is #ifdef`ed out when compiling
for 32 bit platforms so simply breaking out of the switch and letting it
propagate should be the right move here.

Oliver


On Wed, Jan 27, 2016 at 11:52 AM, Andrew Donnellan <
andrew.donnellan@au1.ibm.com> wrote:

> On 25/01/16 17:55, Oliver O'Halloran wrote:
>
>> I think this bug can only be triggered if the instruction to
>> simulate is malformed. The switch in the else case only handles
>> the zero and one case, but it extracts bits 4:1 from the
>> instruction word so it may be other values. It's pretty minor, but
>> a bug is a bug.
>>
>> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
>>
>
> The patch summary should probably be something along the lines of
> "powerpc/sstep: fix switch fall-through when analysing malformed rld*
> instructions" or similar. The rest of the message should have the more
> specific details of the bug you're fixing.
>
> In general, we always mention the affected subsystems in the patch summary
> line and write both the summary line and the message so that other
> developers can get a quick understanding of what the patch does without
> actually needing to read the code. Keep in mind that commit messages will
> show up in the git logs of every kernel developer, not just powerpc people.
>
> --- a/arch/powerpc/lib/sstep.c
>> +++ b/arch/powerpc/lib/sstep.c
>> @@ -925,6 +925,7 @@ int __kprobes analyse_instr(struct instruction_op
>> *op, struct pt_regs *regs,
>>                         }
>>                 }
>>   #endif
>> +       break; /* illegal instruction */
>>
>
> I had a cursory glance at the code and it's not obvious to me that this is
> the correct way to deal with an invalid instruction. What happens when you
> break out of the switch? It looks like it just ends up returning 0, the
> same as any other instruction that isn't executed directly in the
> analyse_instr() stage.
>
> Is there anywhere else in the sstep code that deals well with malformed
> instructions?
>
> --
> Andrew Donnellan              Software Engineer, OzLabs
> andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
> +61 2 6201 8874 (work)        IBM Australia Limited
>
>

--001a113a544e5f01e5052a4a14b4
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><span style=3D"font-size:12.8px">&gt; The patch summary sh=
ould probably be something along the lines of</span><br style=3D"font-size:=
12.8px"><span style=3D"font-size:12.8px">&quot;powerpc/sstep: fix switch fa=
ll-through when analysing malformed rld* instructions&quot; or similar. The=
 rest of the message should have the more specific details of the bug you&#=
39;re fixing.</span><br style=3D"font-size:12.8px">&gt;<br style=3D"font-si=
ze:12.8px"><span style=3D"font-size:12.8px">&gt; In general, we always ment=
ion the affected subsystems in the patch summary line and write both the su=
mmary line and the message so that other developers can get a quick underst=
anding of what the patch does without actually needing to read the code. Ke=
ep in mind that commit messages will show up in the git logs of every kerne=
l developer, not just powerpc people.</span><br><div><br></div><div>That&#3=
9;s fair.</div><div><span style=3D"font-size:12.8px"><br></span></div><div>=
<span style=3D"font-size:12.8px">&gt; I had a cursory glance at the code an=
d it&#39;s not obvious to me that this is the correct way to deal with an i=
nvalid instruction. What happens when you break out of the switch? It looks=
 like it just ends up returning 0, the same as any other instruction that i=
sn&#39;t executed directly in the analyse_instr() stage.</span><br style=3D=
"font-size:12.8px">&gt;<br style=3D"font-size:12.8px"><span style=3D"font-s=
ize:12.8px">&gt;Is there anywhere else in the sstep code that deals well wi=
th malformed instructions?</span><span style=3D"font-size:12.8px"><br></spa=
n></div><div><br></div><div>When you break out of the switch the opcode typ=
e is marked as unknown and when further attempts to parse the instruction f=
ail it returns zero to indicate failure. Also, many of the instructions han=
dled by the function are only valid in 64bit mode. For 32bit processors the=
se instructions would be illegal and the code that handles them is #ifdef`e=
d out when compiling for 32 bit platforms so simply breaking out of the swi=
tch and letting it propagate should be the right move here.</div><div><br><=
/div><div>Oliver</div><div><span style=3D"font-size:12.8px"><br></span></di=
v></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Wed, J=
an 27, 2016 at 11:52 AM, Andrew Donnellan <span dir=3D"ltr">&lt;<a href=3D"=
mailto:andrew.donnellan@au1.ibm.com" target=3D"_blank">andrew.donnellan@au1=
.ibm.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span cl=
ass=3D"">On 25/01/16 17:55, Oliver O&#39;Halloran wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
I think this bug can only be triggered if the instruction to<br>
simulate is malformed. The switch in the else case only handles<br>
the zero and one case, but it extracts bits 4:1 from the<br>
instruction word so it may be other values. It&#39;s pretty minor, but<br>
a bug is a bug.<br>
<br>
Signed-off-by: Oliver O&#39;Halloran &lt;<a href=3D"mailto:oohall@gmail.com=
" target=3D"_blank">oohall@gmail.com</a>&gt;<br>
</blockquote>
<br></span>
The patch summary should probably be something along the lines of<br>
&quot;powerpc/sstep: fix switch fall-through when analysing malformed rld* =
instructions&quot; or similar. The rest of the message should have the more=
 specific details of the bug you&#39;re fixing.<br>
<br>
In general, we always mention the affected subsystems in the patch summary =
line and write both the summary line and the message so that other develope=
rs can get a quick understanding of what the patch does without actually ne=
eding to read the code. Keep in mind that commit messages will show up in t=
he git logs of every kernel developer, not just powerpc people.<span class=
=3D""><br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
--- a/arch/powerpc/lib/sstep.c<br>
+++ b/arch/powerpc/lib/sstep.c<br>
@@ -925,6 +925,7 @@ int __kprobes analyse_instr(struct instruction_op *op, =
struct pt_regs *regs,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 #endif<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0break; /* illegal instruction */<br>
</blockquote>
<br></span>
I had a cursory glance at the code and it&#39;s not obvious to me that this=
 is the correct way to deal with an invalid instruction. What happens when =
you break out of the switch? It looks like it just ends up returning 0, the=
 same as any other instruction that isn&#39;t executed directly in the anal=
yse_instr() stage.<br>
<br>
Is there anywhere else in the sstep code that deals well with malformed ins=
tructions?<span class=3D"HOEnZb"><font color=3D"#888888"><br>
<br>
-- <br>
Andrew Donnellan=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Software E=
ngineer, OzLabs<br>
<a href=3D"mailto:andrew.donnellan@au1.ibm.com" target=3D"_blank">andrew.do=
nnellan@au1.ibm.com</a>=C2=A0 Australia Development Lab, Canberra<br>
<a href=3D"tel:%2B61%202%206201%208874" value=3D"+61262018874" target=3D"_b=
lank">+61 2 6201 8874</a>=C2=A0(work)=C2=A0 =C2=A0 =C2=A0 =C2=A0 IBM Austra=
lia Limited<br>
<br>
</font></span></blockquote></div><br></div>

--001a113a544e5f01e5052a4a14b4--

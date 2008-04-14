Return-Path: <sygao.research@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.29])
	by ozlabs.org (Postfix) with ESMTP id C9526DE6BA
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 Apr 2008 06:47:01 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 3so944436ywj.39
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 14 Apr 2008 13:46:41 -0700 (PDT)
Mime-Version: 1.0 (Apple Message framework v753)
In-Reply-To: <20080414183255.F056C1C300A3@mail62-sin.bigfish.com>
References: <287479FF-A7FC-4B48-BE1E-FDDCB97D55A9@gmail.com>
	<977C41F842E66D4CB2E41332313B615005CB0A39@XSJ-EXCHVS1.xlnx.xilinx.com>
	<20080414183255.F056C1C300A3@mail62-sin.bigfish.com>
Content-Type: multipart/alternative; boundary=Apple-Mail-4-118042033
Message-Id: <1B35E815-094F-40CB-AEDA-C04A6CBECC07@gmail.com>
From: Shanyuan Gao <sygao.research@gmail.com>
Subject: Re: Problems of using APU/FPU under linux
Date: Mon, 14 Apr 2008 16:46:32 -0400
To: John Bonesio <john.bonesio@xilinx.com>,
	Stephen Neuendorffer <stephenn@xilinx.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--Apple-Mail-4-118042033
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	delsp=yes;
	format=flowed

Thank you very much, Steve and John!

My advisor and I discussed how Linux works with APU/FPU a few days  
ago. And he had the same thoughts with John. My naive guess was it  
would automatically decode FP operations and mask the trap. Now it  
answers my second question. I will try it later.

But for my first question, I searched all (almost all) the files,  
such as head.S, entry.S, head_4xx.S, etc. And added following three  
lines before mtmsr or MTMSRD  are used

ori        r10, r10, 1<<13  /* enable fpu */
oris      r10, r10, 1<<9    /* enable apu */
oris      r10, r10, 1<<3    /* enable apu exception */

However the MSR in trap prompts keeps the same (2d030) before and  
after I added those lines.

[   31.819079] Bad trap at PC: 10000458, MSR: 2d030, vector=800     
Not tainted
[   31.887027]   Signal: 5
[   31.887042]   Code:   0
[   31.887058]   Addr:   0
Trace/breakpoint trap

I guess there must be some places, like some interrupts that changed  
the MSR that I didn't know.

And for FP exceptions, it has two bits (two modes) in MSR. I think  
they are for such exceptions like divided by zero. Do I need to set  
them also?

In my previous build, I also added PPC_FPU under config 40x in arch/ 
ppc/Kconfig. It compiled arch/powerpc/kernel/fpu.S in, but didn't  
help. I will try CONFIG_PPC_FPU later.


Shan

On Apr 14, 2008, at 2:32 PM, John Bonesio wrote:

> Hi,
>
> The Linux kernel itself doesn't issue floating point instructions  
> other than to save and restore the fpu state when necessary.
>
> In Linux, the way it saves and restores the fpu state is to make  
> use of the trap. When the trap (fpu unavailable) occurs, it loads  
> the fpu state for the current task, sets up the MSR, and returns to  
> re-try the instruction.
>
> So, getting the trap is normal. If the FPU is not being set up  
> correctly, then there may be a problem with the restoring of the  
> state.
>
> When you guild the Linux kernel, you need to have CONFIG_PPC_FPU  
> enabled. Otherwise the kernel does not setup the fpu exception  
> handling.
>
> - John
>
>
> On Monday 14 April 2008 10:35, Stephen Neuendorffer wrote:
>>
>> I'm not sure exactly what's going on here.  Generally speaking, if  
>> you
>> have the FPU instantiated in the design and enable the APU in the  
>> msr,
>> then the processor should decode FP instructions and send them  
>> directly
>> to the APU with no trap.  I haven't done this myself, or I could
>> probably give you some better help...
>>
>> One thing you should be aware of is that the there are gcc compiler
>> patches which are necessary to get the FPU working properly.   
>> However, I
>> don't think the failure mode that these patches workaround would  
>> cause a
>> trap, so my guess is that there is still something else wrong.
>>
>> Steve
>>
>>> -----Original Message-----
>>> From: linuxppc-embedded-bounces+stephen=neuendorffer.name@ozlabs.org
>> [mailto:linuxppc-embedded-
>>> bounces+stephen=neuendorffer.name@ozlabs.org] On Behalf Of Shanyuan
>> Gao
>>> Sent: Monday, April 14, 2008 9:18 AM
>>> To: linuxppc-embedded@ozlabs.org
>>> Subject: Problems of using APU/FPU under linux
>>>
>>> Hi,
>>>
>>> Recently I was trying to make APU/FPU working under Linux on Xilinx
>>> ML410. The standalone programs work perfectly. However under Linux,
>>> when I try to use a floating point operation, like *fmuls*, it will
>>> give me a *trap*.
>>>
>>> By studying the user guide from Xilinx and dumping the object files,
>>> I know I need to change the corresponding bits (APU enable, FP
>>> enable, maybe APU Exception enable) in Machine State Register. I
>>> guess I need to enable the bits whenever before the kernel uses
>>> *mtmsr*. However, it doesn't work. I got the same trap with the same
>>> MSR, as I had no APU/FPU before. I also tried to add the FPU.S to  
>>> ppc
>>> tree, but it doesn't work either.
>>>
>>> The questions are
>>> 1. I guess there might be some place that changed MSR after all my
>>> changes. But I don't know where. And can I write a kernel module to
>>> change the MSR after booting in Linux? (well, it's hard for me  
>>> though)
>>>
>>> 2. Does it have any exception/interrupt mechanism to direct FP
>>> operation to APU/FPU? Or after enabling APU/FPU it will mask the
>>> exception/interrupt and decode FP operation by itself?
>>>
>>>
>>> Any ideas are appreciated. Thank you very much!
>>>
>>>
>>> Shan
>>>
>>> _______________________________________________
>>> Linuxppc-embedded mailing list
>>> Linuxppc-embedded@ozlabs.org
>>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>>
>>
>


--Apple-Mail-4-118042033
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=ISO-8859-1

<html><body style=3D"word-wrap: break-word; -webkit-nbsp-mode: space; =
-webkit-line-break: after-white-space; ">
Thank you very much, Steve and John!<div><br></div><div>My advisor and I =
discussed how Linux works with APU/FPU a few days ago. And he had the =
same thoughts with John. My naive guess was it would automatically =
decode FP operations and mask the trap. Now it answers my second =
question. I will try it later.</div><div><br></div><div>But for my first =
question, I searched all (almost all) the files, such as head.S, =
entry.S, head_4xx.S, etc. And added following three lines before mtmsr =
or MTMSRD =A0are used</div><div><br></div><div>ori =A0 =A0 =A0 =A0r10, =
r10, 1&lt;&lt;13 =A0/* enable fpu */</div><div>oris =A0 =A0 =A0r10, r10, =
1&lt;&lt;9 =A0 =A0/* enable apu */</div><div>oris =A0 =A0 =A0r10, r10, =
1&lt;&lt;3 =A0 =A0/* enable apu exception =
*/</div><div><br></div><div>However the MSR in trap prompts keeps the =
same (2d030) before and after I added those =
lines.=A0</div><div><br></div><div><div style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; "><font =
face=3D"Helvetica" size=3D"3" style=3D"font: 12.0px Helvetica">[=A0=A0 =
31.819079] Bad trap at PC: 10000458, MSR: 2d030, vector=3D800=A0=A0=A0 =
Not tainted</font></div><div style=3D"margin-top: 0px; margin-right: =
0px; margin-bottom: 0px; margin-left: 0px; "><font face=3D"Helvetica" =
size=3D"3" style=3D"font: 12.0px Helvetica">[=A0=A0 31.887027]=A0=A0 =
Signal: 5</font></div><div style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; "><font face=3D"Helvetica" =
size=3D"3" style=3D"font: 12.0px Helvetica">[=A0=A0 31.887042]=A0=A0 =
Code:=A0=A0 0</font></div><div style=3D"margin-top: 0px; margin-right: =
0px; margin-bottom: 0px; margin-left: 0px; "><font face=3D"Helvetica" =
size=3D"3" style=3D"font: 12.0px Helvetica">[=A0=A0 31.887058]=A0=A0 =
Addr:=A0=A0 0</font></div><div style=3D"margin-top: 0px; margin-right: =
0px; margin-bottom: 0px; margin-left: 0px; "><font face=3D"Helvetica" =
size=3D"3" style=3D"font: 12.0px Helvetica">Trace/breakpoint =
trap</font></div></div><div><br></div><div>I guess there must be some =
places, like some interrupts that changed the MSR that I didn't know. =
=A0</div><div><br></div><div>And for FP exceptions, it has two bits (two =
modes) in MSR. I think they are for such exceptions like divided by =
zero. Do I need to set them also?</div><div><br></div><div>In my =
previous build, I also added PPC_FPU under config 40x in =
arch/ppc/Kconfig. It compiled arch/powerpc/kernel/fpu.S in, but didn't =
help. I will try CONFIG_PPC_FPU =
later.</div><div><br></div><div><br></div><div>Shan</div><div><br><div><ht=
ml>On Apr 14, 2008, at 2:32 PM, John Bonesio wrote:</html><br =
class=3D"Apple-interchange-newline"><blockquote type=3D"cite"><div =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">Hi,</div><div style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; min-height: =
14px; "><br></div><div style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">The Linux kernel itself doesn't =
issue floating point instructions other than to save and restore the fpu =
state when necessary.</div><div style=3D"margin-top: 0px; margin-right: =
0px; margin-bottom: 0px; margin-left: 0px; min-height: 14px; =
"><br></div><div style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">In Linux, the way it saves and =
restores the fpu state is to make use of the trap. When the trap (fpu =
unavailable) occurs, it loads the fpu state for the current task, sets =
up the MSR, and returns to re-try the instruction.</div><div =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; min-height: 14px; "><br></div><div style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">So, =
getting the trap is normal. If the FPU is not being set up correctly, =
then there may be a problem with the restoring of the state.</div><div =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; min-height: 14px; "><br></div><div style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">When you =
guild the Linux kernel, you need to have CONFIG_PPC_FPU enabled. =
Otherwise the kernel does not setup the fpu exception =
handling.</div><div style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; min-height: 14px; "><br></div><div =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">- John</div><div style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; min-height: =
14px; "><br></div><div style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; min-height: 14px; "><br></div><div =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">On Monday 14 April 2008 10:35, Stephen Neuendorffer =
wrote:</div> <blockquote type=3D"cite"><div style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; min-height: =
14px; "><br></div><div style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">I'm not sure exactly what's =
going on here.<span class=3D"Apple-converted-space">=A0 </span>Generally =
speaking, if you</div><div style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">have the FPU instantiated in the =
design and enable the APU in the msr,</div><div style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">then the =
processor should decode FP instructions and send them directly</div><div =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">to the APU with no trap.<span =
class=3D"Apple-converted-space">=A0 </span>I haven't done this myself, =
or I could</div><div style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">probably give you some better =
help...</div><div style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; min-height: 14px; "><br></div><div =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">One thing you should be aware of is that the there =
are gcc compiler</div><div style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">patches which are necessary to =
get the FPU working properly.<span class=3D"Apple-converted-space">=A0 =
</span>However, I</div><div style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">don't think the failure mode =
that these patches workaround would cause a</div><div style=3D"margin-top:=
 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">trap, =
so my guess is that there is still something else wrong.</div><div =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; min-height: 14px; "><br></div><div style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; =
">Steve</div><div style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; min-height: 14px; "><br></div> =
<blockquote type=3D"cite"><div style=3D"margin-top: 0px; margin-right: =
0px; margin-bottom: 0px; margin-left: 0px; ">-----Original =
Message-----</div><div style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">From: =
linuxppc-embedded-bounces+stephen=3D<a =
href=3D"mailto:neuendorffer.name@ozlabs.org">neuendorffer.name@ozlabs.org<=
/a></div> </blockquote><div style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">[<a =
href=3D"mailto:linuxppc-embedded-">mailto:linuxppc-embedded-</a></div> =
<blockquote type=3D"cite"><div style=3D"margin-top: 0px; margin-right: =
0px; margin-bottom: 0px; margin-left: 0px; ">bounces+stephen=3D<a =
href=3D"mailto:neuendorffer.name@ozlabs.org">neuendorffer.name@ozlabs.org<=
/a>] On Behalf Of Shanyuan</div> </blockquote><div style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; =
">Gao</div> <blockquote type=3D"cite"><div style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">Sent: Monday, =
April 14, 2008 9:18 AM</div><div style=3D"margin-top: 0px; margin-right: =
0px; margin-bottom: 0px; margin-left: 0px; ">To: <a =
href=3D"mailto:linuxppc-embedded@ozlabs.org">linuxppc-embedded@ozlabs.org<=
/a></div><div style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">Subject: Problems of using =
APU/FPU under linux</div><div style=3D"margin-top: 0px; margin-right: =
0px; margin-bottom: 0px; margin-left: 0px; min-height: 14px; =
"><br></div><div style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">Hi,</div><div style=3D"margin-top:=
 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; =
min-height: 14px; "><br></div><div style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">Recently I =
was trying to make APU/FPU working under Linux on Xilinx</div><div =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">ML410. The standalone programs work perfectly. =
However under Linux,</div><div style=3D"margin-top: 0px; margin-right: =
0px; margin-bottom: 0px; margin-left: 0px; ">when I try to use a =
floating point operation, like *fmuls*, it will</div><div =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">give me a *trap*.</div><div style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; =
min-height: 14px; "><br></div><div style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">By studying =
the user guide from Xilinx and dumping the object files,</div><div =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">I know I need to change the corresponding bits (APU =
enable, FP</div><div style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">enable, maybe APU Exception =
enable) in Machine State Register. I</div><div style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">guess I need =
to enable the bits whenever before the kernel uses</div><div =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">*mtmsr*. However, it doesn't work. I got the same =
trap with the same</div><div style=3D"margin-top: 0px; margin-right: =
0px; margin-bottom: 0px; margin-left: 0px; ">MSR, as I had no APU/FPU =
before. I also tried to add the FPU.S to ppc</div><div =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">tree, but it doesn't work either.</div><div =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; min-height: 14px; "><br></div><div style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">The =
questions are</div><div style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">1. I guess there might be some =
place that changed MSR after all my</div><div style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">changes. But =
I don't know where. And can I write a kernel module to</div><div =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">change the MSR after booting in Linux? (well, it's =
hard for me though)</div><div style=3D"margin-top: 0px; margin-right: =
0px; margin-bottom: 0px; margin-left: 0px; min-height: 14px; =
"><br></div><div style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">2. Does it have any =
exception/interrupt mechanism to direct FP</div><div style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; =
">operation to APU/FPU? Or after enabling APU/FPU it will mask =
the</div><div style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">exception/interrupt and decode =
FP operation by itself?</div><div style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; min-height: =
14px; "><br></div><div style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; min-height: 14px; "><br></div><div =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">Any ideas are appreciated. Thank you very =
much!</div><div style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; min-height: 14px; "><br></div><div =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; min-height: 14px; "><br></div><div style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; =
">Shan</div><div style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; min-height: 14px; "><br></div><div =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; =
">_______________________________________________</div><div =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">Linuxppc-embedded mailing list</div><div =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; "><a =
href=3D"mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org<=
/a></div><div style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; "><a =
href=3D"https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://ozl=
abs.org/mailman/listinfo/linuxppc-embedded</a></div> </blockquote><div =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; min-height: 14px; "><br></div><div style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; =
min-height: 14px; "><br></div> </blockquote><div style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; =
min-height: 14px; "><br></div> =
</blockquote></div><br></div></body></html>=

--Apple-Mail-4-118042033--

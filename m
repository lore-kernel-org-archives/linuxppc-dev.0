Return-Path: <manoj.shar@gmail.com>
Received: from nz-out-0102.google.com (nz-out-0102.google.com [64.233.162.193])
	by ozlabs.org (Postfix) with ESMTP id 6517E67BB7
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Sep 2006 17:11:04 +1000 (EST)
Received: by nz-out-0102.google.com with SMTP id i1so249100nzh
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Sep 2006 00:11:03 -0700 (PDT)
Message-ID: <d6dada100609210011k284bf815ie955dc1493aed52c@mail.gmail.com>
Date: Thu, 21 Sep 2006 00:11:02 -0700
From: "Manoj Sharma" <manoj.shar@gmail.com>
To: "Liu Dave-r63238" <DaveLiu@freescale.com>
Subject: Re: Hang with isync
In-Reply-To: <995B09A8299C2C44B59866F6391D263516C018@zch01exm21.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_1086_8588946.1158822662753"
References: <d6dada100609202317s8037f73o624015ac37402c2d@mail.gmail.com>
	<995B09A8299C2C44B59866F6391D263516C018@zch01exm21.fsl.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_1086_8588946.1158822662753
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

The hang has trigerred watchdog timer exception. It points that there is
problem somewhere but don't know what is it.
Even with 2.4, it does not happen regularly. It occurs once in a while and
not reproducable.

On 9/20/06, Liu Dave-r63238 <DaveLiu@freescale.com> wrote:
>
>  First, you must make sure if it really happen at watchdog timer
> exception.
> if it is, you need select one suitable way to fix it.
> Second, I don't believe the sync-isync instructions make it happen.
> you can try the 2.6, I don't know if 2.6 kernel can resolve your problem.
>
> -Dave
>
>  ------------------------------
>   Dave, watchdog timeout is around one second and no cpu activity for tha=
t
> long is something wrong. Is it ok to disable it to hide the problem lying
> somewhere else? Do you think it can be because of sync-isync
> instructions and moving to 2.6 might resolve it?
>
>
> On 9/20/06, Liu Dave-r63238 <DaveLiu@freescale.com> wrote:
> >
> >
> > No MSR is 00029030 and user mode bit is not set here.
> >
> > I had missed it in the prev mail:
> >
> > =05NIP: C0005DA4 XER: 20000000 LR: C0004FE4 SP: C01F3000=05 REGS: c01ef=
f30
> > TRAP: 1020    Not tainted
> > MSR: 00029030 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
> > TASK =3D c01f1080[0] 'swapper' Last syscall: 120
> > last math 00000000 last altivec 00000000
> > =05PLB0: bear=3D 0x08000000 acr=3D   0xbb000000 besr=3D  0x00000000
> >
> > Dave>I notice that MSR and TRAP, MSR is 00029030- the critical interrup=
t
> > enable.
> > Dave>TRAP is 1020. --WatchDog timer exception is happening
> > Dave>You can disable the MSR[CE] bit to no critical exception or disabl=
e
> > the WD timer
> >
> >
> >
> > On 9/20/06, Linas Vepstas <linas@austin.ibm.com > wrote:
> > >
> > > On Thu, Sep 21, 2006 at 08:38:13AM +1000, Benjamin Herrenschmidt
> > > wrote:
> > > > On Wed, 2006-09-20 at 15:31 -0700, Manoj Sharma wrote:
> > > > > This is the stack trace.
> > > > >
> > > > > Registers:
> > > > > GPR00: 00069030
> > >
> > > This is the MSR and it has the user-mode bit set, which is surely
> > > wrong.
> > > This is not how one gets to user space.
> > >
> > > 00048000
> > >
> > > The MSR had this or'ed into it, which is setting the user-mode bit.
> > > Surely that's wrong.
> > >
> > > --linas
> > >
> >
> >
>

------=_Part_1086_8588946.1158822662753
Content-Type: text/html; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>The hang has trigerred watchdog timer exception. It points that there is problem somewhere but&nbsp;don't know what is it.&nbsp;</div>
<div>Even&nbsp;with 2.4, it does not happen regularly. It occurs&nbsp;once in a while&nbsp;and not reproducable.<br>&nbsp;</div>
<div><span class="gmail_quote">On 9/20/06, <b class="gmail_sendername">Liu Dave-r63238</b> &lt;<a href="mailto:DaveLiu@freescale.com">DaveLiu@freescale.com</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div>
<div dir="ltr" align="left"><font face="宋体" color="#0000ff" size="2"><span>First, you&nbsp;must make sure if it really happen at&nbsp;watchdog timer exception.</span></font></div>
<div dir="ltr" align="left"><font face="宋体" color="#0000ff" size="2"><span>if it is, you need select one suitable&nbsp;way to fix it.</span></font></div>
<div dir="ltr" align="left"><font face="宋体" color="#0000ff" size="2"><span>Second, I don't believe the sync-isync instructions make it happen.</span></font></div>
<div dir="ltr" align="left"><font face="宋体" color="#0000ff" size="2"><span>you can try the 2.6, I&nbsp;don't know if 2.6 kernel can&nbsp;resolve your problem.</span></font></div>
<div dir="ltr" align="left"><font face="宋体" color="#0000ff" size="2"><span></span></font>&nbsp;</div>
<div dir="ltr" align="left"><font face="宋体" color="#0000ff" size="2"><span>-Dave</span></font></div><font face="宋体" color="#0000ff" size="2"></font><br>
<blockquote style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #0000ff 2px solid; MARGIN-RIGHT: 0px">
<div lang="en-us" dir="ltr" align="left">
<hr>
</div>
<div><span class="e" id="q_10dcf0e9389aade7_1">
<div></div>
<div>Dave, watchdog timeout is around&nbsp;one second and no cpu activity for that long is something wrong. Is it ok to disable it to hide the problem lying somewhere else? Do you think it can&nbsp;be because of sync-isync instructions&nbsp;and moving to 
2.6 might resolve it?</div>
<div><br>&nbsp;</div>
<div><span class="gmail_quote">On 9/20/06, <b class="gmail_sendername">Liu Dave-r63238</b> &lt;<a onclick="return top.js.OpenExtLink(window,event,this)" href="mailto:DaveLiu@freescale.com" target="_blank">DaveLiu@freescale.com
</a>&gt; wrote:</span> 
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div><span><font face="宋体" color="#0000ff" size="2"></font><font face="宋体" color="#0000ff" size="2"></font>
<div dir="ltr" align="left"><br>No MSR is 00029030 and user mode bit is not set here.<br><br>I had missed it in the prev mail:<br><br>NIP: C0005DA4 XER: 20000000 LR: C0004FE4 SP: C01F3000 REGS: c01eff30 TRAP: 1020&nbsp;&nbsp;&nbsp; Not tainted 
<br>MSR: 00029030 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11 <br>TASK = c01f1080[0] 'swapper' Last syscall: 120<br>last math 00000000 last altivec 00000000<br>PLB0: bear= 0x08000000 acr=&nbsp;&nbsp; 0xbb000000 besr=&nbsp; 0x00000000<br><span><font face="宋体" color="#0000ff" size="2">
&nbsp;</font></span></div></span>
<div dir="ltr" align="left"><span><font face="宋体" color="#0000ff" size="2">Dave&gt;I notice that&nbsp;MSR and TRAP, MSR is 00029030-&nbsp;the&nbsp;critical interrupt enable.</font></span></div>
<div dir="ltr" align="left"><span><font face="宋体" color="#0000ff" size="2">Dave&gt;TRAP is 1020. --WatchDog timer&nbsp;exception is happening</font></span></div>
<div dir="ltr" align="left"><span><font face="宋体" color="#0000ff" size="2">Dave&gt;You can disable the MSR[CE] bit to no critical exception or disable the WD timer</font></span></div><span>
<div dir="ltr" align="left"><br>&nbsp;</div>
<blockquote style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #0000ff 2px solid; MARGIN-RIGHT: 0px">
<div><span class="gmail_quote">On 9/20/06, <b class="gmail_sendername">Linas Vepstas</b> &lt;<a onclick="return top.js.OpenExtLink(window,event,this)" href="mailto:linas@austin.ibm.com" target="_blank">linas@austin.ibm.com 
</a>&gt; wrote:</span> 
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0pt 0pt 0pt 0.8ex; BORDER-LEFT: rgb(204,204,204) 1px solid">On Thu, Sep 21, 2006 at 08:38:13AM +1000, Benjamin Herrenschmidt wrote:<br>&gt; On Wed, 2006-09-20 at 15:31 -0700, Manoj Sharma wrote: 
<br>&gt; &gt; This is the stack trace.<br>&gt; &gt;<br>&gt; &gt; Registers:<br>&gt; &gt; GPR00: 00069030 <br><br>This is the MSR and it has the user-mode bit set, which is surely wrong.<br>This is not how one gets to user space. 
<br><br>00048000<br><br>The MSR had this or'ed into it, which is setting the user-mode bit.<br>Surely that's wrong. <br><br>--linas<br></blockquote></div><br></blockquote></span></div></blockquote></div><br></span></div></blockquote>
</div></blockquote></div><br>

------=_Part_1086_8588946.1158822662753--

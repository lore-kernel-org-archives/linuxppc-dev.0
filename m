Return-Path: <rahul.theraja@gmail.com>
Received: from nz-out-0102.google.com (nz-out-0102.google.com [64.233.162.195])
	by ozlabs.org (Postfix) with ESMTP id 98F3A67A03
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 24 Oct 2006 19:37:58 +1000 (EST)
Received: by nz-out-0102.google.com with SMTP id z31so609587nzd
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 24 Oct 2006 02:37:57 -0700 (PDT)
Message-ID: <ff9652ca0610240237j4c4c3733l15b873890bd56d42@mail.gmail.com>
Date: Tue, 24 Oct 2006 15:07:56 +0530
From: Rahul <rahul.theraja@gmail.com>
To: "Fawad Lateef" <fawadlateef@gmail.com>
Subject: Re: help in block drivers
In-Reply-To: <ff9652ca0610220202w4b0d831bu202ccff8ed941f2d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_4986_10520927.1161682676527"
References: <ff9652ca0610190314u32a620b5qd0bd27a1b2700a22@mail.gmail.com>
	<d16b1c80610190808y17c516dl35cfc8ca4a7a42ad@mail.gmail.com>
	<ff9652ca0610190923vffbb981j1978ce4159489b0c@mail.gmail.com>
	<1e62d1370610192213g7502709ufcc2bce6903040d8@mail.gmail.com>
	<ff9652ca0610220202w4b0d831bu202ccff8ed941f2d@mail.gmail.com>
Cc: kernelnewbies@nl.linux.org, Shakthi Kannan <shakthimaan@gmail.com>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_4986_10520927.1161682676527
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 10/22/06, Rahul <rahul.theraja@gmail.com> wrote:
>
>
>
> On 10/20/06, Fawad Lateef <fawadlateef@gmail.com> wrote:
> >
> > Hello Rahul,
> >
> > First of all please don't do top-posting rather do bottom-posting. For
> > more information search google.
>
>
> oh sorry for that
>
> On 10/19/06, Rahul Theraja <rahul.theraja@gmail.com > wrote:
> > > Hello Shakthi Kannan,
> > >
> > >  Thanks for the reply .
> > >
> > >
> > > > > driver. I could not understand why the "sbd_request " is called
> > even
> > > though
> > > > > i have given only one read call from user space file.
> > > >
> > > > Block device I/O transfer is done in blocks.
> > > >
> > > > >  And also in the driver, in the function sbd_request() how does
> > the
> > > driver
> > > > > get the parameters  like sector, current_nr_sectors and buffer.
> > > >
> > > > VFS <-> SCSI <-> Block device?
> > > >
> >
> > I think its VFS<->Buffer-Cache<->Block-Device and if drive is mounted
> > then VFS<->FS<->Buffer-Cache<->Block-Device
> >
> > > > > i could move
> > > > > furhter fastly.
> > > >
> > > > Fastly? IMHO, learning kernel development involves lot of patience.
> > > >
> > > > SK
> > >
> > >
> > >  Is it necessary to use kernel_thread() in block drivers.
> > In  drivers/block
> > > loop.c i could see  kernel_thread() being used but in floopy.c it is
> > not
> > > used. When is this kernel_thread() function is supposed to be used
> > ?  In the
> > > sbd_device also the kernel_thread() is not used.
> > >
> >
> > First in kernel-2.6.x its better to use kthread_*() rather than
> > kernel_thread if threading is needed.
> >
> > Threading isn't necessary in any device until unless you need it. For
> > example if your driver is emulating a device or performing IO directly
> > then you don't need it, but if your driver is sending request to a
> > device which generates interrupts after completing IO and you want to
> > do some extra work after getting IO completion interrupt then you must
> > use thread. As threads work in process-context, hence can do sleep and
> > lengthy processing but interrupt-context shouldn't sleep or nor do
> > long processing.
> >
> > For getting more understanding about different contexts like process,
> > interrupt, softirqs contexts do search google.
> >
> > >  Anyone please kindly clarify my doubts.
> > >
> >
> > I hope you doubts are not clear.
>
>
Can anyone tell me or send me some links that tells about the following
functions:
daemonize, siginitsetinv , recalc_sigpending . Though i googled, i coildnt
get much information on them.

Thanks in adavance
Rahul



thank you very much for all the help
>
> >  Thanks in Advance
> > >
> > >  -Rahul
> > >
> >
> > --
> > Fawad Lateef
> >
>
>

------=_Part_4986_10520927.1161682676527
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 10/22/06, <b class="gmail_sendername">Rahul</b> &lt;<a href="mailto:rahul.theraja@gmail.com">rahul.theraja@gmail.com</a>&gt; wrote:<div><span class="gmail_quote"></span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<br><br><div><span class="q"><span class="gmail_quote">On 10/20/06, <b class="gmail_sendername">Fawad Lateef</b> &lt;<a href="mailto:fawadlateef@gmail.com" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">
fawadlateef@gmail.com</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hello Rahul,<br><br>First of all please don't do top-posting rather do bottom-posting. For<br>more information search google.</blockquote></span><div><br>
oh sorry for that <br>
</div><div><span class="e" id="q_10e6f41baf5f55ea_3"><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">On 10/19/06, Rahul Theraja &lt;<a href="mailto:rahul.theraja@gmail.com" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">
rahul.theraja@gmail.com
</a>&gt; wrote:<br>&gt; Hello Shakthi Kannan,<br>&gt;<br>&gt;&nbsp;&nbsp;Thanks for the reply .<br>&gt;<br>&gt;<br>&gt; &gt; &gt; driver. I could not understand why the &quot;sbd_request &quot; is called even<br>&gt; though<br>&gt; &gt; &gt; i have given only one read call from user space file.
<br>&gt; &gt;<br>&gt; &gt; Block device I/O transfer is done in blocks.<br>&gt; &gt;<br>&gt; &gt; &gt;&nbsp;&nbsp;And also in the driver, in the function sbd_request() how does the<br>&gt; driver<br>&gt; &gt; &gt; get the parameters&nbsp;&nbsp;like sector, current_nr_sectors and buffer.
<br>&gt; &gt;<br>&gt; &gt; VFS &lt;-&gt; SCSI &lt;-&gt; Block device?<br>&gt; &gt;<br><br>I think its VFS&lt;-&gt;Buffer-Cache&lt;-&gt;Block-Device and if drive is mounted<br>then VFS&lt;-&gt;FS&lt;-&gt;Buffer-Cache&lt;-&gt;Block-Device
<br><br>&gt; &gt; &gt; i could move<br>&gt; &gt; &gt; furhter fastly.<br>&gt; &gt;<br>&gt; &gt; Fastly? IMHO, learning kernel development involves lot of patience.<br>&gt; &gt;<br>&gt; &gt; SK<br>&gt;<br>&gt;<br>&gt;&nbsp;&nbsp;Is it necessary to use kernel_thread() in block drivers. In&nbsp;&nbsp;drivers/block
<br>&gt; loop.c i could see&nbsp;&nbsp;kernel_thread() being used but in floopy.c it is not<br>&gt; used. When is this kernel_thread() function is supposed to be used ?&nbsp;&nbsp;In the<br>&gt; sbd_device also the kernel_thread() is not used.
<br>&gt;<br><br>First in kernel-2.6.x its better to use kthread_*() rather than<br>kernel_thread if threading is needed.<br><br>Threading isn't necessary in any device until unless you need it. For<br>example if your driver is emulating a device or performing IO directly
<br>then you don't need it, but if your driver is sending request to a<br>device which generates interrupts after completing IO and you want to<br>do some extra work after getting IO completion interrupt then you must<br>

use thread. As threads work in process-context, hence can do sleep and<br>lengthy processing but interrupt-context shouldn't sleep or nor do<br>long processing.<br><br>For getting more understanding about different contexts like process,
<br>interrupt, softirqs contexts do search google.<br><br>&gt;&nbsp;&nbsp;Anyone please kindly clarify my doubts.<br>&gt;<br><br>I hope you doubts are not clear.</blockquote></span></div></div></blockquote><div><br>
Can anyone tell me or send me some links that tells about the following functions:<br>
daemonize, siginitsetinv , recalc_sigpending . Though i googled, i coildnt get much information on them.<br>
<br>
Thanks in adavance<br>
Rahul<br>
<br>
&nbsp;</div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div><div>
thank you very much for all the help <br>
</div><span class="q"><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">&gt;&nbsp;&nbsp;Thanks in Advance<br>&gt;<br>&gt;&nbsp;&nbsp;-Rahul<br>&gt;<br><br>--
<br>Fawad Lateef
<br></blockquote></span></div><br>

</blockquote></div><br>

------=_Part_4986_10520927.1161682676527--

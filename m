Return-Path: <jasonal00@googlemail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.187])
	by ozlabs.org (Postfix) with ESMTP id 4D8DD67B55
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  3 Jul 2006 21:09:30 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id p77so623478nfc
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 03 Jul 2006 04:09:29 -0700 (PDT)
Message-ID: <b4ebaa9d0607030359x40aa86eap9139ecc3af6d3b9e@mail.gmail.com>
Date: Mon, 3 Jul 2006 12:59:54 +0200
From: "Qichen Huang" <jasonal00@googlemail.com>
To: "Andrei Konovalov" <akonovalov@ru.mvista.com>
Subject: Re: Problem with Xilinx Uart Lite
In-Reply-To: <44A5178A.5050808@ru.mvista.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_30000_3291748.1151924394699"
References: <b4ebaa9d0606290820y4dce2ce2x8d28007b1d591eef@mail.gmail.com>
	<44A3F29F.8020507@ru.mvista.com>
	<b4ebaa9d0606290959w528cac73qd0674c3b1de33a15@mail.gmail.com>
	<44A41C6B.4080701@ru.mvista.com>
	<b4ebaa9d0606291210p5c8284b9mec6ee8d3ed4b0ad8@mail.gmail.com>
	<44A5040B.8020508@ru.mvista.com>
	<b4ebaa9d0606300426v2a0b47d4mc49232dcacec19e3@mail.gmail.com>
	<44A5178A.5050808@ru.mvista.com>
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

------=_Part_30000_3291748.1151924394699
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello Andrei,

Thank you. I have tried this patch, but without luck, the system can not
start, there's no login prompt.
Boot stopps after starting system.
The boot log looks like this:

loaded at: 00400000 004C51E0
board data at: 004C2138 004C2150
relocated to: 0040530C 00405324
zimage at: 00405811 004C1A00
avail ram: 004C6000 04000000

Linux/PPC load: console=ttl0 ip=off root=/dev/xsysace/disc0/part3 rw
Uncompressing Linux...done.
Now booting the kernel
......

Welcome to ML300 powerpc linux 2.4.21, E.I.S. edition

Starting system...
mounting /proc: done.
Mounting '/' read-write: mount: Cannot read /etc/mtab: No such file or
directory

done.
brining up loopback interface: done.
Setup IP-address for eth0: done.
Mounting /tmp: done.
Starting syslogd: done.
Starting klogd: done.
Starting


Thanks,
Qichen

ps. Sorry, I forgot to post this to the mailing list.


On 6/30/06, Andrei Konovalov <akonovalov@ru.mvista.com> wrote:
>
> Seeing a lot of ^M (LF) characters in the end of lines makes me think
> you are using [Win]DOS.
> This makes the patch to look somewhat funny - some of the lines terminated
> with
> <CR> only ("Unix style"), some - with <CR><LF> ("DOS style").
>
> Please try the attached patch. It should help.
>
> Thanks,
> Andrei
>
> Qichen Huang wrote:
> > Hello,
> >
> > attached is my xuartlite_serial.c
> >
> > Thanks,
> > Qichen
> >
> > On 6/30/06, *Andrei Konovalov* <akonovalov@ru.mvista.com
> > <mailto:akonovalov@ru.mvista.com>> wrote:
> >
> >      > Xilinx OS Independent Code XAssert: xuartlite.c:194
> >      > Code may crash due to unhandled errors.
> >
> >     So this is inside XUartLite_Send().
> >     Could you send me your xuartlite_serial.c?
> >     Seems yours doesn't have one of the fixes.
> >
> >     Thanks,
> >     Andrei
>
>
>

------=_Part_30000_3291748.1151924394699
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello Andrei,<br><br>Thank you. I have tried this patch, but without luck, the system can not start, there's no login prompt. <br>Boot stopps after starting system.<br>The boot log looks like this:<br><br>loaded at:     00400000 004C51E0
<br>board data at: 004C2138 004C2150<br>relocated to:  0040530C 00405324<br>zimage at:     00405811 004C1A00<br>avail ram:     004C6000 04000000<br><br>Linux/PPC load: console=ttl0 ip=off root=/dev/xsysace/disc0/part3 rw<br>
Uncompressing Linux...done.<br>Now booting the kernel<br>......<br><br>Welcome to ML300 powerpc linux 2.4.21, E.I.S. edition<br><br>Starting system...<br>mounting /proc: done.<br>Mounting '/' read-write: mount: Cannot read /etc/mtab: No such file or directory
<br><br>done.<br>brining up loopback interface: done.<br>Setup IP-address for eth0: done.<br>Mounting /tmp: done.<br>Starting syslogd: done.<br>Starting klogd: done.<br>Starting<br><br><br>Thanks, <br>Qichen<br><br>ps. Sorry, I forgot to post this to the mailing list. 
<br><br><br><div><span class="gmail_quote">On 6/30/06, <b class="gmail_sendername">Andrei Konovalov</b> &lt;<a href="mailto:akonovalov@ru.mvista.com">akonovalov@ru.mvista.com</a>&gt; wrote:</span><blockquote class="gmail_quote" style="margin-top: 0; margin-right: 0; margin-bottom: 0; margin-left: 0; margin-left: 0.80ex; border-left-color: #cccccc; border-left-width: 1px; border-left-style: solid; padding-left: 1ex">
Seeing a lot of ^M (LF) characters in the end of lines makes me think<br>you are using [Win]DOS.<br>This makes the patch to look somewhat funny - some of the lines terminated with<br>&lt;CR&gt; only (&quot;Unix style&quot;), some - with &lt;CR&gt;&lt;LF&gt; (&quot;DOS style&quot;).
<br><br>Please try the attached patch. It should help.<br><br>Thanks,<br>Andrei<br><br>Qichen Huang wrote:<br>&gt; Hello,<br>&gt;<br>&gt; attached is my xuartlite_serial.c<br>&gt;<br>&gt; Thanks,<br>&gt; Qichen<br>&gt;<br>
&gt; On 6/30/06, *Andrei Konovalov* &lt;<a href="mailto:akonovalov@ru.mvista.com">akonovalov@ru.mvista.com</a><br>&gt; &lt;mailto:<a href="mailto:akonovalov@ru.mvista.com">akonovalov@ru.mvista.com</a>&gt;&gt; wrote:<br>&gt;
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&gt; Xilinx OS Independent Code XAssert: xuartlite.c:194<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&gt; Code may crash due to unhandled errors.<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; So this is inside XUartLite_Send().<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; Could you send me your xuartlite_serial.c?
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; Seems yours doesn't have one of the fixes.<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; Thanks,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; Andrei<br><br><br></blockquote></div><br>

------=_Part_30000_3291748.1151924394699--

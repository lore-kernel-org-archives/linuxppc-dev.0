Return-Path: <yang.reeve@gmail.com>
Received: from nz-out-0102.google.com (nz-out-0102.google.com [64.233.162.199])
	by ozlabs.org (Postfix) with ESMTP id F3E6067BAC
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 30 Sep 2006 08:03:24 +1000 (EST)
Received: by nz-out-0102.google.com with SMTP id i1so411993nzh
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 29 Sep 2006 15:03:23 -0700 (PDT)
Message-ID: <198592450609291503s7be0200ehf72925c2cae07787@mail.gmail.com>
Date: Fri, 29 Sep 2006 22:03:22 +0000
From: "Reeve Yang" <yang.reeve@gmail.com>
To: "Michael Galassi" <mgalassi@c-cor.com>
Subject: Re: Need help on PPC8343E bringup
In-Reply-To: <200609292139.k8TLdV10081103@penguin.ncube.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_12895_8089022.1159567402872"
References: <198592450609291408w2dbf7e5ckf5e4cf7023d2000@mail.gmail.com>
	<200609292133.k8TLXUUv072654@penguin.ncube.com>
	<200609292139.k8TLdV10081103@penguin.ncube.com>
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

------=_Part_12895_8089022.1159567402872
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thanks Machael.

On my flash data sheet, there are some command about security:

Lock Block | Block Address | 0060h | Block Address | 0001h
Unlock Block|Block Address| 0060h | Block Address | 00d0h

So I guess it needs two write cycle to perfomr the command, and the unlock
command should be 006000d0. I tried that but still get the same error. Bad!
:(

Another questions is that is there any way to change CPU register directy?
For 8343E all registers are mapped to 1m starting from 0xff400000. I want to
change on 0Xff400c08, but visionclick reject me to write on that address.

- Reeve

On 9/29/06, Michael Galassi <mgalassi@c-cor.com> wrote:
>
>
> >>Hello linux-ppc experts,
> >>
> >>I'm trying to use using wind river jtag probe to download uboot to our
> >>switching box which is with PPC8343E/Intel 28F128J3D memory flash(16M).
> >>Memory mapping is starting from 0xFF000000 to 0xFFFFFFFF which is 16M.
> The
> >>JTAG software I'm using is visionclick8.
> >>
> >>The problem now is that I even couldn't erash flash, with following
> error
> >>message:
> >>
> >>TF ERASE FFF00000..FFFFFFFF INTEL  28F128Jx ( 8192 x 16 )  1 Device
> >>Erasing Flash(s) ... Failed
> >>!ERROR! - [msg100000] Failed while erasing the device(s)
> >>>BKM>
> >>!HALT! - [msg90009] Target Stopped : CheckStop taken; PC = 0x00007404
> [EVENT
> >>Taken]
> >>>BKM>
> >>
> >>Does anyone has experiece to bring up this CPU, and could shed some
> lights
> >>on it? Thank you in advance.
> >>
> >>- Reeve
> >
> >Your flash part[s] are almost certainly write-protected, or part of them
> >is.  Get the data-sheet for them and find what combination to write to
> >them to un-protect them and try again.  For the parts I'm using (micron
> >MT28F128J3) writing 0x00600060 followed by 0x00d000d0 to the part does
> >the trick.
> >
> >-michael
>
> I must be lonely, responding to my own email :-).
>
> The other option you have is re-build u-boot to run from ram (presumably
> at some lower address), then use u-boot itself to clear the write
> protect bits on your flash.  U-boot's makefile has config targets for
> ram & flash for some target boards which you may be able to take
> advantage of.  My first solution is probably still quicker if you're not
> trying to debug u-boot itself.
>
> -michael
>

------=_Part_12895_8089022.1159567402872
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thanks Machael.<br>
<br>
On my flash data sheet, there are some command about security:<br>
<br>
Lock Block | Block Address | 0060h | Block Address | 0001h<br>
Unlock Block|Block Address| 0060h | Block Address | 00d0h<br>
<br>
So I guess it needs two write cycle to perfomr the command, and the
unlock command should be 006000d0. I tried that but still get the same
error. Bad! :(<br>
<br>
Another questions is that is there any way to change CPU register
directy? For 8343E all registers are mapped to 1m starting from
0xff400000. I want to change on 0Xff400c08, but visionclick reject me
to write on that address.<br>
<br>
- Reeve<br><br><div><span class="gmail_quote">On 9/29/06, <b class="gmail_sendername">Michael Galassi</b> &lt;<a href="mailto:mgalassi@c-cor.com">mgalassi@c-cor.com</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<br>&gt;&gt;Hello linux-ppc experts,<br>&gt;&gt;<br>&gt;&gt;I'm trying to use using wind river jtag probe to download uboot to our<br>&gt;&gt;switching box which is with PPC8343E/Intel 28F128J3D memory flash(16M).<br>&gt;&gt;Memory mapping is starting from 0xFF000000 to 0xFFFFFFFF which is 16M. The
<br>&gt;&gt;JTAG software I'm using is visionclick8.<br>&gt;&gt;<br>&gt;&gt;The problem now is that I even couldn't erash flash, with following error<br>&gt;&gt;message:<br>&gt;&gt;<br>&gt;&gt;TF ERASE FFF00000..FFFFFFFF INTEL&nbsp;&nbsp;28F128Jx ( 8192 x 16 )&nbsp;&nbsp;1 Device
<br>&gt;&gt;Erasing Flash(s) ... Failed<br>&gt;&gt;!ERROR! - [msg100000] Failed while erasing the device(s)<br>&gt;&gt;&gt;BKM&gt;<br>&gt;&gt;!HALT! - [msg90009] Target Stopped : CheckStop taken; PC = 0x00007404 [EVENT<br>
&gt;&gt;Taken]<br>&gt;&gt;&gt;BKM&gt;<br>&gt;&gt;<br>&gt;&gt;Does anyone has experiece to bring up this CPU, and could shed some lights<br>&gt;&gt;on it? Thank you in advance.<br>&gt;&gt;<br>&gt;&gt;- Reeve<br>&gt;<br>&gt;Your flash part[s] are almost certainly write-protected, or part of them
<br>&gt;is.&nbsp;&nbsp;Get the data-sheet for them and find what combination to write to<br>&gt;them to un-protect them and try again.&nbsp;&nbsp;For the parts I'm using (micron<br>&gt;MT28F128J3) writing 0x00600060 followed by 0x00d000d0 to the part does
<br>&gt;the trick.<br>&gt;<br>&gt;-michael<br><br>I must be lonely, responding to my own email :-).<br><br>The other option you have is re-build u-boot to run from ram (presumably<br>at some lower address), then use u-boot itself to clear the write
<br>protect bits on your flash.&nbsp;&nbsp;U-boot's makefile has config targets for<br>ram &amp; flash for some target boards which you may be able to take<br>advantage of.&nbsp;&nbsp;My first solution is probably still quicker if you're not
<br>trying to debug u-boot itself.<br><br>-michael<br></blockquote></div><br>

------=_Part_12895_8089022.1159567402872--

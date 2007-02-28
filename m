Return-Path: <sipcop009@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.249])
	by ozlabs.org (Postfix) with ESMTP id 138ACDDE00
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  1 Mar 2007 10:52:34 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id b21so281611ana
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Feb 2007 15:52:33 -0800 (PST)
Message-ID: <5a4792c00702281552r77bf60d9v4991f9efeff09374@mail.gmail.com>
Date: Wed, 28 Feb 2007 15:52:27 -0800
From: "SIP COP 009" <sipcop009@gmail.com>
To: "Gary Kenaley" <gkenaley@echelon.com>
Subject: Re: Gianfar on 8347 sometimes get stuck at startup
In-Reply-To: <DDBD7B17DB2ECE48BCD94C593F7255B40223B4A6@monk.echelon.echcorp.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_52315_25013173.1172706747425"
References: <DDBD7B17DB2ECE48BCD94C593F7255B40223B4A6@monk.echelon.echcorp.com>
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

------=_Part_52315_25013173.1172706747425
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Ok, we found the root cause. It is the MARVELL PHY 8e1111 which was to
blame. The PHY needs an explicit RESET after any changes are done to the
config. After doing this, the problem goes away.

On 2/22/07, Gary Kenaley <gkenaley@echelon.com> wrote:
>
>  I see a similar problem on the MPC8349E MDS (V1.1 CPUs) in that the first
> ping or tftpboot command often doesn't work in u-boot 1.1.3 or (much less
> often) Wind River Linux kernel 2.6.14. The problem seems least severe on a
> node-to-node gigabit connection and most severe on a public 100BT network. I
> haven't been able to isolate the cause, but the severity seems dependent on
> the driver characteristics of the equipment that the 8349 is communicating
> with. In my case I also see very erratic ping times to the NFS server
> (dependent on how Kudzu configured its e1000 driver). The 8349 sometimes
> slows to a crawl and fills the logs with watchdog messages when it mounts
> NFS partitions and hits the INIT phase of boot-up. This is all with
> out-of-the box software from Motorola and Wind River. Maybe we will have
> better luck with the V3.0 CPUs? I wish I could use 2.6.18, but I'm stuck
> at 2.6.14.
>
> Regards, Gary
>
> ------------------------------
> *From:* linuxppc-embedded-bounces+gkenaley=echelon.com@ozlabs.org on
> behalf of SIP COP 009
> *Sent:* Thu 2/22/2007 9:14 PM
> *To:* linuxppc-embedded@ozlabs.org
> *Cc:* sipcop009@gmail.com
> *Subject:* Gianfar on 8347 sometimes get stuck at startup
>
>
> We have the our own MPC8349 based board which has 2 GigEs. It is pretty
> much modelled similar to the 8349ADS EVAL boards, infact we have zero
> changes.
>
> The issue that we are seeing -
>
> Sometimes at startup, we have send 2 TX packets to kind-of-kickstart the
> TSEC Tranmission. If we send only packet it does not get to the other side.
> This does not happen always.
>
> The TSEC Registers dont really show any errors nor does the Marvell PHY
> show any errors.
>
> The kernel that we are using is 2.6.11.
>
> Anybody  seen this before or something similar ?
>
> Any pointers will be appreciated. We cannot move to any other kernel
> verision right now.
>
> Thanks!
> ashutosh
>
>

------=_Part_52315_25013173.1172706747425
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Ok, we found the root cause. It is the MARVELL PHY 8e1111 which was to blame. The PHY needs an explicit RESET after any changes are done to the config. After doing this, the problem goes away.<br><br><div><span class="gmail_quote">
On 2/22/07, <b class="gmail_sendername">Gary Kenaley</b> &lt;<a href="mailto:gkenaley@echelon.com">gkenaley@echelon.com</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">



<div>
<div dir="ltr">
<div dir="ltr"><font color="#000000" face="Arial" size="2">I see a similar problem on 
the MPC8349E MDS (V1.1&nbsp;CPUs)&nbsp;in that the first ping or tftpboot 
command often doesn&#39;t work in u-boot 1.1.3 or (much less often) Wind River Linux 
kernel 2.6.14. The problem seems least severe on a node-to-node gigabit 
connection and most severe on a public 100BT network. I haven&#39;t been able to 
isolate the cause, but&nbsp;the severity&nbsp;seems dependent on the driver 
characteristics of the equipment that the 8349 is communicating with. In my case 
I also see very erratic ping times to the NFS server (dependent on how Kudzu 
configured its e1000 driver). The&nbsp;8349 sometimes slows to a crawl and fills 
the logs with watchdog messages when it mounts NFS partitions&nbsp;and hits the 
INIT phase of boot-up. This is all with out-of-the box software from Motorola 
and Wind River. Maybe we will have better luck with the V3.0 CPUs? I wish I 
could use 2.6.18, but I&#39;m stuck at 2.6.14.</font></div>
<div dir="ltr"><font face="Arial" size="2"></font>&nbsp;</div>
<div dir="ltr"><font face="Arial" size="2">Regards, Gary</font></div></div>
<div dir="ltr"><br>
<hr>
<font face="Tahoma" size="2"><b>From:</b> 
linuxppc-embedded-bounces+gkenaley=<a href="mailto:echelon.com@ozlabs.org" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">echelon.com@ozlabs.org</a> on behalf of SIP COP 
009<br><b>Sent:</b> Thu 2/22/2007 9:14 PM<br><b>To:</b> 
<a href="mailto:linuxppc-embedded@ozlabs.org" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">linuxppc-embedded@ozlabs.org</a><br><b>Cc:</b> 
<a href="mailto:sipcop009@gmail.com" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">sipcop009@gmail.com</a><br><b>Subject:</b> Gianfar on 8347 sometimes get stuck at 
startup<br></font><br></div><div><span class="e" id="q_110ed36a632b0359_1">
<div>
<div>&nbsp;</div>
<div>We have the our own MPC8349 based&nbsp;board which has 2 GigEs. It is 
pretty much modelled similar to the 8349ADS EVAL boards, infact we have zero 
changes.</div>
<div>&nbsp;</div>
<div>The issue that we are seeing - </div>
<div>&nbsp;</div>
<div>Sometimes at startup, we have send 2 TX packets to kind-of-kickstart the 
TSEC Tranmission. If we send only packet it does not get to the other side. This 
does not happen always.</div>
<div>&nbsp;</div>
<div>The TSEC Registers dont really show any errors nor does the Marvell PHY 
show any errors.</div>
<div>&nbsp;</div>
<div>The kernel that we are using is 2.6.11.</div>
<div>&nbsp;</div>
<div>Anybody &nbsp;seen this before or something similar ? </div>
<div>&nbsp;</div>
<div>Any pointers will be appreciated. We cannot move to any other kernel 
verision right now.</div>
<div>&nbsp;</div>
<div>Thanks!</div>
<div>ashutosh</div>
<div>&nbsp;</div></div></span></div></div>
</blockquote></div><br>

------=_Part_52315_25013173.1172706747425--

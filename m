Return-Path: <samlinuxppc@yahoo.com.cn>
Received: from web15810.mail.cnb.yahoo.com (web15810.mail.cnb.yahoo.com
	[202.165.102.90]) by ozlabs.org (Postfix) with SMTP id 42A312BF07
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 14 Dec 2004 12:51:25 +1100 (EST)
Message-ID: <20041214015124.55109.qmail@web15810.mail.cnb.yahoo.com>
Date: Tue, 14 Dec 2004 09:51:24 +0800 (CST)
From: Sam Song <samlinuxppc@yahoo.com.cn>
To: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
In-Reply-To: <20041207113615.9141.qmail@web15805.mail.cnb.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Subject: System hanged,
	which one is the killer? [was Re: What's the problem could be?]
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Sam Song <samlinuxppc@yahoo.com.cn> wrote：
> Hi, all
> 
> An system application crash running on 2.4.18 was
> happened on my custom 8xx board every now and then,
> especially recently. Yeah, the probelm is becoming
> more and more obvious. Personally, I deem it as an
> default of application software because there are
> some complicated application softwares like GUI and
a
> browser. But I also suspect that my custom keyboard
> did it because there were about 70-80 PCMCIA
> interrupts created once I hit just one key. I used
> PCMCIA interrupt to accept the rubber keyboard
> input.

Well, after some test on keyboard drivers, I found
that neither USB HOST keyboard nor my PCMCIA keyboard
could lead to system hang. It seems that the killer
isn't the PCMCIA keyboard driver.
 
> Any other possibility?

Seems have. The interesting thing was that I could
quit from the hanged application with a special key
and restarted the application and continued operate.
I, however, noticed some errors hints printed on the
LCD panel as "No enough video memory" during the
break.

So my attention was drawn to the 823 LCD driver. Two
different 10.4" SHARP TFT LCD panel with 640*480 and
800*600 were tested on the same target. I found that
640*480 system was more robust than 800*600 one. There
were also some hang happened with some disorder input
on 640*480 but the system could recover to normal
after some time like 3-5 mintues. The recoverable
result never appeared on 800*600.

Here I'd like to make sure one thing that whether I
could extend the video memory to meet the application
need. There are a lot of RAM on my target, at least
64MB. Any suggestion?

Thanks in advance,

=====
Best regards,

Sam

_________________________________________________________
Do You Yahoo!?
150万曲MP3疯狂搜，带您闯入音乐殿堂
http://music.yisou.com/
美女明星应有尽有，搜遍美图、艳图和酷图
http://image.yisou.com
1G就是1000兆，雅虎电邮自助扩容！
http://cn.rd.yahoo.com/mail_cn/tag/1g/*http://cn.mail.yahoo.com/event/mail_1g/

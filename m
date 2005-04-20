Return-Path: <samlinuxppc@yahoo.com.cn>
Received: from web15809.mail.cnb.yahoo.com (web15809.mail.cnb.yahoo.com
	[202.165.102.89]) by ozlabs.org (Postfix) with SMTP id CFC2467A6C
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Apr 2005 23:59:53 +1000 (EST)
Message-ID: <20050420135951.78443.qmail@web15809.mail.cnb.yahoo.com>
Date: Wed, 20 Apr 2005 21:59:51 +0800 (CST)
From: Sam Song <samlinuxppc@yahoo.com.cn>
To: "Mark A. Greer" <mgreer@mvista.com>
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: 824x Sandpoint with 2.6.x
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

"Mark A. Greer" <mgreer@mvista.com> wrote:
> Get rid of the
> "console=uart,mmio,0xfdfce500,115200n8" part of the
> cmdline and see what happens (keep the
> "console=ttyS0,115200" part).

I suspect there are sth wrong with uart iomem_base.
In my 2.4.24 porting, the following two lines must
be added in sandpoint_setup_arch, or I could get the
same result as 2.6.x.

rs_table[0].port = (ulong) ioremap (rs_table[0].port,
PAGE_SIZE);
rs_table[0].iomem_base = (u8 *) rs_table[0].port;

But the pity is that there are no rs_table used in
2.6.x serial driver.

Thanks again,

Sam

_________________________________________________________
Do You Yahoo!?
150万曲MP3疯狂搜，带您闯入音乐殿堂
http://music.yisou.com/
美女明星应有尽有，搜遍美图、艳图和酷图
http://image.yisou.com
1G就是1000兆，雅虎电邮自助扩容！
http://cn.rd.yahoo.com/mail_cn/tag/1g/*http://cn.mail.yahoo.com/event/mail_1g/

Return-Path: <jonsmirl@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.224])
	by ozlabs.org (Postfix) with ESMTP id E6ED5DDDFC
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Sep 2007 05:29:11 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id 71so888974wri
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 18 Sep 2007 12:29:10 -0700 (PDT)
Message-ID: <9e4733910709181229m4afe7ecr56e2411f52a84232@mail.gmail.com>
Date: Tue, 18 Sep 2007 15:29:09 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Domen Puncer" <domen@coderock.org>
Subject: Re: [PATCH] phy: export phy_mii_ioctl
In-Reply-To: <20070918151622.GD32628@nd47.coderock.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20070810095153.GC13994@moe.telargo.com>
	<20070902074143.GB2642@nd47.coderock.org>
	<fa686aa40709030857j6c36c87ek60215f812864ee0f@mail.gmail.com>
	<20070915121444.GA19857@nd47.coderock.org>
	<20070917095334.GA4546@powerlinux.fr>
	<20070917202140.GB2642@nd47.coderock.org>
	<9e4733910709171508s76c842c8hca236249617cbb44@mail.gmail.com>
	<20070918151622.GD32628@nd47.coderock.org>
Cc: netdev@vger.kernel.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 9/18/07, Domen Puncer <domen@coderock.org> wrote:
> More testing and getting it to work properly on Phytec pcm030 would
> be great.

Do we want to do anything about this?

[    1.569657] net eth0: attached phy 0 to driver Generic PHY
[    2.576013] Sending DHCP requests .<6>PHY: f0003000:00 - Link is Up
- 100/Full
[    4.612000] ., OK
[    6.764005] IP-Config: Got DHCP answer from 192.168.1.200, my
address is 192.168.1.5

What is happening is the printk for "<6>PHY: f0003000:00 - Link is Up
- 100/Full" is done in an interrupt and it comes in the middle of the
kernel doing DHCP and printing ... without a CR.

Two possible solutions, get rid of the link-up message or wait in in
the initial driver load until the link is up. Or we could leave it the
way it is, but some people may report this as a bug.


-- 
Jon Smirl
jonsmirl@gmail.com

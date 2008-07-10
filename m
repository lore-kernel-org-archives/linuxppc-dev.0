Return-Path: <lark@linux.net.cn>
Received: from mx.linux.net.cn (unknown [210.82.31.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A85D6DDEE8
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jul 2008 00:33:03 +1000 (EST)
Message-ID: <48761D7F.4050502@linux.net.cn>
Date: Thu, 10 Jul 2008 22:32:31 +0800
From: Wang Jian <lark@linux.net.cn>
MIME-Version: 1.0
To: "Welch, Martyn (GE EntSol,
	Intelligent Platforms)" <martyn.welch@gefanuc.com>
Subject: Re: [PATCH 0/2] Fix register misuse in drivers/net/phy/marvel.c
References: <4875707D.8060808@linux.net.cn> <487576E0.10501@linux.net.cn>
	<1CADFA951940554D86FBD8B24BBFF3A0019BEA37@LONMLVEM08.e2k.ad.ge.com>
In-Reply-To: <1CADFA951940554D86FBD8B24BBFF3A0019BEA37@LONMLVEM08.e2k.ad.ge.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Welch, Martyn (GE EntSol, Intelligent Platforms) 写道:
> Wang Jian wrote:
>> It may not be appropriate to post here instead of netdev, but I am
>> using 
>> powerpc dev board and I think there will be someone here who has board
>> to test.
>>
>> Wang Jian 写道:
>>> These 2 patches fixed misuse of register for 88e1111.
>>>
>>> Notice: These two patches didn't fix some auto selection problem
>>> yet. I will discuss the problem in seperate email.
>>>
> 
> Hi,
> 
> I have a board here with a pair of 88e1111's, though I'm not sure how to go about testing these patches. It's not the applying or compiling that the problem, but how to test it...
> 
> Do you have any test case in mind?
> 

Hi,

The problem I want to fix is:

1. Plug the fiber and start the board in u-boot, the fiber link is 
established, you can transfer data using fiber link;

2. boot the kernel (not fixed one),  when you "ifconfig ethX up" (ethX 
uses 88e1111), the fiber link light goes off, the fiber link is lost;

After apply the patch #1, for the step 2, you can "ifconfig ethX 
w.x.y.z" and fiber link is ok. You can use the fiber link to transfer data.

I my case, the chip is in GMII mode. The patch #2 is obvious but I can't 
test it myself.

BTW, the two patches doesn't fix the problem when you unplug the fiber 
then plug back. That is another problem I have _partially_ fixed by 
patch marvell_read_status().

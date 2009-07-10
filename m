Return-Path: <sachinp@in.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 5E044B6F1F
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Jul 2009 18:35:33 +1000 (EST)
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [59.145.155.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp06.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 645DBDDDE9
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Jul 2009 18:35:31 +1000 (EST)
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by e28smtp06.in.ibm.com (8.13.1/8.13.1) with ESMTP id n6A8ZKTl029102
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Jul 2009 14:05:20 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n6A8ZJgn1806562
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Jul 2009 14:05:19 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
	by d28av04.in.ibm.com (8.13.1/8.13.3) with ESMTP id n6A8ZJba020921
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Jul 2009 18:35:19 +1000
Message-ID: <4A56FD45.6060304@in.ibm.com>
Date: Fri, 10 Jul 2009 14:05:17 +0530
From: Sachin Sant <sachinp@in.ibm.com>
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Badness at drivers/char/tty_ldisc.c:210 during shutdown
References: <4A3A2D2B.7070704@in.ibm.com>	<4A3F281F.9000408@in.ibm.com>
	<1245655421.4400.78.camel@concordia>
	<20090622095245.38edafdd@lxorguk.ukuu.org.uk>
In-Reply-To: <20090622095245.38edafdd@lxorguk.ukuu.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alan Cox wrote:
>>> [c00000003cf6ba70] [c00000000040a3d0] .tty_ldisc_put+0xa4/0xf4 (unreliable)
>>> [c00000003cf6bb10] [c00000000040a7c8] .tty_ldisc_reinit+0x38/0x80
>>> [c00000003cf6bba0] [c00000000040b1d8] .tty_ldisc_hangup+0x190/0x260
>>> [c00000003cf6bc40] [c000000000401090] .do_tty_hangup+0x188/0x4c0
>>> [c00000003cf6bd20] [c000000000401440] .tty_vhangup_self+0x34/0x54
>>> [c00000003cf6bdb0] [c00000000019236c] .sys_vhangup+0x38/0x58
>>> [c00000003cf6be30] [c000000000008534] syscall_exit+0x0/0x40
>>> Instruction dump:
>>> 912b0088 4bcd17bd 60000000 e87e8008 7f44d378 481c04fd 60000000 801b0008 
>>> 7c09fe70 7d200278 7c004850 54000ffe <0b000000> 7f63db78 4bd7c98d 60000000 
>>>       
>> Ah right, so this has check has just gone in, and the code in question
>> has been rewritten somewhat just recently.
>>     
>
> The check is to catch any cases where a line discipline is being freed up
> but has a refcount that is non zero. I think I know what is going on here.
>   
This issue can be recreated with 2.6.31-rc2-git4 kernel
(34f25476ace556263784ea2f8173e22b25557a13).

Thanks
-Sachin


-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------

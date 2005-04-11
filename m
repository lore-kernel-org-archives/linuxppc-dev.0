Return-Path: <andid@gmx.net>
Received: from bullshit.yoobay.net (projekt.yoobay.net [62.111.67.101])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BD30A67A67
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 12 Apr 2005 02:11:44 +1000 (EST)
Received: from [10.1.1.125] (pD9E7F9AF.dip.t-dialin.net [217.231.249.175])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by bullshit.yoobay.net (Postfix) with ESMTP id 4F6B82D169
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 11 Apr 2005 17:12:39 +0200 (CEST)
Message-ID: <425A92FD.8070301@gmx.net>
Date: Mon, 11 Apr 2005 17:08:45 +0200
From: Andre' Draszik <andid@gmx.net>
MIME-Version: 1.0
To: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
References: <Pine.LNX.4.61.0504110931540.6667@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.61.0504110931540.6667@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Subject: Re: moving from devfs to udev with 2.6 kernel on 8xx board?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

Robert P. J. Day wrote:
> before i start reading up on udev, any guidance on whether this will
> be straightforward, or will i want to slit my wrists by lunch time?
> thanks.

for me, this was quite straightforward on a 405 board. you should 
remeber to create two device nodes in your filesystem, though:

crw-rw----  1 root root 5, 1 2005-04-04 04:03 console
crw-rw-rw-  1 root root 1, 3 2005-02-20 11:39 null

else it won't work...

one thing to note is that udev is quite slow on bootup (at least here). 
after init is started some initial device nodes are created, this takes 
like 5 to 10 seconds here. i don't know if there is a way to decrease 
that time:

Freeing unused kernel memory: 92k init
INIT: version 2.86 booting
Mounting a tmpfs over /dev...done.
Creating initial device nodes...done.

that is a bit annoying... but i didn't put any energy in resolving that 
issue yet, so maybe it's easy ;)


hth,
andre

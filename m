Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id E70FEDDD0C
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Jul 2007 05:46:55 +1000 (EST)
Message-ID: <4697D729.5010307@ru.mvista.com>
Date: Fri, 13 Jul 2007 23:48:57 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Marc Leeman <marc.leeman@gmail.com>
Subject: Re: 2.6.22 flash boot
References: <20070713194013.GU2660@chiana.homelinux.org>
In-Reply-To: <20070713194013.GU2660@chiana.homelinux.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Marc Leeman wrote:

> With the release of the 2.6.22, our boards didn't boot anymore. I traced
> the change back to 2.6.21-git10/2.6.21-git11. 

> The reason they didn't boot was that the kernel  didn't detect the flash
> where the root filesystem is stored on. The boards boot without an
> initrd, directly from flash.

> A file was removed (rom.c) and mentioned as obsolete in the ChangeLog.

[...]

> Am I missing something here?

    It's been removed as conflicting with the new of_device probing code.
You can either register the "rom" device explicitly in your platform code, or 
put it on some bus below the ones specified to of_platform_device_probe() -- 
by your platform code again...

WBR, Sergei

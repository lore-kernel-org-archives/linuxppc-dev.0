Return-Path: <cfriesen@nortel.com>
Received: from zcars04f.nortelnetworks.com (zcars04f.nortelnetworks.com
	[47.129.242.57]) by ozlabs.org (Postfix) with ESMTP id 2C1AB67A45
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Feb 2005 05:11:29 +1100 (EST)
Message-ID: <420117CA.8090507@nortelnetworks.com>
Date: Wed, 02 Feb 2005 12:11:22 -0600
From: Chris Friesen <cfriesen@nortel.com>
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: buggy mlock() behaviour in 2.6.9 on ppc64?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I've got a simple test app that tries to mmap() and mlock() an amount of 
memory specified on the commandline.

If I specify more than the amount of physical memory in the system, I 
get different behaviours between ppc and ppc64.

With the ppc kernel, my mmap() call will eventually fail and return 
MAP_FAILED.

With the ppc64 kernel, however, the system hangs, and the fans speed 
starts increasing.  It seems like it doesn't realize that there is 
simply no way that it will ever be able to succeed.

Is this expected behaviour for ppc64?


Chris

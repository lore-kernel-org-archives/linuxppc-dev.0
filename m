Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A9D0ADDE07
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  2 Feb 2007 10:08:25 +1100 (EST)
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1HCkfu-0001zX-4j
	for linuxppc-embedded@ozlabs.org; Thu, 01 Feb 2007 23:45:02 +0100
Received: from dsl-202-45-109-210-static.VIC.netspace.net.au ([202.45.109.210])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Thu, 01 Feb 2007 23:45:02 +0100
Received: from daniel_ng11 by dsl-202-45-109-210-static.VIC.netspace.net.au
	with local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Thu, 01 Feb 2007 23:45:02 +0100
To: linuxppc-embedded@ozlabs.org
From: Daniel Ng <daniel_ng11@lycos.com>
Subject: ELDK glibc fcntl(socketFd,
	=?utf-8?b?Rl9TRVRGTCw=?= flags) causes Seg Fault
Date: Thu, 1 Feb 2007 06:56:43 +0000 (UTC)
Message-ID: <loom.20070201T073939-302@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: news <news@sea.gmane.org>
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

My application Seg Faults when I try to set flags for my socket fd.

First, I get the fd by calling socket():
fd = socket(PF_INET, SOCK_STREAM, IPPROTO_TCP);

Then I try getting the fd flags:
fcntl(fd, F_GETFL, flags)

Then I try setting the flags:
flags |= O_NONBLOCK;
fcntl( fd, F_SETFL, flags );

-I get consistent Seg Faults on the last line above.

-I also checked fd, which is a sensible value. 
I can even successfully connect() with it.

-The problem happens regardless of what value 'flags' is set to


My embedded target details-

-powerpc8272
-ELDK v4
-the application uses glibc


Any ideas why I'm getting these Seg Faults?

Cheers,
Daniel

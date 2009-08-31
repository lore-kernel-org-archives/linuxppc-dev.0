Return-Path: <ben@somanetworks.com>
Received: from zimbra.somanetworks.com (gw-yyz.somanetworks.com
	[216.126.67.39])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 8A0C8B7B65
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  1 Sep 2009 08:01:57 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.somanetworks.com (Postfix) with ESMTP id 61650AF8341
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 31 Aug 2009 17:53:33 -0400 (EDT)
Received: from zimbra.somanetworks.com ([127.0.0.1])
	by localhost (zimbra.somanetworks.com [127.0.0.1]) (amavisd-new,
	port 10024)
	with ESMTP id Wg88nrqfKWeM for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 31 Aug 2009 17:53:33 -0400 (EDT)
Received: from [10.11.11.50] (odo.yyz.somanetworks.com [10.11.11.50])
	by zimbra.somanetworks.com (Postfix) with ESMTP id 4B6C1AF832A
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 31 Aug 2009 17:53:33 -0400 (EDT)
Message-ID: <4A9C465D.4010801@somanetworks.com>
Date: Mon, 31 Aug 2009 17:53:33 -0400
From: Ben Gamsa <ben@somanetworks.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: time jumps forward/backwards
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Our project is currently using 2.6.27.4 with a patch from Paul Mackerras 
("powerpc: Improve resolution of VDSO clock_gettime") running on a 
MPC8555.  We picked up the patch on the hope that it would fix an 
earlier problem we had with time jumping forwards and backwards shortly 
after boot-up.  It seemed to fix that problem, but it seems we have 
another, similar problem.

It appears to be the case that when the time on the system is around the 
epoch (1970), that time will occasionally jump forward and then backward 
by about 17592 seconds.  When it jumps forward, it always jumps back a 
few milliseconds later.  However, it's not always easy to catch these 
occurrences.  The delta is more specifically about 17592186059 usec, 
give or take a few 10s of microseconds (most of the time), despite the 
fact that the user-level program I have that is testing it only checks 
every 10 milliseconds.

The number seems suspiciously close to 2^44 nanoseconds, which suggests 
some sort of overflow error, perhaps caused by the time being set to 
around time 0.

I'm not really sure where to begin looking (I know that the time code is 
one of the more sensitive bits in the system so I definitely don't want 
to go blindly mucking around), so I was hoping to get some suggestions 
from the list.

Thanks for any help.

-- 
Ben Gamsa       ben@somanetworks.com
SOMA Networks   312 Adelaide St. W. Suite 600 Toronto, Ontario, M5V1R2

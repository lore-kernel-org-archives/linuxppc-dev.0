Return-Path: <dwilder@us.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 849D467A73
	for <linuxppc-dev@ozlabs.org>; Wed, 10 May 2006 06:46:27 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e34.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k49KkOLQ031127
	for <linuxppc-dev@ozlabs.org>; Tue, 9 May 2006 16:46:24 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k49KkOUi240238
	for <linuxppc-dev@ozlabs.org>; Tue, 9 May 2006 14:46:24 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id
	k49KkODo021911
	for <linuxppc-dev@ozlabs.org>; Tue, 9 May 2006 14:46:24 -0600
Received: from [9.47.18.65] (linux-009047018065.beaverton.ibm.com [9.47.18.65])
	by d03av02.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id
	k49KkNL1021533
	for <linuxppc-dev@ozlabs.org>; Tue, 9 May 2006 14:46:24 -0600
Message-ID: <4461098F.8050209@us.ibm.com>
Date: Tue, 09 May 2006 14:28:47 -0700
From: David Wilder <dwilder@us.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: might_sleep() called in die()
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul-
Can you advise me?   In the die() function might_sleep() is called while 
holding the die_lock (see call flow below).
 If voluntary preemption is set this can cause a deadlock when multiple 
Oops occur.  I am seeing this problem when issuing a soft-reset as all 
cups call die() at roughly the same time.

die() 
->>show_regs()->>show_instructions()->>__get_user_nocheck()->>might_sleep()

My question is basically should die() ever call might_sleep()? If so why?
 I currently working around the problem by calling clear_need_resched() 
at the top of die().

-- 
David Wilder
IBM Linux Technology Center
Beaverton, Oregon, USA 
dwilder@us.ibm.com
(503)578-3789

Return-Path: <linas@austin.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2B53FDDFB6
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Oct 2007 06:37:31 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l99KbRwp002499
	for <linuxppc-dev@ozlabs.org>; Tue, 9 Oct 2007 16:37:27 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l99KbOmH170010
	for <linuxppc-dev@ozlabs.org>; Tue, 9 Oct 2007 14:37:25 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l99KbOo2028814
	for <linuxppc-dev@ozlabs.org>; Tue, 9 Oct 2007 14:37:24 -0600
Received: from topology.austin.ibm.com (dyn95340167.austin.ibm.com
	[9.53.40.167])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	l99KbO3o028793
	for <linuxppc-dev@ozlabs.org>; Tue, 9 Oct 2007 14:37:24 -0600
Date: Tue, 9 Oct 2007 15:37:24 -0500
To: linuxppc-dev@ozlabs.org
Subject: Hard hang in hypervisor!? 
Message-ID: <20071009203724.GM4350@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: linas@austin.ibm.com (Linas Vepstas)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


I was futzing with linux-2.6.23-rc8-mm1 in a power6 lpar when,
for whatever reason, a spinlock locked up. The bizarre thing 
was that the rest of system locked up as well: an ssh terminal,
and also an hvc console.

Breaking into the debugger showed 4 cpus, 1 of which was 
deadlocked in the spinlock, and the other 3 in 
.pseries_dedicated_idle_sleep

This was, ahhh, unexpected.  What's up with that? Can
anyone provide any insight?

I should mention:
-- prior to the complete hard lockp, I did see 
 BUG: soft lockup - CPU#0 stuck for 11s! [ip:4473]
go off, and I did manage to sneak in a few commands
into the console and the ssh session. Then it locked
up hard -- but still not completely -- exactly 
360 seconds later, a kernel thread ran for a while, 
producing some console output, even though the 
keyboard and console were locked up.

--linas

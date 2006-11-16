Return-Path: <ntl@pobox.com>
Received: from rune.pobox.com (rune.pobox.com [208.210.124.79])
	by ozlabs.org (Postfix) with ESMTP id 5766767BC5
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Nov 2006 02:41:26 +1100 (EST)
Date: Thu, 16 Nov 2006 09:40:51 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Srinivasa Ds <srinivasa@in.ibm.com>
Subject: Re: [RFC] [PATCH]  cpu hotplug on power based systems.
Message-ID: <20061116154051.GB2008@localdomain>
References: <455C783E.2040701@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <455C783E.2040701@in.ibm.com>
Cc: ego@in.ibm.com, anton@au1.ibm.com, linuxppc-dev@ozlabs.org,
	paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Srinivasa Ds wrote:
> 
> Linux kernel uses some of the rtas token to perform cpu hotplug on power 
> systems. Some of the systems may not provide all the rtas services,which 
> are required to perform cpu hotplug. Like for example
>   1) JS20 doesn't provide "stop-self" token and cpu hotplug operations 
> on these systems causes system to crash.
>   2) some of the p630 systems doesn't provide "query-cpu-stopped-state" 
> token and we are not sure of whether cpu is under stopped state or not  
> or stop-self is still in progress .

Neither of these systems (well, the p630 in "SMP" mode) have
hypervisors so their firmwares don't provide the rtas primitives for
CPU offline.

> So we can't take decision on whether cpu really has gone offline or not.
> 
> So we need to make sure that all required rtas tokens for cpu hotplug  
> are available during rtas initialization phase and to disable cpu 
> hotplug if they are not available.
> I have developed the patch which does the above thing. Please let me 
> know your comments on this.

Would be better to either a) inhibit creation of the sysfs 'online'
cpu attributes (I thought we used to handle this correctly on these
systems) or b) use the generic cpu hotplug operations which have no
dependency on RTAS.

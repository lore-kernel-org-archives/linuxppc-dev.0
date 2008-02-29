Return-Path: <pbadari@us.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 04DF0DDF05
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Mar 2008 04:53:53 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m1THrobG024792
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Feb 2008 12:53:50 -0500
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m1THrooE197148
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Feb 2008 10:53:50 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m1THrhUL029698
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Feb 2008 10:53:48 -0700
Subject: [RFC] updating lmb.memory information for hot mem add/remove
From: Badari Pulavarty <pbadari@us.ibm.com>
To: michael@ellerman.id.au, paulus@samba.org
In-Reply-To: <1204247002.7729.11.camel@concordia.ozlabs.ibm.com>
References: <1204217028.28696.10.camel@dyn9047017100.beaverton.ibm.com>
	<1204217166.28696.15.camel@dyn9047017100.beaverton.ibm.com>
	<1204243875.7729.3.camel@concordia.ozlabs.ibm.com>
	<20080229003906.GP16241@localdomain>
	<1204247002.7729.11.camel@concordia.ozlabs.ibm.com>
Content-Type: text/plain
Date: Fri, 29 Feb 2008 09:56:56 -0800
Message-Id: <1204307816.10146.11.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Nathan Lynch <ntl@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I am wondering if you could give me your opinion on how to proceed
(before I code too much).

eHEA driver writers wants to know what the memory layout is - where the
holes are and where the reserved memory is. They can get this from
parsing through the device-tree every time, but it would be too
expensive. And also, they would like to get information for contiguous
ranges (instead of 16MB chunks).

Since we already have this information at boot time in lmb.memory, 
lmb.reserve - would it be okay to update those for hotplug mem
add/remove ? Of course, all the routines which handles updates 
(lmb_add() etc..) are available only at boot (__init). I could
change that. Is it acceptable ?

Other way to handle the issue is to come up with arch-neutral
way of representing the memory layout. x86-64 and ia64 shows
this information in /proc/iomem (even there is in chunks not 
combined).

Ideas ? Would it be acceptable if I update lmb.memory for add/remove
memory ? Am I missing something ?

Thanks,
Badari

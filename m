Message-Id: <200201072210.RAA09322@makai.watson.ibm.com>
To: mod+linuxppc-dev@MissionCriticalLinux.com
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Link-time failures from "simple" CFLAGS changes 
In-Reply-To: Message from mod+linuxppc-dev@MissionCriticalLinux.com
   of "Mon, 07 Jan 2002 17:01:51 EST." <200201072201.RAA05808@missioncriticallinux.com>
Date: Mon, 07 Jan 2002 17:10:45 -0500
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> linuxppc-dev  writes:

> When I change -O2 to -O0 in my CFLAGS definition in Makefile thus:

> CFLAGS := -g $(CPPFLAGS) -Wall -Wstrict-prototypes -Wno-trigraphs -O0 \
> -fno-strict-aliasing -fno-common

> CFLAGS := -g $(CPPFLAGS) -Wall -Wstrict-prototypes -Wno-trigraphs -O2 \
> -fno-strict-aliasing -fno-common

> ...I am astounded to see thousands of unresolved references
> at kernel link time.  WTF?  Any ideas?

	GCC only inlines functions when optimizing and the Linux kernel
assumes inlining and other optimizations only present at -O2.  The Linux
kernel requires optimization at least, and only really is tested at -O2.

David


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

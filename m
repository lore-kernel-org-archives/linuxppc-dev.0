Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e36.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AC1F42C0079
 for <linuxppc-dev@ozlabs.org>; Tue, 22 Jan 2013 08:38:00 +1100 (EST)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Mon, 21 Jan 2013 14:37:58 -0700
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
 [9.17.195.226])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 084313E4003F
 for <linuxppc-dev@ozlabs.org>; Mon, 21 Jan 2013 14:37:50 -0700 (MST)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r0LLbsqK236198
 for <linuxppc-dev@ozlabs.org>; Mon, 21 Jan 2013 14:37:54 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r0LLbrL4016106
 for <linuxppc-dev@ozlabs.org>; Mon, 21 Jan 2013 14:37:54 -0700
Date: Mon, 21 Jan 2013 13:38:23 -0800
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH] perf: Fix compile warnings in tests/attr.c
Message-ID: <20130121213823.GA4774@us.ibm.com>
References: <20130119013052.GA24693@us.ibm.com>
 <20130121135906.GD1995@krava.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20130121135906.GD1995@krava.brq.redhat.com>
Cc: linuxppc-dev@ozlabs.org, Anton Blanchard <anton@au1.ibm.com>,
 paulus@samba.org, linux-kernel@vger.kernel.org, acme@ghostprotocols.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Jiri Olsa [jolsa@redhat.com] wrote:
| On Fri, Jan 18, 2013 at 05:30:52PM -0800, Sukadev Bhattiprolu wrote:
| > From 4d266e5040c33103f5d226b0d16b89f8ef79e3ad Mon Sep 17 00:00:00 2001
| > From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
| > Date: Fri, 18 Jan 2013 11:14:28 -0800
| > Subject: [PATCH] perf: Fix compile warnings in tests/attr.c
| >=20
| > Replace '%llu' in printf()s with 'PRIu64' in 'tools/perf/tests/attr.c'
| > to fix compile warnings (which become errors due to -Werror).
|=20
| i386 and x86_64 compiles fine for me with gcc versions 4.6.3-2 and 4.7.2-2

But is broken on Power for 64bit :-( I am trying to fix that and thought
that use of format specifiers like 'PRIu64' was the way to go.

|=20
| with your patch for x86_64 I'm getting following warnings/errors:

|=20
|     CC tests/attr.o
| tests/attr.c: In function =E2=80=98store_event=E2=80=99:
| tests/attr.c:69:4: error: format =E2=80=98%lu=E2=80=99 expects argument o=
f type =E2=80=98long unsigned int=E2=80=99, but argument 6 has type =E2=80=
=98__u64=E2=80=99 [-Werror=3Dformat]

Here is what I see on an x86_64 box, RHEL6.2 box:

	$ rpm -qf /usr/include/linux/types.h
	kernel-headers-2.6.32-220.4.2.el6.x86_64

	$ cat foo.c
	#include <linux/types.h>

	$ cc -Werror -Wall foo.c
	In file included from /usr/include/asm-generic/types.h:7,
			 from /usr/include/asm/types.h:6,
			 from /usr/include/linux/types.h:4,
			 from foo5.c:1:
	/usr/include/asm-generic/int-ll64.h:31:2: error: #error __u64 defined as u=
nsigned long long

where the #error is my debug message.

<snip>

| make: *** [tests/attr.o] Error 1
|=20
| i386 compiles fine

__u64 is 'unsigned long long' on x86 and PRIu64 is 'llu' which is fine.

__u64 is 'unsigned long' on Power and PRIu64 is 'lu' which is again fine.

But __u64 is 'unsigned long long' on x86_64, but PRIu64 is '%lu' bc __WORDS=
IZE
is 64.

On x86_64, shouldn't __u64, be defined as 'unsigned long' rather than
'unsigned long long' - ie include 'int-l64.h' rather than 'int-ll64.h' ?

BTW, does 'perf' with my patch compile, (with warnings) for you on x86_64
with 'WERROR=3D0 make' ?

Sukadev

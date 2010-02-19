Return-Path: <bsingharora@gmail.com>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51]) by ozlabs.org (Postfix) with ESMTP id 183EAB7CC1
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 20 Feb 2010 02:43:17 +1100 (EST)
Received: by pwi9 with SMTP id 9so169270pwi.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 19 Feb 2010 07:43:16 -0800 (PST)
MIME-Version: 1.0
Sender: bsingharora@gmail.com
In-Reply-To: <20100218222923.GC31681@kryten>
References: <20100218222923.GC31681@kryten>
Date: Fri, 19 Feb 2010 21:13:16 +0530
Message-ID: <661de9471002190743t5385d97hf38c544f0007879c@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Set a smaller value for RECLAIM_DISTANCE to
	enable zone reclaim
From: Balbir Singh <balbir@linux.vnet.ibm.com>
To: Anton Blanchard <anton@samba.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: mel@csn.ul.ie, cl@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Feb 19, 2010 at 3:59 AM, Anton Blanchard <anton@samba.org> wrote:
>
> I noticed /proc/sys/vm/zone_reclaim_mode was 0 on a ppc64 NUMA box. It ge=
ts
> enabled via this:
>
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * If another node is sufficiently far away then it is bet=
ter
> =A0 =A0 =A0 =A0 * to reclaim pages in a zone before going off node.
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0if (distance > RECLAIM_DISTANCE)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0zone_reclaim_mode =3D 1;
>
> Since we use the default value of 20 for REMOTE_DISTANCE and 20 for
> RECLAIM_DISTANCE it never kicks in.
>
> The local to remote bandwidth ratios can be quite large on System p
> machines so it makes sense for us to reclaim clean pagecache locally befo=
re
> going off node.
>
> The patch below sets a smaller value for RECLAIM_DISTANCE and thus enable=
s
> zone reclaim.
>

A reclaim distance of 10 implies a ratio of 1, that means we'll always
do zone_reclaim() to free page cache and slab cache before moving on
to another node?

Balbir Singh.

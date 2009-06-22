Return-Path: <James.Bottomley@HansenPartnership.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 9F5DAB7112
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 23 Jun 2009 08:04:01 +1000 (EST)
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com
	[66.63.167.143]) by ozlabs.org (Postfix) with ESMTP id 5DFF7DDD0C
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Jun 2009 08:04:01 +1000 (EST)
Subject: Re: Boot failure on the powerstation with 2.6.30 latest
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Brian King <brking@linux.vnet.ibm.com>
In-Reply-To: <4A3FAD31.2060703@linux.vnet.ibm.com>
References: <1245683801.6901.8.camel@mulgrave.site>
	<4A3FAD31.2060703@linux.vnet.ibm.com>
Content-Type: text/plain
Date: Mon, 22 Jun 2009 17:03:56 -0500
Message-Id: <1245708236.17035.2.camel@mulgrave.site>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2009-06-22 at 11:11 -0500, Brian King wrote:
> James,
> 
> I was running into a similar hang on one of my Power boxes as well.
> Reverting c868d550115b9ccc0027c67265b9520790f05601 allowed by system
> to boot. It looks like that patch injected a bug where we can end up
> waiting on an uninitialized mutex:
> 
> [c0000000009f3c30] c00000000052c7dc .mutex_lock+0x34/0x50
> [c0000000009f3cb0] c00000000008b190 .get_online_cpus+0x3c/0x74
> [c0000000009f3d40] c000000000146cd0 .kmem_cache_create+0xcc/0x548
> [c0000000009f3e50] c000000000032ae0 .pgtable_cache_init+0x28/0x6c
> [c0000000009f3ee0] c000000000780960 .start_kernel+0x1ec/0x520
> [c0000000009f3f90] c0000000000083d8 .start_here_common+0x1c/0x44
> 
> The mutex gets initialized in cpu_hotplug_init, which doesn't get called until
> after pgtable_cache_init.

Actually, no, reverting that one doesn't fix it.

A full run of git bisect turns up this commit as the culprit; I'll make
a fuss on lkml:

83b519e8b9572c319c8e0c615ee5dd7272856090 is first bad commit
commit 83b519e8b9572c319c8e0c615ee5dd7272856090
Author: Pekka Enberg <penberg@cs.helsinki.fi>
Date:   Wed Jun 10 19:40:04 2009 +0300

    slab: setup allocators earlier in the boot sequence

James

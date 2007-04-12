Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 329BADDFD9
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Apr 2007 02:57:10 +1000 (EST)
In-Reply-To: <461D0D2E.5030300@freescale.com>
References: <boot-4-06.miltonm@bga.com> <461D0D2E.5030300@freescale.com>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <4cdc5e5fe65ea69a45289f0fdd8915b9@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 6/8] bootwrapper: convert flatdevtree to version 16
Date: Thu, 12 Apr 2007 11:56:52 -0500
To: Scott Wood <scottwood@freescale.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>, Fastboot <fastboot@lists.osdl.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 11, 2007, at 11:30 AM, Scott Wood wrote:

> Milton Miller wrote:
>> kexec-tools still produces a version 2 device tree, while the
>> libraries in the wrapper only support version 16 and later.
>> Add a routine to convert a v2 flat device tree to a v16 one inplace
>> by inserting OF_DT_NOP and chomping full path.  Make space for new
>> headers by moving and then chomping the OF_DT_NOPs.
>
> Why not fix kexec-tools to generate a version 17 device tree?
>

Because that would prevent kexec-tools from starting a kernel
between

[PATCH] ppc64: Make early processor spinup based on physical ids
author	olof <olof>
Thu, 25 Nov 2004 23:59:21 +0000 (23:59 +0000)
commit	e1b47549d1588ccea1fa5726eb430aae4e80f8ed

(linux-bkcvs, 2.6.9 or so) and

[PATCH] flattened device tree changes
author	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Tue, 9 Aug 2005 08:36:34 +0000 (10:36 +0200)
committer	Paul Mackerras <paulus@samba.org>
Mon, 29 Aug 2005 00:53:31 +0000 (10:53 +1000)
commit	34153fa3af45d84f3221d9b67ba2ab7e8a220d28

(2.6.14)

Admittedly they don't all support kexec from them, but they
can be kexeced into.   ppc64 kexec support was merged
here:

[PATCH] ppc64: kexec support for ppc64
author	R Sharada <sharada@in.ibm.com>
Sat, 25 Jun 2005 21:58:10 +0000 (14:58 -0700)
committer	Linus Torvalds <torvalds@ppc970.osdl.org>
Sat, 25 Jun 2005 23:24:51 +0000 (16:24 -0700)
commit	fce0d5740322b98b863f9e609f5a9bd4c06703af

(2.6.13)


That, and I didn't want to make changes to the code that
may be replaced with some other library later.


We could move this from kexec_platform_init to  crt0_kexec.S
platform_init so it becomes platform dependent if you want
to support them.


Are there embedded firmwares that hove old device trees?


milton

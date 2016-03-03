Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 00CEC1A0324
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Mar 2016 20:54:53 +1100 (AEDT)
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C3EB514145C
 for <linuxppc-dev@ozlabs.org>; Thu,  3 Mar 2016 20:54:52 +1100 (AEDT)
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <kamalesh@linux.vnet.ibm.com>;
 Thu, 3 Mar 2016 19:54:52 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 6467C2CE805A
 for <linuxppc-dev@ozlabs.org>; Thu,  3 Mar 2016 20:54:48 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u239sd2N10748216
 for <linuxppc-dev@ozlabs.org>; Thu, 3 Mar 2016 20:54:48 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u239sFSL017469
 for <linuxppc-dev@ozlabs.org>; Thu, 3 Mar 2016 20:54:15 +1100
Date: Thu, 3 Mar 2016 15:23:53 +0530
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: linuxppc-dev@ozlabs.org, duwe@lst.de, linux-kernel@vger.kernel.org,
 rostedt@goodmis.org, pmladek@suse.com, jeyu@redhat.com,
 jkosina@suse.cz, live-patching@vger.kernel.org, mbenes@suse.cz,
 Torsten Duwe <duwe@suse.de>
Subject: Re: [RFC][PATCH][v2] Enable livepatching for powerpc
Message-ID: <20160303095352.GA21283@linux.vnet.ibm.com>
Reply-To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
References: <1456988454-26437-1-git-send-email-bsingharora@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1456988454-26437-1-git-send-email-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Balbir Singh <bsingharora@gmail.com> [2016-03-03 18:00:54]:

> Changelog:
> 	1. Implement review comments by Michael
> 	2. The previous version compared _NIP from the
> 	   wrong location to check for whether we
> 	   are going to a patched location
> 
> This applies on top of the patches posted by Michael 
> https://patchwork.ozlabs.org/patch/589791/
> 
> It enables livepatching. This takes patch 6/8 and 7/8 of v8 as the base.
> Removes the extra strict check in gcc-profile-kernel-notrace.sh
> and adds logic for checking offsets in livepatch. The patch
> for HAVE_C_RECORDMCOUNT is not required and not used here.
> 
> Depending on whether or not a TOC is generated, the offset
> for _mcount can be +16,+12,+8,+4. The changes are such that the
> offset checks are specific to powerpc.
> 
> TODOs
> 1. Build a version with offsets removed and rebuild
>    ftrace_location() sort of functionality
> 2. Make livepatching experimental on powerpc
> 
> Comments? Testing? I tested the sample in the livepatch
> directory
> 
> References
> 
> 1. https://patchwork.ozlabs.org/patch/581521/
> 2. https://patchwork.ozlabs.org/patch/587464/
> 
> Signed-off-by: Torsten Duwe <duwe@suse.de>
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>

Tested-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>

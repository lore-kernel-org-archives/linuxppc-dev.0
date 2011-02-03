Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp04.au.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 32C37B70EC
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  3 Feb 2011 11:28:33 +1100 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp04.au.ibm.com (8.14.4/8.13.1) with ESMTP id p130NBMn003827
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Feb 2011 11:23:11 +1100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p130SXFD2314418
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Feb 2011 11:28:33 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p130SVd4029877
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Feb 2011 11:28:33 +1100
Content-Type: text/plain; charset=UTF-8
Subject: Re: [PATCH 4/6] ftrace syscalls: Allow arch specific syscall symbol
	matching
From: Ian Munsie <imunsie@au1.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
In-reply-to: <1296655484.10797.47.camel@gandalf.stny.rr.com>
References: <1296630718-17537-1-git-send-email-imunsie@au1.ibm.com>
	<1296630718-17537-5-git-send-email-imunsie@au1.ibm.com>
	<1296655484.10797.47.camel@gandalf.stny.rr.com>
Date: Thu, 03 Feb 2011 11:28:27 +1100
Message-Id: <1296692691-sup-5940@au1.ibm.com>
Cc: Andreas Dilger <adilger@dilger.ca>, Andreas Schwab <schwab@linux-m68k.org>,
	Dave Kleikamp <shaggy@linux.vnet.ibm.com>,
	DOCUMENTATION <linux-doc@vger.kernel.org>,
	Namhyung Kim <namhyung@gmail.com>, Jiri Kosina <jkosina@suse.cz>,
	Jason Baron <jbaron@redhat.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Alexander Graf <agraf@suse.de>, Ingo Molnar <mingo@redhat.com>,
	Paul Mackerras <paulus@samba.org>,
	KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Scott Wood <scottwood@freescale.com>, Nathan Lynch <ntl@pobox.com>,
	Andrew Morton <akpm@linux-foundation.org>, David Gibson <dwg@au1.ibm.com>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Avantika Mathur <mathur@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Excerpts from Steven Rostedt's message of Thu Feb 03 01:04:44 +1100 2011:
> I'll answer your question here.

> > +#define arch_syscall_match_sym_name(sym, name) !strcmp(sym + 3, name + 3)
> 
> Instead, you could have:
> 
> #ifndef ARCH_HAS_SYSCALL_MATCH_SYM_NAME
> 
> static inline arch_syscall_match_sym_name(const char *sym, const char *name)
> {
>     return strcmp(sym + 3, name + 3) != 0;
> }
> 
> 
> If an arch needs to make its own, then it can simply override it by
> creating its own version and defining:
> 
> #define ARCH_HAS_SYSCALL_MATCH_SYM_NAME
> 
> Just like they do when an arch has its own strcmp.

Ok, I've changed it over. Just doing a quick regression test on ppc64 &
x86 then I'll repost.

Cheers,
-Ian

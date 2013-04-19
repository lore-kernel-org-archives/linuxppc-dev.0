Return-Path: <zhong@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp03.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 996812C0226
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Apr 2013 12:11:34 +1000 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Fri, 19 Apr 2013 12:03:54 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 46FC92BB0052
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Apr 2013 12:11:00 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3J1vV2g37224554
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Apr 2013 11:57:31 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3J2AwjY015639
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Apr 2013 12:10:59 +1000
Message-ID: <1366337453.3250.16.camel@ThinkPad-T5421.cn.ibm.com>
Subject: Re: [RFC PATCH powerpc] make CONFIG_NUMA depends on CONFIG_SMP
From: Li Zhong <zhong@linux.vnet.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>
Date: Fri, 19 Apr 2013 10:10:53 +0800
In-Reply-To: <20130418014559.GB8261@concordia>
References: <1338370318.3637.12.camel@ThinkPad-T420>
 <20130418014559.GB8261@concordia>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: PowerPC email list <linuxppc-dev@lists.ozlabs.org>,
 Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-04-18 at 11:46 +1000, Michael Ellerman wrote:
> On Wed, May 30, 2012 at 05:31:58PM +0800, Li Zhong wrote:
> > I'm not sure whether it makes sense to add this dependency to avoid
> > CONFI_NUMA && !CONFIG_SMP. 
> > 
> > I want to do this because I saw some build errors on next-tree when
> > compiling with CONFIG_SMP disabled, and it seems they are caused by some
> > codes under the CONFIG_NUMA #ifdefs.  
> 
> This seems to make sense to me. Can you please repost with a better
> changelog and a description of the actual build error you were seeing.

I tried it today, but didn't find any build errors any more, guess those
errors should have already been fixed. 

But it seems to me by disabling CONFIG_NUMA when CONFIG_SMP is disabled,
could at least prevent some unnecessary code being compiled into the
kernel. (After building a kernel with/without CONFIG_NUMA just now, it
seems that the vmlinux is ~100K smaller without CONFIG_NUMA).

I'm not sure whether this is still needed. 

Thanks, Zhong

> 
> cheers
> 

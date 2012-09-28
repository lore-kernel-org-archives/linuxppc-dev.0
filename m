Return-Path: <rsa@us.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e32.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C3F3A2C00D0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Sep 2012 08:11:56 +1000 (EST)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <rsa@us.ibm.com>;
 Fri, 28 Sep 2012 16:11:52 -0600
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
 [9.17.195.107])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id DC7621FF003F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2012 16:11:44 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q8SMBm9a261732
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2012 16:11:48 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q8SMBmq7004765
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2012 16:11:48 -0600
Subject: Re: [PATCH 2/6] powerpc: Add enable_ppr kernel parameter to enable
 PPR save/restore
From: Ryan Arnold <rsa@us.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1347342911.2603.39.camel@pasglop>
References: <1347190671.3418.12.camel@hbabu-laptop>
 <1347235922.2385.138.camel@pasglop> <13010.1347236558@neuling.org>
 <504ECF35.9070305@linux.vnet.ibm.com>  <1347342911.2603.39.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 28 Sep 2012 17:11:44 -0500
Message-ID: <1348870304.29664.6212.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Michael Neuling <mikey@neuling.org>,
 Adhemerval Zanella <azanella@linux.vnet.ibm.com>, sjmunroe@us.ibm.com,
 paulus@samba.org, anton@samba.org, linuxppc-dev@lists.ozlabs.org,
 Haren Myneni <haren@linux.vnet.ibm.com>
Reply-To: rsa@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2012-09-11 at 15:55 +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2012-09-10 at 22:42 -0700, Haren Myneni wrote:
> > 
> > Thanks Michael. Yes, we noticed 6% overhead with null syscall test.
> > Hence added cmdline option as suggested. I will add this comment in
> > the
> > changelog.
> > 
> > Regarding the option name, I thought about various ones such as
> > retain_process_ppr, retain_smt_priority, save_ppr and etc. Finally
> > added
> > 'enable_ppr' since it enables CPU_FTR (CPU_FTR_HAS_PPR) which allows
> > to
> > save/restore PPR value. Sure, I will change this option.
> 
> No, that isn't a problem with the name. It's a problem with the polarity
> of the option.
> 
> If you need a command line argument to enable the option, then nobody
> will enable it, it's pointless.

In GLIBC (ppc.h) we'll be providing a user space API to change the
thread priority in user state.  We're also interested in using this in
some of the locking constructs if performance tests indicate it's
beneficial.

I have concerns with being able to enable/disable this option at boot
time.  Usually, in GLIBC we'll just do a kernel version check and enable
certain facilities if we're building against a particular kernel that
supports them.

In this case, with a configurable option, GLIBC is going to need the
kernel to export a hwcap bit that tells us whether we need to do the
save/restore ourselves.  Having to check the hwcap, and do the
save/restore in user space will, of course, increase the overhead on our
side.

If no hwcap bit is provided and this is disabled at kernel boot time, no
check is done and the user process assumes it's running under a certain
priority when it is, in-fact, not.  I don't care for this option.  We'll
be hitting code paths that are ineffective and unnecessary.

Ryan S. Arnold
Linux Technology Center

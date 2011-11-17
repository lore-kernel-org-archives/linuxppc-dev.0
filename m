Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 9C131B7255
 for <linuxppc-dev@ozlabs.org>; Fri, 18 Nov 2011 08:27:51 +1100 (EST)
In-Reply-To: <A8CB2347-27B6-482A-B49B-F434FBFCBC10@freescale.com>
References: <OFD9ADD493.27DB131E-ONC125794B.002E2035-C125794B.002F715A@transmode.se>
 <4EC544C6.3050502@us.ibm.com>
 <A8CB2347-27B6-482A-B49B-F434FBFCBC10@freescale.com>
Subject: Re: oprofile callgraph support missing for common cpus
To: Andy Fleming <afleming@freescale.com>
Message-ID: <OF8F2311F0.71A00B7A-ONC125794B.007583D0-C125794B.0075E666@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Thu, 17 Nov 2011 22:27:46 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, maynardj@us.ibm.com,
 oprofile-list@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Andy Fleming <afleming@freescale.com> wrote on 2011/11/17 18:51:52:
>
>
> On Nov 17, 2011, at 11:30 AM, Maynard Johnson wrote:
>
> >>
> >> Notice the first
> >>        if (!cur_cpu_spec->oprofile_cpu_type)
> >>               return -ENODEV;
> >>
> >>        if (firmware_has_feature(FW_FEATURE_ISERIES))
> >>               return -ENODEV;
> >> For my e300c2 cpu both if's are false and I don't get support for callgraph/backtrace
> >> support. Moving the ops->backtrace = op_powerpc_backtrace; to the top
> >> enables backtrace for me.
> > What kernel version are you using?  Actually, looking at a 3.0.3 tree I happen to have available, I see oprofile h/w event support (in arch/powerpc/kernel/cputable.c) for e300c3 and e300c4, but not the other e300 flavors.  I've added Andy Flemming from Freescale to cc.  Maybe he knows why e300c2
isn't supported.
>
> e300c2 does not have hardware performance monitor events.
>
> However, it should be able to support timer-based profiling, right? And why not support backtrace from there? Do we require hardware counters to get a backtrace?

It sure seems to work :)
If it doesn't, one needs to make sure /dev/oprofile/backtrace_depth isn't published as it is now.

Question, what is the sample rate for timer based oprofile?
Is it HZ depended?

  Jocke

Return-Path: <yur@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3A550DDEA3
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Oct 2007 02:06:02 +1000 (EST)
From: Yuri Tikhonov <yur@emcraft.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] ppc44x: support for 256K PAGE_SIZE
Date: Fri, 19 Oct 2007 20:03:28 +0400
References: <200710181108.19413.yur@emcraft.com>
	<200710191937.23638.yur@emcraft.com>
	<D3506DCC-01F5-48C1-900D-2D827AB6BE19@kernel.crashing.org>
In-Reply-To: <D3506DCC-01F5-48C1-900D-2D827AB6BE19@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200710192003.28143.yur@emcraft.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 19 October 2007 19:48, Kumar Gala wrote:
> > PAGE_SIZE = 4K:
> >  P = 66 MBps;
> >
> > PAGE_SIZE = 16K:
> >  P = 145 MBps;
> >
> > PAGE_SIZE = 64K:
> >  P = 196 MBps;
> >
> > PAGE_SIZE = 256K:
> >  P = 217 MBps.
> 
> Is this all in kernel space? or is there a user space aspect to the  
> benchmark?

 The situation here is that the Linux RAID driver does a lot of complex things
with the pages (strips of array) using CPU before submitting these pages to h/w.
Here is where the most time is spent. Thus, increasing the PAGE_SIZE value we reduce
the number of these complex algorithms calls needed to process the whole test (writing
the fixed number of MBytes to RAID array). So, there are no user space aspects.

-- 
Yuri Tikhonov, Senior Software Engineer
Emcraft Systems, www.emcraft.com

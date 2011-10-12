Return-Path: <dave@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e8.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id AB226B6F62
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Oct 2011 01:15:41 +1100 (EST)
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
 by e8.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p9CE0CIq022989
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Oct 2011 10:00:12 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 p9CEFV7c219456
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Oct 2011 10:15:32 -0400
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 p9CEF5op007611
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Oct 2011 08:15:06 -0600
Subject: Re: [PATCH 2/3] [44x] Enable CONFIG_RELOCATABLE for PPC44x
From: Dave Hansen <dave@linux.vnet.ibm.com>
To: Suzuki Poulose <suzuki@in.ibm.com>
In-Reply-To: <4E943C70.4030106@in.ibm.com>
References: <20111010094627.16589.52367.stgit@suzukikp.in.ibm.com>
 <20111010095514.16589.85241.stgit@suzukikp.in.ibm.com>
 <4E9332AA.1050307@freescale.com>  <4E943C70.4030106@in.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 12 Oct 2011 07:15:02 -0700
Message-ID: <1318428902.3782.9.camel@nimitz>
Mime-Version: 1.0
Cc: Michal Simek <monstr@monstr.eu>, tmarri@apm.com,
 Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>,
 David Laight <David.Laight@ACULAB.COM>, Paul Mackerras <paulus@samba.org>,
 Scott Wood <scottwood@freescale.com>,
 linux ppc dev <linuxppc-dev@lists.ozlabs.org>, Vivek Goyal <vgoyal@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2011-10-11 at 18:24 +0530, Suzuki Poulose wrote:
> On 10/10/11 23:30, Scott Wood wrote:
> > On 10/10/2011 04:56 AM, Suzuki K. Poulose wrote:
> >> #if defined(CONFIG_RELOCATABLE)&&  defined(CONFIG_44x)
> >> #define __va(x) ((void *)(unsigned long)((phys_addr_t)(x) - PHYSICAL_START + (KERNELBASE + RELOC_OFFSET)))
> >> #define __pa(x) ((unsigned long)(x) + PHYSICAL_START - (KERNELBASE + RELOC_OFFSET))
> >> #endif
> >
> > Why is this 44x-specific?
> 
> As of now, we compile with relocations only for the 44x. We could make this
> generic once the approach is accepted by everyone and implemented on the other
> platforms. 

This is not the place to enforce that kind of thing.  If
CONFIG_RELOCATABLE is only supported on one platform, then do:

	config RELOCATABLE
		depends on 44x

and take the 44x reference out of the #ifdef.

-- Dave

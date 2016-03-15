Return-Path: <ruscur@russell.cc>
Received: from russell.cc (russell.cc [IPv6:2404:9400:2:0:216:3eff:fee0:3370])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qPN9Z0RmFzDqgm
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Mar 2016 16:15:30 +1100 (AEDT)
Message-ID: <1458018919.30802.4.camel@russell.cc>
Subject: Re: [PATCH] powernv/hmi: Use the "unknown" checkstop type as a
 fallback
From: Russell Currey <ruscur@russell.cc>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Date: Tue, 15 Mar 2016 16:15:19 +1100
In-Reply-To: <56E787FE.1060104@au1.ibm.com>
References: <1458012409-32448-1-git-send-email-ruscur@russell.cc>
 <56E787FE.1060104@au1.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-03-15 at 14:56 +1100, Andrew Donnellan wrote:
> On 15/03/16 14:26, Russell Currey wrote:
> > 
> > The HMI code knows about three types of errors: CORE, NX and UNKNOWN.
> > If OPAL were to add a new type, it would not be handled at all since
> > there is no fallback case.  Instead of explicitly checking for UNKNOWN,
> > treat any checkstop type without a handler as unknown.
> > 
> > Signed-off-by: Russell Currey <ruscur@russell.cc>
> Indeed it looks like there isn't a fallback case.
> 
> Would it be useful to print xstop_type in the unknown case?

I don't think so - if there's a new checkstop type, specific handling for
it should be implemented in the kernel, and if you're getting unknown
checkstops that are bringing down your machine you should be looking at the
OPAL firmware log anyway, which would contain details if there was
something "new".

> 
> Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> 

Return-Path: <zhong@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp09.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C82F22C00A8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 May 2013 19:46:35 +1000 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Tue, 14 May 2013 06:44:13 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 878AE357801B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 May 2013 19:46:29 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r4D9WMJn20381894
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 May 2013 19:32:22 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r4D9kRew023021
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 May 2013 19:46:28 +1000
Message-ID: <1368438380.2618.52.camel@ThinkPad-T5421>
Subject: Re: [RFC PATCH v3 2/5] powerpc: Exception hooks for context
 tracking subsystem
From: Li Zhong <zhong@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 13 May 2013 17:46:20 +0800
In-Reply-To: <1368435991.19924.35.camel@pasglop>
References: <1368422493-9831-1-git-send-email-zhong@linux.vnet.ibm.com>
 <1368422493-9831-3-git-send-email-zhong@linux.vnet.ibm.com>
 <1368424667.19924.26.camel@pasglop>
 <1368434680.2618.33.camel@ThinkPad-T5421>
 <1368435991.19924.35.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: fweisbec@gmail.com, linux-kernel@vger.kernel.org, paulus@samba.org,
 paulmck@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-05-13 at 19:06 +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2013-05-13 at 16:44 +0800, Li Zhong wrote:
> > Yes, the above and hash_page() are two C functions for a same exception.
> > And the exception hooks enable RCU usage in those C codes. But for asm
> > codes, I think we could assume that there would be no RCU usage there,
> > so we don't need wrap them in the hooks.
> 
> hash_page() won't start a new RCU, at least not in its current incarnation,
> the only thing I can see it ever doing would be to take some RCU read locks one
> day (it doesn't today).

Seems I added the hooks because of the trace point of hcall
entry/exit ...

Thanks, Zhong

> 
> low_hash_fault() is a different beast. It will typically kill things, thus
> involving sending signals etc... RCU might well be involved.
> 
> Cheers,
> Ben.
> 
> 

Return-Path: <ntl@pobox.com>
Received: from rune.pobox.com (rune.pobox.com [208.210.124.79])
	by ozlabs.org (Postfix) with ESMTP id 4A2F267B32
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Jul 2006 14:38:24 +1000 (EST)
Date: Sun, 30 Jul 2006 23:38:06 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] Add rtas_set_indicator_fast() for RTAS call without
	extended delay
Message-ID: <20060731043806.GA9774@localdomain>
References: <44C6F521.8040609@us.ibm.com> <20060726220441.GZ19076@localdomain>
	<44C9301C.7080300@us.ibm.com>
	<17613.33093.767856.432771@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17613.33093.767856.432771@cargo.ozlabs.ibm.com>
Cc: External List <linuxppc-dev@ozlabs.org>, Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mackerras wrote:
> Haren Myneni writes:
> 
> > +	WARN_ON(rc == -2 || (rc >= 9900 && rc <= 9905));
> 
> This worries me... do we know for sure that RTAS will never return a
> busy code?  If it could possibly return a busy code, and we can't
> sleep, then we should spin doing the call again and again until it
> works, I think.

The PAPR marks certain RTAS calls as "fast", meaning they must not
return any kind of busy status.  Manipulating the GIQ (set-indicator
with token 9005) is defined as "fast".

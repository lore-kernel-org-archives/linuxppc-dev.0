Return-Path: <ncase@xes-inc.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id A5462B71E2
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Jun 2009 13:40:39 +1000 (EST)
Received: from xes-mad.com (xes-mad.com [216.165.139.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F272EDDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jun 2009 13:40:38 +1000 (EST)
MIME-Version: 1.0
Date: Wed, 10 Jun 2009 22:40:33 -0500
From: Nathaniel Case <ncase@xes-inc.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/boot: cuboot: Fix up ethernet3 MAC address on
	MPC85xx
In-Reply-To: <094F1487-85D2-400A-A2B6-5ED54685907A@kernel.crashing.org>
References: <1244499462-18719-1-git-send-email-ncase@xes-inc.com>
	<094F1487-85D2-400A-A2B6-5ED54685907A@kernel.crashing.org>
Message-ID: <155ffc0deec796912080304f76bb09e7@xes-inc.com>
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 10 Jun 2009 21:54:01 -0500, Kumar Gala <galak@kernel.crashing.org>
wrote:
>> #define TARGET_85xx
>> +#define TARGET_HAS_ETH3
> 
> This is problematic in that we'd be changing the memory layout of the  
> bd_t and not ALL 85xx's have HAS_ETH3 set.

It shouldn't be problematic.  The bi_enet3addr field is at the end of the
structure on MPC85xx.  The only fields after it in ppcboot.h are
4xx-specific
fields.  I believe the MAC addresses were placed at the end of the struct
for
this very reason.

-- 
Nate Case <ncase@xes-inc.com>

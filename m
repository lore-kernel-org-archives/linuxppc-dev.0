Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 58D9BB7202
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Jun 2009 13:44:06 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9B4A7DDD04
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jun 2009 13:44:05 +1000 (EST)
Message-Id: <3859ABBF-ACBF-4564-B599-FBDDE0E60031@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Nathaniel Case <ncase@xes-inc.com>
In-Reply-To: <155ffc0deec796912080304f76bb09e7@xes-inc.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: [PATCH] powerpc/boot: cuboot: Fix up ethernet3 MAC address on
	MPC85xx
Date: Wed, 10 Jun 2009 22:44:01 -0500
References: <1244499462-18719-1-git-send-email-ncase@xes-inc.com>
	<094F1487-85D2-400A-A2B6-5ED54685907A@kernel.crashing.org>
	<155ffc0deec796912080304f76bb09e7@xes-inc.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jun 10, 2009, at 10:40 PM, Nathaniel Case wrote:

> On Wed, 10 Jun 2009 21:54:01 -0500, Kumar Gala <galak@kernel.crashing.org 
> >
> wrote:
>>> #define TARGET_85xx
>>> +#define TARGET_HAS_ETH3
>>
>> This is problematic in that we'd be changing the memory layout of the
>> bd_t and not ALL 85xx's have HAS_ETH3 set.
>
> It shouldn't be problematic.  The bi_enet3addr field is at the end  
> of the
> structure on MPC85xx.  The only fields after it in ppcboot.h are
> 4xx-specific
> fields.  I believe the MAC addresses were placed at the end of the  
> struct
> for
> this very reason.

ahh, good point... I'll add this detail to the commit message when I  
commit this.

- k

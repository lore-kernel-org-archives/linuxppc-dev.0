Return-Path: <dsa@cumulusnetworks.com>
Received: from mail-pg0-x22c.google.com (mail-pg0-x22c.google.com
 [IPv6:2607:f8b0:400e:c05::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v92rq6hKdzDqhZ
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Jan 2017 02:34:19 +1100 (AEDT)
Received: by mail-pg0-x22c.google.com with SMTP id 3so23457284pgj.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jan 2017 07:34:19 -0800 (PST)
Subject: Re: [next-20170124] Kernel oops(rt6_fill_node) during reboot of LPAR
To: Sachin Sant <sachinp@linux.vnet.ibm.com>,
 "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
 netdev@vger.kernel.org
References: <9520531C-6458-4442-9ED5-3598E72C7C6A@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>,
 davem@davemloft.net, Michael Ellerman <michael@ellerman.id.au>
From: David Ahern <dsa@cumulusnetworks.com>
Message-ID: <84f3cb86-5110-64a0-5575-4024ba758135@cumulusnetworks.com>
Date: Fri, 27 Jan 2017 08:34:15 -0700
MIME-Version: 1.0
In-Reply-To: <9520531C-6458-4442-9ED5-3598E72C7C6A@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 1/27/17 5:54 AM, Sachin Sant wrote:
> While rebooting PowerVM LPAR running 4.10.0-rc5-next-20170124
> on a POWER8 box, following kernel oops is displayed.
> 
> This problem was introduced with next-20170123. next-20170120 works.
> Initial analysis points to following patch included with next-20170123
> 
> commit a1a22c12060e4b9c52f45d4b3460f614e00162a2
> net: ipv6: Keep nexthop of multipath route on admin down

Thanks for the report. Fixed by:

https://git.kernel.org/cgit/linux/kernel/git/davem/net-next.git/commit/?id=1f17e2f2c8a8be3430813119fa7b633398f6185b

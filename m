Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vN1kx3jgRzDqqR
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 23:22:17 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, aneesh.kumar@linux.vnet.ibm.com,
 Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/xmon: add turn off xmon option
In-Reply-To: <1486980832-6846-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
References: <1486980832-6846-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Date: Tue, 14 Feb 2017 23:22:14 +1100
Message-ID: <87k28tklmx.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Pan Xinhui <xinhui.pan@linux.vnet.ibm.com> writes:

> Once xmon is triggered, there is no interface to turn it off again.
> However there exists disable/enable xmon code flows. And more important,
> System reset interrupt on powerVM will fire an oops to make a dump. At
> that time, xmon should not be triggered.
>
> So add 'z' option after current 'x|X' exit commands. Turn xmon off if 'z'
> is following.

Thanks for trying to clear this up.

But I like the solution we discussed in the other thread better. ie.
entering/leaving xmon via sysrq will always leave the state unchanged,
and we'll add a debugfs to change the state.

cheers

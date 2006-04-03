Return-Path: <ak@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1873A67A41
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Apr 2006 21:53:14 +1000 (EST)
From: Andi Kleen <ak@suse.de>
To: Paul Jackson <pj@sgi.com>
Subject: Re: Fw: 2.6.16 crashes when running numastat on p575
Date: Mon, 3 Apr 2006 13:49:02 +0200
References: <20060402213216.2e61b74e.akpm@osdl.org>
	<Pine.LNX.4.64.0604022149450.15895@schroedinger.engr.sgi.com>
	<20060402221513.96f05bdc.pj@sgi.com>
In-Reply-To: <20060402221513.96f05bdc.pj@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200604031349.03036.ak@suse.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	ak@suse.com, Christoph Lameter <clameter@sgi.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 03 April 2006 07:15, Paul Jackson wrote:
> -		for (cpu = 0; cpu < NR_CPUS; cpu++) {
> +		for_each_online_cpu(cpu) {
> 
> Idle curiosity -- what keeps a cpu from going offline during
> this scan, and leaving us with the same crash as before?


CPU hotdown uses RCU like techniques to avoid this. Only potential
problem could be on a preemptive kernel, but I hope nobody tries
cpu unplug on such a beast. The later could be probably fixed
with a rcu_read_lock() or somesuch.

-Andi

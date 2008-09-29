Return-Path: <srinivasa@in.ibm.com>
Received: from e23smtp06.au.ibm.com (E23SMTP06.au.ibm.com [202.81.18.175])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp06.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0CE5FDDF1F
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Sep 2008 23:33:04 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by e23smtp06.au.ibm.com (8.13.1/8.13.1) with ESMTP id m8TDWBoU015861
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Sep 2008 23:32:11 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m8TDX36J4460704
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Sep 2008 23:33:03 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m8TDX2S5016719
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Sep 2008 23:33:03 +1000
Message-ID: <48E0D957.5080907@in.ibm.com>
Date: Mon, 29 Sep 2008 19:04:15 +0530
From: Srinivasa DS <srinivasa@in.ibm.com>
MIME-Version: 1.0
To: Roland McGrath <roland@redhat.com>
Subject: Re: [RFC][PATCH] Demultiplexing SIGTRAP signal -v2
References: <200809221602.32616.srinivasa@in.ibm.com>
	<20080923112812.GL29021@elte.hu> <20080923113001.GA12531@elte.hu>
	<200809231955.01564.srinivasa@in.ibm.com>
	<20080923143120.GD14041@elte.hu>
	<20080926090637.9C0851541FA@magilla.localdomain>
In-Reply-To: <20080926090637.9C0851541FA@magilla.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-parisc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	paulus@samba.org, "H. Peter Anvin" <hpa@zytor.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Ingo Molnar <mingo@elte.hu>, akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Roland McGrath wrote:
> I certainly have no objection in principle.  I doubt that any x86 userland
> apps expect certain si_code values for SIGTRAP now, since the existing
> values are not of any real use.  (Signal handlers get the thread.trap_no and
> thread.error_code values from hardware to guess from, and debuggers via
> ptrace get the hardware %db6 value to guess from.)  I do have a few comments.
> 
> If you're doing it, I think you should do the do_int3 case too,
> so every machine-generated SIGTRAP has a meaningful si_code value.

Roland
    Thanks for your comments.

>   I'm inclined to consolidate the si_code logic there, and just
> pass it the hardware bits or let it get them from the thread_struct
> (trap_nr, error_code, debugreg6).

That sounds like a good idea. Let me go through code and get back to you.

Thanks
  Srinivasa DS

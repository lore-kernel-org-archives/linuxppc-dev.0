Return-Path: <ananth@in.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 57595DDF06
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Jun 2008 15:48:40 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m535maEd019882
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Jun 2008 01:48:36 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m535maYj123604
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Jun 2008 23:48:36 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m535matO023958
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Jun 2008 23:48:36 -0600
Date: Tue, 3 Jun 2008 11:18:46 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [RFC] Kprobes for book-e
Message-ID: <20080603054846.GC31747@in.ibm.com>
References: <Pine.LNX.4.64.0806030027340.27857@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.0806030027340.27857@blarg.am.freescale.net>
Cc: madhvesh.s@ap.sony.com, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, rsmadhvesh@vsnl.net
Reply-To: ananth@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jun 03, 2008 at 12:30:51AM -0500, Kumar Gala wrote:
> This is a patch that adds kprobes support for book-e style debug.  Its
> based on the patch posted by Madhvesh and assumes the exception cleanup
> that I've already posted.
> 
> Post to get any feedback.  The code needs some cleaning up but wanted to
> see if there were any initial comments.
> 
> - k

...
 
> @@ -53,7 +68,8 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
>  		ret = -EINVAL;
>  	}
> 
> -	/* insn must be on a special executable page on ppc64 */
> +	/* insn must be on a special executable page on ppc64.  This is
> +	 * explicitly required on ppc32 (right now), but it doesn't hurt */
	^^^^^^^^
	not required?

I don't have much (any) knowledge about Book-E details, but the generic
powerpc changes look fine to me.

Ananth

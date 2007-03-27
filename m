Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 21AA7DDEE7
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Mar 2007 03:35:39 +1000 (EST)
Date: Tue, 27 Mar 2007 19:35:29 +0200
From: Christoph Hellwig <hch@lst.de>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [PATCH 8/9] ps3: cleanup ps3fb before clearing HPTE
Message-ID: <20070327173529.GA12635@lst.de>
References: <Pine.LNX.4.62.0701251825390.14799@pademelon.sonytel.be>
	<Pine.LNX.4.62.0701251851160.24610@pademelon.sonytel.be>
	<20070126031438.GH18537@lst.de> <4605B861.9060006@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4605B861.9060006@am.sony.com>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Mar 24, 2007 at 04:46:41PM -0700, Geoff Levand wrote:
> Sorry for such a late reply, but I'm now doing the kexec code and see
> why it was put here (by the original author).  It is so you will have
> debugging output until the very last possible moment during a kexec
> shutdown.
> 
> The real problem is really that this routine (and the corresponding ppc_md
> variable) are inappropriately named.  In the general case all that is left
> to do is to call ppc_md.hpte_clear_all, but for ps3 we also want to do the
> framebuffer shutdown here, so something like this should be better:
> 
> -static void ps3_hpte_clear(void)
> +static void ps3_kexec_final(void)
> 
> -	ppc_md.hpte_clear_all = ps3_hpte_clear;
> +	ppc_md.hpte_clear_all = ps3_kexec_final;

as a start method calls sould always be be driver/arch_methodname,
so ps3_hpte_clear_all here, not ps3_hpte_clear but not ps3_kexec_final
either unless the method name changes.

I think you got this code rejected by someone who knows a lot more about
kexec than me, but in a case where something this odd would be allowed
it should at least have a big comment explaining what's going on here.
(In this case it would be basically the content of your email)

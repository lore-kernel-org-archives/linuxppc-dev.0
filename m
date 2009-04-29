Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B4F19DDF19
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Apr 2009 17:41:48 +1000 (EST)
Date: Wed, 29 Apr 2009 00:37:04 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Jeff Haran" <jharan@Brocade.COM>
Subject: Re: bug in drivers/edac/mpc85xx_edac.c:mpc85xx_mc_check()
Message-Id: <20090429003704.1c37d6e1.akpm@linux-foundation.org>
In-Reply-To: <57AC2FA1761300418C7AB8F3EA493C9702E319DB@HQ-EXCH-5.corp.brocade.com>
References: <57AC2FA1761300418C7AB8F3EA493C9702E319DB@HQ-EXCH-5.corp.brocade.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Doug, linux-kernel@vger.kernel.org, Dave Jiang <djiang@mvista.com>,
	linuxppc-dev@ozlabs.org, Thompson <dougthompson@xmission.com>,
	Kumar Gala <galak@gate.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Let's cc the suitable people.

On Tue, 28 Apr 2009 18:23:42 -0700 "Jeff Haran" <jharan@Brocade.COM> wrote:

> Hi,
> 
> Recent versions of this function contain the following snippets:
> 
>     if (err_detect & DDR_EDE_SBE)
>         edac_mc_handle_ce(mci, pfn, err_addr & PAGE_MASK,
>                   syndrome, row_index, 0, mci->ctl_name);
> 
>     if (err_detect & DDR_EDE_MBE)
>         edac_mc_handle_ue(mci, pfn, err_addr & PAGE_MASK,
>                   row_index, mci->ctl_name);
> 
> I am pretty sure the references to PAGE_MASK should be proceeded by a
> tilda, as in:
> 
>     if (err_detect & DDR_EDE_SBE)
>         edac_mc_handle_ce(mci, pfn, err_addr & ~PAGE_MASK,
>                   syndrome, row_index, 0, mci->ctl_name);
> 
>     if (err_detect & DDR_EDE_MBE)
>         edac_mc_handle_ue(mci, pfn, err_addr & ~PAGE_MASK,
>                   row_index, mci->ctl_name);
> 

Could well be.  PAGE_MASK is very easy to get wrong.  I've _never_
trusted my own memory of it and I always have to go back to the
definition when reviewing code :(

> Much as I would like to submit a tested patch like the rest of the
> world, I find myself in the situation where the only Freescale target
> system I have to test on is running a 3 year old kernel (2.6.14), which
> preceeds the introduction of EDAC driver support, at least for
> Freescale. So the best I can do is borrow from the new EDAC driver and
> backport it to the old kernel.
> 
> But I have learned a few things in this process and can thus share what
> I've learned as it may be of help to the EDAC driver developers:
> 
> 1) Before you read the Freescale 8548 CAPTURE_ADDRESS register, you want
> to read CAPTURE_ATTRIBUTES first and make sure the VLD bit (least
> significant bit in the register) is set or else the data in
> CAPTURE_ADDRESS may not be yet valid.
> 
> 2) When you are done scrubbing the memory with the single bit error, you
> want to write 0 to CAPTURE_ATTRIBUTES so as to clear VLD and thus setup
> the ECC capture logic to capture the next single bit error.
> 

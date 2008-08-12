Return-Path: <glikely@secretlab.ca>
Received: from rn-out-0910.google.com (rn-out-0910.google.com [64.233.170.184])
	by ozlabs.org (Postfix) with ESMTP id D9416DE245
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Aug 2008 05:50:33 +1000 (EST)
Received: by rn-out-0910.google.com with SMTP id j40so35074rnf.16
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Aug 2008 12:50:31 -0700 (PDT)
Date: Tue, 12 Aug 2008 13:50:28 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [RFC/PATCH 1/3] powerpc: add ioremap_bat() function for
	setting up BAT translated IO regions.
Message-ID: <20080812195027.GB11386@secretlab.ca>
References: <20080806055214.30717.86092.stgit@trillian.secretlab.ca>
	<20080806060223.30717.35175.stgit@trillian.secretlab.ca>
	<CD66FAA8-BC99-4630-9FFF-E2C651E5DE9A@kernel.crashing.org>
	<fa686aa40808061454t14737278h3fd15fb0ccdbf251@mail.gmail.com>
	<75A0A752-FF2C-41B6-A6D3-E510E8FD4E91@kernel.crashing.org>
	<1218061709.24157.249.camel@pasglop>
	<63451E1F-30C1-4146-9D1A-BD4973E8F17A@kernel.crashing.org>
	<1218147224.24157.308.camel@pasglop>
	<8A11E9B3-4B7D-48CF-ABAB-625050D8FFFE@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8A11E9B3-4B7D-48CF-ABAB-625050D8FFFE@kernel.crashing.org>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: paulus@samba.org, miltonm@bga.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Aug 07, 2008 at 07:04:04PM -0500, Kumar Gala wrote:
>> mem_init_done isn't a good indication. We can do page tables when it's
>> 0, we would have to use a separate mem_preinit_done or something :-)
>>
>> I initially also though about a flag to ioremap_prot to be honest. But
>> it does obfuscate the normal ioremap code path and if there's a flag,
>> that means that callers know the difference and thus may as well call
>> a separate function, don't you think ?
>
> I'm ok with exposing a separate function as far as the API goes.. I'm  
> not ok with duplicating the logic of __ioremap().

Turns out there is very little actual duplication of code with
__ioremap().  The checks for p_mapped_by_* are the same, but all the
alignment checks are different because different boundaries are used.

I attempted to break things down to a common function, but there is not
a lot there.  But I will add a function to manage modification of
ioremap_bot.

g.

Return-Path: <benh@kernel.crashing.org>
Subject: Re: 44x _tlbie() ME/CE/DE disabling unnecessary?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Hollis Blanchard <hollis@penguinppc.org>
In-Reply-To: <fb412d760810301104s228a6036s50adba8605a13a98@mail.gmail.com>
References: <fb412d760810301104s228a6036s50adba8605a13a98@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 31 Oct 2008 07:14:00 +1100
Message-Id: <1225397640.8004.171.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-10-30 at 13:04 -0500, Hollis Blanchard wrote:
> 
> I don't think it's necessary at all to disable ME/CE/DE inside
> _tlbie() on 440, because the interrupt handlers for those types save
> and restore MMUCR (they're all the same code path; see
> mcheck_transfer_to_handler in entry_32.S).

This was written before the saving of MMUCR was added I think.

> However, I think EE does need to be disabled, since the normal EE
> handler doesn't deal with MMUCR. So instead of all these MSR
> manipulations, I think a simple wrteei 0/1 pair should do the trick?
> Or maybe mfmsr/wrteei/wrtee, in case _tlbie() happens to be called
> with interrupts disabled already.

Yes.

Ben.

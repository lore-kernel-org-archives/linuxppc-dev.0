Return-Path: <dan.j.williams@gmail.com>
Received: from mail-ww0-f45.google.com (mail-ww0-f45.google.com [74.125.82.45])
	by ozlabs.org (Postfix) with ESMTP id B96CDB70CB
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  1 Oct 2010 08:52:33 +1000 (EST)
Received: by wwa36 with SMTP id 36so2363199wwa.14
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 30 Sep 2010 15:52:30 -0700 (PDT)
MIME-Version: 1.0
Sender: dan.j.williams@gmail.com
In-Reply-To: <20100930190814.52268D2B48C@gemini.denx.de>
References: <1285865736-32074-1-git-send-email-tmarri@apm.com>
	<20100930190814.52268D2B48C@gemini.denx.de>
Date: Thu, 30 Sep 2010 15:52:30 -0700
Message-ID: <AANLkTi=CJOsayM1YnwE3a22D2S35aM+BTV6_YfXjcjiO@mail.gmail.com>
Subject: Re: [PATCH] PPC4xx: ADMA separating SoC specific functions
From: Dan Williams <dan.j.williams@intel.com>
To: Wolfgang Denk <wd@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: tmarri@apm.com, linux-raid@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-crypto@vger.kernel.org, yur@emcraft.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 30, 2010 at 12:08 PM, Wolfgang Denk <wd@denx.de> wrote:
[snip other valid review comments]
>
> This is a header file, yet you add here literally thousands of lines of
> code.

Yes, these functions are entirely too large to be inlined.  It looks
like you are trying to borrow too heavily from the iop-adma model.
The differences between iop13xx and iop33x from a adma perspective are
just in descriptor format and channel capabilities.  If you look at
the routines implemented in:
arch/arm/include/asm/hardware/iop3xx-adma.h
arch/arm/mach-iop13xx/include/mach/adma.h
...they are just simple helpers that abstract the descriptor details.
For example:

iop_adma_prep_dma_xor()
{
[snip]
        spin_lock_bh(&iop_chan->lock);
        slot_cnt =3D iop_chan_xor_slot_count(len, src_cnt, &slots_per_op);
        sw_desc =3D iop_adma_alloc_slots(iop_chan, slot_cnt, slots_per_op);
        if (sw_desc) {
                grp_start =3D sw_desc->group_head;
                iop_desc_init_xor(grp_start, src_cnt, flags);
                iop_desc_set_byte_count(grp_start, iop_chan, len);
                iop_desc_set_dest_addr(grp_start, iop_chan, dma_dest);
                sw_desc->unmap_src_cnt =3D src_cnt;
                sw_desc->unmap_len =3D len;
                sw_desc->async_tx.flags =3D flags;
                while (src_cnt--)
                        iop_desc_set_xor_src_addr(grp_start, src_cnt,
                                                  dma_src[src_cnt]);
        }
        spin_unlock_bh(&iop_chan->lock);

        return sw_desc ? &sw_desc->async_tx : NULL;
}

Where  iop_adma_alloc_slots() is implemented differently between
iop13xx and iop3xx.  In this case why does ppc440spe-adma.h exist?  If
it has code specific to ppe440spe it should just live in the ppe440spe
C file.  If it is truly generic it should move to the base adma.c
implementation.  If you want to reuse a ppe440spe routine just link to
it.

> Selecting the architecture at build time is bad as it prevents using a
> sinlge kernel image across a wide range of boards. =A0You only replied
> "We select the architecture at build time." without any explanation if
> there is a pressing technical reason to do it this way, or if this was
> just a arbitrary decision.

I agree I have yet to see any indication that this driver needs to
have an architecture selected at build time.

A potential compromise a first step would be to have a common C file
that is shared between two driver modules until such point that they
can be unified into a common module.

--
Dan

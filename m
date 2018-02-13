Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zgX0j71XtzF0kZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Feb 2018 16:59:01 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Johannes Thumshirn <jthumshirn@suse.de>, James Smart <jsmart2021@gmail.com>
Cc: linux-scsi@vger.kernel.org, Dick Kennedy <dick.kennedy@broadcom.com>,
 James Smart <james.smart@broadcom.com>, Mark Rutland <mark.rutland@arm.com>,
 linuxppc-dev@lists.ozlabs.org <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v2 04/13] lpfc: Add push-to-adapter support to sli4
In-Reply-To: <20180207102759.qzzqleujqhxnenna@linux-x5ow.site>
References: <20180207022851.11800-1-jsmart2021@gmail.com>
 <20180207022851.11800-5-jsmart2021@gmail.com>
 <20180207095157.zejjbq6a7eeqmosx@linux-x5ow.site>
 <20180207102759.qzzqleujqhxnenna@linux-x5ow.site>
Date: Tue, 13 Feb 2018 16:59:01 +1100
Message-ID: <871shpo2fu.fsf@concordia.ellerman.id.au>
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

Johannes Thumshirn <jthumshirn@suse.de> writes:

> On Wed, Feb 07, 2018 at 10:51:57AM +0100, Johannes Thumshirn wrote:
>> > +			/* Enable combined writes for DPP aperture */
>> > +			pg_addr = (unsigned long)(wq->dpp_regaddr) & PAGE_MASK;
>> > +#ifdef CONFIG_X86
>> > +			rc = set_memory_wc(pg_addr, 1);
>> > +			if (rc) {
>> > +				lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
>> > +						"3272 Cannot setup Combined "
>> > +						"Write on WQ[%d] - disable DPP\n",
>> > +						wq->queue_id);
>> > +				phba->cfg_enable_dpp = 0;
>> > +			}
>> > +#else
>> > +			phba->cfg_enable_dpp = 0;
>> > +#endif
>> > +		} else
>> > +			wq->db_regaddr = phba->sli4_hba.WQDBregaddr;
>> 
>> I don't really like the set_memory_wc() call here. Neither do I like the ifdef
>> CONFIG_X86 special casing.
>> 
>> If you really need write combining, can't you at least use ioremap_wc()?
>
> Coming back to this again (after talking to our ARM/POWER folks internally).
> Is this really x86 specific here? I know there are servers with other architectures
> using lpfcs out there.
>
> I _think_ write combining should be possible on other architectures (that have
> PCIe and aren't dead) as well.
>
> The ioremap_wc() I suggested is probably wrong.
>
> So can you please revisit this? I CCed Mark and Michael, maybe they can help
> here.

I'm not much of an I/O guy, but I do know that on powerpc we don't
implement set_memory_wc(). So if you're using that then you do need the
ifdef.

I couldn't easily find the rest of this thread, so I'm not sure if
ioremap_wc() is an option. We do implement that and on modern CPUs at
least it will give you something that's not just a plain uncached
mapping.

cheers

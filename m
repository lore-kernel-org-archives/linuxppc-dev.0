Return-Path: <tj@kernel.org>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EE87AB7BC7
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  1 Dec 2009 18:33:42 +1100 (EST)
Message-ID: <4B14C6D7.3030303@kernel.org>
Date: Tue, 01 Dec 2009 16:33:43 +0900
From: Tejun Heo <tj@kernel.org>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 4/5] libata/sff: Use ops->bmdma_stop instead of
	ata_bmdma_stop()
References: <20091201070833.CC084B7BD9@ozlabs.org>	
	<4B14C4DC.6060107@kernel.org> <1259652545.2076.321.camel@pasglop>
In-Reply-To: <1259652545.2076.321.camel@pasglop>
Content-Type: text/plain; charset=UTF-8
Cc: linux-ide@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, jeff@garzik.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/01/2009 04:29 PM, Benjamin Herrenschmidt wrote:
> On Tue, 2009-12-01 at 16:25 +0900, Tejun Heo wrote:
>> On 12/01/2009 04:08 PM, Benjamin Herrenschmidt wrote:
>>> In libata-sff, ata_sff_post_internal_cmd() directly calls ata_bmdma_stop()
>>> instead of ap->ops->bmdma_stop(). This can be a problem for controllers
>>> that use their own bmdma_stop for which the generic sff one isn't suitable
>>>
>>> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>>
>> Oh... that's a scary bug lurking around.  Thanks for catching it.
>>
>> Acked-by: Tejun Heo <tj@kernel.org>
> 
> Feel free to pick that one up earlier if you want (ie for 2.6.32), as
> long as we manage to get it in in 2.6.33 -before- I push powerpc-next to
> Linus, I'm happy :-) (or we can have it in both trees).

As nasty as the bug might be, given that we haven't had too much
problem with that, I think it would be best to give it some time to be
tested before releasing it to users.  It causes behavior differences
for all bmdma drivers which implement custom bmdma_stop.  It's an
apparent bug fix but well the nasty ones are always apparent bug
fixes, right?  :-)

Thanks.

-- 
tejun

Return-Path: <SRS0=LfN0=TY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78CE4C282E3
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 May 2019 13:32:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82B2E218BE
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 May 2019 13:32:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82B2E218BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 459S2m6PPvzDqTg
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 May 2019 23:32:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=neutral (mailfrom) smtp.mailfrom=iki.fi
 (client-ip=62.142.5.107; helo=emh01.mail.saunalahti.fi;
 envelope-from=aaro.koskinen@iki.fi; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=iki.fi
Received: from emh01.mail.saunalahti.fi (emh01.mail.saunalahti.fi
 [62.142.5.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 459Rzc71LTzDqQx
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 May 2019 23:29:13 +1000 (AEST)
Received: from darkstar.musicnaut.iki.fi (85-76-86-221-nat.elisa-mobile.fi
 [85.76.86.221])
 by emh01.mail.saunalahti.fi (Postfix) with ESMTP id 07F4A20080;
 Fri, 24 May 2019 16:29:08 +0300 (EEST)
Date: Fri, 24 May 2019 16:29:07 +0300
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [BISECTED] kexec regression on PowerBook G4
Message-ID: <20190524132907.GE5234@darkstar.musicnaut.iki.fi>
References: <20190522223335.Horde.JIF8kbX8AwL8wErArEvEcg1@messagerie.si.c-s.fr>
 <20190522211724.GC456@darkstar.musicnaut.iki.fi>
 <a3619327-14ba-ff34-913f-cf3384284c9a@c-s.fr>
 <20190523172717.GA5234@darkstar.musicnaut.iki.fi>
 <dc24cfa0-cefa-3245-a9aa-5493b094ffac@c-s.fr>
 <20190523222344.GC5234@darkstar.musicnaut.iki.fi>
 <334b0aca-3731-5754-bd26-af147991345d@c-s.fr>
 <ed5f9739-7661-b32a-cb8f-157b516baafa@c-s.fr>
 <20190524073615.GD5234@darkstar.musicnaut.iki.fi>
 <969271d1-0943-42e6-8992-77b20e305e48@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <969271d1-0943-42e6-8992-77b20e305e48@c-s.fr>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi,

On Fri, May 24, 2019 at 09:40:30AM +0200, Christophe Leroy wrote:
> Le 24/05/2019 à 09:36, Aaro Koskinen a écrit :
> >On Fri, May 24, 2019 at 08:08:36AM +0200, Christophe Leroy wrote:
> >>>Le 24/05/2019 à 00:23, Aaro Koskinen a écrit :
> >>>>Unfortunately still no luck... The crash is pretty much the same with
> >>>>both
> >>>>changes.
> >>>
> >>>Right. In fact change_page_attr() does nothing because this part of RAM is
> >>>mapped by DBATs so v_block_mapped() returns not NULL.
> >>>
> >>>So, we have to set an IBAT for this area. I'll try and send you a new
> >>>patch for that before noon (CET).
> >>>
> >>
> >>patch sent out. In the patch I have also added a printk to print the buffer
> >>address, so if the problem still occurs, we'll know if the problem is really
> >>at the address of the buffer or if we are wrong from the beginning.
> >
> >Reboot code buffer at ef0c3000
> >Bye!
> >BUG: Unable to handle kernel instruction fetch
> >Faulting instruction address: 0xef0c3000
> >
> 
> Oops, I forgot to call update_bats() after setibat().
> 
> Can you add it and retry ?

Thanks, that was it, now it finally works!

A.

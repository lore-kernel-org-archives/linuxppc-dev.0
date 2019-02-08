Return-Path: <SRS0=r06i=QP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5BDC169C4
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 21:55:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17CC4218D2
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 21:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="mte4lPZx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17CC4218D2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43x89s15PVzDqc6
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Feb 2019 08:55:13 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43x87w6mLWzDqbp
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Feb 2019 08:53:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="mte4lPZx"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1003)
 id 43x87w4pLHz9sN1; Sat,  9 Feb 2019 08:53:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1549662812; bh=TTJ2NxioFhOLInM0cq+OcJdONxa2x0s7rtZrdUd40Wk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mte4lPZxMBgEtoIzYEfjvrFsQIC9INB3a/exJY4yNulObP+/LFT1Z7AEotMPWwPgm
 HXKWJ5YqMJL+vHtoyEcnOJKjRP9M0LA+ZR+6sHpSyWrSvR/3HhEtVFXzu0GcySae58
 bEUPmbtNjIFsPvkbShgfZ+9XfR5bnPbfHCNUDNRbArVku8d6Afl4LKCe3/rkKVryiW
 p6mNA42GZLdbZITF8kAL27lr07RdsKI3MIorJeke/4moxd9OAHlDL7Gh8TCeP7uvZU
 cdYy1US+c2k9GwGa6mjKRrWK4TgOzOaZe7rG3zJzGPCh+5umUqBlRRUaMtAxrmYPsY
 b1V9X8M+zeSrQ==
Date: Sat, 9 Feb 2019 08:53:29 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 06/19] KVM: PPC: Book3S HV: add a GET_ESB_FD control to
 the XIVE native device
Message-ID: <20190208215329.GA9529@blackberry>
References: <20190204044531.GB1927@umbus.fritz.box>
 <69791b73-f93e-6957-92e8-5b8620b87731@kaod.org>
 <20190205052822.GE22661@umbus.fritz.box>
 <4d565738-a99b-0333-8533-037677358faa@kaod.org>
 <20190206012308.GP22661@umbus.fritz.box>
 <1745dd9f-2927-cae6-e8da-c350b0bd0a66@kaod.org>
 <20190207024950.GA22661@umbus.fritz.box>
 <d20bbaca-5b49-66e4-9d99-21d991c2c345@kaod.org>
 <20190208051523.GD2688@umbus.fritz.box>
 <9b556f53-fcfb-2ca3-019e-6ced0ec74c2a@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9b556f53-fcfb-2ca3-019e-6ced0ec74c2a@kaod.org>
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
Cc: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Feb 08, 2019 at 08:58:14AM +0100, Cédric Le Goater wrote:
> On 2/8/19 6:15 AM, David Gibson wrote:
> > On Thu, Feb 07, 2019 at 10:03:15AM +0100, Cédric Le Goater wrote:
> >> That's the plan I have in mind as suggested by Paul if I understood it well.
> >> The mechanics are more complex than the patch zapping the PTEs from the VMA
> >> but it's also safer.
> > 
> > Well, yes, where "safer" means "has the possibility to be correct".
> 
> Well, the only problem with the kernel approach is keeping a pointer on 
> the VMA. If we could call find_vma(), it would be perfectly safe and much 
> more simpler.

You seem to be assuming that the kernel can easily work out a single
virtual address which will be the only place where a given set of
interrupt pages are mapped.  But that is really not possible in the
general case, because userspace could have mapped the fd at many
different offsets in many different places.

QEMU doesn't do that; in QEMU, the mmaps are sufficiently limited that
it can work out a single virtual address that needs to be changed.
The way that QEMU should tell the kernel what that address is and what
the mapping should be changed to, is via the existing munmap()/mmap()
interface.

Paul.

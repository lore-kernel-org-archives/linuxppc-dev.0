Return-Path: <linuxppc-dev+bounces-23276-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB111C43327
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Jul 2026 08:29:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqtVX2hxKz2xKh;
	Wed, 01 Jul 2026 18:29:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782894596;
	cv=none; b=DZ5La3dYqILeSFiS7OTItE3nzg8EfxsOQTPGBG4e+rLEeRfC4THFHvKKpgtb9u+z+w+EOo0i4rvcgAAhyNsTN9qtGfA0sYX7ZxvGIlHSptdHhmv5Qj9Db33d/HORbEkLswPLvAQ4o6Yn6xgbz6V2ZDaxoyBfOXzIzdls12ekygu0Nm8bZWUXmjnPxfcc/92bcpm+eL428NGyVqqaA7P9zZgl0jNL1CzAii2YFKfBLFQVE32NkAoIHpTPulojJcMVeLtjBLnc1EEZrhf0XcsVDLbtEvbZxTIzFZJdIyAZcZmTeep46RNVup6rbMnGqzgsEcX1bcbKvlhel5vVHMBEvw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782894596; c=relaxed/relaxed;
	bh=RXXdGVRfCqtqSTHKkrvRfqO5GMS4z58MT3yoL5BEgZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C+uy3Fj83zggpQgALL8uLnwzJDk1CaiejBXzFVSdUMRIfjYvr3QDEziQz+qGD396gdIZP3RIVEOXt2koUNDCakHZHkuB2AtGZEEMPTpTJZbizJWyWkF3NGyYktaIL+Ax68uXGgv615qx+2VM5QFw72YCQn6Q7yPX8DqQ426J5eT+pbA0h+irKFJuPlUo59R2cWcyjQ7oh7npVLiQTfq3hB8ZsLCb9CLPM4asqt9I87oxDcjDk2Y1/s3IvuADjprcFxWC8Fd5rd6BkIUM+vv833Q2l0FuN5LryaFjQMk3K855x9WJzs0dgpkMMb5XLYYesRujCdyw7haMbtDx0tiDGQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=dvtlPlh4; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=7uPmQlpd; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=gRwIZSMX; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=uZZ44JWs; dkim-atps=neutral; spf=pass (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=dvtlPlh4;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=7uPmQlpd;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=gRwIZSMX;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=uZZ44JWs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqtVV6l7kz2xJT
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 18:29:54 +1000 (AEST)
Received: from kunlun.suse.cz (unknown [IPv6:2a07:de40:b306:2000::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 848EE71FB0;
	Wed,  1 Jul 2026 08:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782894591; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RXXdGVRfCqtqSTHKkrvRfqO5GMS4z58MT3yoL5BEgZQ=;
	b=dvtlPlh4W9jg+5DjIlq7QcPbB3m15lWnzhTCdxGfuMUgQ48Hd4o+LbAOHziE0U42z0ILf0
	iBKGsSC1NNIap10csJ8IV6cZE6u/B7VYLB80ahYPyGvQBWPcB7PPM5flA3vNflLdf5y3vK
	tsywaK7z92TdBmI7hInAe/e5s5m8M6k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782894591;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RXXdGVRfCqtqSTHKkrvRfqO5GMS4z58MT3yoL5BEgZQ=;
	b=7uPmQlpdKZJ9LnNRHu6S5Ahdl+5R1OBRLbcw/hxH/mzL1kOhzu2YUqwW5TYolGEmkaYH2i
	Cm6VQ1UXSB1cPzBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=gRwIZSMX;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=uZZ44JWs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782894590; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RXXdGVRfCqtqSTHKkrvRfqO5GMS4z58MT3yoL5BEgZQ=;
	b=gRwIZSMXnBQ4/2B1UC7dU+QiSfBHSTJP4DNJEIm/cp62IrBljt5lDw2t1BbQxqDf7bqPv6
	WuQO8hyXspqp4T+SfsnGeDpjNwnKkgbBSRNCs1kWNQ7u/hLmPXIJBh2HdrHyPA0UHk6GN0
	j9uLZhQA1+V3JgtmCOh41I78aeFsww8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782894590;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RXXdGVRfCqtqSTHKkrvRfqO5GMS4z58MT3yoL5BEgZQ=;
	b=uZZ44JWstUW3gWd+teo9eKyi9pWp8SwRQcI4pnCDnxouK2NRBOqDtR1Nlf2+5jWpnyhG5g
	KXDnrxc/vwIwt9AA==
Date: Wed, 1 Jul 2026 10:29:49 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>, maddy@linux.ibm.com,
	mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
	mkchauras@linux.ibm.com, ryan.roberts@arm.com,
	ruanjinjie@huawei.com, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] powerpc/syscall: Fix seccomp errno handling with
 GENERIC_ENTRY
Message-ID: <akTP_YJvGwln_xb_@kunlun.suse.cz>
References: <20260629182946.419552-1-mkchauras@gmail.com>
 <a58675e4-f5a6-4a21-9871-904aad33b683@linux.ibm.com>
 <akSyVOsraz9waBf4@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <akTExSO3ZT7iRtBa@kunlun.suse.cz>
 <akTJbfXPKc10Xemh@kunlun.suse.cz>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <akTJbfXPKc10Xemh@kunlun.suse.cz>
X-Spamd-Bar: +++++++++++++++
X-Rspamd-Queue-Id: 848EE71FB0
X-Rspamd-Action: add header
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [15.16 / 50.00];
	SPAM_FLAG(5.00)[];
	NEURAL_SPAM_LONG(3.50)[1.000];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_SPAM_SHORT(2.97)[0.989];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	RDNS_NONE(2.00)[];
	ONCE_RECEIVED(1.20)[];
	HFILTER_HELO_IP_A(1.00)[kunlun.suse.cz];
	HFILTER_HELO_NORES_A_OR_MX(0.30)[kunlun.suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b306:2000::2:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[linux.ibm.com,ellerman.id.au,gmail.com,kernel.org,arm.com,huawei.com,lists.ozlabs.org,vger.kernel.org];
	DNSWL_BLOCKED(0.00)[2a07:de40:b306:2000::2:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RCVD_COUNT_ZERO(0.00)[0];
	RCPT_COUNT_SEVEN(0.00)[11];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,kunlun.suse.cz:mid,kunlun.suse.cz:helo]
X-Spam: Yes

On Wed, Jul 01, 2026 at 10:01:49AM +0200, Michal Suchánek wrote:
> On Wed, Jul 01, 2026 at 09:41:57AM +0200, Michal Suchánek wrote:
> > On Wed, Jul 01, 2026 at 11:57:00AM +0530, Mukesh Kumar Chaurasiya wrote:
> > > On Wed, Jul 01, 2026 at 01:41:09AM +0530, Shrikanth Hegde wrote:
> > > > Hi Mukesh.
> > > > 
> > > > On 6/29/26 11:59 PM, Mukesh Kumar Chaurasiya (IBM) wrote:

> > > > > diff --git a/arch/powerpc/kernel/syscall.c b/arch/powerpc/kernel/syscall.c
> > > > > index a9da2af6efa8..36d73933a311 100644
> > > > > --- a/arch/powerpc/kernel/syscall.c
> > > > > +++ b/arch/powerpc/kernel/syscall.c
> > > > > @@ -20,7 +20,6 @@ notrace long system_call_exception(struct pt_regs *regs, unsigned long r0)
> > > > >   	syscall_fn f;
> > > > >   	add_random_kstack_offset();
> > > > > -	r0 = syscall_enter_from_user_mode(regs, r0);
> > > > >   	if (unlikely(r0 >= NR_syscalls)) {
> > > > >   		if (unlikely(trap_is_unsupported_scv(regs))) {
> > > > > @@ -31,6 +30,12 @@ notrace long system_call_exception(struct pt_regs *regs, unsigned long r0)
> > > > >   		return -ENOSYS;
> > > > >   	}
> > > > > +	r0 = syscall_enter_from_user_mode(regs, r0);
> > > > > +
> > > > 
> > > > I see many arch first do syscall_enter_from_user_mode and then check for return value.
> > > > take x86 for example,
> > > > 
> > > > __visible noinstr bool do_syscall_64(struct pt_regs *regs, int nr)
> > > > {
> > > >         nr = syscall_enter_from_user_mode(regs, nr);
> > > > 
> > > >         if (!do_syscall_x64(regs, nr) && !do_syscall_x32(regs, nr) && nr != -1) {
> > > >                 /* Invalid system call, but still a system call. */
> > > >                 regs->ax = __x64_sys_ni_syscall(regs);
> > > >         }
> > > > 
> > > > }
> > > > 
> > > > So seccomp fails silently there if initial nr was -1?
> > > > 
> > > Hey,
> > > 
> > > No the -1 syscall ignores the error silently and returns 0.
> > > 
> > 
> > There seems to be some inconsistency with the invalid syscalls.
> > 
> > Adapting the example from seccomp man page to ignore architecture I get
> > on x86_64 (presumably with GENERIC_ENTRY since long ago):
> > 
> > ./a.out -2 55 /usr/bin/perl -MPOSIX -e '$!=0; my $r = syscall(-2, 0); print "ret=$r errno=".($!+0)." ($!)\n"'
> > ret=-1 errno=55 (No anode)
> > 
> > but on ppc64le (with GENEREC_ENTRY):
> > 
> > ./a.out -2 55 /usr/bin/perl -MPOSIX -e '$!=0; my $r = syscall(-2, 0); print "ret=$r errno=".($!+0)." ($!)\n"'
> > ret=-1 errno=38 (Function not implemented)
> > 
> > That said, behavior of seccomp on invalid syscalls is not particularly
> > concerning. The tools that people typically use for constructing those
> > filters typically require a valid syscall number.
> > 
> > It would be nice to align, though.
> 
> It is more concerning for SECCOMP_SET_MODE_STRICT or similar. So it
> should be resolved to correctly execute seccomp even on invalid
> syscalls. The syscall_enter_from_user_mode API is not particularly
> well-suited for that, though.

In particular the fixup per
https://lore.kernel.org/linuxppc-dev/akJzuEJRLniHk4Fi@kunlun.suse.cz/

handles some cases

./a.out -2 55 /usr/bin/perl -MPOSIX -e '$!=0; my $r = syscall(-2, 0); print "ret=$r errno=".($!+0)." ($!)\n"'
ret=-1 errno=55 (No anode)

but not -1

./a.out -1 55 /usr/bin/perl -MPOSIX -e '$!=0; my $r = syscall(-1, 0); print "ret=$r errno=".($!+0)." ($!)\n"'
ret=-1 errno=38 (Function not implemented)

which is the direct result of the ambiguous return value of
syscall_enter_from_user_mode

Thanks

Michal


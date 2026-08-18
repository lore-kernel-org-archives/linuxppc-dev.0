Return-Path: <linuxppc-dev+bounces-25957-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A89EEC5DF7D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Aug 2026 10:33:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hPQyv1h7Kz2yGB;
	Tue, 18 Aug 2026 20:33:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a07:de40:b251:101:10:150:64:2"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787049207;
	cv=none; b=YG88bzi6EgcmbLF++9h/RwH3nzfr7OVkUiDFkC5ckU0Xl58HOSm1x/c/mkKhfDpLmafBxf2h9ARdA6BoKzv8DQE0lJ7xEeywIyWrZUcP6AoiMUarBrw4cUZCvrMOT6NOw5Vd2UDbF8OdgtllyEdXVd1dUbVnvEwmoYfWsM+0Yj1ktJnvnPRwFNw1rUSWgmvZe5nFYNcBH8Pk967q/qxnWzeQ2VVEzK8qHefzQ6SffT9qZ9aHY7MZ/vfHzeM02I+QWwjyD9uyAwp2oByRLhjTgww6xNv9RueVWIe/Gh6n+ojygPYPJct7vMsfb3EPl2a/8LOOaciM31V+uZblzPjg7A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787049207; c=relaxed/relaxed;
	bh=hajFIrQyCHqzUS+imbiKOjxd+SjzPOZ/FjaQYcoIJZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OEsDvosNeVW3E90sqKnOgoeF+mCLd+OS54S8dydPkoEYd9oanUeXGopiyCGQLZbunwohi1LQPq+e+3ZyYG9dBQyqglu0nJ3mjqrr8vI+FLLlK3QTc+TICiNfCG6++g7RVZgF68C6Ck4OsfoRIoZVNtiovJWuknKX9BaTcJ3SAfA7bN5Jy2wKSxYSnr7R9yWIw9DW4hrS5fg+2gP3z0NHBZYWp5/llrgibIUxAAIYKkaNbU7N3/H0yv31SphQhqwmqYbZPFS3tMhO82AkF85A9FJv/I12AjMJvdIb9v68kMSdgIzruxZuj6TY3sLijce6+V0NAJNK1foqpwpDLt4FnQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=uxW0jaCw; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Q+7zrDZw; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=sAB2Te+o; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=2jJxqJ5b; dkim-atps=neutral; spf=pass (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de; envelope-from=hare@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=uxW0jaCw;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Q+7zrDZw;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=sAB2Te+o;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=2jJxqJ5b;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de; envelope-from=hare@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hPQys1C24z2yCL
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2026 20:33:24 +1000 (AEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 22DE33E43;
	Tue, 18 Aug 2026 10:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787049196; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hajFIrQyCHqzUS+imbiKOjxd+SjzPOZ/FjaQYcoIJZc=;
	b=uxW0jaCwDeghPDckED3gDJmXBF2L1KXNvWQwNQcvkpCYUTSIJFfHZQD8NmX7526XdRWgp2
	q8qPhbmESwKShUSdmrQ7CYIxy1mXW8FK52yLzlB/+cCdeKBLD4zbl8pEvJBs+zMLAtSW+U
	d62o1Qy70uDPutY4EMinPeCcfk/UTi0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787049196;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hajFIrQyCHqzUS+imbiKOjxd+SjzPOZ/FjaQYcoIJZc=;
	b=Q+7zrDZwmusR/vv2cEVcf6RWUVwCIgC/jZB9QMCaAsd79PR3XpcaW0N8AQ11UsFU3dNnNi
	U3HxtHUAPzl54uDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=sAB2Te+o;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=2jJxqJ5b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787049192; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hajFIrQyCHqzUS+imbiKOjxd+SjzPOZ/FjaQYcoIJZc=;
	b=sAB2Te+o2xnRETmTLvuIvnoZ20uJWHJ0TYPNSy1AhUNh2dULDv0jJx0cyr241PulZOWYkV
	t0i/It3wY+89PVMQZoJzWYNsEtcMV6VQEsZyzEntXOWaJ+hOtzUOBK4b3hUZJZiHf0vAbF
	COtWvP6HXK5jzeY4nuU1s31K1XBQ8QQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787049192;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hajFIrQyCHqzUS+imbiKOjxd+SjzPOZ/FjaQYcoIJZc=;
	b=2jJxqJ5b8IzXrfXBYYTRsoDvh8gVFCNz3zZPXOA8ts03GUipyAT2CRMybaXRFNckIVx1nD
	PkuUtCZu61m+GwAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E5AEE22BA;
	Tue, 18 Aug 2026 10:33:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Cp0EN+c0hGqKGQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 18 Aug 2026 10:33:11 +0000
Message-ID: <ef23cb9e-f358-40a2-b494-a78f4983d0ad@suse.de>
Date: Tue, 18 Aug 2026 12:33:11 +0200
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] scsi: core: Drop Scsi_Host.default_lock
To: John Garry <john.g.garry@oracle.com>,
 James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, bvanassche@acm.org,
 linux-s390@vger.kernel.org, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-usb@vger.kernel.org, John Garry <john.garry@linux.dev>,
 Damien Le Moal <dlemoal@kernel.org>
References: <20260817075324.2737619-1-john.g.garry@oracle.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260817075324.2737619-1-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,acm.org:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,linux.dev:email,suse.de:email,suse.de:mid,suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 22DE33E43
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action

On 8/17/26 9:53 AM, John Garry wrote:
> From: John Garry <john.garry@linux.dev>
> 
> Back in the 2.6.xx days, it was possible to for low-level drivers to set
> the shost lock pointer. That is why there is a default lock and a pointer
> to the shost lock.
> 
> However, support for this has long been removed, so drop
> Scsi_Host.default_lock and make Scsi_Host.host_lock as the actual lock.
> 
> Getting the address of embedded host_lock structure just requires adding
> a fixed offset value to the shost pointer. However, getting the value of
> the host_lock pointer requires loading from a fixed offset to the shost
> pointer. The latter should be very slightly slower, which is relevant as
> this lock is used a lot throughout the core code and drivers.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> Acked-by: Damien Le Moal <dlemoal@kernel.org> # ata parts
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> ---
> Difference to v3:
> - Rebase and update some annotations
> 
> Differences to v2:
> - Add tags from Bart and Damien (Thanks!)
> - Update Documentation reference to default_lock (Bart)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


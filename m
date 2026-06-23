Return-Path: <linuxppc-dev+bounces-22949-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AF23CDB470
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Jun 2026 20:23:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4glGjv5hJ6z2yQG;
	Wed, 24 Jun 2026 06:23:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.218.207.228
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782246227;
	cv=none; b=YVxVIvZKMCLymKgJ5CKgP0pbumngzqK8S9wg/7iJ8lJVGJRQlPrpM2qihGEUo2iaRu7umgpIwnhy3u8goDMn6rP1mDry2uwjRN4YxvQFtC7pwha9rywNedKmpvR0kC6i23dIjxqc3V41m3L/+Up8EXcXXa5JT5ttMUfpkbGFEtzOa5Sdugjd58u9GHus/BSaXip8ja3GkLK68P7ghF0HSMv0d7ytvS9KD1lbu0VNqn7wQoggMY/KPti5YjDlkg02zYiG7OsbRmAxBSJmy5sJhOBEi1h4i5yibAlpurCg13XhxfCTSlliOc5q5LcaEMi9/KiS1gIHKEZ7B92Xs/84qA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782246227; c=relaxed/relaxed;
	bh=IAfJFwEnmp1agnnfX2jU4/znEwpzF5AMDwIablcmerY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=gwrj0a6kDohRKcuBj3GwyegrkTAUxy4NR4QaxM3PffsgyBHYfjqehOW3Tm6+WqXojpVvtX4JErHnYsQZG+i+geZazqDowKSxumg4LeDxbuwVQC2+ScsIOgCtryuFSDlGmlZVIlUa9wEwSQaaGe5Ku55Jky0jmlOmx46iIVKtDBlwGxm/7xoXyOEtvfqoYV2YnJVEeDguUm84ODnalhtqQY7VWBHv4XObBRlV4wbXWwOG1Eg6Cu1/1LCl8DYz4gu7KrXkjH5NBGdGwgY3IM/DoNI3EKympbW+V2401viL9BoswTs9KqXnkyK/yYsEebAwDE9vcJ27qWo414t2fkO1fA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; dkim=pass (1024-bit key; secure) header.d=grrlz.net header.i=@grrlz.net header.a=rsa-sha256 header.s=stigmate header.b=Zpv3AvJh; dkim-atps=neutral; spf=pass (client-ip=185.218.207.228; helo=latitanza.investici.org; envelope-from=include@grrlz.net; receiver=lists.ozlabs.org) smtp.mailfrom=grrlz.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; secure) header.d=grrlz.net header.i=@grrlz.net header.a=rsa-sha256 header.s=stigmate header.b=Zpv3AvJh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=grrlz.net (client-ip=185.218.207.228; helo=latitanza.investici.org; envelope-from=include@grrlz.net; receiver=lists.ozlabs.org)
X-Greylist: delayed 422 seconds by postgrey-1.37 at boromir; Wed, 24 Jun 2026 06:23:45 AEST
Received: from latitanza.investici.org (latitanza.investici.org [185.218.207.228])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4glGjs0X9Hz2xnQ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jun 2026 06:23:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1782245793;
	bh=IAfJFwEnmp1agnnfX2jU4/znEwpzF5AMDwIablcmerY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Zpv3AvJhgt1AJ+adOVBabJ3ndlVmvcsuP0v+O20iopTJZNegAtauD78JpvjX7MAnd
	 W9+1taFmIX0eC1TW6DN9IydnVTqtTDBk9eCMjFlDAw/qBRjM9//w73UxL7nuIjLEY2
	 hpb9VUQZvyb17oFkpsk4zB3S95GKuTcABZY1gJE8=
Received: from mx3.investici.org (unknown [127.0.0.1])
	by latitanza.investici.org (Postfix) with ESMTP id 4glGYY3hh1zGpD0;
	Tue, 23 Jun 2026 20:16:33 +0000 (UTC)
Received: by mx3.investici.org (Postfix) id 4glGYY1Lw3zGpCr;
	Tue, 23 Jun 2026 20:16:33 +0000 (UTC)
Date: Tue, 23 Jun 2026 21:16:33 +0100
From: Bradley Morgan <include@grrlz.net>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: Petr Mladek <pmladek@suse.com>, Feng Tang <feng.tang@linux.alibaba.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>,
 Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>,
 Jinchao Wang <wangjinchao600@gmail.com>, Kees Cook <kees@kernel.org>,
 Rio <rioo.tsukatsukii@gmail.com>, Joel Granados <joel.granados@kernel.org>,
 Pnina Feder <pnina.feder@mobileye.com>, Petr Pavlu <petr.pavlu@suse.com>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Douglas Anderson <dianders@chromium.org>, Mayank Rungta <mrungta@google.com>,
 Tejun Heo <tj@kernel.org>, Zhenguo Yao <yaozhenguo1@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_1/4=5D_sys=5Finfo=3A_add_he?=
 =?US-ASCII?Q?lper_for_callers_that_handle_all=5Fbt?=
In-Reply-To: <ajrpPMo3Qc_SgFkG@ashevche-desk.local>
References: <9b8c96e291696815d3c7de5d3e199298dee0279d.1782228656.git.include@grrlz.net> <ajrob9r6cVtxqv72@ashevche-desk.local> <ajrpPMo3Qc_SgFkG@ashevche-desk.local>
Message-ID: <39C3E79F-CB10-4711-95B5-024D6750BDF6@grrlz.net>
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
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On June 23, 2026 9:14:52 PM GMT+01:00, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>On Tue, Jun 23, 2026 at 11:11:34PM +0300, Andy Shevchenko wrote:
>> On Tue, Jun 23, 2026 at 03:34:58PM +0000, Bradley Morgan wrote:
>> > Some callers handle SYS_INFO_ALL_BT themselves before calling
>sys_info().
>> > Add a helper that strips that bit without turning an all_bt only mask
>into
>> > a kernel_sys_info fallback.
>> 
>> You also want a getter with check
>> 
>> bool sysinfo_is_all_bt_enabled(...,  *si_mask)
>> 
>> where *si_mask is the result of READ_ONCE() that you keep as
>implementation
>> detail inside this helper.
>
>Ah, sorry, I have thought that the mask is part of sysinfo implementation.
>Disregard my above comment, it can't be done without also supplying the
>pointer
>to the original one, which makes no sense.

Ah, yeah, I was gonna say that.

No worries, will disregard! :)

>

Thanks!


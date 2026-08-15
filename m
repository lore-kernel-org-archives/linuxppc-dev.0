Return-Path: <linuxppc-dev+bounces-25883-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8DE3C5CFDB
	for <linuxppc-dev@archiver.kernel.org>; Sat, 15 Aug 2026 09:58:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hMZKQ53phz2xnH;
	Sat, 15 Aug 2026 19:58:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=81.169.146.165 arc.chain=strato.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786787882;
	cv=pass; b=bhCStSQ9xDk+bn19JLSKYqwHf2qNZfaOM2xnDr9u/+B8AHRDH+mfBnRv8vlLaN2fz+RYKIS70WtDpmJxSivoD3NLpPrfhPQdfeOU4DZ50TuI0TjLrKqOQ8eaV11xrnmxB/LaknMsOeXHqN01HtyIlGbdDxQFUeKwFVEboieheyx0HB0fJgs1jJkYU+/b58XDj0KX/f+4qp4yM5KJ6l/Kq3eVPLvQaHxamHI31YvarKsLiPUXK/An14Bj9y4FR8H1llkZ6Z0W+goe8AzQLMzHiaVT62DQHw407vNsKKcapgTQAl9MuIeyFXqHq+rhK/OGDlsXuIrZRd8jXyrjPwGXfA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786787882; c=relaxed/relaxed;
	bh=afnTQAXkp3yavSjC2F6pm9TdU2bctdI0zMMMGBji++A=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=lXoaVyN4AbEf3WCw/I5zH4H95UZJohcT0cnN5sBcYyS0P1lJRA4vJ1kLfDy3+wMHnNpHF1NqFuFVV7BB73YW7lOPfqTQAiz/LBuN0ZVO+CdKPoxra6lJN3wtrYhIYC6gMaefoUFa5hEsT1NrUbzFNDrA74wC719usd+baXzto2OIhk+ZA8UIHVGFkTBDxax2ouAJOpDoY/nrBbaJsBLoxlXcBSQoCHdy4H1cM01Az5C5obtt8L+MaHnpVhdZpVwD0T2ilHck7uJ/rh3uDCtiWoKtXFRAmQWfjwCflzpOwhMSp33f88JWnli/oWCtCLrZeZksPZpPqPov1XaQC7Ztkw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de; dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=eI2bi5Gc; dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=3iSI2cFO; dkim-atps=neutral; spf=pass (client-ip=81.169.146.165; helo=mo4-p01-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org) smtp.helo=mo4-p01-ob.smtp.rzone.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=eI2bi5Gc;
	dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=3iSI2cFO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.helo=mo4-p01-ob.smtp.rzone.de (client-ip=81.169.146.165; helo=mo4-p01-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hMZKH252Hz2xW5
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Aug 2026 19:57:51 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; t=1786787819; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=GK41msrg61ldnYf6c/5zqVTZGkUDKE4NOFBAStpkLO7kDqA52Ghoao0mGAhVIXI0YY
    NnoC/7ZfT9ntviFUok0Vw2BSTyUbA1k+Mn7NB8ToEVTznfUtkkwZLEkwuzGt5WlKXuWA
    pQPrXF8XZGmA5TYLe6VsP7xFG1U36LeA5ktENuaURE9kc3QdQeUsQ0owQxoeFj0LdbFY
    R0NMX15zzYvgMDh6FQI2xhJb4Luitp+J9s+O//SAZZLHevf54qGYg2gtHHYR+TMYk0WJ
    YAZNZ9mCHpchFFL9ME795IWxINaUCObrfYCohe9iZvvgndKYl4oE35mwuZAKJmh7bUMO
    o2Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1786787819;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=afnTQAXkp3yavSjC2F6pm9TdU2bctdI0zMMMGBji++A=;
    b=M4A2huit6DLkXj2WD2eu6/9FY+Bhpli4E1y2X6duFXYrVhIBQuTi0Ob4VnkKAdGx0H
    bhjBzjC2QDuKHLFIAXl2SHiG0lflITfnVT024jSKo/Zd4pzL+vnOKvMDG9ERilSZV8y1
    midHXlmDjkGdIaxfKa8LAM2vPZuqCQsiM7CFABgk07I54k33tTv3SWzg5ndAyYhgjLIU
    LGj1OajE13s3Nc8y0qnM60XJK58j2/C+h8PwxEt+xLemTnPhzAv8iFLEvb9c4DxkM9x8
    7Z627/qNrftIRzKBVrMx1JHl993nMaf8l9L14Vww8c9x5gpG7RNyoeN8lZuUuah9uxUk
    Fn7w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1786787819;
    s=strato-dkim-0002; d=xenosoft.de;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=afnTQAXkp3yavSjC2F6pm9TdU2bctdI0zMMMGBji++A=;
    b=eI2bi5GcYWpDzRZ3RFixTH3Qi22yvznq6J1bfpGzLR+GIQo1ks4mOJV0tVa14s8kI0
    ldGlDWarZI1ryTGfJcbrwGoZahQy+l/6AQQwOcW45GnzBPWwLhAhe8n5tXE5ZMHeqth8
    E21ngjJpQGVDGPKOSpB3ZkXL33VpKB8RAz7e/s52klprGOgL6LMyXdQWWVxyar4bx4w1
    klJqNcjRL+JWMBBUhtpZZg3O7RZLNsNA7KluGVcTOuQWqk2Bvkx+WYKqdU3fWLItqE6Z
    UjQP2w13MBvNZAyXpISV2JzMeD8JWSvnW0tqhGCNak6rU/57oZ6XH4ltNG2MtqZWyufk
    Pbuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1786787819;
    s=strato-dkim-0003; d=xenosoft.de;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=afnTQAXkp3yavSjC2F6pm9TdU2bctdI0zMMMGBji++A=;
    b=3iSI2cFOEL/yOe1f7MX6V+C5SRXWQYhApKDdFiV60DZu36l1RCMy4FKzEBh4MpamoG
    7SqvtKe+2JiW2M3UwDDg==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr4thIFiqT9BURIC+l7Rzg"
Received: from void-ppc.a-eon.tld
    by smtp.strato.de (RZmta 55.5.6 DYNA|AUTH)
    with ESMTPSA id eed0ee27F9uvmf3
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 15 Aug 2026 11:56:57 +0200 (CEST)
Subject: Re: [PATCH] Connecting the SB600's i8259 controller rather in
 pasemi's pci.c than in pasemi's setup.c.
To: kernel test robot <lkp@intel.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 "(open list:LINUX FOR POWERPC \\(32-BIT AND 64-BIT\\))"
 <linuxppc-dev@lists.ozlabs.org>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, "R.T.Dickinson" <rtd2@xtra.co.nz>,
 Darren Stevens <darren@stevens-zone.net>,
 Damien Stewart <hypexed@yahoo.com.au>, Christian Zigotzky <info@xenosoft.de>
References: <20260701125941.906-2-chzigotzky@xenosoft.de>
 <202608142355.4AeDorvg-lkp@intel.com>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Organization: A-EON Open Source
Message-ID: <5ad17e60-7c02-2cd9-7cad-0c14896b8f3d@xenosoft.de>
Date: Sat, 15 Aug 2026 11:56:56 +0200
X-Mailer: BrassMonkey/34.3.1
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
In-Reply-To: <202608142355.4AeDorvg-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/08/26 17:42, kernel test robot wrote:
 > Hi Christian,
 >
 > kernel test robot noticed the following build warnings:
 >
 > [auto build test WARNING on powerpc/next]
 > [also build test WARNING on powerpc/fixes linus/master v7.2-rc7 
next-20260813]
 > [If your patch is applied to the wrong git tree, kindly drop us a note.
 > And when submitting patch, we suggest to use '--base' as documented in
 > https://git-scm.com/docs/git-format-patch#_base_tree_information]
 >
 > url: 
https://github.com/intel-lab-lkp/linux/commits/Christian-Zigotzky/Connecting-the-SB600-s-i8259-controller-rather-in-pasemi-s-pci-c-than-in-pasemi-s-setup-c/20260813-054214
 >
 > All warnings (new ones prefixed by >>):
 >
 >>> arch/powerpc/platforms/pasemi/setup.c:217:6: warning: no previous 
prototype for function 'nemo_init_IRQ' [-Wmissing-prototypes]

This is the old patch.

Here is the new patch with pasemi.h: 
https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20260801043458.12500-1-chzigotzky@xenosoft.de/

Thanks

-- 
Sent with BrassMonkey 34.3.1 (https://github.com/chzigotzky/Web-Browsers-and-Suites-for-Linux-PPC/releases/tag/BrassMonkey_34.3.1)



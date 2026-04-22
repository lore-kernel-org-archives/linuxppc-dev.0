Return-Path: <linuxppc-dev+bounces-19930-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 638CAF94CD9
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Apr 2026 07:13:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g0r7B0l7xz2yZN;
	Wed, 22 Apr 2026 17:13:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776842038;
	cv=none; b=fhocvKBFfJUzb2Eff8yilwsh8moQsc0cMjmBhEd8xhZPuiv2akfS7gewuKYYnf7DEWhhVQA9oXqTu9IWSok+1bRbQWVFzrn4FRioJNSoaH+EjCvwFUPY4ih5By0qYF/H7PsY7iixPFn641N1Ffd3yq8i7WkzF/r4FMY6eoHTJ67Lqyfkx8/cgN+fh6J6OHeddMagINw4XGZW9tScw98JxQmeorbxY7pjBbwMv33sYn0WaO1utKT5zrH/PQZcGoYJXPmLWITizB1VP3QT9Z1khScd9nEryTOCSD8SGy7t9nYPGo0ZR/aDj7pppzngcBq8+cr+fcMnGeHigPp6qhassg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776842038; c=relaxed/relaxed;
	bh=u6VpsgmCXU921ccCM+rxS9Re8awywwK9qScDhKikl/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AgjQjt5AY3zJPqZI/N9GZVvt3flitqGt5zBKRNO84aJBXOhkmTHA3M2munb++IFqO7VfI7zd/duDw5NTISIorNA0vr0/Dn2LuPQazQ4FgtP+4w3uvEAV9aJJ3SiNiQ+uEpflt1TEPWzS62Of8cwN6K9NvfI7UtWAhe3Ph10fQU9ttEoKE2rL8EB0fCbXhqMO1X8EUkOEvx431nURi30HLeQcze/IOUhlD7PFScPHaxziO9Q+X++qyM/iPutjFIjE8fcbeZa14ZX/CbIcQG/Yp2g2gKI2poZGrKBkC0cRi7ZNYN4CfnMH19ck8yvr/Q7EP9Xb81R6025+xd7xZpJ4iQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PfhZYA3h; dkim-atps=neutral; spf=pass (client-ip=198.175.65.20; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PfhZYA3h;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.20; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g0r782f2Kz2xc8
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2026 17:13:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776842037; x=1808378037;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2fkao8ArefIYQIbLZPL2ShMrSXc6ICRKryHIhWNINls=;
  b=PfhZYA3h3dgYFV5Jy68YDF3xVkDfTETRzZCh0gJfZL6YkTEjVBbazNkR
   5vRvbHC8Bt0Mr8xNNfEaoLsW4Wo5iuox/pGp2ZJvpy2TZ+m1AUYhXbbdl
   ba14C8IPBUtJrcdv5LQTaXd8j7VQCU6Lh65e6KUY1u0f8I9Z5C+fmexn0
   x/q5zost+EWH7dFqfyKfqePjBQVv2WYlQXd+vGn8uPoFl2UfmOtNwctCI
   tcSe9Fv7BbQUkgxaG92WCyndJJQi/WRJxz4N+RXjUAZCTsZAUGlv9cSdg
   48Vyfmjo7jTWrmMA1lUQqplASrSRFypNHBgsoMw6rUM7PTNK+Zvb/S3xk
   Q==;
X-CSE-ConnectionGUID: pDIqIx0bQhysBlIl2NYMHA==
X-CSE-MsgGUID: 1fl5aLjHRT68sAspxzx/MQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="77491891"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="77491891"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 00:13:51 -0700
X-CSE-ConnectionGUID: 8bjn/CoeRfmR+ZxM9NIV9g==
X-CSE-MsgGUID: b/tjYM8wT72QHDuE4PxnmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="227681986"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.201])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 00:13:32 -0700
Date: Wed, 22 Apr 2026 10:13:31 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Link Mauve <linkmauve@linkmauve.fr>, linuxppc-dev@lists.ozlabs.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Juergen Gross <jgross@suse.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Geoff Levand <geoff@infradead.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Anatolij Gustschin <agust@denx.de>,
	Breno =?iso-8859-1?Q?Leit=E3o?= <leitao@debian.org>,
	Nayna Jain <nayna@linux.ibm.com>,
	Paulo Flabiano Smorigo <pfsmorigo@gmail.com>,
	Eric Biggers <ebiggers@kernel.org>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Thomas Huth <thuth@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	David Hildenbrand <david@kernel.org>,
	Alistair Popple <apopple@nvidia.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Donet Tom <donettom@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	Will Deacon <will@kernel.org>,
	"Lorenzo Stoakes (Oracle)" <ljs@kernel.org>,
	Paul Moore <paul@paul-moore.com>, Nam Cao <namcao@linutronix.de>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Srikar Dronamraju <srikar@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Jiri Bohac <jbohac@suse.cz>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Kees Cook <kees@kernel.org>, Stephen Rothwell <sfr@cab.auug.org.au>,
	Xichao Zhao <zhao.xichao@vivo.com>,
	Gautam Menghani <gautam@linux.ibm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Li Chen <chenl311@chinatelecom.cn>,
	Aboorva Devarajan <aboorvad@linux.ibm.com>,
	Petr Mladek <pmladek@suse.com>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	"Nysal Jan K.A." <nysal@linux.ibm.com>,
	Aditya Gupta <adityag@linux.ibm.com>,
	Sayali Patil <sayalip@linux.ibm.com>,
	Rohan McLure <rmclure@linux.ibm.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Donnellan <andrew+kernel@donnellan.id.au>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	Athira Rajeev <atrajeev@linux.ibm.com>,
	Kajol Jain <kjain@linux.ibm.com>, Thomas Gleixner <tglx@kernel.org>,
	Chen Ni <nichen@iscas.ac.cn>, Haren Myneni <haren@linux.ibm.com>,
	Jonathan Greental <yonatan02greental@gmail.com>,
	Ingo Molnar <mingo@kernel.org>,
	"Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
	Gaurav Batra <gbatra@linux.ibm.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Vivian Wang <wangruikang@iscas.ac.cn>,
	Adrian =?utf-8?Q?Barna=C5=9B?= <abarnas@google.com>,
	"Rafael J. Wysocki (Intel)" <rafael@kernel.org>,
	Thierry Reding <treding@nvidia.com>, Yury Norov <ynorov@nvidia.com>,
	"Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>,
	Ruben Wauters <rubenru09@aol.com>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-crypto@vger.kernel.org,
	kvm@vger.kernel.org, virtualization@lists.linux.dev, x86@kernel.org
Subject: Re: [PATCH 1/2] powerpc: Add a typos.toml file
Message-ID: <aeh1GzpdvGjRdMdd@ashevche-desk.local>
References: <20260421121420.26079-1-linkmauve@linkmauve.fr>
 <20260421121420.26079-2-linkmauve@linkmauve.fr>
 <215f12d6-62c1-4837-9f78-ef270684950c@kernel.org>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <215f12d6-62c1-4837-9f78-ef270684950c@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Apr 21, 2026 at 02:26:35PM +0200, Krzysztof Kozlowski wrote:
> On 21/04/2026 14:14, Link Mauve wrote:
> > This file is used by the typos tool[1] to determine which words to fix,
> > which ones not to fix, and what the target word should be.

It's a little too many people in Cc list...

> > [1] https://github.com/crate-ci/typos

You may do it as Link tag in a form of

Link: $URL [1]

> > Signed-off-by: Link Mauve <linkmauve@linkmauve.fr>
> 
> This typos.toml file does not belong to the kernel, IMO, but that's up
> to PowerPC folks.

In kernel we use codespell. If we want to have another tool to welcome, we
need to setup infrastructure in parallel, so it will be `make` option with
the fixed name and choose the tool based on availability, et cetera.

> My note here is: please use your real, full name. See submitting patches.

+1.

-- 
With Best Regards,
Andy Shevchenko




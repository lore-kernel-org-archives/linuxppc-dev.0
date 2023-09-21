Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F5E4E706FB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Sep 2023 09:34:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RrqxG6xMwz3dmK
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Sep 2023 19:34:42 +1000 (AEST)
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Rrqvh58WDz2ymM
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Sep 2023 19:33:20 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rrqvh3Y4kz4xPX;
	Thu, 21 Sep 2023 19:33:20 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: lkml <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Kexec-ml <kexec@lists.infradead.org>, Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <20230912082950.856977-1-hbathini@linux.ibm.com>
References: <20230912082950.856977-1-hbathini@linux.ibm.com>
Subject: Re: [PATCH v3 1/2] vmcore: remove dependency with is_kdump_kernel() for exporting vmcore
Message-Id: <169528860033.876432.15480467889695445457.b4-ty@ellerman.id.au>
Date: Thu, 21 Sep 2023 19:30:00 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>, Dave Young <dyoung@redhat.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Baoquan He <bhe@redhat.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 12 Sep 2023 13:59:49 +0530, Hari Bathini wrote:
> Currently, is_kdump_kernel() returns true when elfcorehdr_addr is set.
> While elfcorehdr_addr is set for kexec based kernel dump mechanism,
> alternate dump capturing methods like fadump [1] also set it to export
> the vmcore. Since, is_kdump_kernel() is used to restrict resources in
> crash dump capture kernel and such restrictions may not be desirable
> for fadump, allow is_kdump_kernel() to be defined differently for such
> scenarios. With this, is_kdump_kernel() could be false while vmcore is
> usable. So, remove unnecessary dependency with is_kdump_kernel(), for
> exporting vmcore.
> 
> [...]

Applied to powerpc/next.

[1/2] vmcore: remove dependency with is_kdump_kernel() for exporting vmcore
      https://git.kernel.org/powerpc/c/86328b338c3996b814417dd68e3f899a1a649059
[2/2] powerpc/fadump: make is_kdump_kernel() return false when fadump is active
      https://git.kernel.org/powerpc/c/b098f1c32365304633077d73e4ae21c72d4241b3

cheers

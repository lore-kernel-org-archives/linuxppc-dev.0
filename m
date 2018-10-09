Return-Path: <SRS0=k2O5=MV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C593C64EAD
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 09:49:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13BB521479
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 09:49:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13BB521479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42TsrZ2zd0zF3CX
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 20:49:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42TspR6kR2zF38w
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Oct 2018 20:47:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42TspQ6x3vz9s2P;
 Tue,  9 Oct 2018 20:47:26 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [linux-next][bisected e3fbcc7c] build error at
 drivers/pci/pcie/aer_inject.c:444:6: error: =?utf-8?Q?=E2=80=98struct_pt?=
 =?utf-8?Q?=5Fregs=E2=80=99?= has no member named =?utf-8?Q?=E2=80=98ip?=
In-Reply-To: <1539069292.17569.7.camel@abdul.in.ibm.com>
References: <1539069292.17569.7.camel@abdul.in.ibm.com>
Date: Tue, 09 Oct 2018 20:47:20 +1100
Message-ID: <87woqr1mfr.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: sachinp <sachinp@linux.vnet.ibm.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 linux-kernel <linux-kernel@vger.kernel.org>, keith.busch@intel.com,
 linux-next <linux-next@vger.kernel.org>, bhelgaas@google.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Abdul Haleem <abdhalee@linux.vnet.ibm.com> writes:
> Greeting's
>
> Today's linux-next fails to build on ppc with below error
>
> drivers/pci/pcie/aer_inject.c: In function =E2=80=98aer_inject_ftrace_thu=
nk=E2=80=99:
> drivers/pci/pcie/aer_inject.c:444:6: error: =E2=80=98struct pt_regs=E2=80=
=99 has no
> member named =E2=80=98ip=E2=80=99
>   regs->ip =3D (unsigned long) hook->function;
>       ^
> make[3]: *** [drivers/pci/pcie/aer_inject.o] Error 1
> make[2]: *** [drivers/pci/pcie] Error 2
> make[1]: *** [drivers/pci] Error 2
>
> Machine: Power 9
> kernel version: 4.19.0-rc7-next-20181008
> gcc version: 4.8.5 20150623
> config attached
>
> Recent code changes from these commits:
>
> c79ad38b36dd4967d67f83fc48bade37ee041a47 PCI/AER: Abstract AER interrupt =
handling
> 7b23285f930a8dedcbf749661cd0f2cc27f79be6 PCI/AER: Reuse existing pcie_por=
t_find_device() interface
> e3fbcc7c4b130f81ea586183db561fa3ce9c6447 PCI/AER: Covertly inject errors =
with ftrace hooks

I don't see this commit in today's linux next (20181009) so presumably
someone else has noticed and dropped the commit?

cheers

Return-Path: <SRS0=k2O5=MV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F721C64EAD
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 12:22:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87111204FD
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 12:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="XJDRVBvK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87111204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42TxFR5sv4zF3CT
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 23:22:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="XJDRVBvK";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=google.com
 (client-ip=2a00:1450:4864:20::444; helo=mail-wr1-x444.google.com;
 envelope-from=bhelgaas@google.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.b="XJDRVBvK"; 
 dkim-atps=neutral
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Tx7h0R3fzF39g
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Oct 2018 23:17:29 +1100 (AEDT)
Received: by mail-wr1-x444.google.com with SMTP id x12-v6so1567458wru.8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Oct 2018 05:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=l036Q/UFkUUqicQqNfneN9vMYq+5SocYLAHwwS7vc9Y=;
 b=XJDRVBvKFMOpuM1dowL3cOdbvsS2WQXRq2Y/whgTf8yQCK9nSJK7yyZ7xTCIRVfmpU
 8Nq3TBkYuIMByFzEddHdO4sBLIcnUZcNGMaemHV8qj/PxsKTZxkr5oJPWQhLSCDY+pys
 UxJKF6GGmXnDGKiDNw45l6Rt7tMd+CAb5WjhUKUjnGF0a+o5TuvCmf+/l/OUuOoSaz4R
 ERPNEGkwPSrUJOkVqMx7hk+GZxWjCwNnKhYIxKVTS2ASCRfZPRAlFb5tym7/krOSbcf2
 sCD/VvL8Vz9LyGVMb4Nz7WuU590YmV9PZxNPKMaxARmXZv6zcXPbhJyHqdshjYB0P9qi
 THgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=l036Q/UFkUUqicQqNfneN9vMYq+5SocYLAHwwS7vc9Y=;
 b=WykpF/v31fiug8Q6XCloR6RkyUANCUS1VP0CJK3RPKjmwBJSNqVQJIeix91rfhDz7z
 BqtSHGJEF5aH5BGiel7UoqBjYEUsUn6EbYHcSyeWUaBmNLPTQIxG4zyZKUiT75YDx7zp
 Ic07q2Cthwyb+Do/8liFhYPbWoe0whN9kc1K0ZlO12fvs8JfcKy2BLM+GpPROwBL1uW8
 R7xERhj/z4N2DlnTo03HhGgLqpfbxC8jx3mKzMUBH4F5v8imsW1Z49WUdwcfnYI7pGfw
 wDFKSG3PdmLAeLy0qykOrhckWVY9eHh4PlBflatadcoRTyjRbPUZPF4wVZCgdd3gDpLU
 HgYA==
X-Gm-Message-State: ABuFfog6M7xErnaNBf/puwDW5bohWcINQ8VWotc2/AitLDZGQqxGFdJl
 YaRqvysM0BSMJvb6RuRqKwJHA3djX+BzRRdfQ3ZE
X-Google-Smtp-Source: ACcGV62hdpavTRvi72L9nQUQTYGy7U0z5DwU9vigixMsYB3XvI5/HNcsgHgGRV1beNznN3AVg0FDy220dB7tIRDK3mU=
X-Received: by 2002:adf:a781:: with SMTP id
 j1-v6mr17215493wrc.277.1539087445973; 
 Tue, 09 Oct 2018 05:17:25 -0700 (PDT)
MIME-Version: 1.0
References: <1539069292.17569.7.camel@abdul.in.ibm.com>
 <87woqr1mfr.fsf@concordia.ellerman.id.au>
 <1539081603.17569.10.camel@abdul.in.ibm.com>
In-Reply-To: <1539081603.17569.10.camel@abdul.in.ibm.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 9 Oct 2018 07:17:14 -0500
Message-ID: <CAErSpo5RGSdX_g36KSBE1er_bmKpHih=X7DoTtTwos5PW4qn7w@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IFtsaW51eC1uZXh0XVtiaXNlY3RlZCBlM2ZiY2M3Y10gYnVpbGQgZXJyb3IgYXQgZA==?=
 =?UTF-8?B?cml2ZXJzL3BjaS9wY2llL2Flcl9pbmplY3QuYzo0NDQ6NjogZXJyb3I6IOKAmHN0cnVjdCBwdF9yZWdz?=
 =?UTF-8?B?4oCZIGhhcyBubyBtZW1iZXIgbmFtZWQg4oCYaXA=?=
To: abdhalee@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"
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
Cc: sachinp@linux.vnet.ibm.com, Stephen Rothwell <sfr@canb.auug.org.au>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Keith Busch <keith.busch@intel.com>,
 linux-next list <linux-next@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Oct 9, 2018 at 5:40 AM Abdul Haleem <abdhalee@linux.vnet.ibm.com> w=
rote:
>
> On Tue, 2018-10-09 at 20:47 +1100, Michael Ellerman wrote:
> > Abdul Haleem <abdhalee@linux.vnet.ibm.com> writes:
> > > Greeting's
> > >
> > > Today's linux-next fails to build on ppc with below error
> > >
> > > drivers/pci/pcie/aer_inject.c: In function =E2=80=98aer_inject_ftrace=
_thunk=E2=80=99:
> > > drivers/pci/pcie/aer_inject.c:444:6: error: =E2=80=98struct pt_regs=
=E2=80=99 has no
> > > member named =E2=80=98ip=E2=80=99
> > >   regs->ip =3D (unsigned long) hook->function;
> > >       ^
> > > make[3]: *** [drivers/pci/pcie/aer_inject.o] Error 1
> > > make[2]: *** [drivers/pci/pcie] Error 2
> > > make[1]: *** [drivers/pci] Error 2
> > >
> > > Machine: Power 9
> > > kernel version: 4.19.0-rc7-next-20181008
> > > gcc version: 4.8.5 20150623
> > > config attached
> > >
> > > Recent code changes from these commits:
> > >
> > > c79ad38b36dd4967d67f83fc48bade37ee041a47 PCI/AER: Abstract AER interr=
upt handling
> > > 7b23285f930a8dedcbf749661cd0f2cc27f79be6 PCI/AER: Reuse existing pcie=
_port_find_device() interface
> > > e3fbcc7c4b130f81ea586183db561fa3ce9c6447 PCI/AER: Covertly inject err=
ors with ftrace hooks
> >
> > I don't see this commit in today's linux next (20181009) so presumably
> > someone else has noticed and dropped the commit?
>
> Yes, the commit is dropped from next-20181009, and now build is fine.

I dropped those commits yesterday.

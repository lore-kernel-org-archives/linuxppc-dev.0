Return-Path: <SRS0=4MsH=NU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA79C43441
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 03:31:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6ED020840
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 03:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gPymQ5dA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6ED020840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42rm0V27thzF3W7
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 14:31:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gPymQ5dA";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42rlxv3kHCzF3W7
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Nov 2018 14:29:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="gPymQ5dA"; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 42rlxv2bDhz8t5w
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Nov 2018 14:29:23 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 42rlxv2CYXz9sC7; Fri,  9 Nov 2018 14:29:23 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::341; helo=mail-ot1-x341.google.com;
 envelope-from=flukshun@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Authentication-Results: ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="gPymQ5dA"; 
 dkim-atps=neutral
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 42rlxt2CyYz9s7T;
 Fri,  9 Nov 2018 14:29:22 +1100 (AEDT)
Received: by mail-ot1-x341.google.com with SMTP id t5so463515otk.1;
 Thu, 08 Nov 2018 19:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id;
 bh=HYYiVtHD/xA79Bpi/vsaE19yHhyG089/O/jeOgrc4UI=;
 b=gPymQ5dAq5rnM+9oEGvuWz6FO6ArJI//JzEK5tdbX2yXRWW0bQqgGGTves/BZRymy+
 3TG88M14ykp+49SAHBQ+ekHJExVoE5S7TPUEiRDieF1utgejNB7Psrebl5qSbwpjIWhX
 ZTGI0tpOg345Nzo4eMbtmtIUlH+ssYbN2ZqUIVzYTiyUALmcQdwAnWn6oAOi32LcTmJN
 RvndPSqjbpa6N9naPKIvUw1xDShC2p0+2Hb+esArGnKbdKec7DJVP/knq3pYm+2/odOq
 xALHJaeoOtS8mPSF2VgiGIoM9EEoJ+63ua4rre9IH8dQxGqmXV5mf7A5KfszdsgqHJwW
 Up5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
 bh=HYYiVtHD/xA79Bpi/vsaE19yHhyG089/O/jeOgrc4UI=;
 b=UBAT1QqX+c/oLdz/TamrkIZtjz9uaNk7xYCRyOfIvS2papONTETo+PeGzzB4/HMQxx
 F2ejY6+V84wZIwm+xw0Y+1r7Iageo3MD3oqEveRdLZs0WMF5UA/eX1c4inhgS3xXSFxY
 asPdeXj6JjLN6nqPBqGdhGw398yg4hHbgLgMpJ/+UTr01Qaav3y0x/YcpRkmEiHNcXk2
 JckPLxmPam8y5BItwKjVcfjWyBeLMmVbnSaPv7A7VAUb8+BEOhDnvhI8ZNWDOdD5vC9W
 CdrLc/P5M1ZHWIbSV4cT6w7fOmjaKbGpHSVR1JsAYgcoEdsveDpxV8GhgiGTKR3bdpYO
 TU8g==
X-Gm-Message-State: AGRZ1gIhxo3Ug9RMxamurjUArlJdI/en3l5Uri7mGIeA/q1zb8iHAZnA
 C8k/+HqKMs2PuYzazwk77Rg=
X-Google-Smtp-Source: AJdET5dZ4FbN0dxma+shBIoJSJwL0fzPaY+zDMh++Sj9V0B8F116b9yc6HJfSmGVD1U+qM/rPBD8LA==
X-Received: by 2002:a9d:439d:: with SMTP id t29mr4595260ote.284.1541734159494; 
 Thu, 08 Nov 2018 19:29:19 -0800 (PST)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id o64-v6sm3370867oig.6.2018.11.08.19.29.17
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 08 Nov 2018 19:29:18 -0800 (PST)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: kvm@vger.kernel.org
Subject: [PATCH] KVM: PPC: Book3S HV: fix handling for interrupted
 H_ENTER_NESTED
Date: Thu,  8 Nov 2018 21:27:23 -0600
Message-Id: <20181109032723.16394-1-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
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
Cc: linuxppc-dev@ozlabs.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
 kvm-ppc@vger.kernel.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

While running a nested guest VCPU on L0 via H_ENTER_NESTED hcall, a
pending signal in the L0 QEMU process can generate the following
sequence:

  ret0 = kvmppc_pseries_do_hcall()
    ret1 = kvmhv_enter_nested_guest()
      ret2 = kvmhv_run_single_vcpu()
      if (ret2 == -EINTR)
        return H_INTERRUPT
    if (ret1 == H_INTERRUPT)
      kvmppc_set_gpr(vcpu, 3, 0)
      return -EINTR
    /* skipped: */
    kvmppc_set_gpr(vcpu, 3, ret)
    vcpu->arch.hcall_needed = 0
    return RESUME_GUEST

which causes an exit to L0 userspace with ret0 == -EINTR.

The intention seems to be to set the hcall return value to 0 (via
VCPU r3) so that L1 will see a successful return from H_ENTER_NESTED
once we resume executing the VCPU. However, because we don't set
vcpu->arch.hcall_needed = 0, we do the following once userspace
resumes execution via kvm_arch_vcpu_ioctl_run():

  ...
  } else if (vcpu->arch.hcall_needed) {
    int i

    kvmppc_set_gpr(vcpu, 3, run->papr_hcall.ret);
    for (i = 0; i < 9; ++i)
           kvmppc_set_gpr(vcpu, 4 + i, run->papr_hcall.args[i]);
    vcpu->arch.hcall_needed = 0;

since vcpu->arch.hcall_needed == 1 indicates that userspace should
have handled the hcall and stored the return value in
run->papr_hcall.ret. Since that's not the case here, we can get an
unexpected value in VCPU r3, which can result in
kvmhv_p9_guest_entry() reporting an unexpected trap value when it
returns from H_ENTER_NESTED, causing the following register dump to
console via subsequent call to kvmppc_handle_exit_hv() in L1:

  [  350.612854] vcpu 00000000f9564cf8 (0):
  [  350.612915] pc  = c00000000013eb98  msr = 8000000000009033  trap = 1
  [  350.613020] r 0 = c0000000004b9044  r16 = 0000000000000000
  [  350.613075] r 1 = c00000007cffba30  r17 = 0000000000000000
  [  350.613120] r 2 = c00000000178c100  r18 = 00007fffc24f3b50
  [  350.613166] r 3 = c00000007ef52480  r19 = 00007fffc24fff58
  [  350.613212] r 4 = 0000000000000000  r20 = 00000a1e96ece9d0
  [  350.613253] r 5 = 70616d00746f6f72  r21 = 00000a1ea117c9b0
  [  350.613295] r 6 = 0000000000000020  r22 = 00000a1ea1184360
  [  350.613338] r 7 = c0000000783be440  r23 = 0000000000000003
  [  350.613380] r 8 = fffffffffffffffc  r24 = 00000a1e96e9e124
  [  350.613423] r 9 = c00000007ef52490  r25 = 00000000000007ff
  [  350.613469] r10 = 0000000000000004  r26 = c00000007eb2f7a0
  [  350.613513] r11 = b0616d0009eccdb2  r27 = c00000007cffbb10
  [  350.613556] r12 = c0000000004b9000  r28 = c00000007d83a2c0
  [  350.613597] r13 = c000000001b00000  r29 = c0000000783cdf68
  [  350.613639] r14 = 0000000000000000  r30 = 0000000000000000
  [  350.613681] r15 = 0000000000000000  r31 = c00000007cffbbf0
  [  350.613723] ctr = c0000000004b9000  lr  = c0000000004b9044
  [  350.613765] srr0 = 0000772f954dd48c srr1 = 800000000280f033
  [  350.613808] sprg0 = 0000000000000000 sprg1 = c000000001b00000
  [  350.613859] sprg2 = 0000772f9565a280 sprg3 = 0000000000000000
  [  350.613911] cr = 88002848  xer = 0000000020040000  dsisr = 42000000
  [  350.613962] dar = 0000772f95390000
  [  350.614031] fault dar = c000000244b278c0 dsisr = 00000000
  [  350.614073] SLB (0 entries):
  [  350.614157] lpcr = 0040000003d40413 sdr1 = 0000000000000000 last_inst = ffffffff
  [  350.614252] trap=0x1 | pc=0xc00000000013eb98 | msr=0x8000000000009033

followed by L1's QEMU reporting the following before stopping execution
of the nested guest:

  KVM: unknown exit, hardware reason 1
  NIP c00000000013eb98   LR c0000000004b9044 CTR c0000000004b9000 XER 0000000020040000 CPU#0
  MSR 8000000000009033 HID0 0000000000000000  HF 8000000000000000 iidx 3 didx 3
  TB 00000000 00000000 DECR 00000000
  GPR00 c0000000004b9044 c00000007cffba30 c00000000178c100 c00000007ef52480
  GPR04 0000000000000000 70616d00746f6f72 0000000000000020 c0000000783be440
  GPR08 fffffffffffffffc c00000007ef52490 0000000000000004 b0616d0009eccdb2
  GPR12 c0000000004b9000 c000000001b00000 0000000000000000 0000000000000000
  GPR16 0000000000000000 0000000000000000 00007fffc24f3b50 00007fffc24fff58
  GPR20 00000a1e96ece9d0 00000a1ea117c9b0 00000a1ea1184360 0000000000000003
  GPR24 00000a1e96e9e124 00000000000007ff c00000007eb2f7a0 c00000007cffbb10
  GPR28 c00000007d83a2c0 c0000000783cdf68 0000000000000000 c00000007cffbbf0
  CR 88002848  [ L  L  -  -  E  L  G  L  ]             RES ffffffffffffffff
   SRR0 0000772f954dd48c  SRR1 800000000280f033    PVR 00000000004e1202 VRSAVE 0000000000000000
  SPRG0 0000000000000000 SPRG1 c000000001b00000  SPRG2 0000772f9565a280  SPRG3 0000000000000000
  SPRG4 0000000000000000 SPRG5 0000000000000000  SPRG6 0000000000000000  SPRG7 0000000000000000
  HSRR0 0000000000000000 HSRR1 0000000000000000
   CFAR 0000000000000000
   LPCR 0000000003d40413
   PTCR 0000000000000000   DAR 0000772f95390000  DSISR 0000000042000000

Fix this by setting vcpu->arch.hcall_needed = 0 to indicate completion
of H_ENTER_NESTED before we exit to L0 userspace.

Cc: linuxppc-dev@ozlabs.org
Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: Paul Mackerras <paulus@ozlabs.org>
Cc: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 arch/powerpc/kvm/book3s_hv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index d65b961661fb..a56f8413758a 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -983,6 +983,7 @@ int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu)
 		ret = kvmhv_enter_nested_guest(vcpu);
 		if (ret == H_INTERRUPT) {
 			kvmppc_set_gpr(vcpu, 3, 0);
+			vcpu->arch.hcall_needed = 0;
 			return -EINTR;
 		}
 		break;
-- 
2.17.1


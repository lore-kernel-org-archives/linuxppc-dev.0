Return-Path: <linuxppc-dev+bounces-29163-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72A7BCA6017
	for <linuxppc-dev@archiver.kernel.org>; Sat, 10 Oct 2026 03:49:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j1qVq2P7lz2yQl;
	Sat, 10 Oct 2026 14:49:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::535" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791604195;
	cv=pass; b=QRq4ro8f61LF3y6m0fkRkTQxYAjmz2xiNwu/7zc+UJYzOfL10gLgGYTJZYx7dyRgLOTx/JwxnnRK74GiX0aUlCqSILNyyPpIAp7Jea8cbwdQYMpJlIfg5j4wpCd8IwEGmW22OjyzsBkktnvKT2WR+OSlHPwS/Q9qxfj1OrVXqQKrjBl3n+ab+5zF93VhluGby7CGZKF04zF0OIWewpHNbptruPT0VhifqPqTlWYupU+ozDw3G0TFKh9YiaEApq1ER5M/RPVaPsChTTcqndcwBL4n6+c8LRqHPV2LuZuakhJ/5l2dfAAc3ppqOlio0lPFs8AvSNz4lI+mABb2gE0RPA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791604195; c=relaxed/relaxed;
	bh=XvvY7S8HRq9XwIfKh5P7GJDm6dvfslD5dk/W3mmoMKU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=hhETSxbu1jt/r75kjlm4GYQ6S1zEQFrseMbryC1BcYKHwFzDraqkaydm2pcZ+YIiw8yninZxbJfVFO4tyuEquw/H9IehVuCaqvGW8uWjPLcsxqk3XfyDNHThZG3Bn7tKD+HOMtaCsJw8NJvln6glcSY+U5U0+PwWKeB3rf6Ql/GPezmjpS64NT6kAqPfc0MeFBUMPaiUAWMwPkrvsTXq7g02iFibRozpZJsO1xPeA9RXz+zh3FcSa+n21RDgjMUCl33sLpb8RorTwGaj4vjRNlXl/eRzp6ky9PsNNVR3IjO3C7RkNrnqo4wwOS/dSGDr/sEHJplh/va4NroyjcmodA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mT2V7QSo; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::535; helo=mail-ed1-x535.google.com; envelope-from=jperlow@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mT2V7QSo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::535; helo=mail-ed1-x535.google.com; envelope-from=jperlow@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j1qVm2LJ4z2y8Z
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Oct 2026 14:49:51 +1100 (AEDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-6afe8d3980aso417669a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 09 Oct 2026 20:49:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791604187; cv=none;
        d=google.com; s=arc-20260327;
        b=hmMQ9wkCz9BXlUAGLL7y53Uy2OgVovcDrktgt6Yj6V72mSkRq2Uw5Ns/HbMPshNm5G
         kFGheFAEvYi55v85LkJ0Hp8cXtzqFxItOCk7kZVHX/rVQYRybZhiMx/62YXi/PppDYSM
         knEqrfIwJ9AOclubbKyvh25cCDRSPbJIDtP3ZikyzAo2i+RTJJxkNZpbNlkLayHXBeq3
         pADdZa7wzfkbrUmIOQlkHX8vCxt/MUw0CSl5Z5hK8nQTEywWD8TVTNl3s43Qd+T7NFZr
         sslYsKT1S3PXJS5uXl6Qyy6UWIQOkoVe+dmZR3VRSn3JsWsgjhXhH1vhe8fnHvaeacfz
         TuRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=XvvY7S8HRq9XwIfKh5P7GJDm6dvfslD5dk/W3mmoMKU=;
        fh=LzIyGW3RKhk2uGRwRT5Nt2/4FSCWgrWdVbsD5lxajyg=;
        b=dgKepWSnrKz6V7WVsu2RfxYdtaiKhu+Cx6OpomUVySK5Mn7JT53il3D/XpX+uRdYEN
         0kVrBYdxhRcU+XFczvW9nQJbIcFEN12DxIBjSYqKUuQzJir5+LFmtQbEMUgZGRPFY1MR
         RAq4Qyctv1WTfU1yRZCgXhD009XsxQwdCtnwQ2vQl44mgrdynZTR4OPzEvqWJe4dusLv
         GZM4G8Cfy7PkAP8pon8HsybNl0FWF5Jo9KRFxvskB0FuJEEtlT1OaAA5ty+kirR85N84
         Lm6+a6iRV99oLeQ8wKY0gIilFxX01Nji4cBLeD2UoKMs7xnJegDbVOiCLAddkhugkv4X
         WNzQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791604187; x=1792208987; darn=lists.ozlabs.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XvvY7S8HRq9XwIfKh5P7GJDm6dvfslD5dk/W3mmoMKU=;
        b=mT2V7QSo5B4JjXLi6VMQE4xeFZu4K1DLjMfDzevzwPJbQpmhljW/9D4nsbJ0AM1uPI
         RUHfaR2kGXEPj560OiCVsfSKqyYPSYIDNCcAJI6dukEZkUGAsNJCBa77ShjaEzUKq8ro
         V2aknD3AzoiWohxQPu551IvOpit2ClUk+OFWMm1DOdQ1y+T7EJ4q2b9zxLpATNDBF+2V
         yb4sGY4EMseZlgX5O80OvYf4YcWBpWlfkngNBt7jnKzd2rGL7wefVM9+SoBFgwxxp2Ky
         phoOioBvJtis5ZtiZ6TV/aGJi2+jDD90eECFjfVHXt8q4I0P1UgAyvKYIXV43JweDSRz
         2WoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791604187; x=1792208987;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=XvvY7S8HRq9XwIfKh5P7GJDm6dvfslD5dk/W3mmoMKU=;
        b=BOwjOVc5juzBfOFdz4+pSQ610dM1nGGtNNYP9BbY4tx570oCTa8pJ2r5EZA+SQ0nJa
         zWTx2SqwcbuzBOaCxYwqOF424qoJiQekGJn+1+omipFdcc/KkUwfBxLYzIacvenVAotv
         0lGJJGg+2ImfkXH9+dAW7PZVgzT6GNdMnAJ/1LA2nMkX9FwvvVR0VD1+r+kV/dVt0B7n
         mpWib6TQbizDrAhsQBXg36RmVd3RluehtqvOV7A/IEywyGZxLGu933zL7d3Q1IFmosrc
         ggfhh4AyN1ajTh/cSznmPeO5bvBObXALVb1kjtFbNzUmhl7lZNyzX5u9IA0gH9na4cau
         iwjw==
X-Forwarded-Encrypted: i=1; AKwUvBxr4ujDifSiUzy6qjvAUjdPlfo8bnIK74pLJIN/Xme8mxLgZLA9P6C6G6ETSQF0Y9uEfHTvWnXM0ipw3aw=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYLWSeiPvuHO6PfieSPxuR8mwfotOxvIjdkc1xfoanWNxIhRNUbJ
	zIaI+KchPjubQRmpeLCek5xQVrCBWwrdsSPKOQ9UqlZoEx1N/bZ4yebYffapr9m+mZlQnKwvyO6
	3pZ38yhS3u7NZtDb9Bo3lyMPt6VvJHhc=
X-Gm-Gg: AYBFou3oBpFoqQUd0WA63cOUvLGqkYOHB7o+2WCJaVi9/OKh7yboSnqjKE5TS7iJOvc
	bY7qCy0/E6D7dxKvtCFQ9XHRbASN9l81eb5yFAkLkqSjzYPmGp+KvtoTMTtlE87y8ifq6eRrzc6
	un2Ay8cUUER1vjOJ8NoU1XumXPUpNJzrQszIuAfcX3jE7qvuxQ6ZQsqCZ+TGRCiqYcjL2PgyB5N
	cuuMTAzZN6pNIpAkF4zj6Pngv2x5D8AkkdK5U82pnqYYsP3S7uUGy+d85/SlzbE0bOEoTo1fNWT
	t8NZH97Ozb514TTjuAjPRHYyK0GG1Edu/esXpMr4WzM5sJ+Tl577GYl+yEhsxBcTqKaP2pxX284
	WV9sqbVmU3UY+lMpy6wF0m6OI9Yv72ac90FRl68Rkv4ms9hSGJT7LIakD0V4vWdgc6jMtfpsp8F
	T+hINtMarfUIuaCzb/JxtB
X-Received: by 2002:a17:907:3f8e:b0:c29:f5d5:5aa7 with SMTP id
 a640c23a62f3a-c31aa0c0ae8mr355096366b.49.1791604186895; Fri, 09 Oct 2026
 20:49:46 -0700 (PDT)
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
From: "Perlow, Jason" <jperlow@gmail.com>
Date: Fri, 9 Oct 2026 23:49:35 -0400
X-Gm-Features: AclHuK8tLlsj04-qdY1M1uq0VlVi4LCtBYcpexWHP6C-VMCJXIeCQa4uODnFQf4
Message-ID: <CABZrw2EfeChvuWDJ_hiwr9Oh_QpyrfZKLq_-jOxkzZH=fr575Q@mail.gmail.com>
Subject: PCI/AER: MacBookPro16,1 test results with Apple SEP ANFE quirk
To: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>
Cc: Aditya Garg <aditya.garg@linux.dev>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
	"Oliver O'Halloran" <oohall@gmail.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/mixed; boundary="0000000000002cd88d065d745b4d"

--0000000000002cd88d065d745b4d
Content-Type: text/plain; charset="UTF-8"

Bjorn, Lukas,

I have tested the Apple SEP ANFE quirk together with Lukas's false-alarm
recovery fix on two MacBookPro16,1 systems. Both stayed up for over two
hours after booting the candidate kernel. The patch is being prepared
against pci/for-linus at 79c168e2aa957ed0054c93db17caba653b95e377.

The candidate retains eddba19b8b5f ("PCI/AER: Support Advisory Non-Fatal
Errors"), adds 79c168e2aa95 ("PCI/AER: Skip error recovery on false
alarms"), and leaves the ANFE mask unchanged only on the Apple T2 Secure
Enclave Processor [106b:1802]. The global ANFE revert is absent from the
test kernel. The per-device flag approach follows Aditya's earlier
proposal, with an EARLY fixup so the flag is set before pci_aer_init().

The test systems are:

  MEDUSA:  MacBookPro16,1, Core i7-9750H
  CHIMERA: MacBookPro16,1, Core i9-9980HK

Both ran 7.3.0-rc6-6-t2-edge-apple-sep-anfe-test, confirmed by uname and
the kernel banner in each current boot journal. At the 23:24 EDT check
on October 9, MEDUSA had 2 hours 22 minutes uptime and Chimera had
2 hours 21 minutes. Their boot IDs were unchanged from the initial
successful candidate boots. graphical.target and the display manager
were active on both, and neither had failed systemd units.

Read-only config-space checks gave the same results on both systems:

  Function                    Correctable error mask
  Apple SEP, 04:00.2           0x00006000
  Apple function, 04:00.0      0x00004000
  Apple function, 04:00.1      0x00004000
  AMD GPU, 03:00.0             0x00000000

ANFE bit 13 is therefore masked on the SEP and unmasked on the other
observed functions. No config-register writes were used in these checks.
The implementation matches vendor/device ID, not these bus addresses.

Neither candidate boot journal contains an AER/GHES report, kernel
panic, oops, BUG or call trace. Neither recorded additional kernel
messages after the initial 21:04 checks through the 23:24 check.

The earlier Wunner-only candidate booted on MEDUSA but then powered off,
as I reported on October 8. Its retained journal ended before that event;
there was no recorded shutdown sequence or panic. The cause of the power
loss is still unknown, and this quirk does not establish a firmware
mechanism. The combined candidate has not reproduced that symptom within
the observed interval.

There are remaining boot warnings unrelated to the reported AER symptom:
ACPI duplicate-table/method errors, AMD SDMA fence fallback warnings,
HID rotation probe failures, and Broadcom P2P failures. Chimera also logs
CPU 0 machine-check records in banks 12 and 13. These warning categories,
including the same machine-check status/address records, appear in the
previous boot logs. I am retaining them as separate follow-up issues.

This was a v7.3-rc6 test build with the existing T2 driver/patch stack,
using Debian Forky GCC 16.2 and binutils 2.47. It was not a vanilla
upstream kernel or an identical-toolchain comparison to the older GCC 14
release image. Artifact checksums, exact source/provenance, config checks,
t2gmux/t2smc builds and imported-symbol CRC checks passed. A generic
KVM/OVMF boot also passed; the hardware observations above come from the
two physical systems, not KVM.

The T2 team reports that [106b:1802] identifies the SEP across T2 models,
but this report covers only these two MacBookPro16,1 machines. I have not
tested other T2 models, power-off/cold-start, suspend/resume, reset, kexec
or deliberate AER error injection. Physical confirmation of the rendered
GUI is not included in this report; desktop service state was checked
remotely. The existing release/rescue boot files were preserved.

The patch (enclosed) leaves other ANFE handling enabled and is idempotent across
repeated fixup/AER initialization. Please review it as a targeted workaround
for the MacBookPro16,1 regression, with the testing limits above.
I also have a zip file with all logs/evidence if needed.

Thanks,
Jason

--0000000000002cd88d065d745b4d
Content-Type: application/octet-stream; 
	name="apple-sep-anfe-quirk-clean.patch"
Content-Disposition: attachment; filename="apple-sep-anfe-quirk-clean.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mv1urcfi0>
X-Attachment-Id: f_mv1urcfi0

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL3BjaWUvYWVyLmMgYi9kcml2ZXJzL3BjaS9wY2llL2Fl
ci5jCmluZGV4IDkyMmE3MjZhNTJhNS4uNzMyZjc1YTMxNzYwIDEwMDY0NAotLS0gYS9kcml2ZXJz
L3BjaS9wY2llL2Flci5jCisrKyBiL2RyaXZlcnMvcGNpL3BjaWUvYWVyLmMKQEAgLTQyOCw3ICs0
MjgsOCBAQCB2b2lkIHBjaV9hZXJfaW5pdChzdHJ1Y3QgcGNpX2RldiAqZGV2KQogCSAqIEFkdmlz
b3J5IE5vbi1GYXRhbCBFcnJvcnMgYXJlIG1hc2tlZCBieSBkZWZhdWx0IChQQ0llIHI3LjAsIHNl
YwogCSAqIDcuOC40LjYpLgogCSAqLwotCWlmIChwY2llX2Flcl9pc19uYXRpdmUoZGV2KSAmJiBk
ZXYtPmRldmNhcCAmIFBDSV9FWFBfREVWQ0FQX1JCRVIpCisJaWYgKHBjaWVfYWVyX2lzX25hdGl2
ZShkZXYpICYmIGRldi0+ZGV2Y2FwICYgUENJX0VYUF9ERVZDQVBfUkJFUiAmJgorCSAgICAhZGV2
LT5ub19hZXJfYW5mZSkKIAkJcGNpX2NsZWFyX2FuZF9zZXRfY29uZmlnX2R3b3JkKGRldiwKIAkJ
CQkJICAgICAgIGRldi0+YWVyX2NhcCArIFBDSV9FUlJfQ09SX01BU0ssCiAJCQkJCSAgICAgICBQ
Q0lfRVJSX0NPUl9BRFZfTkZBVCwgMCk7CmRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9xdWlya3Mu
YyBiL2RyaXZlcnMvcGNpL3F1aXJrcy5jCmluZGV4IGRlOWJiY2NkYTIxZi4uNjc3Y2Q4Nzk3ZDE5
IDEwMDY0NAotLS0gYS9kcml2ZXJzL3BjaS9xdWlya3MuYworKysgYi9kcml2ZXJzL3BjaS9xdWly
a3MuYwpAQCAtMjU3NCw2ICsyNTc0LDE3IEBAIHN0YXRpYyB2b2lkIHF1aXJrX3A2NGgyXzFrX2lv
KHN0cnVjdCBwY2lfZGV2ICpkZXYpCiB9CiBERUNMQVJFX1BDSV9GSVhVUF9IRUFERVIoUENJX1ZF
TkRPUl9JRF9JTlRFTCwgMHgxNDYwLCBxdWlya19wNjRoMl8xa19pbyk7CiAKKy8qCisgKiBVbm1h
c2tpbmcgQWR2aXNvcnkgTm9uLUZhdGFsIEVycm9ycyBvbiB0aGUgQXBwbGUgVDIgU2VjdXJlIEVu
Y2xhdmUKKyAqIGNhdXNlcyBhIE1hY0Jvb2tQcm8xNiwxIHRvIGxvc2UgcG93ZXIuICBTZXQgdGhp
cyBiZWZvcmUgcGNpX2Flcl9pbml0KCkKKyAqIHNvIHRoYXQgaXQgbGVhdmVzIHRoZSBBTkZFIG1h
c2sgYml0IHVuY2hhbmdlZC4KKyAqLworc3RhdGljIHZvaWQgcXVpcmtfbm9fYWVyX2FuZmUoc3Ry
dWN0IHBjaV9kZXYgKmRldikKK3sKKwlkZXYtPm5vX2Flcl9hbmZlID0gMTsKK30KK0RFQ0xBUkVf
UENJX0ZJWFVQX0VBUkxZKFBDSV9WRU5ET1JfSURfQVBQTEUsIDB4MTgwMiwgcXVpcmtfbm9fYWVy
X2FuZmUpOworCiAvKgogICogVW5kZXIgc29tZSBjaXJjdW1zdGFuY2VzLCBBRVIgaXMgbm90IGxp
bmtlZCB3aXRoIGV4dGVuZGVkIGNhcGFiaWxpdGllcy4KICAqIEZvcmNlIGl0IHRvIGJlIGxpbmtl
ZCBieSBzZXR0aW5nIHRoZSBjb3JyZXNwb25kaW5nIGNvbnRyb2wgYml0IGluIHRoZQpkaWZmIC0t
Z2l0IGEvaW5jbHVkZS9saW51eC9wY2kuaCBiL2luY2x1ZGUvbGludXgvcGNpLmgKaW5kZXggZDMx
YThkMTA3YjFlLi41ZmZjZjVjZThjOTYgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvcGNpLmgK
KysrIGIvaW5jbHVkZS9saW51eC9wY2kuaApAQCAtNDY3LDYgKzQ2Nyw3IEBAIHN0cnVjdCBwY2lf
ZGV2IHsKIAogCXVuc2lnbmVkIGludAlpc19idXNtYXN0ZXI6MTsJCS8qIElzIGJ1c21hc3RlciAq
LwogCXVuc2lnbmVkIGludAlub19tc2k6MTsJCS8qIE1heSBub3QgdXNlIE1TSSAqLworCXVuc2ln
bmVkIGludAlub19hZXJfYW5mZToxOwkJLyogRG8gbm90IHVubWFzayBBTkZFICovCiAJdW5zaWdu
ZWQgaW50CWJsb2NrX2NmZ19hY2Nlc3M6MTsJLyogQ29uZmlnIHNwYWNlIGFjY2VzcyBibG9ja2Vk
ICovCiAJdW5zaWduZWQgaW50CWJyb2tlbl9wYXJpdHlfc3RhdHVzOjE7CS8qIEdlbmVyYXRlcyBm
YWxzZSBwb3NpdGl2ZSBwYXJpdHkgKi8KIAl1bnNpZ25lZCBpbnQJaXJxX3Jlcm91dGVfdmFyaWFu
dDoyOwkvKiBOZWVkcyBJUlEgcmVyb3V0aW5nIHZhcmlhbnQgKi8K
--0000000000002cd88d065d745b4d--


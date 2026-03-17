Return-Path: <linuxppc-dev+bounces-18307-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6385BFD8763
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Mar 2026 13:09:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZsjT6bQTz2yh4;
	Wed, 18 Mar 2026 00:09:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773752941;
	cv=none; b=CXjwYP23q/c7P/9EGwGwlKdcHRJd6yf5853fNk/uJuQ2Am8tCtW4+vXEOjwJd4fezLHbpSkScmkLC1QXaJkD5e4dQjDk4fma2+nNQ8YphXFKJZ5IvK+ktVO2zeWEdU3NQEllXtpIn2EdF87aMWjUNCMl5c7YRDAPl9YtNsCoxE9ihbIWmY+ziKmt1zx48L2B+vzapGaOMTg0YprLTwtv4VSrbHzc+zAeiHmw770m2QLx+zTV0eakqsHkn/rRvRnvB7kVCwQkPj0zhZETqnbODnLTdFuUSbzRyfyfIDHyjQRrFrHs30Crs3jv5EgzVP/J36flb4cE1OxvxzksqzOlng==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773752941; c=relaxed/relaxed;
	bh=0VDX03ZM9h3MV8phI/cKgVv2koYIgaCozb0lJ+VmqDM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QOi5sOc4F3wzYanhYuvfwZoxg2FGZXG0NfkcCvxm0iQj4kFa2eUEou4H96xf0DqHJPn/36j+3rmlXCVZR1S75LbbLoc/i254oF+4uzq2bGZe3JrurMMUNmOJWl02Wk5rFYyyVXt/CNR6yZEH7WzTeBcKVFMXaNJJIGB2hoxEKZKW2SeqM5nOKzwaphJuurkNufv61HicWCJI6FvYtASYX1sTt0Cor7bKFgfYtx6hf0DvMYhsfUl8q5twF/23dNDkFIL3ClaE3pZmp7ZNWSqm0QYYVvuXl80bLEEbJ1EM3JfvMyP12CAp1/FmBUC575j29uvBRvEaF4y9RjWKWsk9hw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JEEWOyMG; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kERjTE3W; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JEEWOyMG;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kERjTE3W;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZsjS0Ymrz2yfP
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Mar 2026 00:08:59 +1100 (AEDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62HBllea1025762
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2026 13:08:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=0VDX03ZM9h3MV8phI/cKgVv2koYIgaCozb0
	lJ+VmqDM=; b=JEEWOyMGS13lVteTYdu3Jy7Z2pYcj2du96D1OiA9boMM1qLaYBj
	8nH+c2xyCAkMy7eyTekiDjxbzlffFPNyAKdyHl3+GptntSUBGIWlxYNtonmfgFrI
	MqjfDhUMqE1qEwmMVNtjqzDzGlWT0BIUzNtmzM56LwG0Xxduc+Dn9L+a0yE99xC8
	KHp7TyAjJ4VFZLHA/bvc4YLxgOwWCEWVMd9iP8HMBOXyWxzHM727REULr4JaX0lk
	npTFvtKZ3uHnYeDKPRFtjQDgixPL9/urBLHaEv4FSPydkuBaFsmZ3x7cG7nvuAJ8
	WP1ZQMLqt7c9EtlqTwGJGkLwLK2qb6i7+VA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cy6d6g8nv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2026 13:08:56 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-899edf01747so224737276d6.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2026 06:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773752935; x=1774357735; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0VDX03ZM9h3MV8phI/cKgVv2koYIgaCozb0lJ+VmqDM=;
        b=kERjTE3Wtz1R4SHt9MstY2AxgblSaE4Y9tX9xtwUqT/ZIoVmFRHzyFvb9H7mXMafT6
         /JYMICkPXIVAM4UV1w0NrxugIiRVd1pY54D/BclLjwwst0qCHIIQsFLpX4Qzxqbq+yG2
         04z+3J96+JXTtX28ZHkXUF/n1WxdY6NTLWRE4Tmir/Yyr020TO8NfeFHz01GLaka9bs1
         qrut4mwEkZmMaNRrt2FWezkgYaHHaCMiy+AyV5STjueN0UlfatNSyJFueC+Ih7cwhBoX
         Iteb81cX4M0X3l323SHGxszbEY7EJirF44Y56BAOSF8t1y0KWXZ6G9im0ym8pDKvT0Zp
         WJ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773752935; x=1774357735;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0VDX03ZM9h3MV8phI/cKgVv2koYIgaCozb0lJ+VmqDM=;
        b=o18Em/Zs1+VJOpsAI5NytpDXYGw1HSaVtfmorT8w2W607Zf6HVsR94tCXwYDAXRH76
         Zr5pT0BXhqDFfaIx5n8GIzKrX0/STHPg3WM9+UrS6m/lh6972pw0abYRgxrD/UI1xJPi
         icwpx/1psCRp44lDmWrD0o7aKwgrD0mogRIYOKjHGyUJsdkMK9gNq8Kri2mp+NKDx5zM
         a6oEBx8aTebaOE0ymaMC14cx8EwERyW9lzLiKK7b7280qDMAUhI8JpIDNkkMtKi0klMS
         N0gUrRlOmrSB3s3rtHa/x0O0+3VwwzdG+3IC10mDEzheNC/SaAgaPHAB5i10ledNJ2g0
         UXXw==
X-Forwarded-Encrypted: i=1; AJvYcCW9JocZ+Uai44nh+LiIPwgC5F8JY7HWkk6DFFNJaad/xpZAOPfawkd9ioWI0bQuj8Sim0LXYNr5bDcwQso=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw+i7bJoz2pt25V0Sz2JBaPJiyLNEm7Um64ONjD1xhrWurnH84w
	5BlG1tnaz+24MQfsnoNVrvEyDAI3abZ9cWYMqDJumC5ghcQC95ZlPVYBM75Cb/hN8cXo/zCXgXf
	uRmdIwrMC0fKNLZNBfdAzRkTsUcVvn2lnJQv4vVmSKqjn43OnA21CDenqhyPbZZtEOYmQ
X-Gm-Gg: ATEYQzwsJMjDLUAnN4trE5IjYISnEFhJJL0uRjdvpHWl2tgh0OQHl4iCaV+MlwtAHmR
	NX2KDlx9ozIIAi0UivDz+/4y/xVpu0APxb209JXkVTQC6vvTMCiODSQ4oy3h8rv23PkwV2Znd/M
	FXIMxX0v4JkN7TaVsSDrLP7QVyaj59trQX7P9dTRXHFw1lMYk2LJ0BZfa9z8KzxcfOXEziml0/g
	fzgKjB8713tNjRPrgC8JBVPOHk90tMZ0nEgeQNHmDi+ObVyNwKeodCTzn6oqMI/+8PZlD5IK8i2
	y93h6M+tXPEDV5BacpCIVCAX5QcjqY+ANKUEliHE9iW9L1EkIOSVvtU30AHYHruFKCGImw4Vym1
	NIvNDQHkPNk2CdSME4W472tSM5wiVnKSC9hTO
X-Received: by 2002:a05:620a:444b:b0:8cb:4dc4:61d3 with SMTP id af79cd13be357-8cdb5b4d2dcmr2133501985a.45.1773752935341;
        Tue, 17 Mar 2026 06:08:55 -0700 (PDT)
X-Received: by 2002:a05:620a:444b:b0:8cb:4dc4:61d3 with SMTP id af79cd13be357-8cdb5b4d2dcmr2133492385a.45.1773752934670;
        Tue, 17 Mar 2026 06:08:54 -0700 (PDT)
Received: from quoll ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b46b41eb2sm14570171f8f.1.2026.03.17.06.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 06:08:53 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Geoff Levand <geoff@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH RESEND 1/2] powerpc/ps3: Drop redundant result assignment
Date: Tue, 17 Mar 2026 14:08:24 +0100
Message-ID: <20260317130823.240279-3-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1197; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=kfK2P00GOS1HGyokkFKCyFr1v2aOTRTV58ef0x8ZCQQ=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpuVJHcmZsBTdcO2QsppBGSBCOPt3xe/J35A29L
 qNKniyejUGJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCablSRwAKCRDBN2bmhouD
 14sMD/9UZePTUYjWEmQVApyC5fbqybToJIdplE+zCWT6XcIgZjMA/yV4Eqay0bVg5w9ypQvW6CI
 bnHiJHmLVRrHEr9rpUMKmfUXjc5AQxX7qZmvsBRKtrkK2Nq8+YYXm9e45Etg78VBfVFldLnKky2
 mPMhNEa4IwQjNSnUSToBLesf2dIBoqMmFEkg9t+EMwo9Kk9Tzlz0Ge+9/5jAseWu7issT44lHdf
 0bw61ebC8ObSrAOfd9FoFaGHTSHoB84QADdMuMykgOWf08k7flz70oWllwwruZlzfoNrMEHcOKo
 TuuDqTj9Rkf+9CpwK7ckVAtYyn4x3YjE8OMEOYF6f9PdTUmv6XR1BcLLC0Gw4G/omY3wdnkukOF
 s3ZC1FcDKWqH5mdRAR+n3G9XJz9aFBtLZYTI5wX7vtawwSlrISRCDWCpABZc2E/GlX5VsPwz5/n
 J5gMheGdZwfQbkIVa1dS2B1zASHFuK6L5Exn7cbv3sl9Kp6TafQNiyPVmlCyvFLUsUplvPexMXk
 QIth6mMce/QyVjCtanIjbZsxdwDGAUsyNf/RK1WybQti16qEsylnNvkO/MJw76K8e1MnsEAVpQR
 I3tjJjwkIT8HGJAm0y6sOCMM8hrwpbYIdxItRpsdmokUUXZuxH+pQgXA14uxArmFx0RuTJO3rYb uBwyCdSKIKhcjiA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDExNiBTYWx0ZWRfXwuF6AGMBFfW4
 R1y/3LsphSY0v4lAb+Zc6A8MuCJ8bk04FpOeIB0bGafPiVSZUizEsR4dx0UBwAFJ7ap6ltMwOrT
 CTsGoPeEaolLJurikGG87qZ/UFYln4l4DY6bvOPcCg3fqZeQkKr+dtUtc2YJhT5r5utaxPLuWcd
 fSdLWT5e3bCBAxM1zWF0Q+DkhtAjOcjgLg+lb9noLtn3mt+C02gKbUoXb/h8bL5ADLgRNxdc9S2
 Vto4HTXNxMuJrDTqrUWJ0xTGuyEkbj6/u7YBt09atGS+twmUFTlElRIbayqHak4I6yDMPNcNHaC
 DpO2cLuL9hwuTuoIZmkAVdq60jsl2e9je0XuPjBZzx+ZHw67+snEwbWW/UapZpMxBjHCheZcuHM
 yOjNA9X2nYApMJO/cQoD1sG0OLjNsj1XtdJYCr3A0qv8rXejFGjmaNApgufnNPVnW0fUb7AXOOT
 UTFem5ZpJGA/buNvU0Q==
X-Proofpoint-GUID: 2IWGzjkllffLkSRF6eIb-8G3zDkFLM3T
X-Authority-Analysis: v=2.4 cv=IqMTsb/g c=1 sm=1 tr=0 ts=69b95268 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=AlWDwjukKM133PY4UH8A:9 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-ORIG-GUID: 2IWGzjkllffLkSRF6eIb-8G3zDkFLM3T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_01,2026-03-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 malwarescore=0 phishscore=0 impostorscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603170116

Return value of ps3_start_probe_thread() is not used, so code can be
simplified to fix W=1 clang warnings:

  arch/powerpc/platforms/ps3/device-init.c:953:6: error: variable 'result' set but not used [-Werror,-Wunused-but-set-variable]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---

Resend after ~2.5 months

 arch/powerpc/platforms/ps3/device-init.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/ps3/device-init.c b/arch/powerpc/platforms/ps3/device-init.c
index 12c473768c39..9109c218a060 100644
--- a/arch/powerpc/platforms/ps3/device-init.c
+++ b/arch/powerpc/platforms/ps3/device-init.c
@@ -950,8 +950,6 @@ static int __init ps3_start_probe_thread(enum ps3_bus_type bus_type)
 
 static int __init ps3_register_devices(void)
 {
-	int result;
-
 	if (!firmware_has_feature(FW_FEATURE_PS3_LV1))
 		return -ENODEV;
 
@@ -959,7 +957,7 @@ static int __init ps3_register_devices(void)
 
 	/* ps3_repository_dump_bus_info(); */
 
-	result = ps3_start_probe_thread(PS3_BUS_TYPE_STORAGE);
+	ps3_start_probe_thread(PS3_BUS_TYPE_STORAGE);
 
 	ps3_register_vuart_devices();
 
-- 
2.51.0



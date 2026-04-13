Return-Path: <linuxppc-dev+bounces-19664-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 435E2E9381E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Apr 2026 06:03:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fvGzS5h0Sz2yjV;
	Mon, 13 Apr 2026 16:03:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776060180;
	cv=none; b=YYMcyz/MTBXsiZ1CJWFjaBL5/6G85wIJHkDv/UAOwuQ7mcqh87HxBBvqzifRyVrqzETNIDTugGdu9N6Ccy5vjKZpjW1Yz4A01DOxmJZPFic4j50t+3Gs8CAU3bha3/b845+jGqD+lev7NTt5L23uvr+ONUP62qoNvfJnzGYL9NIl+ob3LyD944mrfvlguLUS8jKpbxEG1hJRvRN7LuLkj1hhOzT69+Y5tvzGS2VrkRcGyb5ujGOoK7crblc3jIoorvRHPgH8DOJWT+9sZ8xAlQ0y3MGCXg0+bR8i6cj1ff6h5GiwlNWunOWgo7ZgLdr4StwzSt7rH3kSfPgJdYGxOw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776060180; c=relaxed/relaxed;
	bh=/4xEK6n45wHIagvOP28E0o/90Kesd4wn03yNOhl0Vac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dM7N3d7ktmzEX3B6w37/JpCfOAWrKEPcQdV6V8Qmq2IgfxJlD3FrkZE8cchWcy4cb9GfOPbP/UbHCc0I/nyQD9HiJIuTm9iZLybql3VYzxD9mpl7MqwHgbn8srd8nXZkkuX0QU1u75Y2CO4ANyaK5wMyBLa++Rp7HgfHhbDZbGZTfMK0+HR+wegPGATTkLb2Co+Fu2CPoYUOS0WTDx63U/q5Ht2pTQFJQvZiIzKdLeRCNUNfY8+1BN6nqvfROh/S7s65gET2odkXFhMpV8CjEhxTVorzcvcpWUKl0iuOQfaJkhSMseQFkwKjB5s4LJ8EEN0KG+oG33t2ieix1xow5g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LBg9mcO8; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=rnsastry@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LBg9mcO8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=rnsastry@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fvGzR5VgVz2xTh
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Apr 2026 16:02:59 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63D2wIOS3661387;
	Mon, 13 Apr 2026 06:02:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/4xEK6
	n45wHIagvOP28E0o/90Kesd4wn03yNOhl0Vac=; b=LBg9mcO8qcR6QgUZhxqDZl
	xqVZS2KjWP9vvpIMiD3nEpnl/AqynxmCtSKWw/wqKiYvIavmAMh5RHEgiAJ18Bwr
	LDf0aO5ii8iTlES9nMUwTqWHANfQ/nf3yf+oZoSB3fNqHRFZ2/AZCQhH5Ty03QeP
	KKLFT9qUD12LOXwqYApqpCL0HKI1LPNWKHlbWTmx82sH8yp1k01nWLTINI99rjWR
	GZQf1Y75eTfFkGgjwwTJVl9n2G6idDlxr1U+kK6sInsZhPG/+vOojd/SCqfAmdSj
	MUt6c7A14BTMAlCOXgOHiHaYRer1YLAkx6mpWQ+EZD9/ZDt5Uxc7pr9JMXesSf2w
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dfcqex05p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Apr 2026 06:02:35 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63D5gO0K025809;
	Mon, 13 Apr 2026 06:02:34 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dg3b1bme6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Apr 2026 06:02:34 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63D62Vci52625776
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Apr 2026 06:02:31 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 24CAE2004D;
	Mon, 13 Apr 2026 06:02:31 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0CC1E20040;
	Mon, 13 Apr 2026 06:02:27 +0000 (GMT)
Received: from [9.61.255.69] (unknown [9.61.255.69])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 13 Apr 2026 06:02:26 +0000 (GMT)
Message-ID: <10679c0d-53d7-43cd-9400-10b27371919e@linux.ibm.com>
Date: Mon, 13 Apr 2026 11:32:23 +0530
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
Subject: Re: [PATCH] powerpc/boot: avoid overflowing the bootwrapper printf
 buffer with bootargs
To: Pengpeng Hou <pengpeng@iscas.ac.cn>, maddy@linux.ibm.com
Cc: mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
        geoff@infradead.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, rnsastry@linux.ibm.com
References: <20260401160312.88459-1-pengpeng@iscas.ac.cn>
Content-Language: en-US
From: R Nageswara Sastry <rnsastry@linux.ibm.com>
In-Reply-To: <20260401160312.88459-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDA1MyBTYWx0ZWRfX50//VAU1ENks
 QP5mE7I7Ppk/0eATASD1XfBQxYfNVcaiL+Wwusiewq1Jetl4FR65dfks6spnRGhGPOE0gpgS3lF
 lY4nM/MHAx4P3CwLigy3yg7wEF8WJMeTdNZMLfCmCbkSuOw6dbnFOMUFyRNhzJ2oRutPR3YYFf7
 y7kT8kKvVkxoofNw5n4Ef4Q+pGJamGOjZrWnHzJiIICxDibAHi2bruVTCqJF+X+oYB6kERMf7QS
 DzOpEn9G+NH7FFXhlTG/vinyHGDZziRWHz1lrFBeAAsyzPSYAhgiPmrCmHR/lTK9H5pqvIIXzD2
 +fff7i9ObIPPm2XkiPEPJ1mlb3o1JHfOQ/tRp4qThU8kpY4zu5HROa4w5+/uvQIGj8WPcPUVNMM
 0jdQP4wRtuqahcKDB88vmJUzLRyiU1YUUSv8TG9Mo9+bUrywm19ReIkOXyw6ifM4hc7kNGIUKFx
 ntFchee1cgGS5XVtvtw==
X-Proofpoint-GUID: whSPaoIwLue0cmM7iFLAPo3crQdJ31Gs
X-Proofpoint-ORIG-GUID: Djlvn0qQSUu0jKmKlIWXaRKdH8Mp8xWD
X-Authority-Analysis: v=2.4 cv=YemNIQRf c=1 sm=1 tr=0 ts=69dc86fb cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=DUVUJfB6Tj1BngdjnsMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_02,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1011
 impostorscore=0 bulkscore=0 malwarescore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604130053


On 01.04.2026 9:33 PM, Pengpeng Hou wrote:
> The bootwrapper printf path formats strings through a fixed 1024-byte
> scratch buffer in arch/powerpc/boot/stdio.c.
>
> Both prep_cmdline() in main.c and ps3.c print the full bootargs string
> with a %s conversion even though the command line buffer itself is 2048
> bytes. A long firmware-provided or built-in command line can therefore
> overrun the bootwrapper printf staging buffer while the kernel is still
> starting.
>
> Print the command line through console_ops.write() in bounded chunks
> instead of passing it to printf() as a single %s argument.
>
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>

Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>

Tested this on Power11 with different sizes of the kernel parameters in 
bytes (e.g. 512, 1024, 2047, 2049) not seen any errors/crashes. If some 
one wants to test, test with more data in a parameter rather than number 
of parameters. In general there is a limit of number of kernel 
parameters defined in CONFIG_INIT_ENV_ARG_LIMIT.

> ---
>   arch/powerpc/boot/main.c | 12 +++++++++++-
>   arch/powerpc/boot/ps3.c  | 12 +++++++++++-
>   2 files changed, 22 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/boot/main.c b/arch/powerpc/boot/main.c
> index 2c0e2a1cab01..d02f77ad4df7 100644
> --- a/arch/powerpc/boot/main.c
> +++ b/arch/powerpc/boot/main.c
> @@ -193,6 +193,16 @@ static inline void prep_esm_blob(struct addr_range vmlinux, void *chosen) { }
>   static char cmdline[BOOT_COMMAND_LINE_SIZE]
>   	__attribute__((__section__("__builtin_cmdline")));
>   
> +static void print_cmdline(const char *prefix, const char *suffix)
> +{
> +	size_t len = strnlen(cmdline, BOOT_COMMAND_LINE_SIZE - 1);
> +
> +	printf("%s", prefix);
> +	if (console_ops.write && len)
> +		console_ops.write(cmdline, len);
> +	printf("%s", suffix);
> +}
> +
>   static void prep_cmdline(void *chosen)
>   {
>   	unsigned int getline_timeout = 5000;
> @@ -207,7 +217,7 @@ static void prep_cmdline(void *chosen)
>   	if (cmdline[0] == '\0')
>   		getprop(chosen, "bootargs", cmdline, BOOT_COMMAND_LINE_SIZE-1);
>   
> -	printf("\n\rLinux/PowerPC load: %s", cmdline);
> +	print_cmdline("\n\rLinux/PowerPC load: ", "");
>   
>   	/* If possible, edit the command line */
>   	if (console_ops.edit_cmdline && getline_timeout)
> diff --git a/arch/powerpc/boot/ps3.c b/arch/powerpc/boot/ps3.c
> index 89ff46b8b225..2f17b99c713c 100644
> --- a/arch/powerpc/boot/ps3.c
> +++ b/arch/powerpc/boot/ps3.c
> @@ -31,6 +31,16 @@ BSS_STACK(4096);
>   static char cmdline[BOOT_COMMAND_LINE_SIZE]
>   	__attribute__((__section__("__builtin_cmdline")));
>   
> +static void print_cmdline(const char *prefix, const char *suffix)
> +{
> +	size_t len = strnlen(cmdline, BOOT_COMMAND_LINE_SIZE - 1);
> +
> +	printf("%s", prefix);
> +	if (console_ops.write && len)
> +		console_ops.write(cmdline, len);
> +	printf("%s", suffix);
> +}
> +
>   static void prep_cmdline(void *chosen)
>   {
>   	if (cmdline[0] == '\0')
> @@ -38,7 +48,7 @@ static void prep_cmdline(void *chosen)
>   	else
>   		setprop_str(chosen, "bootargs", cmdline);
>   
> -	printf("cmdline: '%s'\n", cmdline);
> +	print_cmdline("cmdline: '", "'\n");
>   }
>   
>   static void ps3_console_write(const char *buf, int len)

-- 
Thanks and Regards
R.Nageswara Sastry



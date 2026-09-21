Return-Path: <linuxppc-dev+bounces-27855-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC0AFC982ED
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Sep 2026 12:34:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hpN2z3x3kz2xk7;
	Mon, 21 Sep 2026 22:34:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789994075;
	cv=pass; b=XJXeUWkOqILbubQo9kn+oX5Ex8ZP7pOHaSJ/pZgvN/R8HRUhUYhMYqy3PFAok+ZuH5sVxmm8Yn9U8TuaNF/ffa1YKUD3isLzzr4BjE4n5G3AerdSL8FS5yf4I0l9T86i3pN4qhQ77N+8N+SuzPVowNMxhvLlcz8cvf8XtdKws/cKhPj7wJ/9g/wsVFSsHmwIGQHqO5bwM1xQiNIYnf9kIJ2bha3Ln5wblPNG7aIrP16muKKqiuaGimRcp7t7MjpocE+IB85zf2II6LW8iwIeO61TJnaTZGTp4EbbbLONYZ7AGvQBXuw/B/a2absYXI6VCTwnnLyVzF8XIAAfHCS7cA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789994075; c=relaxed/relaxed;
	bh=/BDRXmBkcw22M59qvA9K+D4f4Ea8LGuvWPNOiAu3AEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ln27tSxyagE8Hnf4u0ct202s4TzQ/NRekavxqPmgmbCR/Yb3NHcsgGI80othBEdIjjzJrCbvxu6Dnwf7SlTJvz1O7cnGJZvMDvuX6ha52fwGQnhfifabud5O8sDQItAUmm3Fdn289NjROqEppYV/kwx6EhWcOSiC8fALqY4qnkJZvxy/ND8NlT3jyCgoEiEp9eeDDfgxpUQjQpgKLSox7dlY4wsTWrp38zJMswKsWgeQszIZtVbk1Fu1nTa/BFhaFuaMFSjD/OjA7Oy8s38P3psFEfqHKgmD45Orm/AQET+7CqxpDDGlh0ftqkq5K9TPvNC8OUuVXKPxxTdkjsgMOw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Cb7aZkbm; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::5; helo=duzpr83cu001.outbound.protection.outlook.com; envelope-from=peng.fan@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Cb7aZkbm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c200::5; helo=duzpr83cu001.outbound.protection.outlook.com; envelope-from=peng.fan@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hpN2x5cMdz2xdb
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2026 22:34:33 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GtWwreKKzcKJhEykFnHbmzGNXmo/ItDBmWdGr4lGx9worKxBhqqUbL6524ESzPL3lUUu35eSjCdxjiGlaiwuCN8+/flTquZkjOkMTLtFUGgPxpTWh3fWtPQNpP5pvBorNKXcAoBhzRkriXW7dTzSa12R0ZMXXmRPHxc4k34cq1S3s12wJmHsO2bEDg0GKCQW8+PNtrGlZIfiFMxb6Yr+ScPvBeI2BXVY8Fpyshf1OQeFbeWFCd+a0hTI+BkPpwHCX+etw99MKhUfoB1ueCIZXkyaCjzMbo43q1Sqx8ju48v5HQzGEPgc9SwSZUAvTfABQ0BavPXAupmJrHyLuxz0jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/BDRXmBkcw22M59qvA9K+D4f4Ea8LGuvWPNOiAu3AEo=;
 b=N2NH29F7c/CsjAUP3vD56nCwXOWLgJhd8lf6WPSuIY6Y++bLS9PAP9GWbCm/jHU6eMeIPRv6qSA3kbW8H49gR9U7to+DSL1LEavX8U86j/8DgLn3TJ1MTEQExwx7CdzKh1HFVhdD9R2Ilov9g7rStIJyYkaA791rzBNA9VHSit+iVsAtb6uw+bOEqHTR+lyKr3Hqr4MgiKONDXmqMJnYWkGh6a7Bm5zMRjK0QjsvRRuPX2OCcX/Z1kU7DNc7X8p1YaXLrr9Iu7i4i1NE0uEtYmkOck2Kzdx5EiBdeh/4qJo1UTqtZBKGm7Bthr88XX8/mK8lz24I1IKzLiYJZaNz+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/BDRXmBkcw22M59qvA9K+D4f4Ea8LGuvWPNOiAu3AEo=;
 b=Cb7aZkbmrbleJpmzNrbt2qT/HLqexR/KS7juxUCdghD460Dj3y9muC4d8AM0suskmq7tIcVlNvo76IHsq3wFrgP/aoVxF2zHJmArXuAtAHV9Jnca7IXQw/V1ofeU6+FTpgiYZRe5LjDRwe/tSLprlL4f2sNTyet3+9YRTD1xMik+P1CZRQVjdR0U/dXS574hs+HWDh9h2hUeyJEOGN3DUWsg5n8oxUJzNmyDEbN3ya1STseMb94aB9ivgPbjhPGliMXjQL1J/NT8rvaBC86NxdxSvRfgzFOVRUWSIlLeziwX6XGk6r3tqpYcIq0g4JTTmBq9xHnYDXdR4Ix09l7c0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 12:34:05 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 12:34:05 +0000
Date: Mon, 21 Sep 2026 20:37:58 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: Re: [PATCH] KVM: PPC: use assign_bit() where applicable
Message-ID: <arElJku644yUmTUY@shlinux89>
References: <20260920022618.3145649-1-peng.fan@oss.nxp.com>
 <aed4e6a7-1678-4e27-9091-d621d3fe1535@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aed4e6a7-1678-4e27-9091-d621d3fe1535@linux.ibm.com>
X-ClientProxiedBy: MA5P287CA0310.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:21a::9) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
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
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|AM7PR04MB7046:EE_
X-MS-Office365-Filtering-Correlation-Id: 869f3da4-9fd2-402e-809b-08df17dc9fb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|19092799006|10067099003|56012099006|22082099003|18002099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	8nmMaT6WmFf9kGSIvq9/aTIexDHnPm21X2yNaTmXJJPxkHV60h5CA6kUvJClNwmdkxJCQvuBjKMOE4W4dlycHJvJhSgj69WxI95qs7+lpqCgO/Ssfsi8iIivFN7FuqoK64YZojmWBBRpRNy8SjI6o+iJ7tqpj0Xap5LEpyXHpe+ExD1Icw5sepBbLXBkXilgMMWVy1zHyp1OkvWlGgmVHz0HSxJ761bRDZbEhlN8IAo3ieALNG148kdVsSXxHLAs3zgamvOkudGGk9OIkbh+/RE9p9ZTjMH6ZWXOPFIi2TJBCea6JWYxqMxte6/llonZh0evj/aOKakizC/wsX6hBDYMTBOzxK3YIamhIk/P73nB0P9KUSydux9HJOWvQQJIwQ3Q1T6PePI2kOVXDmn8rXotWCob0U52jk23R4LKGwmqE3SppFgQbEdoX8iDOcOJJpLMcCMGQSRmcIqFUkI2iZUrjCsY3OE5C65gW0o5iXsJZKxc+dROI7fufXTi86wZjrdOf5K1Gzg8IEZnwRCsfzP/dhQu0BXI/okP1OHE2aH9If4U4ZX9UoWUB0+N0BveXLNqqNKQXTkkDfRDbhisirzlNKyKiGCDThZZDOGZx+2567fpfMrUEmoSxoyhWMeaGnmjt70fbinKl0kGQ1/Gs9xzN6Yj85QYDOg6EZjP3OY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(19092799006)(10067099003)(56012099006)(22082099003)(18002099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?euRQfd+LHDJVXlwCKQURtQ93jWXo9FLN6s9ag36VeZaTimmaJmd2Awf6MwwN?=
 =?us-ascii?Q?CoZQpfCXJovR9fXmh4Yhl3IZuEWV0jfpqIq2e40wehvL1SoGpnLfaWAkjE0S?=
 =?us-ascii?Q?omP8STV0wOnbpfmI+Pvr8BmqVTqVizkZ5B0AX9c8ygC0FCkHs8VKmhykhEKE?=
 =?us-ascii?Q?oLHm5SAONe6tx+cMT7Z4VhYt+ChiPocqx3Vb1QtMriTwOdumRDDyV8dFmpOF?=
 =?us-ascii?Q?Mf6ip7q9UqYpu1tFKZ/A+Dp8vNDiHPhBQ1OwQfdCQ21Q4S5k0FKSOr10fgKu?=
 =?us-ascii?Q?VnIEzJW2QebzCDAMSxlDKfA+NzWMUcvbES63vvxxN2t4Q5Ms0e98A1+3iVLn?=
 =?us-ascii?Q?pci5o9TOdzikDsdk/KkKmnnPn65VGYFhqu4b9y1UO2ttCu2noUDX1IytsCIF?=
 =?us-ascii?Q?gx4NJX5m/hmEUmnc181Z0j4WzL+yR9Qz8NY6XFKMVCkNLP05XyENDdlRUjxl?=
 =?us-ascii?Q?J2rZF+F6H5encu6NyApxdezgiognBqdjKRqcTDBgj5+abiWZ97sdYkGfwrQb?=
 =?us-ascii?Q?EzZTWBWK2it3gFYSOS+6tKF1M/VEOh1UyNzKk1o9rxisCoI5xwByMmWPYsIg?=
 =?us-ascii?Q?6EehcJ4k0XDLYalCw+wT4x67RruB7cKoStpcFMEVXKBSdSUKmDXPG7VX7G4J?=
 =?us-ascii?Q?+8UWDsZM5dzwgiTGALgBwDdujdxcAp+ieMIFMFVdo3nfUNOQVr/i8IquL2jN?=
 =?us-ascii?Q?cz8OpGS9VlU6M7pJ5gQPA2pI8EhmgtLZJGrWLgIN/9fPxsij2WkRUUtYzgMs?=
 =?us-ascii?Q?WyyOeT22I+mpYbXO3Sx+ZngrFMGWPqcsto+NyGpSS+jBoBekjbLtc25NhPiS?=
 =?us-ascii?Q?IOL6iPQRrUyTD48tBwb+1W6AKiyzaJnQxfeTRJ/2oimn9nkPk2gVJs4WVriK?=
 =?us-ascii?Q?YvQ9SRHhSQLin87qKYApJlqL/E1EHng3P2xWvpU6cuD4m7ZHxSfgkYNM4XzX?=
 =?us-ascii?Q?kJXDDPSulCQHzYWKWoHMEbgObtYH9pZAZLtnjWPAzegVCJFcP4KWaf6LoYai?=
 =?us-ascii?Q?MLywhcx2hLNKO+tUxnnCj2Z3U4go6lMkOztq8jlWsslsBoEBBkRl6Ks+Jlhg?=
 =?us-ascii?Q?OuG2alvUla9JE99g0s1PMDVLqHe6DGsTm+dIYg1y3pGWpto5Ow2umPYSf033?=
 =?us-ascii?Q?p5dM+BjqDHFrK5Z5zxd0AnmtBbIsDR9o7AvpxaNtk7vP66sJSy+BM3u2HGt1?=
 =?us-ascii?Q?lAujR5/Txv/hB93l/uBnSgzWRkbQpNJbSwTW5pVkQrV37nZjZDrVTA1/gAGD?=
 =?us-ascii?Q?DjYKZLMrT8Pwdvavr8AlLQyzMOsQkokuSPE5YHcPmC2kk/U+aqbdRMc86+yc?=
 =?us-ascii?Q?F+kPdW2qf3Y7FvONUaAJ4I0esCF98TT2EJCuxRSxKCrwKo+MEld8vT51J2fM?=
 =?us-ascii?Q?xHZe3grezS9I7DIfAQ6Ip4cgPhFb8cMu8XxKxNUIG2yThPcHGQtrI3yxp5vP?=
 =?us-ascii?Q?S9PArGocLrZa7AdGCxBtNnaX72ehvlCUGSl10nP9tjQ2XCm+dOCMt/O45pY2?=
 =?us-ascii?Q?cafqwbPgNfj3TZt1SgPbjVFDiKhcrBVCaipCdjhDl2sXd8w/dfCoqReuvl4/?=
 =?us-ascii?Q?/4eOVLaMGDIqaT1Q33BKsdo0TaNqHxdDXQjy5Y9lqzwJyFO9khocFUrGQD/r?=
 =?us-ascii?Q?RRzBrGhvsiKg/IV8JLo9Kl+DNyviYlQB67IFINh91BB+frQlCGD1znzoOhKr?=
 =?us-ascii?Q?emZvDGp03RaTIMPI367kG3t4CxmOxXfnxWhnqBUDK73eoW1M/fcR3D1Bi1z6?=
 =?us-ascii?Q?3zd/9jaka3Lim7jpt9vzuErv86m6ig1CP4OWvRB/Ht64WfRd9JwH?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 869f3da4-9fd2-402e-809b-08df17dc9fb3
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 12:34:05.0990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: isGpbmoiPMant2GBohJcihYfmRWx9cfvhF8yu2ME4nkHuzfojPh4ojgT6JOh74nknKer+92cUYh27zM9ZgWSJT5Y7cSS11u+RWjcEaByTVi7fiWwMsKKy1zBXC0IJcex
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7046

Hi Shrikanth,
On Mon, Sep 21, 2026 at 02:39:34PM +0530, Shrikanth Hegde wrote:
>Hi Peng.
>
>On 9/20/26 7:56 AM, Peng Fan (OSS) wrote:
>> From: Peng Fan <peng.fan@nxp.com>
>> 
>> Convert open-coded if/else with set_bit/clear_bit to the assign_bit API.
>> 
>
>Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
>
>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>> ---
>>   arch/powerpc/kvm/powerpc.c | 5 +----
>>   1 file changed, 1 insertion(+), 4 deletions(-)
>> 
>> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
>> index 9194cf492d1c..a567b63a5f1f 100644
>> --- a/arch/powerpc/kvm/powerpc.c
>> +++ b/arch/powerpc/kvm/powerpc.c
>> @@ -2210,10 +2210,7 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
>>   			break;
>>   		if (!kvmppc_book3s_hcall_implemented(kvm, hcall))
>>   			break;
>> -		if (cap->args[1])
>> -			set_bit(hcall / 4, kvm->arch.enabled_hcalls);
>> -		else
>> -			clear_bit(hcall / 4, kvm->arch.enabled_hcalls);
>> +		assign_bit(hcall / 4, kvm->arch.enabled_hcalls, cap->args[1]);
>>   		r = 0;
>>   		break;
>>   	}
>
>
>Just ensure you have covered all such possible open coding where applicable
>in arch/powerpc/.

My cocci rule as below, only one candicate for arch/powerpc/ is found.

// set_bit -> clear_bit => assign_bit

@@
expression cond, bit, addr;
@@

-if (cond)
-        set_bit(bit, addr);
-else
-        clear_bit(bit, addr);
+assign_bit(bit, addr, cond);


// clear_bit -> set_bit => assign_bit

@@
expression cond, bit, addr;
@@

-if (cond)
-        clear_bit(bit, addr);
-else
-        set_bit(bit, addr);
+assign_bit(bit, addr, !cond);


// __set_bit -> __clear_bit => __assign_bit

@@
expression cond, bit, addr;
@@

-if (cond)
-        __set_bit(bit, addr);
-else
-        __clear_bit(bit, addr);
+__assign_bit(bit, addr, cond);


// __clear_bit -> __set_bit => __assign_bit

@@
expression cond, bit, addr;
@@

-if (cond)
-        __clear_bit(bit, addr);
-else
-        __set_bit(bit, addr);
+__assign_bit(bit, addr, !cond);

Thanks
Peng
>


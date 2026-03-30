Return-Path: <linuxppc-dev+bounces-19025-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CDB91061B16
	for <linuxppc-dev@archiver.kernel.org>; Mon, 30 Mar 2026 17:05:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fkyL32nCqz2yF1;
	Tue, 31 Mar 2026 04:05:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c100::f" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774890315;
	cv=pass; b=fQZGc6uCOmwrWM65vddxupmAcd7YXBZV+PANFPfeuKJmOnzTBsWQdArtv75b9cMrCl/TPGcvKEF6mRdybCFZxKkdPSn4ccz5lx0yytWFX8xt2x1aPfjJ4j4oNaouW/jk8np5Z6eEECGd7sZsVHFV6krl7aVMK3CtZIr/8SK6y/01Q6lTvdpfgFNw5oh7P4kzsEbHtpwMVjdOWXU5AWR/MEEV6rm7/H5llM+84hnjPwbgs+N3KuC1V6lL1P71753y2OWEe8mpft1qc9ELdSRG3QSKr2vMfs7ptpV+UMrRB0FtnM48E0iZOiIEjAfU+eoj7uSOt8eHZfdi3zEFX/zvBQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774890315; c=relaxed/relaxed;
	bh=yYNEMV3cl/QhB/WSE0+heczqQJfGKY9bmQBxlDDtDUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WJBiC2Iy1LqEV9H+0k7/UC9TQszu6a6fb+uNuePeovu9pF7m/NXRRGm3Nwn5TELi2S4Ht0W4Ln3FcCjUIOA+sAzdjTTIQIJxqVZtnRkwp4OSjKxxnP+9VVtlHXVmfI0vNoUyxc7J2pHZKfarvTEZ1r6ONL96t6q2NhxJklY1FEx9XEDYKKiCXwrVnFTlKyZtQgAultVUog1b29MhYNlCC/U2cILI3rqS764Ia01fX/Maz/xqBIhu1lXuzpJw1ZsU/5X3o/ZEHBQGf7uFKe6eKls3xt87NonCpGV/Z0HwKGucFfOBI6w5F36vs68lOIaQyRRrEJuDV7+uoL0fmp8oyA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ZRkZmXAE; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c100::f; helo=bl2pr02cu003.outbound.protection.outlook.com; envelope-from=ynorov@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ZRkZmXAE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c100::f; helo=bl2pr02cu003.outbound.protection.outlook.com; envelope-from=ynorov@nvidia.com; receiver=lists.ozlabs.org)
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazlp17011000f.outbound.protection.outlook.com [IPv6:2a01:111:f403:c100::f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fkyL12kjvz2xnl
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2026 04:05:12 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kerr5TI1SU6X6iLngogti+Fm5ubEwju6plrHJXZeae77HhFiEHO44heoJzDBtj8NzJF+6wd4aVmhvuh0iEbgWmefqNdHrt/MLJRgKL9cyYtZZKjBLDVczqEIxMK4rWVP3pvgpyDg+Wi0s4+NEVbheNfOYxTC6HETNdgU++iDDwcW4/Iti/0IiGRISUSBeKJjwiWISPNSiaeo5gnHf+/BBUf9JPK+vJ1+/63pMEp35XywY1mccQFaE+UVPJO7cMwV6gtatgwn6Y7XQyamc7h3qEvjMfzUGG8eM13JPL+plBi+e/2RYAo1op/4nVH5QSBy8CtjcLuEMxYDoLhiFGtfrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yYNEMV3cl/QhB/WSE0+heczqQJfGKY9bmQBxlDDtDUo=;
 b=s8Ji3yDzrzL0VNc2+083ud8HixMjbZP1paPYrJMqdshWQYhDLqFRsPAFcq8PS3mrZfYgB388zpZ1Ie5avpIo3SgXmVp0V+PBCvhwrKf2hjQ9tUbtPXtuIog9O4VPNZNwMHd+nioIaEi9mdTz30Tl7s3Y4ppu65lUbKibwE6odewn42aH8hXDtwbcrRR3HZ4SskMItRYxjur2XZ+vcgAbptm84mQsAklA9nckKS4ant3JgOJk4AOkx021SR2zGMVptmSwDrJqgH+XjsajB5w1gUCh8jY+9LI+UYcR13ltFHPQtzUJUyhWWSiK2lBNvhgvuLK4OvEXNW9ATuNdUJsHLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yYNEMV3cl/QhB/WSE0+heczqQJfGKY9bmQBxlDDtDUo=;
 b=ZRkZmXAEZlCYyztURGrM9Bb7SxcrBDzkSe2ibdFQ9x+L0+EjlRUr/6o9iG40dSaGYvPUaoT6wsQhvVPPcA4w+CZSYXOhOyeZjPRi2BF2ugSdeQhVRwUbv4qSzG/JPU/PM15QRB6zXMsyuKiO6mWdN+SAggjRh9r8WF/rimq3b762BUbuL8VoupqP0k4NNBvyBHV3Gu4sbsCH4tek28FJ2k/fPnAkKdwAlsC4FYONmMTRefDdejYgHFbQGj4c1nBB9PB3hk03lzIqHkgYk8Y3JvwbDUoDsV3B+tk3hdpYRVtz8fB9G6lLfLV9a/qjLPdpbibdccMi7oKN9P4WCGp8lw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB7171.namprd12.prod.outlook.com (2603:10b6:930:5c::20)
 by LV3PR12MB9117.namprd12.prod.outlook.com (2603:10b6:408:195::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 17:04:42 +0000
Received: from CY8PR12MB7171.namprd12.prod.outlook.com
 ([fe80::4487:395f:3abf:ad9]) by CY8PR12MB7171.namprd12.prod.outlook.com
 ([fe80::4487:395f:3abf:ad9%4]) with mapi id 15.20.9769.011; Mon, 30 Mar 2026
 17:04:42 +0000
Date: Mon, 30 Mar 2026 13:04:39 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Nam Cao <namcao@linutronix.de>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Kees Cook <kees@kernel.org>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] powerpc/xive: rework xive_find_target_in_mask()
Message-ID: <acqtJ2WUkg0ZtiHE@yury>
References: <20260319033647.881246-1-ynorov@nvidia.com>
 <20260319033647.881246-3-ynorov@nvidia.com>
 <275be5b0-9680-4d85-84f7-cf57142f20df@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <275be5b0-9680-4d85-84f7-cf57142f20df@linux.ibm.com>
X-ClientProxiedBy: BN0PR07CA0027.namprd07.prod.outlook.com
 (2603:10b6:408:141::29) To CY8PR12MB7171.namprd12.prod.outlook.com
 (2603:10b6:930:5c::20)
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
X-MS-TrafficTypeDiagnostic: CY8PR12MB7171:EE_|LV3PR12MB9117:EE_
X-MS-Office365-Filtering-Correlation-Id: 71c41db9-65d4-4bbb-e3c5-08de8e7e6f48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|10070799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	hsR9d437X3cyVkyzFcDO3Dq8xiQktcfXWw5xP7HCEVcSjGFjpecC5BsLdWWjX2ExIpn9jbV9WTgnjDRvJ23k6jSbYUo/thETJL7z9Ns6FyIu+7kYla2FiZkV9OnaN3ZTpaVoV9UlA1yrc+06S3+9yUU+8dqAIibQWqa8CZCHWuzsdyaegjE0rCn3Tvvxe+jQeQ3oDLCFNH0XC6X86RR/lfzgsjwXMaSTCM2QPRiyQtghY85db2QFnxAoj4EoloOlLyCRuWsMdv2x0EPNPozwF+fM0adEmz0sdJsqzaZNTVFJqDX9levkxV9YCtbxhBn4U5hUH1aeEQVs7EpC+QoVnMcxsAVsIAjp4id8AAp5BLsxl1Crpz/vzx/o3E2ElcxOoQ78vpOK02xDoVZam/kalhRRiGPpMRdFn2kI/clKs/xteIHDzTv3eBq4OQZ73uP+cIAuyTiSvbXvYQ7t9Qrvs8+tTutielFlU8rr3DuPXfSGLN+d2Ajhgm5AlxOHTGWWCYju6JbguSAL+Fiuvu9fGVch3IkDmI6eUAqDP86WVYv9vpHhKbM/HXV/cRhv5RZTi2EhsvntXZb+/H6szQLJ+T4uczZrrm6b2JSQPlBUDo/ylSXPRjio8YekXbICRBGQHm9pzkGWX3nirOE0Dw+FjgHfzOz2viYmySEZqSwnDrteDM57nBnB+DsZUbk1XSFOJFpSx1fAKvKkSHCW+MKunoQtqPtKPLG7774fFMPCtjo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7171.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(10070799003)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sxTmExeeOVhIJFfDKWnM3ZYmmyyGKU92qtpgoujwUnbZUL2NMwb3hCxizwmx?=
 =?us-ascii?Q?x9w+zIqzO1mqaJkh8Zb/jTtnG5nMe1LDfq5FR8CoX7H5iDZwlJl5dvQetrQr?=
 =?us-ascii?Q?oHCw/HFeLiGUJUkvsXkVmiA4NER8x7BA81th/HBD3TMvzjip2pd2YPoAuJDL?=
 =?us-ascii?Q?d/daWiEYzJp8Nj7fIyzW0JEK6zx5/gp97adeWGgFYmaPWbEx2OiVTIwmVbus?=
 =?us-ascii?Q?QCcdaw+8O00+VUQaXreWuR7kt9klTziu20g3gMvX/5ZGVsNDweEzafzF+QSq?=
 =?us-ascii?Q?SAoArMRuo+Gaes4Y2Rj6E13ffntSenkmwnRaemO+Nuz4K59eW6Zm6mbGzxx0?=
 =?us-ascii?Q?VkfT8JCWsgkG19iJXa+iAhVlavsFefnQ2mjYugo+OIQcg8tbTbIXD00tKNRW?=
 =?us-ascii?Q?P8SMOVr9C5XqRiY4HGnk86Z0nzvc0cejZFBSBR1yNc++dTjiMOi7LfDm3nTc?=
 =?us-ascii?Q?jBOP+QHbBMwDqqanhFC0IPj/TtDZ/i6/Kux9M4vH8IzBURz1Arj3ZNe1CGRa?=
 =?us-ascii?Q?EIWEVoSbiTuf3LNRzMCQWbpd98qWJQ6mCS5zvkVfrssrsd701dU5bsyDvVCD?=
 =?us-ascii?Q?w6aSyMvi0JApFXTKhJQyci9W+SJtujx+yPtHqYuJOyK1b9mNSKlqzteebNpW?=
 =?us-ascii?Q?bwHC/SWGuQI+XuN4oCz1gmI1l9RMhHRfynWbKBIroEu+O+4asRKe5sIkYR4O?=
 =?us-ascii?Q?Hrx7zM7ggCAK7N1712ppjPFdbuDt4JLQFOJR6lH2iLxuhtLdnr0mQSY7KdYK?=
 =?us-ascii?Q?IJZIa2QNNzw7qJup4H8R4l+5TkqjGActXurdEVnS+HPsAGpaMpSsPd4gwr4A?=
 =?us-ascii?Q?NcNc/GHQvAJ3dnvjaq0kuzPFBadVqmwQPQdGQQWfBdsueyKuIoOOYoq9Ls5n?=
 =?us-ascii?Q?jqBzkKYZ6ndyfL0Lwu2hca9cbi4ocE879AxfxBI0WQVLNjPHTQsaM0mFt4n8?=
 =?us-ascii?Q?gk7NV8DNPwmt0mIoYGFHOUqx2ZooF48KXh6O/mtiNIXKFE5U+s6Ai1Ui1xgz?=
 =?us-ascii?Q?xmrucZ8w2nSLooRDQ32FczvHOBtcmWfTbKPve8/H/XzqXOQs2pWb06TXQVF5?=
 =?us-ascii?Q?HkKj9AyL4q0Nd4enISdifaU6cxgqGILJpNFGQP1q3U1ExyWmLFP6Ua3dvPbC?=
 =?us-ascii?Q?FHxTQ6Va9hpQFA9XBjjqbdSOYDiVX0lYCw0UXVVh1j/CJXws+75VaLkhO0uJ?=
 =?us-ascii?Q?T85w88MP/rej3eT0Ffn2e3d67tbLok/+6F4ozN+dWrtzXejq3mLAttLm1xZy?=
 =?us-ascii?Q?La92eqZSX2tF+hUHZJ9AhH0Q/pwIAD+W43JMu1kwUWbCUhQfTWuT4G6uEPHA?=
 =?us-ascii?Q?X2/SDy816xZUHUc1MVucpCsPqQiDX+cFeavqlKyrYe4FETh1LEriGbTlLp5e?=
 =?us-ascii?Q?oJmMRgSQiWD+s0YtoJlPQIp274DpbNeNYNU2m4Pu9yNbpsmC1z9qmdwuRgly?=
 =?us-ascii?Q?/HYL4Ny7gwN2UTMuVnhptyf6SX7vRUm4PHnxqQ1kCxnp0ITyVbIR1gDpVN3T?=
 =?us-ascii?Q?skezcNGVMVjevtUdKe6W4d56kReR74+B0cTGxrdF5CdwYy2rp+/RwG+moCjL?=
 =?us-ascii?Q?74f+pWLIsAlVpw9chcRBBdhcvx76Z7naewK7oYthvHVotJ2seEKxzvqtQ/iV?=
 =?us-ascii?Q?lnADJEO/S3Pt/onzcmv9TuVpJWaMrcqui9+TqMpUvVdSVvjcAtAVC//n5Ez8?=
 =?us-ascii?Q?sBUHKX82kQ9O4M24Z0lONZEtZA5c767dsbrNjWpoMqDz2oj2IhI/zjIbpnJm?=
 =?us-ascii?Q?gdbmMrz4d8j2OWFMg72E8bxDxdHcwoCTOiDVFXnguRrMn1vAb5Hb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71c41db9-65d4-4bbb-e3c5-08de8e7e6f48
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7171.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 17:04:42.0628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8OOEyVaegW4JCkW4n2IaCsJ9GjusqoJtWmfsXKmCT6n7qCYNR1B/7WFhAHCya9B2KCc7d22Gq08fNXUaivSNXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9117

On Sun, Mar 29, 2026 at 02:43:27PM +0530, Shrikanth Hegde wrote:
> Hi Yury.
> 
> On 3/19/26 9:06 AM, Yury Norov wrote:
> > Switch the function to using modern cpumask API and drop most of the
> > housekeeping code.
> > 
> > Notice, if first >= nr_cpu_ids, for_each_cpu_wrap() iterator behaves just
> > like for_each_cpu(), i.e. begins from 0. So even if WARN_ON() is triggered,
> > no special handling is needed.
> > 
> > Signed-off-by: Yury Norov <ynorov@nvidia.com>
> > ---
> >   arch/powerpc/sysdev/xive/common.c | 31 ++++++-------------------------
> >   1 file changed, 6 insertions(+), 25 deletions(-)
> > 
> > diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
> > index e91ec9036ad8..4e05f678e171 100644
> > --- a/arch/powerpc/sysdev/xive/common.c
> > +++ b/arch/powerpc/sysdev/xive/common.c
> > @@ -548,40 +548,21 @@ static void xive_dec_target_count(int cpu)
> >   static int xive_find_target_in_mask(const struct cpumask *mask,
> >   				    unsigned int fuzz)
> >   {
> > -	int cpu, first, num, i;
> > +	int cpu, first;
> >   	/* Pick up a starting point CPU in the mask based on  fuzz */
> > -	num = cpumask_weight(mask);
> > -	first = fuzz % num;
> > -
> > -	/* Locate it */
> > -	cpu = cpumask_first(mask);
> > -	for (i = 0; i < first && cpu < nr_cpu_ids; i++)
> > -		cpu = cpumask_next(cpu, mask);
> > -
> > -	/* Sanity check */
> > -	if (WARN_ON(cpu >= nr_cpu_ids))
> > -		cpu = cpumask_first(cpu_online_mask);
> > -
> > -	/* Remember first one to handle wrap-around */
> > -	first = cpu;
> > +	fuzz %= cpumask_weight(mask);
> > +	first = cpumask_nth(fuzz, mask);
> > +	WARN_ON(first >= nr_cpu_ids);
> >   	/*
> >   	 * Now go through the entire mask until we find a valid
> >   	 * target.
> >   	 */
> > -	do {
> > -		/*
> > -		 * We re-check online as the fallback case passes us
> > -		 * an untested affinity mask
> > -		 */
> > +	for_each_cpu_wrap(cpu, mask, first) {
> >   		if (cpu_online(cpu) && xive_try_pick_target(cpu))
> >   			return cpu;
> > -		cpu = cpumask_next(cpu, mask);
> > -		/* Wrap around */
> > -		if (cpu >= nr_cpu_ids)
> > -			cpu = cpumask_first(mask);
> > -	} while (cpu != first);
> > +	}
> >   	return -1;
> >   }
> 
> Only concern i have, (which could potentially leads to while(1) loop
> today if it), is if mask is empty. atleast for_each_cpu_wrap will not
> be a while(1) loop.
> 
> So, IMO this is better than what we have today.
> 
> nit: maybe a good to add a WARN_ON(cpu >= nr_cpu_ids) in the end.
> 
> Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
 
The iterator of for_each_cpu() is always >= nr_cpu_ids when it exits the
loop because it's the exit condition. If you want to warn user before
returning -1, just do __WARN().


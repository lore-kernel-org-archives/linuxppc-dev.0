Return-Path: <linuxppc-dev+bounces-28757-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEF06CA5FD4
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Oct 2026 12:55:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hx80C6TZ2z30B9;
	Fri, 02 Oct 2026 22:55:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20f::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790945739;
	cv=pass; b=lEcPfgatGMxxORz80E+AYC15DiY0q/OHEbDttJ2P0sm9wqR0rYtRYVEbZ8WM3R9ywDuWRj5KTH5Xy2Vj3xwllltuUnUOtk5ZAoGHVlEW15xcp2vS7VLwV2IjftuirO7ine9Lzpz8ITZRHfP7SX2FAm3u9UMZrH27BQLbF3NDZEhVfS+zLfj+t3/ynWhqXMkik3vwsOqnq68HUJnAtd+himAlZunttb9hjvQ+EQwPzbfWnUIFscpHGIXgjvtSZkp2u2lcPXzHIpXyTFYHebhYp5JW8YdCD0wCrtQihVkdtK3uCiv6qYbIxf01r41rel6DmfMkelJ4nbwOTRy1wsySDQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790945739; c=relaxed/relaxed;
	bh=QXCm89YgWlOfFMMcD+ln38RylJPQVlzhUuqL1d8yYkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KqRUxNVBYc+9Qqb7z0ZiDhxHYRQD+FUMibh20ZbrXx+mxO0fIrIXyEhm6csj9/WOgavZ7B7LYbZbElzzzYdk7mu2q8T/ETQuh3OkuwZW5PaqLp9yvzYKHzUR5HaNBMHC+wEc8fhkN0gL8bbFMJ98dZprzycKOIWzsP7dudBdpAVBa9VFYzd/BSG5w4iiINO9pGVYCBqLElyQpaRcP0suYCLh6cSa8OvGrHy320LatLdmU1cZAAqiB4wykJSjCKlaU6EMwOUEkXw1ZlD4agXE7xBaID6RMlaYf4BEgYC1FlhqAzUqkBA5biA7nPAwCWc6FvV683zf7+2yQyxVFxRjsw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=GEYeMEvh; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=ioana.ciornei@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=GEYeMEvh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=ioana.ciornei@nxp.com; receiver=lists.ozlabs.org)
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20f::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hx80B245Zz308H
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 22:55:36 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ug+P746c7tcVr4kSwkDTqakg83YnlKJ2QYR7NId+da9Iqo5+E+KH/qdprOeMwLTuWEGo5V2nixwAJEMH0oTlxSLuEiVfpOOW0B6bPibRo7ZN6biOJKUHujGZBxJvdxZ3u83HKthFcrAcS0HTNZBNBAdMZXv/hbYu42Uk7GrYf8H1F78I+QVFe6Yc6gUE5ih5hjcUU7FRG0rHEmBEkUL3DO5w2TuhHDAJkemqFsR4nJ/KD72rZ4Yuv9dRj6JBA/jZE+YmW2p4Ti7hpr9CzN2hDrpzuic2vK6KnL38HI10AGC1eh06iMXgGd0iVA9NrI9Hqctvcob3IOA9fUI/Vf/t1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QXCm89YgWlOfFMMcD+ln38RylJPQVlzhUuqL1d8yYkk=;
 b=Mvs4dBfTWM3QnDxOEMtbfqL3unvR+xXKzKGYk2zQbjaHThn/XTRbSDPF5+OrgPFgTh/vqY7QvEmEvkVt9QEVgRXERLdqDi+b5Xk2COwvhE9k/x4XgRcWvd4AF+KgMPhcTqjbhG/rSMU+xNNtkBM58VZBy/p1H9TVyojtzoIxZMTn3rmqxcZ4Iz/r27ZYyCkoK0uKnovMRNWFJzzjiinjmzhSBEQVzYzFKzlvds6OEeqr3m1WrYm2EIFw4ZwArrIGPYjuLqGKkqbADP7xH/SuY31PaI4ibJPADnG80xCGo7DF2e7YxV6j9XKctiz0uhGOgcBbElYbcuCWjL5S9CZpWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QXCm89YgWlOfFMMcD+ln38RylJPQVlzhUuqL1d8yYkk=;
 b=GEYeMEvhZga2xppCbj+R0+QkYF2ICtynuore4YjC2faaMmnITqyZf4Wkz5mQvxbL1GKqwByO36fnRaUvzn+gc1MTN2Oq2smA3CE6yvDf5bf5HKqydGHvGGKTnKNmmQrNwH9Q/UpJixMGTxZueNO/YAhb9GwIrNPHAxIJCx1VOV+Ts/kgOBZpAfFBEIfEgCrF3siI3ZgRV9neTSzv8TSQbqrDp6juZH5LG2vViTAUj066raLy+6mzqaDU8cfp4qgJtUJ0/4fOamoA2zzWKtwtv5Oe5c7wzvLnzMOLnzmBtdjViJkpFHuVJRGsnlaTEup4Ev8sxOO55jVGSGvQsHV1ow==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MI9PR04MB019273.eurprd04.prod.outlook.com
 (2603:10a6:290:d3::17) by VI2PR04MB10168.eurprd04.prod.outlook.com
 (2603:10a6:800:229::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 12:55:05 +0000
Received: from MI9PR04MB019273.eurprd04.prod.outlook.com
 ([fe80::263c:943a:dcb0:29d8]) by MI9PR04MB019273.eurprd04.prod.outlook.com
 ([fe80::263c:943a:dcb0:29d8%5]) with mapi id 15.21.0472.016; Fri, 2 Oct 2026
 12:55:05 +0000
Date: Fri, 2 Oct 2026 15:55:01 +0300
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Bill Wendling <morbo@google.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Justin Stitt <justinstitt@google.com>, linuxppc-dev@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	llvm@lists.linux.dev, codemender-patching+linux@google.com
Subject: Re: [PATCH] bus: fsl-mc: Annotate fsl_mc_io.portal_virt_addr with
 __counted_by_ptr
Message-ID: <kgtsddrbn2b3bseck7ac4gtuxjhqnqwxwlmcimumvduxmxxtqa@tnhtf6mfu7ls>
References: <20260922223538.2287676-1-morbo@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922223538.2287676-1-morbo@google.com>
X-ClientProxiedBy: FR0P281CA0043.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::8) To MI9PR04MB019273.eurprd04.prod.outlook.com
 (2603:10a6:290:d3::17)
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
X-MS-TrafficTypeDiagnostic: MI9PR04MB019273:EE_|VI2PR04MB10168:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e40d0e6-6e31-43f5-df7a-08df20846189
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|19092799006|7416014|376014|1800799024|366016|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	sIZGr+F2eKIhP4E0pSM0EZMA8fHhcJs7NMWCtusTgn736J57HQVyM/4HJ0LhL6jhfxs0hCqO4CTv/wM6TZAGKhXqgMU6T0iyPbHJrbe9qjuTQMOLERZVN7o0LdpoT2NnmnyXykr0M2hQuHaGZ2rqyR3in2Z9C5QBTlCRdpVznlXL8+Kn+cjdsIc66hmNbqZT6S1+rNzTP3DA1YNefwm9y5C+T8JztNVd11bX3jUex0kvd7zfTIra5rFfcsZTQ2damfbIYxZ3wzAnrDvjx3wkqk3H/iwk4M8U7itQYjQMRNAUAPR2ePvbMLkN1iBUTRTIifWbWrnh2cHSc6VDnb9sQHPTB/ghRVXl1OhT/KZLFlpN1DMR/3+88hTKXvWb0pPqrJUkQH11vDfMIHYmHZlZvZowv/AWi2DBhYxVKxCvvgjFKLzs7gJF3uq/CPebW5tt31J/HdkRbcxSBqqjIM+vOfsl+UI8gbfH4uQaLPObolotP9ymgmxgqL7hv+HxXOwlAEuvn7tJ/mPM67ecteo8m/DhdEZoxpeZ80Bt+xe52Vzhz/ZODLI2vbWaJYVTTN8ejAG9Pr+D0khBjCVs71ggSe1hP9dur0cBmA3fKCZbKUKPhwTY3Yd0ar8lJ7WOWiaqTQbs2Y5uxJvi8bUzd12GyK7KImYylxuCdBr7slRzUPg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI9PR04MB019273.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(7416014)(376014)(1800799024)(366016)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6MFWMwBcMmSK8wzCkT1T/+ecGiXi4Fe+CHZ8XS6wztHDMkwbJwUE09wRsFHF?=
 =?us-ascii?Q?UG+DcsvdLX0vozJt/tsz9WAo74JKGm02WPjnmrADQF/6pfj1JGM45wWPtDZV?=
 =?us-ascii?Q?dTA5QYIsLsgTdS87zQrmxTsIowhoKL7BERaYNmI7rUuVPgO/IFS8LFgS2Mxq?=
 =?us-ascii?Q?EpPlQ2I1ffj5fJy0EXLeafq9ddgu+2nlnAUr00lEfKRkMRVs8iSXEma68hBA?=
 =?us-ascii?Q?kputeUDJallAdY3zQag3vXIMwN9GuavOaT0S3/EHJAxih8QwVaFCdf3PWdVA?=
 =?us-ascii?Q?Kru/r+9lZf264lZZ5ZU8+MdbAjzedW3Qu4zSWg2EjbVLY4gmwGtEK9yt45xD?=
 =?us-ascii?Q?T21+SM0BjjbaDPHeL0eGWUk2+zcirQRpNKd1LusXcsVj/sFLZxY7vhii9hXo?=
 =?us-ascii?Q?4/BXoyIlnSPHw7kR1oJ5D0nj8BmLnh2aQbp176oRw2yKBva/rmRRzuxKqZ/Y?=
 =?us-ascii?Q?ThePcnLLDyX2Y+YIgDrOPLuBMCVrz3E7XpQ9FS6RIyIikxsyZuYTElXpyENf?=
 =?us-ascii?Q?dG+nwalmNm3dmUbkrPlp+Wbw2Mf59JvZwPMCm96V1dE4rlS3KLo5VL0RJfbU?=
 =?us-ascii?Q?bdBEZ22SPaKosRJrn2iLemCeT9XQZNzQqFCH406QKXDkoGiXWK2duibDu1vQ?=
 =?us-ascii?Q?ckWs4FjD7mM2OvmuRt1/3N+xApLGtxGeCE352am+B3fQWpeKOSzD1EUYXAdk?=
 =?us-ascii?Q?I7oSjZc46LUqBbdMnHrL2E7A00fMzflyJ/4ZN2qULwSHmGZX5aBqQLYwbBk9?=
 =?us-ascii?Q?qH0BoGc5GfMgN5k1N0YLwG4UHmktMgZnu294qHx+El2kJPk3mBng89DLHc0X?=
 =?us-ascii?Q?An6fFbQnO/8e/XI4MuKT0Y8y55puuDG/J/rk9Jh9CieOx7dI+B+c859NPx+c?=
 =?us-ascii?Q?3ssifC39wxbs2gNB9SwtlcfkxHa18JAwz+oYK862lUDsOBbu87x8v10rb1OX?=
 =?us-ascii?Q?Ay7TJEleJjuXQKAV9gksGlOJQITGeiNpHh7kz9n07kJdsi6/aGmFweSSbuuC?=
 =?us-ascii?Q?JZk5Gy7qCQpwk4c6wp16FcXUZYZH+a6Iff0Zv9ttp78xQ/+/nqa6XUZikKoA?=
 =?us-ascii?Q?K8OpAonTzntQVaPSDNBeKF3b2WTZniXnougLQ/wtq44nvcOtjkDe3LkvMBzI?=
 =?us-ascii?Q?SR/qcCMW0sBbIpgP+3VPiDiGwHPVVWjWlFyltJyPSEj4Vm5OBv/uUBqQnDhR?=
 =?us-ascii?Q?mKYuQ5c+yLVK0MODb+EUsgY4BxwsTfVh66ev1H4r3lXFFjrjmcCaM5DU3vsQ?=
 =?us-ascii?Q?K+v8Jr78BZ3v7is5546tBvfTMKavC5snUT2jmeWwFRSDVFhDYSGY5iflu5We?=
 =?us-ascii?Q?37O36zVnCjCCXLcg0oK8WfN+tfetbuBfm/SvUKv495c/RaY8KrzyfgvdXEce?=
 =?us-ascii?Q?VHuk4qOU9DPXUP8ZW9jeoGOseECwAkK/cTqzV6OkiYa5BUvTlitbNe2oXmss?=
 =?us-ascii?Q?fvDqZlUDcTreiyljQ5jTKPpV2RBJwC3fQI4NCqXVTlrVzOafbzvuXzZujxCV?=
 =?us-ascii?Q?H1pevgbxA/pe+z75zvXNxMEyth3z1lHeM7fG+YrSJ5IHSfgjzewI7Hwiulgx?=
 =?us-ascii?Q?5g813Rll4LE0kIkT6QRV9FPn1rySfiyFONYqSNsiw4obCqHEp5Yofu+4Oh1L?=
 =?us-ascii?Q?TXUzWtlmY/sfMX6vSx4r6ztbvfOF2NzrPTT8eid9Wf2k60dRIK03PRfLuu+m?=
 =?us-ascii?Q?Io/Uuwu8h6y74gdzfd0mZAl4WOE5r4y3gGGf/5kAJqnkhJ0kXQhF5GA0rXz2?=
 =?us-ascii?Q?GqSNnFMmoQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e40d0e6-6e31-43f5-df7a-08df20846189
X-MS-Exchange-CrossTenant-AuthSource: MI9PR04MB019273.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 12:55:05.4679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N1C+VZQapDohbRaiVlbV+09jredN/v6LRGy9IJV3MV8O/WCJs0TNZQQLPI1E5ZstMp00O+Y6jJ+YafboaLfXog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10168

On Tue, Sep 22, 2026 at 10:35:38PM +0000, Bill Wendling wrote:
> The GCC and Clang compilers provide the __counted_by_ptr attribute,
> which is used by KASAN and compiler bounds-checking to detect
> out-of-bounds accesses to pointer fields.
> 
> In "struct fsl_mc_io", the "portal_virt_addr" pointer points to the MC
> command portal virtual address. The size of this allocated portal in
> bytes is tracked by the "portal_size" field within the same structure.
> 
> Annotate the "portal_virt_addr" pointer field with
> "__counted_by_ptr(portal_size)" to enable compiler bounds-checking and
> harden against potential out-of-bounds accesses.
> 
> Cc: codemender-patching+linux@google.com
> Assisted-by: LLM
> Signed-off-by: Bill Wendling <morbo@google.com>

Reviewed-by: Ioana Ciornei <ioana.ciornei@nxp.com>



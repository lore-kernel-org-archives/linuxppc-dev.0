Return-Path: <linuxppc-dev+bounces-25115-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19A0CC55165
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2026 14:02:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9rVd66mRz2yhb;
	Fri, 31 Jul 2026 00:02:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c207::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785420137;
	cv=pass; b=YINwDv/itHQtQkZP3tChX9xAWjsl+aVY0QEf7rmWyeF5NKvtPMzSNJynpr48iEO5ae4hpsQWBQFJHrYzCFaUasEhfjNwKOcujfepDNt5/iuOG8lJ8/8e1pKN52Swo7wBnhxMRL0FGOmv6qKchN9UbA7jCshdHo0/iFm/DYY4geBMgiZWw2tk3AtZRfm9tVDQnlpqZ2WbWGSXMvhlDGbuRg3EfQXsw4Kn4iXvauokHvq4IiqHUVVprneSgX60mFSW9XFTiYW6J3xAZKupZGDE1xkzJwTR/7E3ONgzBbYX+lZqut7qzrOFPSNQsoUVZ2e9a1c3emGo7yGIkqlpHrlyEg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785420137; c=relaxed/relaxed;
	bh=ZHHwuPB/YLiJJ9Q+CdcB9FZCufPFm1cuuANYXt8TG5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JgQhKKG4Wb48/Hh1yBp/9Uors4fycJxFqrdVqy7SEX2ilzhKYsp80scHpMkGlcBhfcAbBsvl9XYQ822EkgPz6ayKw97BDOr04phaKLCgCZgDmc4SXEjkMcCVDho1hrLfbcBADYzLho3WTr+eHrzqRk/XuGutMnOiO4F5H+pY9xdcy94eGPGOiSollHAqoP//crdPZyvh5uFThC+5tZ1adig3+/YtWmNucY3DrWTYRMR+Yz3D4h1rEcjDKq9CGb8AavPNTO4dVqfEkv+SV48igU2eFtaf7M5mLkGoTmQKCpxQ9DgKE0GYyPM+efZU9JDh9LfqbXrFXfnEKGGp7/rbvw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=OlXe0roC; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=ioana.ciornei@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=OlXe0roC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=ioana.ciornei@nxp.com; receiver=lists.ozlabs.org)
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c207::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9rVc1Djlz2yDs
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2026 00:02:15 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vvWVGthV8PpdzvojpenseXPJq3UYEVZVcCoJ1r9PZmd8UoDGZwm1+fr+mxIKDcJM3ZtXVqTDYJwAPHX+A67z1KhlNE+jeRvAVpOO66KfKlO/xE90R8EyObqSL0Wh9bYJtIA9vDXorOcvej80ZXYk2XikjOa9Z9LAt4Qt5nQnElh/FnrNye5Wehl96/mjHQ+2Ug1xRFr0n29ufgdaWJ7AnSczVupOTn+mUabjxliTajMa20V/b0CzKW8n3D0Bw4TkSDmwc+h5hKrLln6dJIb8xJl/U/z5ngK0qiu4L0+VLbe7Y59bcgb1tn9SBwwbu2guuMvUDooAxqmUtxOuzpfr+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZHHwuPB/YLiJJ9Q+CdcB9FZCufPFm1cuuANYXt8TG5k=;
 b=A9fav6L70TMrfrWynfWXGW0bFxh2Qu1hpvGG4/z3w6k5cKch+zyeJ5Q2QdjugN+0AfTJAiiLm65Mc2TvVTwcFWz16uoxcLbYnOmFMMmi5uitJlCFypV9QSC2qb41OC00tVus7r1LBnLGn+/AC5L5d1ZrA9shH/ka4EUz6MJpe0jUJpkukuj2aP3tkUOzjZqJ1JqJC/Zs3I1lIXsERnVo7rVPMq1puTNoTSGuNqbbKMuUoTH6MDTWrhF5pujSj1Fxe3JB5Nxp1rWSlV6AyZPRi6FzeIEXCM6obqLrQ+tSBYD7uaEeGntM1bGir5qHNjkxcaREbXZYb8TR3atcgmKoeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZHHwuPB/YLiJJ9Q+CdcB9FZCufPFm1cuuANYXt8TG5k=;
 b=OlXe0roCghrLi4Eb6MMN4+Ms/RwCOEwPir0b57E0njpgTCX11iBoLTLXWaaopNknIx50tXuSeOfE6B0eqAiJByD7zU9LRKfKtO5EEICNzZGnsNI+DSUEfLDwZ6r1DRA0AVUBy9fj/HI3UOk7UT8axteIaigbIzNYiqNiowENLHWApyqCnbqUCQtdywhG8H/Hlkmtf4wbJimkyAd/T4xHz1JzN8Lg3lI/jg2pNxP92guo98ShLOj5wDwSpEWnoU7o8VC7NAnzXrHse3Q7+vmP/YY+5OanNZckmgUILfpwXgOojizD+vFdbvtn9VnduYgrJSvwEYmg3uF+VXsXiLitIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13) by GV2PR04MB11638.eurprd04.prod.outlook.com
 (2603:10a6:150:2c8::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 14:01:48 +0000
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd]) by GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd%6]) with mapi id 15.21.0245.012; Thu, 30 Jul 2026
 14:01:47 +0000
Date: Thu, 30 Jul 2026 17:01:44 +0300
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bus: fsl-mc: drop unused assignment of
 acpi_device_id::driver_data
Message-ID: <3ztez2aureq2zzmwivgbum6d6uglg2msla6al64eompvuhp4qd@wqimvuouaia6>
References: <20260728-acpi-bus-v1-1-12ff25fdea9b@thegoodpenguin.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728-acpi-bus-v1-1-12ff25fdea9b@thegoodpenguin.co.uk>
X-ClientProxiedBy: FR2P281CA0111.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::15) To GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13)
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
X-MS-TrafficTypeDiagnostic: GVXPR04MB12290:EE_|GV2PR04MB11638:EE_
X-MS-Office365-Filtering-Correlation-Id: 87e4d46e-7658-47f0-ff08-08deee43187e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|19092799006|376014|18002099003|22082099003|10067099003|5023799004|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	LMDnROrgqhHgJs1wIBmSfgMV8Hxm3DpQ5fnX/Esj0IK6PjPmSY+5C6RZX1HRcrrrmPKp78hnPD59LhgU1fcv15vINPU96KKVHQ6MLImb4yBzVO12R8uUAMqLAy7Lr7DbHhLKWZBPtlnk1evWBYwKtYSzNeXWnWwhiuNoXvLSHgMJbGbcWfApy5FWYXUTTw4Nt2mdcaeCd5ZpZv1ZUOOq+GkQbMwT5Vb6fOTEAZcYIdxwNrW3D0eKZjmXjjXMKZSRG2880D26jcd7swrto+/yV8/zp8gl3NC6KMvVaQh9neyYn0fvDXqnxc0ZUkVBcr6DZLJScUXnk7QyXwZzumGfvIeAUZ+kYU0XEX/kcaMn893OWdQOzq4nAJupwUI6yd/kvEZKewqngKRYnjdL1rf4DVinawVk6Fc+pkI3AEAjA235t7V4QhozS4RQvbUrEOeywaFS0X433Xn0fi+fRRneGXMfoAKwDivmb+kycJj4uqX1DdYJL7PEQ44mScEPG7DPnUuTJauvP7JPaKW0ZQJhib3SJ85LybtyKRGxRV5mEAizm4obOmwmU1aZLm8dhulTAgBgODgbqW0oz85EZidw+beeMaPeb9v3f3gp1u16jlFdXFzzasBqDYgQp9PR5KhN6+VLXMwomNBvefkKtc44Cyycqih/g6NSLv0VKqXsjAg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12290.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(19092799006)(376014)(18002099003)(22082099003)(10067099003)(5023799004)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IEahbc2zNW+8q+Fdz9VSlIUEKvF6SBqNmMrQv3GDDutSJ7EX24hZKLe9TtDz?=
 =?us-ascii?Q?e8cvCUIP++UCUAxpq+f7SgznhCiJjmKRIjbHNrF+zGxIi0IbFWsN6kKDMdRJ?=
 =?us-ascii?Q?/FPdMOipybUIyUO1mRlB6qE375RPIC69LQHr2eAIVgsd7Kw9OjvLDpv7yUdB?=
 =?us-ascii?Q?CWwSRlONm1HjzGyFt4UXrKASB0m2tpThe6ojhwI+SRAOfkfC+D83QkNZnHDD?=
 =?us-ascii?Q?MREYfmrM3GCtZsacLoLfzn+9hqFf3K4g1xNaZElT/b12bMxnmCVDhKM2Gg6H?=
 =?us-ascii?Q?mibwc867zpidwgAXE0trsit5T1yYCUJjjpaBTC4DH+CqQr4XiKoL0t+YGDDC?=
 =?us-ascii?Q?b80HJ7UobXxgzYmhXJUyPPcRWV/og25Ooq7pCz+uecpB/sTw/zJrRaqTO9vV?=
 =?us-ascii?Q?fJdpFjH2OaO7ltTDVoDSb1GDsb5aGQRd3XZE3uVOHjK4Z0Hyxqdu6fRC3kNd?=
 =?us-ascii?Q?9JWHlRs0xjzpaZzjBk3GSdie0xri/9DndHjObWQhIJ0SrPbwUY/FDqdo7PFv?=
 =?us-ascii?Q?YFJOucBsvis6LVTAI1OC6YrYxid+xQQ7nACoRlEmT0sCNy7eXh0K5B8b6KkZ?=
 =?us-ascii?Q?56mt9hCFSoLsQ7okDr0e7mH3Tiwhr2Jqo0doA/ETWHyDDGEpRzzWkstaV8LO?=
 =?us-ascii?Q?w0SESyXidGUf8XkIA+MZpAWAEEG8jA89CR1Ow8Ecq1poN1hzHSx84+2Ojkpr?=
 =?us-ascii?Q?2/91VENJDibpELCl3/by7Dx0zyT72jYKwVpWgD4NDeanX2SF0ugP/S6+TmRu?=
 =?us-ascii?Q?6uQGtMHCBb1zs+rjdqRTPIQlVALoJM5APASIUTh743OPDTfFVpc+pdP6mw1Y?=
 =?us-ascii?Q?8vT9IIDfrjz9Ki1enzJEBIpMxLEtmxSBhEQ2toDZCXhPLTbJfe9SrgXi4GY6?=
 =?us-ascii?Q?5PWeYoFlOzVGAYGD//MDbIi+8eukbahqWrYJ6q5GxGxmQvKWV44xJm0b4tfd?=
 =?us-ascii?Q?+u3j6SBUDjJYWvTozf0HTMQH3PI5nhSCnmLYyqKpzfV2p/Zp6OOVAHYyCZ1E?=
 =?us-ascii?Q?mPqopNv4/W0ifsixgJnLROZQq5fuDCSeIYNSfIK2OZ/IFz/WXfVvaOqIp/hi?=
 =?us-ascii?Q?zwFtj1boaFysiJl4L1ImJO4thvUCdkEJUXAignIHkZZKaKuIQU/qB78Ezp/g?=
 =?us-ascii?Q?a4a0pt2akBGBlFxqJTY/RlBYmQTTKDaLWo6+UpaQXpDZG4SzWh08lTGpzT2z?=
 =?us-ascii?Q?IQfRWJa7BJLg/9thWEg9GrXy9gYg1VKxgtUVom/q4JPzgdElhkp687C7X5uZ?=
 =?us-ascii?Q?UBqpOhJ/RXvqwXUwK6p4Jgt2pQPvy1QidaTZn4JXv3pro0HtsL2+/5wbXO3w?=
 =?us-ascii?Q?2IvmhFt/Axwp3D7Kj4uHVA/kI1ZGSwfzunkBHKvhVg0KP3wZPmBXmdPVNPGt?=
 =?us-ascii?Q?5TOzjte+32beTz0zigfEC0CK0mL0Py1CYJ5WHCaF/8k8OYiie29qsYRsdMpu?=
 =?us-ascii?Q?8pvRlQx5DScy8RfnUO9uhfDORo38WoPJ7m8sLICQ/86qqxHRs83gtncQ/cP1?=
 =?us-ascii?Q?rzbgrH6ZtHF/1yYBr+MWqpbVvsWuXx59PAD/HqopqFQTnDxkcTNFSglk9nwn?=
 =?us-ascii?Q?Pt0opAlZ5dedDYpM58RnK8t4mtmhrfgex9LTC/YontAf8Oy+hepVzMwe+Ii0?=
 =?us-ascii?Q?9/Jkjwx7Th1w7PtjeLJRPaTX1QctwjSiL+AT4cmXcvYxVtf+t/vDoPR7YEWa?=
 =?us-ascii?Q?wiWin2PLEiMAtxWa/cUCdHpUGpKn7zmpQ7lNgh4WsxgQRktF1mPig+q+e1yc?=
 =?us-ascii?Q?aZfB5EIOmA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87e4d46e-7658-47f0-ff08-08deee43187e
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12290.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 14:01:47.5594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bWYNEwfNmrkptok/fzZYJdYjbuyxbTz7/R6QJT3AbQKfltX/ZsiYVrrxB219vM7DBClmyi/CLEqNzAaeqbBX8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11638

On Tue, Jul 28, 2026 at 11:58:56AM +0100, Pawel Zalewski (The Capable Hub) wrote:
> This module sets the acpi_device_id::driver_data to 0 but
> the field is not actually used within the module, we can
> just drop it from the table.
> 
> While we are at it - use a named initializer for the
> acpi_device_id::id field as well to make the code more
> readable.
> 
> Signed-off-by: Pawel Zalewski (The Capable Hub) <pzalewski@thegoodpenguin.co.uk>

Reviewed-by: Ioana Ciornei <ioana.ciornei@nxp.com>

